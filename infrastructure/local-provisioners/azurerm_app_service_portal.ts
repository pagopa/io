/**
 * Run this task from the command line to create
 * a new API management user that has the rights to
 * create a new Service (through Admin API) and to send
 * a new Message (through Digital Citizenship API).
 *
 * yarn resources:devapp:apikey
 *
 *
 * This lets the developer portal facilities web application
 * create or update API gateway users.
 *
 * https://github.com/teamdigitale/io-onboarding
 *
 */
// tslint:disable:no-console
// tslint:disable:no-any

import * as t from "io-ts";
import * as path from "path";
import * as winston from "winston";

import yargs = require("yargs");

import { ICreds, login } from "../../lib/login";

import { checkEnvironment } from "../../lib/environment";

import { IUserData, updateApimUser } from "../../lib/apim_user";
import { createOrUpdateService } from "../../lib/service";

import apiManagementClient from "azure-arm-apimanagement";
import webSiteManagementClient = require("azure-arm-website");

import { DocumentClient, UriFactory } from "documentdb";
import { left } from "fp-ts/lib/Either";
import { reporter } from "io-ts-reporters";
import {
  CONF_DIR,
  getObjectFromJson,
  readConfig,
  ResourcesConfiguration
} from "../../lib/config";

const TaskParams = t.interface({
  apim_configuration_path: t.string,
  azurerm_apim: t.string,
  azurerm_app_service_portal: t.string,
  azurerm_cosmosdb: t.string,
  azurerm_cosmosdb_key: t.string,
  azurerm_documentdb: t.string,
  azurerm_resource_group: t.string,
  environment: t.string
});

type TaskParams = t.TypeOf<typeof TaskParams>;

const createOrUpdareAdminApiUser = async (
  config: ResourcesConfiguration,
  params: TaskParams,
  loginCreds: ICreds
) => {
  const userData: IUserData = {
    email: config.apim_admin_email,
    firstName: config.apim_admin_firstname,
    groups: config.apim_admin_groups,
    lastName: config.apim_admin_lastname,
    oid: config.apim_admin_oid,
    productName: config.apim_admin_product
  };

  const apiClient = new apiManagementClient(
    loginCreds.creds as any,
    loginCreds.subscriptionId
  );

  winston.info(
    "Create or update an API management user for the Developer Portal application"
  );

  // Create or update user in API management
  const user = await apiClient.user.createOrUpdate(
    params.azurerm_resource_group,
    params.azurerm_apim,
    userData.oid,
    {
      email: userData.email,
      firstName: userData.firstName,
      lastName: userData.lastName
    }
  );

  if (!user || !user.name) {
    throw new Error("Cannot create new user");
  }

  winston.info("Subscribe the user to the APIs (products) and assign Groups");

  // Add user to product in API management
  const subscription = await updateApimUser(
    user.name,
    userData,
    apiClient,
    params.azurerm_resource_group,
    params.azurerm_apim
  );

  if (!subscription || !subscription.name) {
    throw new Error("Cannot create subscription");
  }

  const serviceId = subscription.name;
  const cosmosdbLink = `https://${
    params.azurerm_cosmosdb
  }.documents.azure.com:443/`;
  const cosmosdbKey = params.azurerm_cosmosdb_key;

  winston.info(`Using CosmosDB url ${cosmosdbLink}`);
  winston.info(
    `Creating Service for the Developer Portal application user ${serviceId}`
  );

  const cosmosdbClient = new DocumentClient(cosmosdbLink, {
    masterKey: cosmosdbKey
  });

  // Save a service related to the user subscription.
  // We cannot use the APIs at https://${config.azurerm_apim}.azure-api.net
  // because to do that we need an associated Service
  // *before* the actual call to the APIs
  await createOrUpdateService(
    cosmosdbClient,
    UriFactory.createDocumentCollectionUri(
      params.azurerm_documentdb,
      "services"
    ),
    serviceId,
    {
      authorizedCIDRs: [],
      authorizedRecipients: [],
      departmentName: "AgID",
      organizationName: "IT",
      serviceId,
      serviceName: "Digital Citizenship"
    }
  );

  return subscription;
};

export const run = async (params: TaskParams) => {
  const config = readConfig(
    params.environment,
    path.join(...CONF_DIR, ...params.apim_configuration_path.split("/"))
  ).getOrElseL(errs => {
    throw new Error(
      "Error parsing configuration:\n\n" + reporter(left(errs) as any)
    );
  });
  const loginCreds = await login();

  const subscription = await createOrUpdareAdminApiUser(
    config,
    params,
    loginCreds
  );

  const webSiteClient = new webSiteManagementClient(
    loginCreds.creds as any,
    loginCreds.subscriptionId
  );

  const appSettings = await webSiteClient.webApps.listApplicationSettings(
    params.azurerm_resource_group,
    params.azurerm_app_service_portal
  );

  // Set up ADMIN_API_KEY variable in application settings
  if (appSettings.properties) {
    winston.info(
      "Setup the user API Key into the Developer Portal application settings"
    );
    await webSiteClient.webApps.updateApplicationSettings(
      params.azurerm_resource_group,
      params.azurerm_app_service_portal,
      {
        properties: {
          ...appSettings.properties,
          ADMIN_API_KEY: subscription.primaryKey
        }
      }
    );
  }
};

const argv = yargs
  .option("environment", {
    string: true
  })
  .option("azurerm_resource_group", {
    string: true
  })
  .option("azurerm_apim", {
    string: true
  })
  .option("apim_configuration_path", {
    string: true
  })
  .option("azurerm_app_service_portal", {
    string: true
  })
  .option("azurerm_documentdb", {
    string: true
  })
  .option("azurerm_cosmosdb", {
    string: true
  })
  .option("azurerm_cosmosdb_key", {
    string: true
  })
  .help().argv;

checkEnvironment()
  .then(() => getObjectFromJson(TaskParams, argv))
  .then(e =>
    e.map(run).mapLeft(err => {
      throw err;
    })
  )
  .then(() => winston.info("Completed"))
  .catch((e: Error) => winston.error(e.message));

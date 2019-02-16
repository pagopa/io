/**
 * Creates a new Service tied to the user subscription
 * in the API management resource.
 */
// tslint:disable:no-console

import * as t from "io-ts";

import { DocumentClient, RetrievedDocument } from "documentdb";
import { isRight } from "fp-ts/lib/Either";

// Service is a versioned model,
// see https://github.com/teamdigitale/io-functions/blob/master/lib/utils/documentdb_model_versioned.ts
const SERVICE_ID_SUFFIX = "-0000000000000000";

export const ServicePayload = t.strict({
  authorizedCIDRs: t.readonlyArray(t.string),
  authorizedRecipients: t.readonlyArray(t.string),
  departmentName: t.string,
  organizationName: t.string,
  serviceId: t.string,
  serviceName: t.string
});

export type ServicePayload = t.TypeOf<typeof ServicePayload>;

export function createOrUpdateService(
  client: DocumentClient,
  collectionUri: string,
  serviceId: string,
  servicePayload: ServicePayload
): Promise<RetrievedDocument> {
  return new Promise((resolve, reject) => {
    const errorOrService = ServicePayload.decode(servicePayload);
    if (isRight(errorOrService)) {
      return errorOrService.map(service => {
        return client.upsertDocument(
          collectionUri,
          { id: serviceId + SERVICE_ID_SUFFIX, serviceId, ...service },
          {
            partitionKey: serviceId
          },
          (err, created) => {
            if (err) {
              const error = JSON.stringify(err);
              reject(new Error(error));
            } else {
              resolve(created);
            }
          }
        );
      });
    } else {
      const error = JSON.stringify(errorOrService);
      return reject(new Error(error));
    }
  });
}

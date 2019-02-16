# Terraform configuration file to create Azure resources.
# Set up environment variables before running this script (see README.md)

provider "azurerm" {
  version = "~> 1.10.0"
}

provider "random" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 1.0"
}

# Set up an Azure backend to store Terraform state.
# You *must* create the storage account and the container before running this script
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-resource-group"
    storage_account_name = "terraformstorageaccount"
    container_name       = "terraform-storage-container"
  }
}

variable environment {
  type        = "string"
  description = "Environment: production or test"
}

variable environment_short {
  type        = "string"
  description = "Short version of environment name: prod or test (used in resource names)"
}

variable "azurerm_resource_name_prefix" {
  type        = "string"
  description = "Prefix for naming resources (e.g. 'myorg')"
}

variable location {
  type        = "string"
  description = "Location of the Azure resource group and services (ie. West Europe)"
}

variable "cosmosdb_failover_location" {
  type        = "string"
  description = "Location for CosmosDB failover (ie. North Europe), Must differ from 'location'"
}

variable "message_blob_container" {
  default     = "message-content"
  description = "Name of the message container blob"
}

variable "azurerm_functionapp_git_repo" {
  default     = "https://github.com/teamdigitale/io-functions"
  description = "The GitHub repository that must be associated to the function app"
}

variable "azurerm_functionapp_git_branch" {
  default     = "funcpack-release-latest"
  description = "The branch of the GitHub repository that must be associated to the function app"
}

variable "azurerm_storage_queue_emailnotifications" {
  type        = "string"
  description = "Name of the storage queue for email notifications"
}

variable "azurerm_storage_queue_webhooknotifications" {
  type        = "string"
  description = "Name of the storage queue for notifications sent to webhook"
}

variable "azurerm_storage_queue_createdmessages" {
  type        = "string"
  description = "Name of the storage queue for created messages"
}

variable "azurerm_storage_queue_profileevents" {
  type        = "string"
  description = "Name of the storage queue for profile events (create / update)"
}

variable "azurerm_cosmosdb_collections" {
  type        = "map"
  description = "Name and partition keys of collections that must exist in the CosmosDB database"
}

variable "app_service_portal_git_repo" {
  type        = "string"
  description = "URL of the GitHub repository providing the source of the App Service Portal"
}

variable "app_service_portal_git_branch" {
  default     = "master"
  description = "Branch of the GitHub repository providing the source of the App Service Portal"
}

variable "app_service_portal_post_login_url" {
  type        = "string"
  description = "Redirect to this page after developer portal login"
}

variable "app_service_portal_post_logout_url" {
  type        = "string"
  description = "Redirect to this page after developer portal logout"
}

variable "azurerm_apim_sku" {
  type        = "string"
  description = "SKU (tier) of the API management"
}

variable "azurerm_adb2c_policy" {
  type        = "string"
  description = "Name of ADB2C policy used in the API management portal authentication flow"
}

# TF_VAR_ADB2C_TENANT_ID
variable "ADB2C_TENANT_ID" {
  type        = "string"
  description = "Name of the Active Directory B2C tenant used in the API management portal authentication flow"
}

# TF_VAR_DEV_PORTAL_CLIENT_ID
variable "DEV_PORTAL_CLIENT_ID" {
  type        = "string"
  description = "Client ID of an application used in the API management portal authentication flow"
}

# TF_VAR_DEV_PORTAL_CLIENT_SECRET
variable "DEV_PORTAL_CLIENT_SECRET" {
  type        = "string"
  description = "Client secret of the application used in the API management portal authentication flow"
}

# TF_VAR_DEV_PORTAL_EXT_CLIENT_ID
variable "DEV_PORTAL_EXT_CLIENT_ID" {
  type        = "string"
  description = "Client ID of an application used by the digital citizenship onboarding procedure"
}

# TF_VAR_DEV_PORTAL_EXT_CLIENT_SECRET
variable "DEV_PORTAL_EXT_CLIENT_SECRET" {
  type        = "string"
  description = "Client secret of the application used by the digital citizenship onboarding procedure"
}

variable "webhook_channel_url" {
  type        = "string"
  description = "URL to contact when sending notifications to the webhook (without the secret token)"
}

# TF_VAR_WEBHOOK_CHANNEL_URL_TOKEN
variable "WEBHOOK_CHANNEL_URL_TOKEN" {
  type        = "string"
  description = "Secret token that is appended to the webhook_channel_url"
}

variable "azurerm_apim_eventhub_rule" {
  type        = "string"
  description = "EventHub rule for API management"
}

# Notification HUB

variable "azurerm_notification_hub_sku" {
  type        = "string"
  description = "SKU (tier) of the Notification HUB"
}

variable "notification_hub_apns_app_id" {
  type        = "string"
  description = "APNS application Id"
}

variable "notification_hub_apns_name" {
  type        = "string"
  description = "APNS name"
}

variable "notification_hub_apns_endpoint" {
  type        = "string"
  description = "APNS endpoint (test or sandbox)"
}

# This should be passed by ENV var TF_VAR_NOTIFICATION_HUB_APNS_KEY
variable "NOTIFICATION_HUB_APNS_KEY" {
  type        = "string"
  description = "APNS Key"
}

# This should be passed by ENV var TF_VAR_NOTIFICATION_HUB_APNS_KEY_ID
variable "NOTIFICATION_HUB_APNS_KEY_ID" {
  type        = "string"
  description = "APNS key Id"
}

# This should be passed by ENV var TF_VAR_NOTIFICATION_HUB_GCM_KEY
variable "NOTIFICATION_HUB_GCM_KEY" {
  type        = "string"
  description = "GCM Key"
}

variable "azurerm_shared_address_space_cidr" {
  default     = "100.64.0.0/10"
  description = "Azure internal network CIDR"
}

# see https://docs.microsoft.com/en-us/azure/cosmos-db/firewall-support
variable "azurerm_azure_portal_ips" {
  default     = "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"
  description = "The IPs of the Azure admin portal"
}

# This should be passed by ENV var TF_VAR_MAILUP_USERNAME
variable "MAILUP_USERNAME" {
  type        = "string"
  description = "Username for the MailUp SMTP+ service"
}

# This should be passed by ENV var TF_VAR_MAILUP_SECRET
variable "MAILUP_SECRET" {
  type        = "string"
  description = "Password for the MailUp SMTP+ service"
}

variable "default_sender_email" {
  type        = "string"
  description = "Default sender email address"
}

variable "azurerm_kubernetes_admin_username" {
  type        = "string"
  description = "The username of the admin account on the Kubernetes nodes"
}

variable "azurerm_kubernetes_admin_ssh_publickey_file" {
  type        = "string"
  description = "The name of the file under 'files' of the ssh public key for the admin account on the Kubernetes nodes"
}

variable "azurerm_kubernetes_agent_count" {
  type        = "string"
  description = "How many agent nodes in the Kubernetes cluster"
}

# See VM sizes https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes
variable "azurerm_kubernetes_agent_vm_size" {
  type        = "string"
  description = "Virtual machine size for agent nodes in Kubernetes cluster"
}

variable "ARM_CLIENT_SECRET" {
  type        = "string"
  description = "The client secret of the service principal"
}

# DNS configuration for the default email provider

variable "azurerm_dns_main_zone" {
  type        = "string"
  description = "The domain used by Digital Citizenship subsystems"
}

variable "azurerm_dns_main_zone_spf1" {
  type        = "string"
  description = "Default email provider spf1 DNS record"
}

variable "azurerm_dns_main_zone_dkim" {
  type        = "map"
  description = "Default email provider dkim DNS records"
}

# PagoPA VPN

variable "pagopa_vpn_site_gateway_ip" {
  default     = ""
  description = "The IP address of the pagoPA VPN gateway"
}

variable "pagopa_vpn_shared_key" {
  default     = ""
  description = "The shared key to be used by the pagoPA VPN"
}

#
# Paths to local provisioner scripts
#

variable "cosmosdb_collection_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_cosmosdb_collection.ts"
}

variable "website_git_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_website_git.ts"
}

variable "apim_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_apim.ts"
}

variable "apim_logger_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_apim_logger.ts"
}

variable "apim_adb2c_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_apim_adb2c.ts"
}

variable "apim_api_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_apim_api.ts"
}

variable "app_service_portal_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_app_service_portal.ts"
}

variable "functionapp_apikey_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_functionapp_apikey.ts"
}

variable "apim_configuration_path" {
  default     = "common/apim.json"
  description = "Path of the (json) file that contains the configuration settings for the API management resource"
}

variable "notification_hub_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_notification_hub.ts"
}

variable "cosmosdb_iprange_provisioner" {
  default = "infrastructure/local-provisioners/azurerm_cosmosdb_iprange.ts"
}

#
# Compute name of resources
#
# Instead of explicitly defining the name of each resource, we use a convention
# to compose the name of the resource as: PREFIX-RESOURCE_TYPE-ENVIRONMENT_SHORT
#

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment_short}
  azurerm_resource_group_name = "${var.azurerm_resource_name_prefix}-rg-${var.environment_short}"

  azurerm_storage_account_name             = "${var.azurerm_resource_name_prefix}storage${var.environment_short}"
  azurerm_storage_container_name           = "${var.azurerm_resource_name_prefix}-storage-${var.environment_short}"
  azurerm_cosmosdb_name                    = "${var.azurerm_resource_name_prefix}-cosmosdb-${var.environment_short}"
  azurerm_cosmosdb_documentdb_name         = "${var.azurerm_resource_name_prefix}-documentdb-${var.environment_short}"
  azurerm_app_service_plan_name            = "${var.azurerm_resource_name_prefix}-app-${var.environment_short}"
  azurerm_functionapp_name                 = "${var.azurerm_resource_name_prefix}-functions-${var.environment_short}"
  azurerm_functionapp_storage_account_name = "${var.azurerm_resource_name_prefix}funcstorage${var.environment_short}"
  azurerm_application_insights_name        = "${var.azurerm_resource_name_prefix}-appinsights-${var.environment_short}"
  azurerm_app_service_plan_portal_name     = "${var.azurerm_resource_name_prefix}-portal-app-${var.environment_short}"
  azurerm_app_service_portal_name          = "${var.azurerm_resource_name_prefix}-portal-${var.environment_short}"
  azurerm_log_analytics_name               = "${var.azurerm_resource_name_prefix}-loganalytics-${var.environment_short}"
  azurerm_apim_name                        = "${var.azurerm_resource_name_prefix}-apim-${var.environment_short}"
  azurerm_eventhub_ns_name                 = "${var.azurerm_resource_name_prefix}-eventhub-ns-${var.environment_short}"
  azurerm_apim_eventhub_name               = "${var.azurerm_resource_name_prefix}-apim-eventhub-${var.environment_short}"
  azurerm_notification_hub                 = "${var.azurerm_resource_name_prefix}-notificationhub-${var.environment_short}"
  azurerm_notification_hub_ns              = "${var.azurerm_resource_name_prefix}-notificationhubns-${var.environment_short}"
  azurerm_kubernetes_name                  = "${var.azurerm_resource_name_prefix}-k8s-${var.environment_short}"
  azurerm_kubernetes_public_ip_name        = "${var.azurerm_resource_name_prefix}-k8s-ip-${var.environment_short}"
  azurerm_redis_cache_name                 = "${var.azurerm_resource_name_prefix}-redis-${var.environment_short}"
  azurerm_redis_backup_name                = "${var.azurerm_resource_name_prefix}redisbck${var.environment_short}"
  azurerm_redis_vnet_name                  = "${var.azurerm_resource_name_prefix}-redis-vnet-${var.environment_short}"
}

#
# Data resources
#

# We need the configuration of the Azure Resource Manager provider for some
# resources that need to create other resources themselves (i.e. Kubernetes)
data "azurerm_client_config" "current" {}

## RESOURCE GROUP

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "azurerm_resource_group" {
  name     = "${local.azurerm_resource_group_name}"
  location = "${var.location}"

  tags {
    environment = "${var.environment}"
  }
}

## STORAGE

resource "azurerm_storage_account" "azurerm_storage_account" {
  name                = "${local.azurerm_storage_account_name}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"

  # can be one between Premium_LRS, Standard_GRS, Standard_LRS, Standard_RAGRS, Standard_ZRS
  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
  account_tier = "Standard"

  account_replication_type = "GRS"

  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-service-encryption
  enable_blob_encryption = true

  enable_https_traffic_only = true

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_account" "azurerm_functionapp_storage_account" {
  name                = "${local.azurerm_functionapp_storage_account_name}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"

  # can be one between Premium_LRS, Standard_GRS, Standard_LRS, Standard_RAGRS, Standard_ZRS
  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
  account_tier = "Standard"

  account_replication_type = "GRS"

  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-service-encryption
  enable_blob_encryption = true

  enable_https_traffic_only = true

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_container" "azurerm_storage_container" {
  name                 = "${local.azurerm_storage_container_name}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.azurerm_storage_account.name}"

  # Can be either blob (to publish blob on internet),container (to publish everything) or private
  container_access_type = "private"
}

## QUEUES

resource "azurerm_storage_queue" "azurerm_storage_queue_emailnotifications" {
  name                 = "${var.azurerm_storage_queue_emailnotifications}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.azurerm_storage_account.name}"
}

resource "azurerm_storage_queue" "azurerm_storage_queue_webhooknotifications" {
  name                 = "${var.azurerm_storage_queue_webhooknotifications}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.azurerm_storage_account.name}"
}

resource "azurerm_storage_queue" "azurerm_storage_queue_createdmessages" {
  name                 = "${var.azurerm_storage_queue_createdmessages}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.azurerm_storage_account.name}"
}

resource "azurerm_storage_queue" "azurerm_storage_queue_profileevents" {
  name                 = "${var.azurerm_storage_queue_profileevents}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name = "${azurerm_storage_account.azurerm_storage_account.name}"
}

## BLOBS

resource "azurerm_storage_blob" "azurerm_message_blob" {
  name = "${var.message_blob_container}"

  resource_group_name    = "${azurerm_resource_group.azurerm_resource_group.name}"
  storage_account_name   = "${azurerm_storage_account.azurerm_storage_account.name}"
  storage_container_name = "${azurerm_storage_container.azurerm_storage_container.name}"

  type = "block"
}

## DATABASE

resource "azurerm_cosmosdb_account" "azurerm_cosmosdb" {
  name                = "${local.azurerm_cosmosdb_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  # Possible values are GlobalDocumentDB and MongoDB
  kind = "GlobalDocumentDB"

  # Required - can be only set to Standard
  offer_type = "Standard"

  # Can be either BoundedStaleness, Eventual, Session or Strong
  # see https://docs.microsoft.com/en-us/azure/cosmos-db/consistency-levels
  # Note: with the default BoundedStaleness settings CosmosDB cannot perform failover / replication:
  #   Operations (max_staleness): for a single region the maximum operations lag must be between 10 and 1 000 000
  #               for the multi region, it will be between 100 000 and 1 000 000
  #   Time (max_interval_in_seconds): the maximum lag must be between 5 seconds and 1 day for either single or multi-regions
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = "${var.cosmosdb_failover_location}"
    failover_priority = 0
  }

  # ip_range_filter = "${azurerm_function_app.azurerm_function_app.outbound_ip_addresses}"

  tags {
    environment = "${var.environment}"
  }
}

resource "null_resource" "azurerm_cosmosdb_collections" {
  triggers = {
    cosmosdb_id = "${azurerm_cosmosdb_account.azurerm_cosmosdb.id}"

    # serialize the collection data to json so that the provisioner will be
    # triggered when collections get added or changed
    # NOTE: when a collection gets removed from the config it will NOT be
    # removed by the provisioner (the provisioner only creates collections)
    collections_json = "${jsonencode(var.azurerm_cosmosdb_collections)}"

    # increment the following value when changing the provisioner script to
    # trigger the re-execution of the script
    # TODO: consider using the hash of the script content instead
    provisioner_version = "5"
  }

  count = "${length(keys(var.azurerm_cosmosdb_collections))}"

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.cosmosdb_collection_provisioner}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_cosmosdb ${azurerm_cosmosdb_account.azurerm_cosmosdb.name}",
      "--azurerm_documentdb ${local.azurerm_cosmosdb_documentdb_name}",
      "--azurerm_cosmosdb_collection ${element(keys(var.azurerm_cosmosdb_collections), count.index)}",
      "--azurerm_cosmosdb_collection_pk ${lookup(var.azurerm_cosmosdb_collections, element(keys(var.azurerm_cosmosdb_collections), count.index))}",
      "--azurerm_cosmosdb_key ${azurerm_cosmosdb_account.azurerm_cosmosdb.primary_master_key}"))
    }"
  }
}

## APPLICATION INSIGHTS

resource "azurerm_application_insights" "azurerm_application_insights" {
  name                = "${local.azurerm_application_insights_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  # Web or Other
  application_type = "Web"
}

## APP SERVICE PLAN

resource "azurerm_app_service_plan" "azurerm_app_service_plan" {
  name                = "${local.azurerm_app_service_plan_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  sku {
    tier = "Standard"

    # see https://azure.microsoft.com/en-en/pricing/details/app-service/
    size = "S1"
  }
}

## FUNCTIONS

resource "azurerm_function_app" "azurerm_function_app" {
  name                      = "${local.azurerm_functionapp_name}"
  location                  = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name       = "${azurerm_resource_group.azurerm_resource_group.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.azurerm_app_service_plan.id}"
  storage_connection_string = "${azurerm_storage_account.azurerm_functionapp_storage_account.primary_connection_string}"
  client_affinity_enabled   = false
  version                   = "~1"

  site_config = {
    # We don't want the express server to idle
    # so do not set `alwaysOn: false` in production
    always_on = true
  }

  # Do not set "AzureWebJobsDashboard" to disable builtin logging
  # see https://docs.microsoft.com/en-us/azure/azure-functions/functions-monitoring#disable-built-in-logging

  app_settings = {
    # "AzureWebJobsStorage" = "${azurerm_storage_account.azurerm_functionapp_storage_account.primary_connection_string}"

    "COSMOSDB_NAME" = "${local.azurerm_cosmosdb_documentdb_name}"

    "QueueStorageConnection" = "${azurerm_storage_account.azurerm_storage_account.primary_connection_string}"

    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.azurerm_application_insights.instrumentation_key}"

    # Avoid edit functions code from the Azure portal
    "FUNCTION_APP_EDIT_MODE" = "readonly"

    # AzureWebJobsSecretStorageType may be `disabled` or `Blob`
    # When set to `Blob` the API manager task won't be able
    # to retrieve the master key
    "AzureWebJobsSecretStorageType" = "disabled"

    "WEBSITE_HTTPLOGGING_RETENTION_DAYS" = "3"

    "DIAGNOSTICS_AZUREBLOBRETENTIONINDAYS" = "1"

    "WEBSITE_NODE_DEFAULT_VERSION" = "6.11.2"

    "SCM_USE_FUNCPACK_BUILD" = "1"

    "MESSAGE_CONTAINER_NAME" = "${azurerm_storage_blob.azurerm_message_blob.name}"

    "MAILUP_USERNAME" = "${var.MAILUP_USERNAME}"

    "MAILUP_SECRET" = "${var.MAILUP_SECRET}"

    "MAIL_FROM_DEFAULT" = "${var.default_sender_email}"

    "WEBHOOK_CHANNEL_URL" = "${var.webhook_channel_url}${var.WEBHOOK_CHANNEL_URL_TOKEN}"

    "PUBLIC_API_URL" = "https://${local.azurerm_apim_name}.azure-api.net/"

    # API management API-Key (Ocp-Apim-Subscription-Key)
    # set the value manually or with a local provisioner
    "PUBLIC_API_KEY" = ""
  }
  connection_string = [
    {
      name  = "COSMOSDB_KEY"
      type  = "Custom"
      value = "${azurerm_cosmosdb_account.azurerm_cosmosdb.primary_master_key}"
    },
    {
      name  = "COSMOSDB_URI"
      type  = "Custom"
      value = "https://${azurerm_cosmosdb_account.azurerm_cosmosdb.name}.documents.azure.com:443/"
    },
  ]
}

resource "null_resource" "azurerm_function_app_git" {
  triggers = {
    azurerm_functionapp_id = "${azurerm_function_app.azurerm_function_app.id}"

    # trigger recreation of this resource when the following variables change
    azurerm_functionapp_git_repo   = "${var.azurerm_functionapp_git_repo}"
    azurerm_functionapp_git_branch = "${var.azurerm_functionapp_git_branch}"

    # increment the following value when changing the provisioner script to
    # trigger the re-execution of the script
    # TODO: consider using the hash of the script content instead
    provisioner_version = "1"
  }

  provisioner "local-exec" {
    command = "ts-node ${var.website_git_provisioner} --resource-group-name ${azurerm_resource_group.azurerm_resource_group.name} --app-name ${azurerm_function_app.azurerm_function_app.name} --git-repo ${var.azurerm_functionapp_git_repo} --git-branch ${var.azurerm_functionapp_git_branch}"
  }
}

resource "null_resource" "azurerm_function_app_apikey" {
  triggers = {
    azurerm_functionapp_id = "${azurerm_function_app.azurerm_function_app.id}"

    # increment the following value when changing the provisioner script to
    # trigger the re-execution of the script
    # TODO: consider using the hash of the script content instead
    provisioner_version = "1"
  }

  depends_on = ["null_resource.azurerm_app_service_portal"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.functionapp_apikey_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--azurerm_functionapp ${azurerm_function_app.azurerm_function_app.name}"))
    }"
  }
}

### DEVELOPER PORTAL TASKS

resource "azurerm_app_service_plan" "azurerm_app_service_plan_portal" {
  name                = "${local.azurerm_app_service_plan_portal_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  sku {
    tier = "Standard"

    # see https://azure.microsoft.com/en-en/pricing/details/app-service/
    size = "S1"
  }
}

resource "random_string" "cookie_key" {
  length = 32
}

resource "random_string" "cookie_iv" {
  length = 12
}

resource "azurerm_app_service" "azurerm_app_service_portal" {
  name                = "${local.azurerm_app_service_portal_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  app_service_plan_id = "${azurerm_app_service_plan.azurerm_app_service_plan_portal.id}"

  site_config {
    always_on = true
  }

  # Go to https://github.com/teamdigitale/io-onboarding
  # to see how to fill these values
  app_settings {
    POLICY_NAME                  = "${var.azurerm_adb2c_policy}"
    WEBSITE_NODE_DEFAULT_VERSION = "6.5.0"
    COOKIE_KEY                   = "${random_string.cookie_key.result}"
    COOKIE_IV                    = "${random_string.cookie_iv.result}"
    LOG_LEVEL                    = "info"
    ARM_RESOURCE_GROUP           = "${azurerm_resource_group.azurerm_resource_group.name}"
    ARM_APIM                     = "${local.azurerm_apim_name}"
    APIM_PRODUCT_NAME            = "starter"
    APIM_USER_GROUPS             = "ApiLimitedMessageWrite,ApiInfoRead,ApiMessageRead,ApiLimitedProfileRead"
    ADMIN_API_URL                = "https://${local.azurerm_apim_name}.azure-api.net/"
    POST_LOGIN_URL               = "${var.app_service_portal_post_login_url}"
    POST_LOGOUT_URL              = "${var.app_service_portal_post_logout_url}"
    REPLY_URL                    = "https://${local.azurerm_app_service_portal_name}.azurewebsites.net/auth/openid/return"

    ARM_SUBSCRIPTION_ID = "${data.azurerm_client_config.current.subscription_id}"
    TENANT_ID           = "${var.ADB2C_TENANT_ID}"
    CLIENT_ID           = "${var.DEV_PORTAL_EXT_CLIENT_ID}"
    CLIENT_SECRET       = "${var.DEV_PORTAL_EXT_CLIENT_SECRET}"

    # Prevent Terraform to override these values
    APPINSIGHTS_INSTRUMENTATIONKEY = ""
    ADMIN_API_KEY                  = ""
  }
}

# Creates a new administrator user and setup the API-Key (of this user)
# in the developer portal onboarding web application,
# see https://github.com/teamdigitale/io-onboarding
resource "null_resource" "azurerm_app_service_portal" {
  triggers = {
    azurerm_app_service_portal_id = "${azurerm_app_service.azurerm_app_service_portal.id}"
    provisioner_version           = "1"
  }

  depends_on = ["null_resource.azurerm_apim", "azurerm_function_app.azurerm_function_app", "azurerm_app_service.azurerm_app_service_portal"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.app_service_portal_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--azurerm_app_service_portal ${azurerm_app_service.azurerm_app_service_portal.name}",
      "--azurerm_cosmosdb ${azurerm_cosmosdb_account.azurerm_cosmosdb.name}",
      "--azurerm_documentdb ${local.azurerm_cosmosdb_documentdb_name}",
      "--azurerm_cosmosdb_key ${azurerm_cosmosdb_account.azurerm_cosmosdb.primary_master_key}"))
    }"
  }
}

resource "null_resource" "azurerm_app_service_portal_git" {
  triggers = {
    azurerm_app_service_portal_id = "${azurerm_app_service.azurerm_app_service_portal.id}"

    # trigger recreation of this resource when the following variables change
    app_service_portal_git_repo   = "${var.app_service_portal_git_repo}"
    app_service_portal_git_branch = "${var.app_service_portal_git_branch}"

    # increment the following value when changing the provisioner script to
    # trigger the re-execution of the script
    # TODO: consider using the hash of the script content instead
    provisioner_version = "1"
  }

  provisioner "local-exec" {
    command = "ts-node ${var.website_git_provisioner} --resource-group-name ${azurerm_resource_group.azurerm_resource_group.name} --app-name ${azurerm_app_service.azurerm_app_service_portal.name} --git-repo ${var.app_service_portal_git_repo} --git-branch ${var.app_service_portal_git_branch}"
  }
}

locals {
  application_outbound_ips = "${var.azurerm_shared_address_space_cidr},${azurerm_function_app.azurerm_function_app.outbound_ip_addresses},${azurerm_app_service.azurerm_app_service_portal.outbound_ip_addresses},${var.azurerm_azure_portal_ips}"
}

resource "null_resource" "azurerm_cosmosdb_ip_range_filter" {
  triggers = {
    cosmosdb_id              = "${azurerm_cosmosdb_account.azurerm_cosmosdb.id}"
    application_outbound_ips = "${local.application_outbound_ips}"

    # increment the following value when changing the provisioner script to
    # trigger the re-execution of the script
    # TODO: consider using the hash of the script content instead
    provisioner_version = "1"
  }

  provisioner "local-exec" {
    command = "ts-node ${var.cosmosdb_iprange_provisioner} --resource-group-name ${azurerm_resource_group.azurerm_resource_group.name} --cosmosdb-name ${azurerm_cosmosdb_account.azurerm_cosmosdb.name} --ips ${local.application_outbound_ips}"
  }
}

# TODO: assign role to the MSI to let the App Service access API Management users
# resource "azurerm_virtual_machine_extension" "app_service_portal_msi" {
#     name                 = "app_service_portal_msi"
#     location            = "${azurerm_resource_group.azurerm_resource_group.location}"
#     resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
#     app_service_plan_id = "${azurerm_app_service_plan.azurerm_app_service_plan_portal.id}"
#
#     # virtual_machine_name = "${azurerm_virtual_machine.test.name}"
#
#     publisher            = "Microsoft.ManagedIdentity"
#     type                 = "ManagedIdentityExtensionForWindows"
#     type_handler_version = "1.0"
#     settings             = ""
# }
# resource "azurerm_role_assignment" "app_service_portal_role" {
#   name               = "app_service_portal_role"
#   scope              = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.azurerm_resource_group}/providers/Microsoft.Storage/storageAccounts/${var.azurerm_apim}"
#   role_definition_id = ""
#   principal_id       = ""
# }

# Logging (OSM)

resource "azurerm_log_analytics_workspace" "azurerm_log_analytics" {
  name                = "${local.azurerm_log_analytics_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  sku                 = "Standard"
  retention_in_days   = 30
}

# Logging (EventHub)

resource "azurerm_eventhub_namespace" "azurerm_eventhub_ns" {
  name                = "${local.azurerm_eventhub_ns_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  sku                 = "Standard"
  capacity            = 1

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_eventhub" "azurerm_apim_eventhub" {
  name                = "${local.azurerm_apim_eventhub_name}"
  namespace_name      = "${azurerm_eventhub_namespace.azurerm_eventhub_ns.name}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  # EventHub Partition Count has to be between 2 and 32
  partition_count   = 2
  message_retention = 7
}

resource "azurerm_eventhub_authorization_rule" "azurerm_apim_eventhub_rule" {
  name                = "${var.azurerm_apim_eventhub_rule}"
  namespace_name      = "${azurerm_eventhub_namespace.azurerm_eventhub_ns.name}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  eventhub_name       = "${azurerm_eventhub.azurerm_apim_eventhub.name}"
  listen              = true
  send                = true
  manage              = false
}

# Notification Hub for push notifications
# TODO: set up services credentials
resource "null_resource" "azurerm_notification_hub" {
  triggers = {
    azurerm_resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
    provisioner_version         = "1"
  }

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.notification_hub_provisioner}",
      "--location ${lower(replace(var.location, " ", ""))}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_notification_hub_sku ${var.azurerm_notification_hub_sku}",
      "--azurerm_notification_hub_ns ${local.azurerm_notification_hub_ns}",
      "--notification_hub_apns_app_id ${var.notification_hub_apns_app_id}",
      "--notification_hub_apns_name ${var.notification_hub_apns_name}",
      "--notification_hub_apns_endpoint ${var.notification_hub_apns_endpoint}",
      "--notification_hub_apns_key ${var.NOTIFICATION_HUB_APNS_KEY}",
      "--notification_hub_apns_key_id ${var.NOTIFICATION_HUB_APNS_KEY_ID}",
      "--notification_hub_gcm_key ${var.NOTIFICATION_HUB_GCM_KEY}",
      "--azurerm_notification_hub ${local.azurerm_notification_hub}"))
    }"
  }
}

# API management

## Create and configure the API management service

resource "null_resource" "azurerm_apim" {
  triggers = {
    azurerm_function_app_id     = "${azurerm_function_app.azurerm_function_app.id}"
    azurerm_resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
    provisioner_version         = "1"
  }

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.apim_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--azurerm_functionapp ${azurerm_function_app.azurerm_function_app.name}",
      "--azurerm_app_service_portal ${local.azurerm_app_service_portal_name}",
      "--apim_configuration_path ${var.apim_configuration_path}"))
    }"
  }
}

## Connect API management developer portal authentication to Active Directory B2C

resource "null_resource" "azurerm_apim_adb2c" {
  triggers = {
    azurerm_function_app_id     = "${azurerm_function_app.azurerm_function_app.id}"
    azurerm_resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
    azurerm_apim_id             = "${null_resource.azurerm_apim.id}"
    provisioner_version         = "1"
  }

  depends_on = ["null_resource.azurerm_apim"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.apim_adb2c_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--adb2c_tenant_id ${var.ADB2C_TENANT_ID}",
      "--adb2c_portal_client_id ${var.DEV_PORTAL_CLIENT_ID}",
      "--adb2c_portal_client_secret ${var.DEV_PORTAL_CLIENT_SECRET}"))
    }"
  }
}

## Connect the API management resource with the EventHub logger

resource "null_resource" "azurerm_apim_logger" {
  triggers = {
    azurerm_function_app_id            = "${azurerm_function_app.azurerm_function_app.id}"
    azurerm_resource_group_name        = "${azurerm_resource_group.azurerm_resource_group.name}"
    azurerm_apim_eventhub_id           = "${azurerm_eventhub.azurerm_apim_eventhub.id}"
    azurerm_eventhub_connection_string = "${azurerm_eventhub_authorization_rule.azurerm_apim_eventhub_rule.primary_connection_string}"
    azurerm_apim_id                    = "${null_resource.azurerm_apim.id}"
    provisioner_version                = "1"
  }

  depends_on = ["null_resource.azurerm_apim"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.apim_logger_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--azurerm_apim_eventhub ${azurerm_eventhub.azurerm_apim_eventhub.name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--azurerm_apim_eventhub_connstr ${azurerm_eventhub_authorization_rule.azurerm_apim_eventhub_rule.primary_connection_string}"))
    }"
  }
}

## Setup OpenAPI in API management service from swagger specs exposed by Functions

resource "null_resource" "azurerm_apim_api" {
  triggers = {
    azurerm_function_app_id     = "${azurerm_function_app.azurerm_function_app.id}"
    azurerm_resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
    azurerm_apim_id             = "${null_resource.azurerm_apim.id}"
    provisioner_version         = "1"
  }

  depends_on = ["null_resource.azurerm_apim_logger"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.apim_api_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${azurerm_resource_group.azurerm_resource_group.name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--azurerm_functionapp ${azurerm_function_app.azurerm_function_app.name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--apim_include_policies",
      "--apim_include_products"))
    }"
  }
}

#
# DNS Zone
#
resource "azurerm_dns_zone" "azurerm_dns_main_zone" {
  name                = "${var.azurerm_dns_main_zone}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  # This resource must exist only in the "production" environment
  count = "${var.environment == "production" ? 1 : 0}"
}

# default email provider txt spf1 dns record
resource "azurerm_dns_txt_record" "azurerm_dns_main_zone_spf1" {
  count               = "${var.environment == "production" ? 1 : 0}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  zone_name           = "${azurerm_dns_zone.azurerm_dns_main_zone.name}"
  name                = "@"
  ttl                 = 3600

  record {
    value = "${var.azurerm_dns_main_zone_spf1}"
  }
}

# default email provider cname dkim dns records
resource "azurerm_dns_cname_record" "azurerm_dns_main_zone_dkim" {
  count               = "${var.environment == "production" ? length(keys(var.azurerm_dns_main_zone_dkim)) : 0}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  zone_name           = "${azurerm_dns_zone.azurerm_dns_main_zone.name}"
  name                = "${element(keys(var.azurerm_dns_main_zone_dkim), count.index)}"
  record              = "${lookup(var.azurerm_dns_main_zone_dkim, element(keys(var.azurerm_dns_main_zone_dkim), count.index))}"
  ttl                 = 3600
}

#
# Redis cache
#
resource "azurerm_storage_account" "azurerm_redis_backup" {
  name                = "${local.azurerm_redis_backup_name}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"

  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction#types-of-storage-accounts
  account_tier = "Standard"

  # see https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction#replication
  account_replication_type  = "GRS"
  enable_blob_encryption    = true
  enable_https_traffic_only = true
}

resource "azurerm_redis_cache" "azurerm_redis_cache" {
  name                = "${local.azurerm_redis_cache_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"

  # Possible values for Premium: n=1=6GB, 2=13Gb, 3=26GB, 4=53GB
  capacity = 1

  # Total capacity is shard_count * capacity in GB
  shard_count = 1

  enable_non_ssl_port = false

  # see https://docs.microsoft.com/en-us/azure/redis-cache/cache-faq#what-redis-cache-offering-and-size-should-i-use
  # and https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#default-redis-configuration-values
  #
  # default values are:
  #   maxmemory_reserved = 200
  #   maxmemory_delta    = 200
  #   maxmemory_policy   = "volatile-lru"
  #
  redis_configuration {
    # Values are: 15, 30, 60, 360, 720 and 1440 seconds
    rdb_backup_frequency          = 360
    rdb_backup_max_snapshot_count = 1
    rdb_backup_enabled            = true

    rdb_storage_connection_string = "${azurerm_storage_account.azurerm_redis_backup.primary_connection_string}"
  }

  subnet_id = "${data.azurerm_subnet.azurerm_redis_cache.id}"

  # must be inside azurerm_virtual_network.azurerm_redis_cache address space
  private_static_ip_address = "10.230.0.10"

  # At the moment we need Premium tier even
  # in the test environment to support clustering
  family = "P"

  sku_name = "Premium"

  tags {
    environment = "${var.environment}"
  }
}

# Virtual network needed to deploy redis cache
resource "azurerm_virtual_network" "azurerm_redis_cache" {
  name                = "${local.azurerm_redis_vnet_name}"
  location            = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.azurerm_resource_group.name}"
  address_space       = ["10.230.0.0/16"]

  tags {
    environment = "${var.environment}"
  }
}

data "azurerm_subnet" "azurerm_redis_cache" {
  name                 = "default"
  virtual_network_name = "${local.azurerm_redis_vnet_name}"
  resource_group_name  = "${azurerm_resource_group.azurerm_resource_group.name}"
}

# Peering from the Redis Cache VNet to the AKS agent VNet
resource "azurerm_virtual_network_peering" "redis_to_aks" {
  name                         = "RedisToAks"
  resource_group_name          = "${azurerm_resource_group.azurerm_resource_group.name}"
  virtual_network_name         = "${azurerm_virtual_network.azurerm_redis_cache.name}"
  remote_virtual_network_id    = "${module.kubernetes.aks_vnet_id}"
  allow_virtual_network_access = "true"

  # NOTE: due to an issue with the Azure provider, once the two mutual
  # peerings gets created, on the next run it will attempt to recreate this
  # one due to the changed (computed) value of remote_virtual_network_id
  # We can safely ignore changes to remote_virtual_network_id.
  lifecycle {
    ignore_changes = ["remote_virtual_network_id"]
  }
}

# Peering from the AKS agent VNet to the Redis Cache VNet
resource "azurerm_virtual_network_peering" "aks_to_redis" {
  name                         = "AksToRedis"
  resource_group_name          = "${module.kubernetes.aks_rg_name}"
  virtual_network_name         = "${module.kubernetes.aks_vnet_name}"
  remote_virtual_network_id    = "${azurerm_virtual_network.azurerm_redis_cache.id}"
  allow_virtual_network_access = "true"
}

#
# Azure Container Service (Kubernetes)
#
locals {
  # The ssh public key for the admin account on the k8s nodes is read from the
  # file stored in the "files" directory and named after the value of the
  # variable "azurerm_kubernetes_admin_ssh_publickey_file"
  azurerm_kubernetes_admin_ssh_publickey = "${file("${path.module}/files/${var.azurerm_kubernetes_admin_ssh_publickey_file}")}"
}

module "kubernetes" {
  source = "./modules/azurerm/kubernetes"

  environment                     = "${var.environment}"
  resource_group_location         = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name             = "${azurerm_resource_group.azurerm_resource_group.name}"
  name                            = "${local.azurerm_kubernetes_name}"
  admin_username                  = "${var.azurerm_kubernetes_admin_username}"
  admin_ssh_publickey             = "${local.azurerm_kubernetes_admin_ssh_publickey}"
  agent_count                     = "${var.azurerm_kubernetes_agent_count}"
  agent_vm_size                   = "${var.azurerm_kubernetes_agent_vm_size}"
  service_principal_client_id     = "${data.azurerm_client_config.current.client_id}"
  service_principal_client_secret = "${var.ARM_CLIENT_SECRET}"
}

#
# Allocates a public IP for exposing the Kubernetes services
#
# This IP needs to be registered on the following CNAMEs:
#
# *.k8s.test.cd.teamdigitale.it (for the test environment)
# *.k8s.prod.cd.teamdigitale.it (for the production environment)
#

resource "azurerm_public_ip" "azurerm_kubernetes_public_ip" {
  name                         = "${local.azurerm_kubernetes_public_ip_name}"
  location                     = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name          = "${azurerm_resource_group.azurerm_resource_group.name}"
  public_ip_address_allocation = "static"

  tags {
    environment = "${var.environment}"
  }
}

output "azurerm_kubernetes_public_ip_ip" {
  value = "${azurerm_public_ip.azurerm_kubernetes_public_ip.ip_address}"
}

#
# PagoPA VPN
# Currently enabled only for test environment
#
# WARNING: see note in the module source about associating AKS agents to the
# backend pool.
#

module "pagopa_vpn" {
  source = "./modules/pagopa-vpn"

  # This resource must exist only in the "test" environment
  enable = "${var.environment == "test" ? "true" : "false"}"

  environment                  = "${var.environment}"
  azurerm_resource_name_prefix = "${var.azurerm_resource_name_prefix}"
  environment_short            = "${var.environment_short}"
  resource_group_location      = "${azurerm_resource_group.azurerm_resource_group.location}"
  resource_group_name          = "${azurerm_resource_group.azurerm_resource_group.name}"
  site_gateway_address         = "${var.pagopa_vpn_site_gateway_ip}"
  vpn_shared_key               = "${var.pagopa_vpn_shared_key}"
  aks_rg_name                  = "${module.kubernetes.aks_rg_name}"
  aks_vnet_id                  = "${module.kubernetes.aks_vnet_id}"
  aks_vnet_name                = "${module.kubernetes.aks_vnet_name}"
  aks_nsg_name                 = "${module.kubernetes.aks_nsg_name}"
  aks_nodes_cidr               = "${module.kubernetes.aks_nodes_cidr}"
  lb_ssh_key                   = "${local.azurerm_kubernetes_admin_ssh_publickey}"
}

output "pagopa_vpn_public_ip_ip" {
  value = "${module.pagopa_vpn.vpn_gateway_public_ip}"
}

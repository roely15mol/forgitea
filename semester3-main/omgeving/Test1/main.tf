module "lb" {
  source = "../../modules/LB"

  application_port = 80
  name             = "Loadbalancer1"
  location         = module.rg.location
  rgn              = module.rg.name
  ip               = module.network.public_ip
}

module "storage" {
  source = "../../modules/Storage"

  storageaccount = "coa1test1" # Moet uniek zijn in Azure
  sharename      = "coa1test1" 
  name           = module.rg.name
  location       = module.rg.location
}

module "database" {
  source = "../../modules/Database"

  name                 = "coa1test1" # Moet uniek zijn in Azure
  location             = module.rg.location
  rgn                  = module.rg.name
  mysql_admin_user     = "Testuser"
  mysql_admin_password = "Testww@123"
  dbname               = "wordpress"
}

module "rg" {
  source = "../../modules/Resourcegroup"

  resource_group_name = "coa1test1" # Moet uniek zijn in je account
  location            = "westeurope"
}

module "network" {
  source = "../../modules/Network"

  domainprefix = "coa1netwerk1" # Moet uniek zijn in azure
  name         = module.rg.name
  location     = module.rg.location

}

module "VMMS" {
  source = "../../modules/VMSS"

  name               = "ScaleGroup1"
  location           = module.rg.location
  rgn                = module.rg.name
  computernameprefix = "test1"
  admin_user         = "azureuser"
  admin_password     = "Testww@123"
  networkprofilename = "Testnw"
  lbbe               = module.lb.backendpool
  subnet             = module.network.subnet

  #variables for data.tf

  db_user              = module.database.dbusername
  db_password          = module.database.dbpassword
  db_name              = module.database.dbnaam
  db_adres             = module.database.dbadres
  file_share_name      = module.storage.fsn
  storage_account_key  = module.storage.sak
  storage_account_name = module.storage.StorageAccountName
  userdata = "userdata.tpl"
  
}

module "jumpbox" {
  source = "../../modules/Jumphost"

  name           = "jumpbox1"
  location       = module.rg.location
  rgn            = module.rg.name
  domainprefix   = "test" # Moet uniek zijn in Azure
  jumpboxname    = "jumpbox1"
  cn             = "jumpbox1"
  admin_user     = "azureuser"
  admin_password = "Testww@123"
  subnet         = module.network.subnet
}
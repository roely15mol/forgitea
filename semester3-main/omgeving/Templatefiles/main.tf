# Deze file is te gebruiken als Template file voor een nieuwe deployment.
# Verander alle waardes tussen {} en je bent klaar om te gaan. 



module "lb" {
  source = "../../modules/LB"

  application_port = 80
  name             = "Loadbalancer"
  location         = module.rg.location
  rgn              = module.rg.name
  ip               = module.network.public_ip
}

module "storage" {
  source = "../../modules/Storage"

  storageaccount = "{Vul_hier_storage_naam_in}" # Moet uniek zijn in Azure
  sharename      = "{Vul_hier_storage_share_naam_in}" 
  name           = module.rg.name
  location       = module.rg.location
}

module "database" {
  source = "../../modules/Database"

  name                 = "{Vul_hier_db_hostname_in}" # Moet uniek zijn in Azure
  location             = module.rg.location
  rgn                  = module.rg.name
  mysql_admin_user     = var.sqluser
  mysql_admin_password = var.sqlpassword
  dbname               = "wordpress"
}

module "rg" {
  source = "../../modules/Resourcegroup"

  resource_group_name = "{Vul_hier_resource_group_naam_in}" # Moet uniek zijn in je account
  location            = "{Location_invullen}"
}

module "network" {
  source = "../../modules/Network"

  domainprefix = "{Domein_naam_invullen}" # Moet uniek zijn in azure
  name         = module.rg.name
  location     = module.rg.location

}

module "VMMS" {
  source = "../../modules/VMSS"

  name               = "ScaleGroup"
  location           = module.rg.location
  rgn                = module.rg.name
  computernameprefix = "{Computernaam}"
  admin_user         = var.usernamewebserver
  admin_password     = var.passwordwebserver
  networkprofilename = "NetwerkProfiel"
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
  userdata             = var.userdata # User data moet in het mapje Userdata geplaatst worden. Hier alleen de file name opgeven de rest wordt geregeld. 
}

module "jumpbox" {
  source = "../../modules/Jumphost"

  name           = "JumpboxName"
  location       = module.rg.location
  rgn            = module.rg.name
  domainprefix   = "{Jumpbox_domein_invullen}" # Moet uniek zijn in Azure
  jumpboxname    = "JumpboxName"
  cn             = "JumpboxName"
  admin_user     = var.usernamejumpbox
  admin_password = var.passwordjumpbox
  subnet         = module.network.subnet
}
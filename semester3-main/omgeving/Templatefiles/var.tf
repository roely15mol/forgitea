variable "usernamejumpbox" {
    description = "Username voor de jumpbox"
}

variable "passwordjumpbox" {
    description = "Password voor de jumpbox"
}

variable "usernamewebserver" {
    description = "Username voor de webserver"
}

variable "passwordwebserver" {
    description = "Password voor de webserver"
}

variable "sqluser" {
    description = "Username voor de sql database"
}

variable "sqlpassword" {
    description = "Password voor de sql database"
}

variable "userdata" {
    description = "Vul hier de userdata file in die in het mapje Userdata staat. Verander de variabelen in /modules/VMSS/data.tf"
}
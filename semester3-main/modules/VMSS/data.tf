data "template_file" "userdata" {
    template = file("../../omgeving/Userdata/${var.userdata}")
    vars = {
        dbuser = "${var.db_user}",
        dbpassword = "${var.db_password}",
        dbname = "${var.db_name}",
        dbadres = "${var.db_adres}",
        Filesharename=  "${var.file_share_name}",
        Storageaccountkey = "${var.storage_account_key}",
        Storageaccountname = "${var.storage_account_name}"
    }
}


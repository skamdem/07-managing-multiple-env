resource "aws_db_instance" "default" {
  count               = var.create_db_and_s3 == true ? 1 : 0
  allocated_storage   = 10
  storage_type        = "standard"
  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  identifier          = "${var.subdomain}-db" //name of the RDS instance
  db_name             = var.db_name
  username            = var.db_user
  password            = var.db_pass // password for the master DB user
  skip_final_snapshot = true
}
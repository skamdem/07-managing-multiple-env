resource "aws_db_instance" "default" {
  allocated_storage   = 10
  storage_type        = "standard"
  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  identifier          = "${var.app_name}-${var.environment_name}"
  db_name             = var.db_name
  username            = var.db_user
  password            = var.db_pass
  skip_final_snapshot = true
}
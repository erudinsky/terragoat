resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = var.neptune-dbname
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = false
  apply_immediately                   = true
  storage_encrypted                   = false
  tags = {
    git_commit           = "357cfda6537fb099a2b46fde694a348e8e68c765"
    git_file             = "aws/neptune.tf"
    git_last_modified_at = "2021-09-11 09:29:28"
    git_last_modified_by = "evgeny.rudinsky@gmail.com"
    git_modifiers        = "evgeny.rudinsky"
    git_org              = "erudinsky"
    git_repo             = "terragoat"
    yor_trace            = "0d4cbb85-73ed-4ca0-b1da-296e4185f34e"
  }
}

resource "aws_neptune_cluster_instance" "default" {
  count              = 1
  cluster_identifier = aws_neptune_cluster.default.id
  engine             = "neptune"
  instance_class     = "db.t3.medium" # Smallest instance type listed for neptune https://aws.amazon.com/neptune/pricing/
  apply_immediately  = true
  #publicly_accessible                = true # No longer supported, API returns create error. See https://docs.aws.amazon.com/neptune/latest/userguide/api-instances.html#CreateDBInstance
  tags = {
    git_commit           = "357cfda6537fb099a2b46fde694a348e8e68c765"
    git_file             = "aws/neptune.tf"
    git_last_modified_at = "2021-09-11 09:29:28"
    git_last_modified_by = "evgeny.rudinsky@gmail.com"
    git_modifiers        = "evgeny.rudinsky"
    git_org              = "erudinsky"
    git_repo             = "terragoat"
    yor_trace            = "9b2b45fd-6f9f-44fd-b8bc-868b1db178b3"
  }
}

resource "aws_neptune_cluster_snapshot" "default" {
  db_cluster_identifier          = aws_neptune_cluster.default.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1"
}


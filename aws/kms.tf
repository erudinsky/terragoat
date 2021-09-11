resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  deletion_window_in_days = 7
  tags = {
    git_commit           = "357cfda6537fb099a2b46fde694a348e8e68c765"
    git_file             = "aws/kms.tf"
    git_last_modified_at = "2021-09-11 09:29:28"
    git_last_modified_by = "evgeny.rudinsky@gmail.com"
    git_modifiers        = "evgeny.rudinsky"
    git_org              = "erudinsky"
    git_repo             = "terragoat"
    yor_trace            = "cd8fa2a7-4868-4cd1-993d-da4644808ce5"
  }
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = "${aws_kms_key.logs_key.key_id}"
}

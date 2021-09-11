resource aws_ecr_repository "repository" {
  name                 = "${local.resource_prefix.value}-repository"
  image_tag_mutability = "MUTABLE"

  tags = merge({
    Name = "${local.resource_prefix.value}-repository"
    }, {
    git_commit           = "357cfda6537fb099a2b46fde694a348e8e68c765"
    git_file             = "aws/ecr.tf"
    git_last_modified_at = "2021-09-11 09:29:28"
    git_last_modified_by = "evgeny.rudinsky@gmail.com"
    git_modifiers        = "evgeny.rudinsky"
    git_org              = "erudinsky"
    git_repo             = "terragoat"
    yor_trace            = "7a3ec657-fa54-4aa2-8467-5d08d6c90bc2"
  })
}

locals {
  docker_image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${aws_ecr_repository.repository.name}"
}


resource null_resource "push_image" {
  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = <<BASH
    aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
    docker build -t ${aws_ecr_repository.repository.name} .
    docker tag ${aws_ecr_repository.repository.name} ${local.docker_image}
    docker push ${local.docker_image}
    BASH
  }
}
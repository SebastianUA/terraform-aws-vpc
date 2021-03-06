#---------------------------------------------------
# AWS VPC ipv4 cidr block association
#---------------------------------------------------
resource "aws_vpc_ipv4_cidr_block_association" "vpc_ipv4_cidr_block_association" {
  count = var.enable_vpc_ipv4_cidr_block_association ? 1 : 0

  vpc_id     = var.vpc_id != "" && ! var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
  cidr_block = var.vpc_ipv4_cidr_block_association_cidr_block

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.vpc_ipv4_cidr_block_association_timeouts
    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}

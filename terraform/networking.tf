resource "aws_vpc_endpoint" "bedrock" {
  vpc_id              = aws_vpc.agents.id
  service_name        = "com.amazonaws.${var.region}.bedrock-runtime"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${local.name_prefix}-vpce-bedrock" })
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.agents.id
  service_name    = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.private.id]

  tags = merge(var.tags, { Name = "${local.name_prefix}-vpce-s3" })
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = aws_vpc.agents.id
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${local.name_prefix}-vpce-secrets" })
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.agents.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${local.name_prefix}-vpce-logs" })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.agents.id
  tags   = merge(var.tags, { Name = "${local.name_prefix}-rt-private" })
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

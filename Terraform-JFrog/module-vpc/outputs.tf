output "subnet_id" {
    value = aws_subnet.main-public-1.id
}

output "vpc_id" {
    value = aws_vpc.main.id
}
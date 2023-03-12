
output "vpc_id" {
  value       = aws_vpc.development-vpc.id
  description = "The ID of the VPC"
}
################################################################
output "public_subnet_id_1" {
  value = element(aws_subnet.public-subnet-1.*.id, 0)
}
output "public_subnet_id_2" {
  value = element(aws_subnet.public-subnet-2.*.id, 0)
}
output "public_subnet_id_3" {
  value = element(aws_subnet.public-subnet-3.*.id, 0)
}

output "private_subnet_id_1" {
  value = element(aws_subnet.private-subnet-1.*.id, 0)
}
output "private_subnet_id_2" {
  value = element(aws_subnet.private-subnet-2.*.id, 0)
}
output "private_subnet_id_3" {
  value = element(aws_subnet.private-subnet-3.*.id, 0)
}
################################################################



output "public_subnet_ids" {
  value = [
    element(aws_subnet.public-subnet-1.*.id, 0),
    element(aws_subnet.public-subnet-2.*.id, 0),
    element(aws_subnet.public-subnet-3.*.id, 0)
  ]
  description = "All public subnet IDs created by the network module"
}

output "private_subnet_ids" {
  value = [
    element(aws_subnet.private-subnet-1.*.id, 0),
    element(aws_subnet.private-subnet-2.*.id, 0),
    element(aws_subnet.private-subnet-3.*.id, 0)
  ]
  description = "All private subnet IDs created by the network module"
}

# output "public_subnet_ids" {
#   value = [
#     "${element(aws_subnet.public-subnet-1.*.id, 0)}",
#     "${element(aws_subnet.public-subnet-2.*.id, 0)}",
#     "${element(aws_subnet.public-subnet-3.*.id, 0)}"
#   ]
#   description = "All public subnet IDs created by the network module"
# }

# output "private_subnet_ids" {
#   value = [
#     "${element(aws_subnet.private-subnet-1.*.id, 0)}",
#     "${element(aws_subnet.private-subnet-2.*.id, 0)}",
#     "${element(aws_subnet.private-subnet-3.*.id, 0)}"
#   ]
#   description = "All private subnet IDs created by the network module"
# }

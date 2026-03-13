output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main_cluster.name
}

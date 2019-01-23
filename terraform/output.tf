# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT IP-ADDRESS OF THE ELASTICSEARCH CLUSTER TO THE TERMINAL
# ---------------------------------------------------------------------------------------------------------------------

output "Elasticsearch-cluster instance IP address" {
  value = "${aws_instance.web_instance.public_ip}"
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT PUBLIC-DNS OF THE ELASTICSEARCH CLUSTER TO THE TERMINAL
# ---------------------------------------------------------------------------------------------------------------------

output "Elasticsearch-cluster DNS name" {
  value = "${aws_instance.web_instance.public_dns}"
}

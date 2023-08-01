variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "image_id" {
  description = "Disk image"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "zone" {
  description = "Zone of Cloud"
}
variable "sa_name" {
  description = "Service account name"
}
variable "k8s_version" {
  description = "Kubernetes version"
}
variable "folder_id" {
  description = "Folder ID"
}

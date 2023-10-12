output "nfs_mount_point" {
  value = "${local.file_share_ip[0]}:/${local.file_share_dir[0]}"
}
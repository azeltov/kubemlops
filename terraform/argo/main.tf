module "common-provider" {
  source = "../provider"
}

resource "null_resource" "deploy_argo" {
  count = var.enable_flux ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'Need to use this var so terraform waits for kubeconfig ' ${var.kubeconfig_complete};KUBECONFIG=${var.output_directory}/${var.kubeconfig_filename} ${path.module}/deploy_argo.sh"
  }

  triggers = {
    enable_flux   = var.enable_flux
    flux_recreate = var.flux_recreate
  }
}

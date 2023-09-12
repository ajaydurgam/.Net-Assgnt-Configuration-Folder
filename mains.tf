# Define a null_resource to run local-exec provisioners
resource "null_resource" "install_iis_dotnet" {
  # Trigger this resource whenever Terraform is initialized or when you explicitly apply changes
  triggers = {
    always_run = "${timestamp()}"
  }

  # Execute a local PowerShell script to install IIS and .NET features
  provisioner "local-exec" {
    command = "powershell.exe"
    inline = [
      "Install-WindowsFeature -Name Web-Server -IncludeManagementTools",
      "Install-WindowsFeature -Name Web-ASP",
      "Install-WindowsFeature -Name Web-Net-Ext45",
      "Install-WindowsFeature -Name Web-ISAPI-Ext",
      "Install-WindowsFeature -Name Web-ISAPI-Filter",
      "Install-WindowsFeature -Name Web-Mgmt-Console"
    ]
  }
}

# Output to indicate that IIS and .NET features installation is complete
output "iis_dotnet_installed" {
  value = "IIS and .NET features installation is complete."
}
#resource "azurerm_resource_group" "aks-getting-started" {
#  name     = "aks-getting-started"
#  location = var.location
#}

resource "azurerm_kubernetes_cluster" "aks-getting-started" {
  name                  = "tstk8cluster"
  location              = "eastus"
  resource_group_name   = "tstk8grp"
  dns_prefix            = "tstk8grp-dns"            
  kubernetes_version    =  var.kubernetes_version
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_E4s_v3"
    type       = "VirtualMachineScaleSets"
    os_disk_size_gb = 250
  }

  service_principal  {
    client_id = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  linux_profile {
    admin_username = "azureuser"
    #ssh_key {
    #    key_data = var.ssh_key
    #}
  }

  network_profile {
      network_plugin = "kubenet"
      load_balancer_sku = "Standard"
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }

    
    }
  }




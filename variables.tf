variable "vnets" {
  description = "value"
  type = map(object({
    address_space = list(string)
    subnets = map(object({
      address_prefixes = list(string)
    }))
  }))
  default = {
    "vnet1" = {
      address_space = ["10.10.10.0/24"]
      subnets = {
        "snet1" = {
          address_prefixes = ["10.10.10.0/25"]
        }
        "snet2" = {
          address_prefixes = ["10.10.10.128/25"]
        }
      }
    }
    "vnet2" = {
      address_space = ["10.10.20.0/24"]
      subnets = {
        "snet1" = {
          address_prefixes = ["10.10.20.0/25"]
        }
        "snet2" = {
          address_prefixes = ["10.10.20.128/25"]
        }
      }
    }
  }
}
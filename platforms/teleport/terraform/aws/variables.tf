variable "namespace" {
    type    = string
    default = "teleport"
}

variable "appname" {
    type    = string
    default = "teleport"
}

variable "imagesecret" {
    type    = string
    default = "regcred"
}

variable "base_domain" {
    type    = string
    default = "ci.teleport.com"
}
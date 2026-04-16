variable "project_id" {
  description = "ID вашого GCP проєкту"
  type        = string
  default     = "exam-462809"
}

variable "name_prefix" {
  type    = string
  default = "kravchuk"
}

variable "region" {
  description = "Регіон GCP (найближчий до України)"
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "Зона GCP"
  type        = string
  default     = "europe-central2-a"
}
provider "google" {
  project = "mario-castro-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yml")}"
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/540829645030"
}

resource "google_folder" "TI" {
  display_name = "TI"
  parent       = "organizations/540829645030"
}

resource "google_folder" "RH" {
  display_name = "RH"
  parent       = "organizations/540829645030"
}

resource "google_folder" "SAP" {
  display_name = "SAP"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "DEV" {
  display_name = "DEV"
  parent       = google_folder.TI.name
}

resource "google_folder" "INFRA" {
  display_name = "Infraestrutura"
  parent       = google_folder.TI.name
}

resource "google_folder" "Producao" {
  display_name = "PROD"
  parent       = google_folder.DEV.name
}

resource "google_folder" "Teste" {
  display_name = "Teste"
  parent       = google_folder.DEV.name
}

resource "google_folder" "Servicos" {
  display_name = "Servicos"
  parent       = google_folder.RH.name
}

resource "google_project" "mario-castro-financeiro" {
  name       = "castro-sap"
  project_id = "bdevops-375215"
  folder_id  = google_folder.Financeiro.name
  auto_create_network=false
  billing_account = "018973-A8340F-83D8E5"
}

resource "google_project" "mario-castro-ti" {
  name       = "castro-dev"
  project_id = "bdevops-375215"
  folder_id  = google_folder.TI.name
  auto_create_network=false
  billing_account = "018973-A8340F-83D8E5"
}

resource "google_project" "mario-castro-rh" {
  name       = "castro-rh"
  project_id = "bdevops-375215"
  folder_id  = google_folder.RH.name
  auto_create_network=false
  billing_account = "018973-A8340F-83D8E5"
}

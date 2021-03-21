# terraform-valheim

Some templates to deploy valheim server. Could be a lot more abstract, just need a server real quick.

## Usage

### Setup gcloud CLI

1. Download and install the [gcloud sdk](https://cloud.google.com/sdk/docs/install)
2. Run `gcloud init`
3. Select your project and accept the oauth prompt
4. Run `gcloud auth application-default login` and accept the oauth prompt

### Setup terraform
1. Download and install terraform 0.11.13
2. Update `var.provider_project_id` in `provider-variables.tf` with the same project ID
... todo, generate ssh keys instead of the coded paths, assumes you have an ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub already
3. Run `terraform init`
4. Run `terraform apply -target=google_project_service.compute`
5. Run `terraform apply`

### Troubleshooting

The machine which you used to provision these templates is allowed through the firewall, so you can get the current IP of the provisioned instance like:
```sh
terraform state show google_compute_instance.this | grep nat_ip
```

Then ssh there via `ssh ubuntu@<the-ip-from-above>`

In it's current form, there is a systemd service unit of the app, so you can:
```sh
journalctl -fu valheim
```

### Restoring from backup

By default, backups of the world are zipped every hour under `/var/lib/valheim/valheim/config/backups`. If you override `${var.server_name}` to 'example' it would be `/var/lib/valheim/example/config/backups`.

Using the 'example' world, say you have a zipped backup named `/tmp/worlds-20210321-020002.zip`. You would need to provision a new server or reusing an existing deployment, then:
```sh
service valheim stop
pushd /var/lib/valheim/example/config
unzip -o /tmp/worlds-20210321-020002.zip
service valheim start
```

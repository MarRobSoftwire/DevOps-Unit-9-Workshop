#! /usr/bin/env bash -ex

read -p "Enter Your Resource Group Name: " ResourceGroupName
read -p "Enter a short prefix for your Azure Resources (lowercase with no spaces): " ResourcePrefix
read -p "Enter a password for your database: " DatabasePassword

az deployment group create \
    --resource-group $ResourceGroupName \
    --template-file scenario.bicep \
    --parameters resourcePrefix=$ResourcePrefix administratorLoginPassword=$DatabasePassword

# Install sqlcmd (from https://github.com/microsoft/go-sqlcmd/releases/tag/v1.8.2)
curl -L https://github.com/microsoft/go-sqlcmd/releases/download/v1.8.2/sqlcmd-linux-amd64.tar.bz2 -o sqlcmd.tar.bz2
tar xf sqlcmd.tar.bz2 -C .

./sqlcmd \
    -S $ResourcePrefix-non-iac-sqlserver.database.windows.net \
    -d $ResourcePrefix-non-iac-db \
    -U dbadmin \
    -P $DatabasePassword \
    -i db_setup.sql

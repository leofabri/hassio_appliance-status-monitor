# Main branch = the latest stable version
Some people asked why this repo is organized the way it is. 

Repositories usually work differently: the main branch has the latest modifications. This one doesn't.

### Here's why

In this project, <u>the main branch represents the latest stable release.</u>
Home Assistant doesn't have an easy way to help users to update their blueprints. I initially made this choice so that when someone tries to use the [![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https%3A%2F%2Fgithub.com%2Fleofabri%2Fhassio_appliance-status-monitor%2Fblob%2Fmain%2Fappliance-status-monitor.yaml) button, the link stays the same. 

The same result could have been achieved by creating a release branch. Maybe this will change in the future.
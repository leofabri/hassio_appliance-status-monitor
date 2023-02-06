# Upgrade to Appliance Status Monitor V3.0.0 via terminal

## Replace the existing blueprint in one go
1. Open your VSCode terminal on Home Assistant.
2. Run the following command:

    ```bash
    cd /config/blueprints/automation/leofabri && curl -sSL https://raw.githubusercontent.com/leofabri/hassio_appliance-status-monitor/release/v3.0.0-dev/appliance-status-monitor.yaml -O
    ```


## Create helpers for your washing machine
1. Find your washing machine package (it should be inside of /config/packages) and delete it.
2. Open the terminal in your VSCode and run the following command:

    ```bash
    mkdir -p /config/packages/appliances/washing_machine && cd /config/packages/appliances/washing_machine && curl -sSL https://raw.githubusercontent.com/leofabri/hassio_appliance-status-monitor/release/v3.0.0-dev/home%20assistant/packages/washing_machine/asm_washing_machine.yaml -O
    ```


## Verify/Reboot Home Assistant
1. Verify that the new package has been created inside the washing_machine folder
2. Reboot Home Assistant

## Replace the existing automation for your washing machine
1. Open your existing Washing Machine Automation
2. Click "Edit in YAML"
3. Copy and save the content you see on your PC because we are going to replace it entirely.
4. Replace its content with https://raw.githubusercontent.com/leofabri/hassio_appliance-status-monitor/release/v3.0.0-dev/home%20assistant/pre_configurations/ui/asm_washing_machine_ui_starter.yaml
5. Remember to set the following values: 
   - appliance_socket
   - appliance_power_sensor
   - appliance_starting_power_threshold
   - appliance_finishing_power_threshold
6. You can also use the visual mode to do this. The values of these variables should match the ones of the old yaml you saved in step 3.
7. Save and perform step 2 once more.

## Additional Configuration
1. From now on, if you need to configure more appliances, please refer to the new V3 guide [here]().

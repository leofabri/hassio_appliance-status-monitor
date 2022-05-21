# 🔌 Detect and monitor the status of an appliance based on its power consumption - V. 2.0.0-beta ✨
### Automation Blueprint for Home Assistant

<br>

> ## Warning! This needs more testing, and could potentially break the existing automation!
> It's a beta, it'll be merged when ready.

<br>

<p align="center">
  <img width="240" height="auto" alt="Monitor the status of an appliance - by leofabri" src="automation-tree.png">
</p>


Here's the automation I made to control the status of the most power-hungry appliances in my house. I like to think that I can automate my machines without wasting money to buy them new. Here I'm offering a cheap and simple solution that just works.

I use this for my dishwasher and washing machine, and so far the results have been great! 
My family ❤️s it! Even if they don't really get what's the fuss about this intricate thing. 

I'm sharing this with everyone, hoping that you'll find it useful.

## 📋 Features

For the record: there is more inside. Anyways, here's a summary:

*   **Set your own custom actions** for each of the following states:
    *   On Start
    *   On Finish
    *   On Resume After Overload
    *   On Powered Again After Overload
*   **The appliance has its own** [**State Machine**](https://en.wikipedia.org/wiki/Finite-state_machine)
    *   You can tell if it's in one of the following states:
        *   unplugged
        *   idle
        *   paused
        *   job\_ongoing
        *   job\_completed
    *   <strong>Note:</strong> Each state transition is handled automatically, you just have to provide the initial configuration.
*   **More triggers: more control,** even if Home Assistant reboots!
    *   This automation is triggered on each power read. I'm doing the starting/finishing thresholds magic in the "actions" section, and you can also add some of your own. 
The objective of this automation is to permit a more granular control over what's happening. There might be better ways of doing this. If you know one, feel free to share it!
*   **Faster machine start-to-finish detection**: one of the problems that I always face is timing. <i>What if you want to measure how long it took for your appliance to complete its job?</i> The automation has to be <strong>very reactive</strong>. This logic should solve that problem for you.
*   **Unreliable power absorption filtering and inhibition**: prevents the blueprint from thinking that a job was completed as soon as the power falls below the finishing power threshold.
  
<br>

Interested? Let's dive in!
## What do I need to run this blueprint? 🗸

### Premise
> <i>Please consider that this blueprint is shared as-is, and even if it fits my use case, it might not be the same for you.</i>


To achieve this level of control the socket must have some basic features, like: 
- power monitoring (polling rate of a maximum of 60 sec for best results)
- ON/OFF control over HASSIO
- status reporting

Mine is a <strong>Meross MSS310EU</strong>, but it shouldn't be that important.

- To get the pause state to work properly, you also need another automation that can detect an overload. I'm not the author of any of that, but the one I'm using is [here](https://github.com/andbad/HA_PowerControl) (disclaimer: it's just in Italian 🍝). <br>

...

## Let's make some helper variables (<i style="text-color: red">mandatory</i>)
To make those, head over to `configuration.yaml` and add the following pieces of code:
### 1. The State Machine

```yaml
input_select:
  <your_appliance_name>_state_machine:
    name: <Your Appliance Name> - State Machine
    options:
      - unplugged
      - idle
      - paused
      - job_ongoing
      - job_completed
    icon: mdi:<your_appliance_icon>
  # ... <- Your other input_select(s) (if you have any)
```


### 2. The Job Cycle indicator

```yaml
input_boolean:
  <your_appliance_name>_job_cycle:
    name: <Your Appliance Name> - Job Cycle
    icon: mdi:<your_appliance_icon>

  # ... <- Your other input_boolean(s) (if you have any)
```

### 3. The delay timer (🆕 <i>added in version V2.0.0</i>)

```yaml
timer:
  <your_appliance_name>_delayed_job_completion_timer:
    name: <Your Appliance Name> - Delayed Job Completion Timer
    duration: "00:15:00" # <- Note that the time here. Leave it 15 min
    restore: true
    icon: mdi:<your_appliance_icon>

  # ... <- Your other timers (if you have any)
```

### 4. The automation self-trigger (🆕 <i>added in version V2.0.0</i>)
```yaml
input_boolean:
  <your_appliance_name>_automation_self_trigger:
    name: <Your Appliance Name> - Automation Self-trigger
    icon: mdi:<your_appliance_icon>

  # ... <- Your other input_boolean(s) (if you have any)
```

Important! Please make sure to edit all the fields `<your_appliance_name>`, `<Your Appliance Name>` and `<your_appliance_icon>` accordingly.

```yaml
# Example (Washing Machine):
#
# <your_appliance_name> = washing_machine
# <Your Appliance Name> = Washing Machine
# <your_appliance_icon> = washing-machine (taken from here https://materialdesignicons.com/)

# # # Result:
# # input_select:
# #   washing_machine_state_machine:
# #     name: Washing Machine - State Machine
# #     options:
# #       - unplugged
# #       - idle
# #       - paused
# #       - job_ongoing
# #       - job_completed
# #     icon: mdi:washing-machine

# # and so on ...
```
If you need it, check out the [`config.yaml`](examples/configuration.yaml) example I prepared.

# ➕ Download & Import
If you have just created your helpers, please reboot Home Assistant ([at this page](https://my.home-assistant.io/redirect/server_controls/) -> Verify & if okay, Reboot)

1.  Add this blueprint to your Home Assistant ➡️  [![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https%3A%2F%2Fgithub.com%2Fleofabri%2Fhassio_appliance-status-monitor%2Fblob%2Fmain%2Fappliance-status-monitor.yaml)
2.  Create a New Automation from that blueprint
3.  Configure the variables as indicated inside the blueprint's UI

Have fun!
### Congratulations! Your appliance is now smarter 🧠
<br>
<br>

___
<br>
<br>


# 📯Important notice! 🚨
### 🆕 The code has been updated
1. **Version 2.0.0 of 05/20/2022** - [**MAJOR**] Introduces some new features:


   - **+ADDED+ Low Power Threshold -> job_completed inhibition**: [@siklosi](https://community.home-assistant.io/t/detect-and-monitor-the-status-of-an-appliance-based-on-its-power-consumption-updated-v1-0-1/421670/4?u=leofabri) found that some appliances may intermittently absorb less than the Low Power Threshold, and that causes the automation to act like if multiple jobs were started and finished consecutively.
  
      This version aims to fix this issue by waiting and checking if, during that period, the appliance's power consumption rises again. 
      The only disadvantage here is that waiting for a long time means that a possible job length estimate is less accurate, because the state machine is not as reactive.
  
    - **+ADDED+ Automation can now trigger itself**: This is very useful, because in a case like the above, when the appliance consumes 0 Watts steadily, there is no trigger as no change in power absorption is detected. The self-triggering solution will now prevent it from being 'stuck' in the same state because of this problem.

    - **/CHANGED/** The automation now runs in restart mode, not in single-mode anymore. I did this because I am prioritizing the trigger over the internal checks.
  
    > More details below (*if you are installing the blueprint for the first time, you can discard this message*)

   **To update:** 
   * open this page [![Open your Home Assistant instance and show your blueprints.](https://my.home-assistant.io/badges/blueprints.svg)](https://my.home-assistant.io/redirect/blueprints/) (just click the link, it's magical) and scroll till you find "*Monitor the status of an appliance - by leofabri*" and delete it by clicking on the trash bin 🗑. Don't worry, we'll add it right back in a few sec, you can leave the automation as it is for now.
   * Create the missing helpers (entities) as shown in the instructions
   * add the blueprint again [![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https%3A%2F%2Fgithub.com%2Fleofabri%2Fhassio_appliance-status-monitor%2Fblob%2Fmain%2Fappliance-status-monitor.yaml) and reload home assistant.
   * Open your automation and add the previously created helpers (entities)
  
  <br>

  
                            -- older versions below ---

2. **[Version 1.0.1 of 05/16/2022](https://github.com/leofabri/hassio_appliance-status-monitor/tree/V1.0.1)** - [**FIX!**] *Fixes the error of the 'idle' state which was not working correctly.*
    

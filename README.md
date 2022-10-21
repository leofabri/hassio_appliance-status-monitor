# This is the development branch - V3.0.0 is still under development

# 🔌 Detect the state of your appliances based on their power consumption - V3.0.0 ✨
### Automation Blueprint for Home Assistant

<br>

<p align="center">
  <img width="240" height="auto" src="assets/automation-tree.jpg" alt="Monitor the state of an appliance - by leofabri"/>
</p>

<p align="center" position="absolute">
  <img width="120" height="auto" src="assets/washing_machine_widget.jpg" alt="Monitor the state of an appliance - by leofabri"/>
  <img width="320" height="auto" src="assets/washing_machine_widget_markdown.jpg" alt="Monitor the state of an appliance - by leofabri"/>
</p>

# **Introduction**

This automation can detect what your appliances are doing, inferring their state from power consumption. All you need is a smart socket with a power monitoring feature.

## Why does this exist?

There aren’t numerous blueprints that do what I need, and I want to automate my machines without wasting money to buy them new. Here’s my cheap and reliable solution that addresses the problem, once and for all.

## Use-cases
I use this for my dishwasher, my washing machine, the electric bicycle and my desk. The results have been great! The blueprint is very extensible and easy to use.

My family ❤️ this thing! Even if they don’t understand what all the fuss is about.

I’m sharing this with everyone. I’m sure that you’ll find it useful!

---
# **Features**

For the record: there is more inside. Here's a summary of the most remarkable ones:
*   🎛️ **More triggers: more control,** <u>even across Home Assistant reboots!</u>
    **This automation is triggered on each power read**. I'm placing the starting/finishing thresholds magic in the "actions" section, and you can also add some of your own.
    The goal is to allow a more granular control over what's happening. We also want to do that reliably.

*   ⏱️ **Faster machine start-to-finish detection**: one of the problems that I always face is **timing**. <i>What if you want to measure how long it took for your appliance to complete its job?</i> The automation has to be <strong>very reactive</strong> and detect a state change as fast as possible. This logic should solve that problem for you.
  
*   📉 **Unreliable power absorption filtering and inhibition**: This is useful! It prevents the blueprint from thinking that a job was completed as soon as the power falls below the finishing power threshold. The same option is present for the starting power threshold. You can tune this to your needs.
  
*   📅 **Set your own custom actions** for each of the following conditions (OPTIONAL):
      * #Overloads (if used):  
        * when an overload occurs
        * when the overload situation is solved, now paused
        * when the overload situation is solved, now resuming
      * #Socket state change (On <-> Off):
        * when the appliance is plugged back in, now paused
      * #Job-cycle based:
        * when a new job cycle begins
        * when a job cycle resumes
        * when a job cycle is finished

*   🥷 **The appliance has its own** [**State Machine**](https://en.wikipedia.org/wiki/Finite-state_machine)
    *   Meaning that you can tell if it's in one of the following states:
          - <strong><u><ins>unplugged</ins></u></strong> - means that the appliance is no longer powered. 
            It happens when the user manually turns off the smart socket (from HA or the socket itself).
            
          - <strong><u><ins>idle</ins></u></strong> - There is no pending job, the machine is powered but idling.
            
          - <strong><u><ins>paused</ins></u></strong> - Indicates that a job is pending (incomplete cycle) but the appliance is not performing it. The inhibitors of these state are the <strong><i>detached_overload</i></strong> and <strong><i>unplugged</i></strong> states. 
            In this condition, the Power absorption is lower than the finishing power threshold. The appliance must be off (the user may have turned it off manually, or maybe the job needs some time to recover).
            The blueprint is now waiting for the appliance to resume.

            <strong>Pro Tip!</strong> You could use this state to diagnose and warn if a job is not resumed after x minutes. 
            
          - <strong><u><ins>detached_overload</ins></u></strong> - This happens when, during a cycle, the appliance used too much power and was therefore suspended. It is also technically unplugged.
            
          - <strong><u><ins>job_ongoing</ins></u></strong> - Triggered in two situations:
              - **when a new job cycle begins**: the previous one is completed and the Starting Power threshold is surpassed (with the possibility of selecting for how long).
              - **when a job is resumed**.
              
          - <strong><u><ins>job_completed</ins></u></strong> - Triggered when the current incomplete job cycle is finished. The appliance uses less power than the Finishing Power threshold (with the possibility of selecting for how long).


        <strong>Note:</strong> Each state's transition is handled automatically, you just have to provide the initial configuration.
<br>

# Installation

---
## 📋**Requirements:** What do I need to run this blueprint?

To achieve this level of control **the socket has have some basic features**: 
- Power monitoring (a polling rate of circa 60 sec. or less for best results)
- ON/OFF control over Home Assistant
- State reporting (if it's ON or OFF)

Mine is a <strong>Meross MSS310EU</strong>, but all the smart sockets with the mentioned features should be supported.

### One more thing:
- <u>OPTIONAL:</u> To get **the pause state** to work properly, **you also need another automation that can detect an overload**. I'm not the author of that, but the one I'm using is [here](https://github.com/andbad/HA_PowerControl) (disclaimer: it's just in Italian 🍝). <br>

---

## ⚙️ **Setup:** Let's make some helper variables (<i style="text-color: red">mandatory!</i>)
There are **two possible ways** of doing this:

- **Setup via the UI [Discouraged but Beginner Friendly]:** newcomers that might be a little into shiny-but-dark UIs 😎 might want to do the set up following [this documentation here](Alternative%20UI%20Setup.md).

  

- <u>**Setup via the old school YAML [Optimal & Suggested]:**</u> The best way of creating what we need is to create a package (suggestion provided by [@HollyFred](https://github.com/leofabri/hassio_appliance-status-monitor/issues/8#issue-1304478600)) because it allows us to create all the necessary helpers (timers, input_booleans...) in one shot. <i>Continue reading for this one</i> ⬇️

Creating a package is super easy. Some of you may already have the right configuration in place, but I'll show you how to do that anyway.

> Note: you need to have the VS Code integration enabled. This will allow you to manually edit the necessary files. Need help with that? [Read this](https://www.home-assistant.io/docs/configuration/).

Back to us, here are the two steps for creating a package:

1. **Make sure that you have a directory called 'packages'**.
   
    If you are a beginner, or you are starting fresh with your HA installation, likely, the `packages` dir is not present.
   
   To add it, you can:
   > Open your HomeAssistant VS Code editor and create a directory called `packages` (<u>at the same level as the configuration.yaml</u> file).
  
   OR

   > Issue this command in the terminal section of your VS Code:
   >
   >  ```
   > cd /config && mkdir packages
   > ```
   > Easy-peasy.


   <u>**Result:**</u> You should see the packages' directory <u>**at the same level**</u> as the `configuration.yaml` file.


2. **Make sure that the packages support is enabled** inside the [`configuration.yaml`](home%20assistant/configuration.yaml) file as shown below:

    ```yaml
    homeassistant:
      packages: !include_dir_named packages/ ## Packages support enabled - Includes every .yaml file that is inside the packages/ directory
      ## Warning! Please pay attention to the indentation!
    ```

## Helpers creation
**We'll put all the helpers in a package, organized by appliance**. Now we are ready to create our first package.

<strong>PRESETS</strong> - These are vital if you want to simplify this setup even more, check out one of the already pre-made [packages](home%20assistant/packages/README.md) I prepared for you ([Washing Machine](home%20assistant/packages/washing_machine.yaml), [Dryer](home%20assistant/packages/dryer.yaml), [Dishwasher](home%20assistant/packages/dishwasher.yaml) and more are among the already supported ones).

---

## ➕ **Download & Import**
>Are you **trying to update** to a newer version? [Let's do that in a snap! Follow this guide](#to-update).

If you have just created your package, please reboot Home Assistant ([at this page](https://my.home-assistant.io/redirect/server_controls/) → Verify & if okay, Reboot)

1.  Add this blueprint to your Home Assistant [![Open your Home Assistant instance and show the blueprint import dialog with a specific blueprint pre-filled.](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?blueprint_url=https%3A%2F%2Fgithub.com%2Fleofabri%2Fhassio_appliance-status-monitor%2Fblob%2Fmain%2Fappliance-status-monitor.yaml)
2.  Create a New Automation from that blueprint
3.  Configure the variables as indicated inside the blueprint's UI.
   
That's it!

---

## 🪛 **Tuning the values**

Please refer to the guide [here](How%20to%20find%20the%20right%20Power%20Thresholds.md).

---

## **Final results** 🎉
### You should see the 4 new entities:

> <strong>Warning |</strong> always use those entities as indicators, do not change their values manually! Leave that to your automation

<figure align="center">
  <img src="assets/washing_machine-entities-example.jpg" alt="my alt text"/>
  <figcaption><p align="center">Washing Machine entities</p></figcaption>
</figure>

### During a job cycle:

<figure align="center">
  <img src="assets/washing_machine-power-example.jpg" alt="power usage example"/>
  <figcaption><p align="center">This is my washing machine. Power usage example</p>
</figcaption>
</figure>

<figure align="center">
  <img src="assets/appliance-history.jpg" alt="appliance history image"/>
  <figcaption><p align="center">The State machine. The one in light blue is a simulated overload situation.</p>
</figcaption>
</figure>


## Congratulations! Your appliance is now smarter 🧠
<br>
<br>

___
<br>
<br>


# Versions & Changelogs:
## 📯Important notice! 🚨
### 🆕 The code has been updated

## - Version 3.0.0

> ---
> The changes related to the **older versions** are <u>[here](older_versions_changelog.md)</u>.

<br>

---

<br>

# **How do I know if there is a new version?**
[**Read here**](./Frequent%20Questions%20and%20Answers.md/#../How%20to%20find%20the%20right%20Power%20Thresholds.md)

<br>

#  <p id="update">**How to update:**</p>
[Learn how](./Frequent%20Questions%20and%20Answers.md/#how-to-update)

<br>

# Q&A - Things you may want to know
[See the dedicated documentation](Frequent%20Questions%20and%20Answers.md)
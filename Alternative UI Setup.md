# Introduction
Some of you asked to document how to make the helpers using the Home Assistant UI instead of the editor.

While I do agree that this might be useful for newcomers, I still believe that using the old good VS Code .yaml solution is indeed the better option. 

Having the .yaml configuration in place allows you to make your Home Assistant setup more modular and portable. You choose how to organize the helpers, and the overall result it's just better in my opinion. 

However, if we truly want to make Home Assistant easier for less techie people, we still need to provide an easier way of creating helpers. 

## Using the Helpers UI 📱

This is how you do that within the home assistant UI:

1. Go to the Helpers' page of your instance: [![Open your Home Assistant instance and show your helper entities.](https://my.home-assistant.io/badges/helpers.svg)](https://my.home-assistant.io/redirect/helpers/)
2. Select "Create Helper" and now, Create these:

>**Important!** Don't forget to edit all the fields `<your_appliance_name>`, `Your Appliance Name` and `<your_appliance_icon>` accordingly.

   1. **Type:** Dropdown (The State machine)<br>
      **Name:** Your Appliance Name - State Machine<br>
      **Icon:** mdi:<your_appliance_icon><br>
      **Options:**        
        - unplugged<br>
        - idle<br>
        - paused<br>
        - detached_overload<br>
        - job_ongoing<br>
        - job_completed<br>
  
        Please respect the underscores and the lowercase letters. These states are very important and all needed.

   2. **Type:** Button (The Job Cycle indicator)<br>
      **Name:** Your Appliance Name - Job Cycle<br>
      **Icon:** mdi:<your_appliance_icon><br>


   3. **Type:** Timer (The State machine)<br>
      **Name:** Your Appliance Name - Delayed Job Completion Timer<br>
      **Icon:** mdi:<your_appliance_icon><br>
      **Duration:** 00:15:00 (leave it 15 minutes)<br>
      **Restore:** Checked, True

   4. **Type:** Button (The automation self-trigger)<br>
      **Name:** Your Appliance Name - Automation Self-trigger<br>
      **Icon:** mdi:<your_appliance_icon><br>


Done!

---

## Next Up: [You can now proceed with the Download & Import of the Blueprint](#-download--import)
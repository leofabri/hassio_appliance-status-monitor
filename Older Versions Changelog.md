## Changelogs

These are the released versions of the blueprint. 
The current release is always shown in the main [README.md](/README.md) file.

---
2. [**Version 2.1.1 of 07/21/2022**](https://github.com/leofabri/hassio_appliance-status-monitor/tree/release/v2.1.1) - [**FIX!**]
   - Fixed [this bug](https://community.home-assistant.io/t/detect-and-monitor-the-state-of-an-appliance-based-on-its-power-consumption-v2-1-0/421670/37?u=leofabri):
    > ### Description:      
    > When you don’t indicate the Appliance suspended entity - which I
    > marked as optional - the automation becomes unresponsive, thus making the optional value a
    > required one.<br>

  - Added some new documentation. You can decide to make your helpers through the UI instead of VS Code.
  - We are now using packages instead of overloading the configuration.yaml file with the helpers.

3. [**Version 2.1.0 of 05/31/2022**]() - [**FIX!** | **IMPROVEMENTS**] 
   - Fixes an issue with the timer that was restarting indefinitely. The delay should now be working.
   - Added two more triggers: when HA starts, when the automation is reloaded.
   - The description inside the automation has been updated/improved.
   - The order of definition of the input entities is now different.
   - There's a new version tag visible inside the blueprint's description.

4. [**Version 2.0.0 of 05/20/2022**](https://github.com/leofabri/hassio_appliance-status-monitor/tree/v2.0.0) - [**MAJOR UPDATE**] Introduces a ton of new features:

   - **±FIXED± some subtle 🐛🐛🐛**: I hate bugs (the coded ones of course)! I did notice some strange and unwanted behavior during some state transitions. V1.0.1 seems to become unreliable when the user manually turns on and off the smart socket. This is a fix to that and to other smaller things.

   - **+ADDED+ Low Power Threshold → job_completed inhibition**: [@siklosi](https://community.home-assistant.io/t/detect-and-monitor-the-status-of-an-appliance-based-on-its-power-consumption-updated-v1-0-1/421670/4?u=leofabri) found that some appliances may intermittently absorb less than the Low Power Threshold, and that causes the automation to act like if multiple jobs were started and finished consecutively.
  
      This version aims to fix this issue by waiting and checking if, during that period, the appliance's power consumption rises again. 
      The only disadvantage is that waiting for a long time also means that a possible job length estimate is less accurate because the state machine is not as reactive.
  
    - **+ADDED+ Automation can now trigger itself**: This is very useful because in a case like the above, when the appliance consumes 0 Watts steadily, there would be no trigger, as no change in power absorption is detected. The self-triggering solution will now prevent it from being 'stuck' in the same state because of this problem.
  
    - **+ADDED+ detached_overload state**: The new detached_overload state was introduced to make things tidier and clearer to understand. The pause state indicates that the appliance is not resuming the previous job.

    - **/CHANGED/** The automation now runs in restart mode, not in single-mode anymore. I did this because I am prioritizing the trigger over the internal checks.


5. **[Version 1.0.1 of 05/16/2022](https://github.com/leofabri/hassio_appliance-status-monitor/tree/release/v2.1.0)** - DEPRECATED - [**FIX!**] *Fixes the error of the 'idle' state which was not working correctly.*
    

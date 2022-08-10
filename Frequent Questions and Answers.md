# Q&A - Things you may want to know

### `#general`

* **<ins>Is this able to survive reloading automations and Home Assistant?</ins>** —  Yes!

* **<ins>Why is this thing so big? That monstrosity doesn't even show correctly on my small screen!</ins>** —  I know 😅. There are many conditions, and those increase the visual width of the blueprint in the UI. On mobile devices, it's going to be a pain, but what's important here is that things work and that all the possible situations are handled.

* **<ins>How is this different when compared to [Notify or do something when an appliance like a dishwasher or washing machine finishes](https://community.home-assistant.io/t/notify-or-do-something-when-an-appliance-like-a-dishwasher-or-washing-machine-finishes/254841)?</ins>** —  It's very, very different and much more articulated. [Read here for more info](https://community.home-assistant.io/t/notify-or-do-something-when-an-appliance-like-a-dishwasher-or-washing-machine-finishes/254841/131?u=leofabri).

* **<ins>Will this slowdown Home Assistant?</ins>** — Nope. The blueprint will run every time a new power read is polled or sent to HA. If there's no state change, the automation is basically doing nothing and completes super quickly.

* **<ins>How do I update to a new version?</ins>** —  Please follow the steps **[here](https://community.home-assistant.io/t/detect-and-monitor-the-status-of-an-appliance-based-on-its-power-consumption-v2-0-0-updated/421670/3)**.

### `#overloads`
* **<ins>What is an overload situation? When does it happen?</ins>** —  An overload occurs when the appliance is drawing too much power and this affects the entire home grid. This usually triggers your circuit breaker.

* **<ins>What does this blueprint do during an overload?</ins>** — If the "Appliance Suspended entity" was configured, the state machine should transition to the `detached_overload` state.
  
* **<ins>Is this blueprint a solution to my overloads?</ins>** —  Nope. It just stores the states of your appliance, it doesn't diagnose anything, it notes that it happened. 
**[HA_PowerControl](https://github.com/andbad/HA_PowerControl)** is instead a separate package that takes care of detaching the loads progressively based on a settable priority. The package itself does the job, but the problem is that the appliance is not self-conscious of being the cause of an overload. The `detached_overload` state adds that consciousness. 

* **<ins>Do I really need HA_PowerControl?</ins>** — No. I’m allowing the user to bind this blueprint to whatever system they have for handling those situations. 
You might not want to use anything at all! If that's the case, just leave the "Appliance Suspended entity" empty.

* **<ins>HA_PowerControl is just in Italian 🍝.. is there no other alternative?</ins>** —  I was unable to find one yet. [I asked](https://github.com/andbad/HA_PowerControl/issues/15) the author if I'm allowed to translate it ad he approves, but it's still too early to talk about a release.


Got more questions? [Feel free to ask!](https://community.home-assistant.io/t/detect-and-monitor-the-state-of-an-appliance-based-on-its-power-consumption-v2-1-1-updated/) 🙂
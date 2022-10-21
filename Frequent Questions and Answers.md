# Q&A - Things you may want to know

## Index:
- [Q&A - Things you may want to know](#qa---things-you-may-want-to-know)
  - [Index:](#index)
    - [`#general`](#general)
    - [`#bugs`](#bugs)
    - [`#overloads`](#overloads)
    - [`#project`](#project)

---
  
### `#general`

* **Is this able to survive reloading automations and Home Assistant?** —  Yes!

* **Why is this thing so big? That monstrosity doesn't even show correctly on my small screen!** —  I know 😅. There are many conditions, and those increase the visual width of the blueprint in the UI. On mobile devices, it's going to be a pain, but what's important here is that things work and that all the possible situations are handled.

* **How is this different when compared to [Notify or do something when an appliance like a dishwasher or washing machine finishes](https://community.home-assistant.io/t/notify-or-do-something-when-an-appliance-like-a-dishwasher-or-washing-machine-finishes/254841)?** —  It's very, very different and much more articulated. [Read here for more info](https://community.home-assistant.io/t/notify-or-do-something-when-an-appliance-like-a-dishwasher-or-washing-machine-finishes/254841/131?u=leofabri).

* **Will this slowdown Home Assistant?** — Nope. The blueprint will run every time a new power read is polled or sent to HA. If there's no state change, the automation is basically doing nothing and completes super quickly.

* **How do I update to a new version?** —  Please follow the steps **[here](https://community.home-assistant.io/t/detect-and-monitor-the-status-of-an-appliance-based-on-its-power-consumption-v2-0-0-updated/421670/3)**.

### `#bugs`

* **Why when I turn off *'appliance_overload_state_enabled'* in the blueprint's UI and save the change is discarded?** — There is [a bug in Home Assistant](https://community.home-assistant.io/t/blueprint-booleans-not-saving-after-deployment/440382/2) that causes the UI to ignore the update the value of inputs like this. Sometimes, you'll have to go to "Edit in YAML" and define 'appliance_overload_state_enabled: true/false' to solve the issue.

  
* **Why when I delete an entity in a selector in the blueprint's UI and save the change is discarded?** — See the problem above. The only solution so far is to manually delete the entity in the "Edit in YAML" mode.

### `#overloads`
* **What is an overload situation? When does it happen?** —  An overload occurs when the appliance is drawing too much power and this affects the entire home grid. This usually triggers your circuit breaker.

* **What does this blueprint do during an overload?** — If the "Appliance Suspended entity" was configured, the state machine should transition to the `detached_overload` state.
  
* **Is this blueprint a solution to my overloads?** —  Nope. It just stores the states of your appliance, it doesn't diagnose anything, it notes that it happened. 
**[HA_PowerControl](https://github.com/andbad/HA_PowerControl)** is instead a separate package that takes care of detaching the loads progressively based on a settable priority. The package itself does the job, but the problem is that the appliance is not self-conscious of being the cause of an overload. The `detached_overload` state adds that consciousness. 

* **Do I really need HA_PowerControl?** — No. I’m allowing the user to bind this blueprint to whatever system they have for handling those situations. 
You might not want to use anything at all! If that's the case, just leave the "Appliance Suspended entity" empty.

* **HA_PowerControl is just in Italian 🍝.. is there no other alternative?** —  I was unable to find one yet. [I asked](https://github.com/andbad/HA_PowerControl/issues/15) the author if I'm allowed to translate it ad he approves, but it's still too early to talk about a release.

### `#project`

* **Why is the Git repo's main branch not the development branch?** —  [Read here to see why](/Versioning.md)


Got more questions? [Feel free to ask!](https://community.home-assistant.io/t/detect-and-monitor-the-state-of-an-appliance-based-on-its-power-consumption-v2-1-1-updated/) 🙂
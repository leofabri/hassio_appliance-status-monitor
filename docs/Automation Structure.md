# Detailed Inputs list

| Inputs | | | | | |
| ------ | --- | ---- | -- | -- | -- |
| N°     | Name | Description | Type | Helper? | Optional / Required |
| 00     | **appliance\_socket** | Appliance Smart Socket | switch. | True | *REQUIRED |
| 01     | **appliance\_power\_sensor** | Appliance Power Consumption | sensor. | True | *REQUIRED |
| 02     | **appliance\_starting\_power\_threshold** | Starting power threshold | number | False | *REQUIRED |
| 03     | **delayed\_job\_ongoing\_timer** | Delayed Job Ongoing timer | timer. | True | OPTIONAL |
| 04     | **delayed\_job\_ongoing\_duration** | Delayed Job Ongoing duration | number | False | OPTIONAL |
| 05     | **appliance\_finishing\_power\_threshold** | Finishing power threshold | number | False | *REQUIRED |
| 06     | **delayed\_job\_completion\_timer** | Job Completion - Delayed Job Completion timer | timer. | True | OPTIONAL |
| 07     | **delayed\_job\_completion\_duration** | Delayed Job Completion duration | number | False | OPTIONAL |
| 08     | **appliance\_overload\_state\_enabled** | Appliance Overload State Enabled | boolean | False | *REQUIRED |
| 09     | **appliance\_suspended\_sensor** | Appliance Suspended Overload entity | input_number. | True |OPTIONAL but *REQUIRED if `appliance_overload_state_enabled: true` |
| 10     | **appliance\_state\_machine** | Appliance State Machine | input_select. | True | *REQUIRED |
| 11     | **appliance\_job\_cycle** | Appliance Job Cycle | input_boolean. | True | *REQUIRED |
| 12     | **job\_completed\_persistence\_timer** | Job completed - State persistence Timer | timer. | True | OPTIONAL |
| 13     | **job\_completed\_persistence\_duration** | Job completed - State Persistence Duration | number | True | OPTIONAL |

### The current automation has:
- 1 `switch`
- 1 `sensor`
- 3 `timer`s: theoretically OPTIONAL (but this is untested)
- 1 `input_number`
- 1 `input_boolean`

That have to be provided to fully configure the automation.
The rest are constants, stored in the automation itself. 



# Detailed Triggers list

| Triggers | | |
| -------- | --- | --- |
| N°       | Name | Description |
| 00       | **automation\_self\_trigger** | Automation Self-triggering entity |
| 01       | **power\_event** | Event - A new power measurement is received |
| 02       | **socket\_state\_change\_event** | Event - The socket had changed its state (ON <-> OFF) |
| 03       | **paused\_after\_overload\_event** | Event - The state machine changed state. From detached\_overload -> paused |
| 04       | **paused\_after\_unplugged\_event** | Event - The state machine changed state. From unplugged -> paused |
| 05       | **resuming\_after\_paused\_overload\_event** | Event - The state machine changed state. From detached\_overload -> job\_ongoing |
| 06       | **automation\_self\_triggered** | Event - The automation\_self\_trigger changed from false  \-> true |
| 07       | **job\_started\_timer\_finished** | Event - delayed\_job\_ongoing\_timer has finished counting |
| 08       | **job\_completed\_timer\_finished** | Event - delayed\_job\_completion\_timer has finished counting |
| 09       | **job\_completed\_persistence\_timer\_finished** | Event - job\_completed\_persistence\_timer has finished counting |
| 10       | **home\_assistant\_started\_event** | Event - Home Assistant has started |
| 11       | **automation\_reloaded\_event** | Event - The automation have been reloaded |

# Detailed States list 

| States | | |
| ------ | --- | --- |
| N°     | Name | Description |
| 00     | **unplugged** | The appliance is no longer powered. The smart socket is off.  |
| 01     | **idle** | There is no pending job, the machine is powered but idling. |
| 02     | **paused** | The appliance has a pending job (cycle still on) but the appliance is not performing it. The state also indicates that the Power absorption is lower than the finishing power threshold, but the previous state indicates that the appliance hasn't completed its job yet. The appliance has to be off (the user may have turned it off manually), or maybe the job needs some time to recover. The automation is now waiting for the appliance to resume. |
| 03     | **detached_overload** | Entered when, during a cycle, the appliance used too much power and was therefore suspended. It is also technically unplugged. The state works only if Appliance Overload State is enabled `appliance_overload_state_enabled: true` and `appliance_suspended_sensor: input_number.some_power_overload_sensor_is_present`  |
| 04     | **job_ongoing** | Signals that a cycle has to be complete and a new or a previous job is ongoing |
| 05     | **job_completed** | Entered when the current incomplete job cycle is finished. The appliance uses less power than the **Finishing Power threshold** ( `appliance_finishing_power_threshold`) (with the possibility of selecting for how long). |

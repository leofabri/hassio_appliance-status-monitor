There are at least two ways of doing that

## 1.  First way: Create a sensor
You could create a sensor inside of <your_appliance_name>.yaml file inside of packages: 

- **Advantages**: 
         - The configuration of your automation is all in one place (in you .yaml file), it's super portable and organized 
         - This is by far the easiest and fastest way of doing that.
         - A sensor is way more usable and supported by most lovelace cards.
- **Disadvantages**: 
        - It's quite inappropriate to use a sensor for translating things. It works, but I have mixed feelings about this. 
        - you create a sensor just for that and some people dont't like that. 

    In this case, all you have to do is to add the following to the end of your `packages/your_appliance_name.yaml`:

```yaml
template:
  - sensor:
      - name: <Your Appliance Name> Current State - Translated
        unique_id: <your_appliance_name>_current_state_translated
        state: >
          {## 
              -- Extended state translation macro --

            This macro translates each state into something more human-readable.
            The following lines define how each state should be translated:
              <state>: <translation to whatever I like>
            This is very useful, as it allows you to customize how each state should be displayed on the UI.

          ##}
          {%- macro extended_state_machine_translation(state) -%}
          {% set STATE_MACHINE_TRANSLATION = {
            "unplugged": "is unplugged",
            "idle": "is Idle but ready",
            "paused": "has been paused and waiting to resume the pending job",
            "detached_overload": "has been detached temporarily since it caused an overload on the grid",
            "job_ongoing": "is currently is washing the laundry",
            "job_completed": "has finished washing",
          } %}
          The <Your Appliance Name> {{ STATE_MACHINE_TRANSLATION[state]}}
          {%- endmacro -%}
          {{ extended_state_machine_translation(states('input_select.<your_appliance_name>_state_machine')) | default('Unknown') }}.
        icon: "mdi:<your_appliance_icon>"
```
     WARNING! Make sure to replace all the fields those of your appliance. Look for these
      - <Your Appliance Name>   ->   (Example: Washing Machine)
      - <your_appliance_name>_state_machine   ->   (Example: washing_machine)
      - <your_appliance_icon>   ->   (Example: washing-machine)

---

## 2. Second way: Translate in the UI
You can translate the state right from the UI. 

- **Advantages**: you are not creating a separate sensor. 
- **Disadvantages**: your code is not portable. 
        - You'd need to copy the same logic over and over.
        - The code is more subjective and documenting it is harder.
        - You need a template card, you can't use an entity card (the one you are using now).


Example with a markdown card:

<p align="center">
<img src="../hassio_appliance-status-monitor/assets/washing_machine_widget_markdown.jpg" width="320" height="auto" />
</p>

```yaml
type: markdown
content: |-
  {% set state_machine_ref = "input_select.washing_machine_state_machine" %}
  {% if is_state(state_machine_ref, 'unplugged') %}
  Unplugged
  {% elif is_state(state_machine_ref, 'idle') %}
  Idle
  {% elif is_state(state_machine_ref, 'paused') %} 
  Paused waiting to resume
  {% elif is_state(state_machine_ref, 'detached_overload') %}
  Detached temporarily, overload detected
  {% elif is_state(state_machine_ref, 'job_ongoing') %}
  Washing in progress
  {% elif is_state(state_machine_ref, 'job_completed') %}
  Washing complete
  {% endif %}
title: Washing Machine Status
```

#### Example with custom:button-card

<p align="center">
<img src="../hassio_appliance-status-monitor/assets/washing_machine_widget.jpg" width="160" height="auto" />
</p>

```yaml
type: custom:button-card
entity: input_boolean.washing_machine_job_cycle
icon: mdi:washing-machine
name: Washing Machine
label: |
  [[[
    return states['sensor.washign_machine_power'].state + " W";
  ]]]
tap_action:
  action: none
show_label: true
color: rgb(28, 128, 199)
state:
  - value: 'off'
    color: firebrick
    styles:
      card:
        - filter: opacity(50%)
      icon:
        - filter: grayscale(100%)
  - value: 'on'
    color: '#25CCF7'
    styles:
      icon:
        - animation: blink 4s ease infinite
styles:
  card:
    - width: 150px
    - height: 150px
  label:
    - color: gray
    - font-size: 12px
  grid:
    - grid-template-areas: '"i" "n" "s" "l" "job-status"'
    - grid-template-columns: 1fr
    - grid-template-rows: 1fr min-content min-content
  img_cell:
    - align-self: center
    - text-align: center
    - width: 100px
  name:
    - justify-self: center
    - font-weight: bold
    - font-size: 14px
  state:
    - justify-self: start
    - padding-left: 10px
  custom_fields:
    job-status:
      - align-self: start
      - justify-self: middle
      - font-size: 12px
      - padding: 8px
      - line-break: auto
      - display: block
      - white-space: initial
      - text-overflow: initial
      - overflow: initial
custom_fields:
  job-status: |-
    [[[
      let state = states['input_select.washing_machine_state_machine'].state;
      if (state == 'idle'){
        return `<ha-icon
        icon='mdi:sleep'
        style='width: 16px; height: 16px; color: #273c75'>
        </ha-icon> Idle, ready`;
      } else if (state == 'unplugged'){
        return `<ha-icon
        icon="mdi:power-plug-off"
        style="width: 16px; height: 16px; color: #487eb0;">
        </ha-icon> Unplugged`;
      } else if (state == 'paused') {
        return `<ha-icon
        icon="mdi:pause"
        style="width: 16px; height: 16px; color: #f39c12;">
        </ha-icon> Paused. Waiting for the washing process to resume...`;
      } else if (state == 'detached_overload') {
        return `<ha-icon
        icon="mdi:alert-decagram"
        style="width: 16px; height: 16px; color: #c0392b;">
        </ha-icon> Overload! Detached temporarily`;
      } else if (state == 'job_ongoing') {
        return `<ha-icon
        icon="mdi:magic-staff"
        style="width: 16px; height: 16px; color: #e1b12c;">
        </ha-icon> Washing in progress...`;
      } else if (state == 'job_completed') {
        return `<ha-icon
        icon="mdi:check-all"
        style="width: 16px; height: 16px; color: #2ecc71;">
        </ha-icon> Washing completed`;
      }
      return "NA";
    ]]]
```

As always, remember to Edit the entities to match yours
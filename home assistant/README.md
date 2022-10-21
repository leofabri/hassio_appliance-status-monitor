# Setup utilities
The structure of the **home assistant** folder is as follows:

- [**packages/**](./packages/) — Contains a folder for each one of the appliances you might want to configure this blueprint for. Each package comes pre-configured with the set of helpers that are needed to configure the final automation. Each helper follows the recommended notation to keep things organized.

- [**pre_configurations/**](./pre_configurations/) — Contains the full configuration of the blueprint for all the different appliances you might want to configure. [Read how to use them](./pre_configurations/)

##  Collection of appliances and the files you need:
| Appliance (automation name) | [Package](./README.md) | [Configuration files](./pre_configurations/)| |
|---|---|---|---|
|**Air Conditioner (A/C) - ASM**| [Package](./packages/air_conditioner/asm_air_conditioner.yaml) | [NO UI](./no_ui/asm_air_conditioner_noui_starter.yaml) | [UI](./ui/asm_air_conditioner_ui_starter.yaml) |
|**Coffee Maker - ASM**| [Package](./packages/coffee_maker/asm_coffee_maker.yaml) | [NO UI](./no_ui/asm_coffee_maker_noui_starter.yaml) | [UI](./ui/asm_coffee_maker_ui_starter.yaml) |
|**Desk - ASM**| [Package](./packages/desk/asm_desk.yaml) | [NO UI](./no_ui/asm_desk_noui_starter.yaml) | [UI](./ui/asm_desk_ui_starter.yaml) |
|**Dishwasher - ASM**| [Package](./packages/dishwasher/asm_dishwasher.yaml) | [NO UI](./no_ui/asm_dishwasher_noui_starter.yaml) | [UI](./ui/asm_dishwasher_ui_starter.yaml) |
|**Dryer - ASM**| [Package](./packages/dryer/asm_dryer.yaml) | [NO UI](./no_ui/asm_dryer_noui_starter.yaml) | [UI](./ui/asm_dryer_ui_starter.yaml)|
|**Electric Bicycle - ASM**| [Package](./packages/electric_bicycle/asm_electric_bicycle.yaml) | [NO UI](./no_ui/asm_electric_bicycle_noui_starter.yaml) | [UI](./ui/asm_electric_bicycle_ui_starter.yaml) |
|**Freezer - ASM**| [Package](./packages/freezer/asm_freezer.yaml) | [NO UI](./no_ui/asm_freezer_noui_starter.yaml) | [UI](./ui/asm_freezer_ui_starter.yaml) |
|**Fridge - ASM**| [Package](./packages/freezer/asm_freezer.yaml) | [NO UI](./no_ui/asm_fridge_noui_starter.yaml) | [UI](./ui/asm_fridge_ui_starter.yaml) |
|**Hair Dryer - ASM**| [Package](./packages/hair_dryer/asm_hair_dryer.yaml) | [NO UI](./no_ui/asm_hair_dryer_noui_starter.yaml) | [UI](./ui/asm_hair_dryer_ui_starter.yaml) |
|**Home Lab - ASM**| [Package](./packages/home_lab/asm_home_lab.yaml) | [NO UI](./no_ui/asm_home_lab_noui_starter.yaml) | [UI](./ui/asm_home_lab_ui_starter.yaml) |
|**Home Theater - ASM**| [Package](./packages/home_theater/asm_home_theater.yaml) | [NO UI](./no_ui/asm_home_theater_noui_starter.yaml) | [UI](./ui/asm_home_theater_ui_starter.yaml) |
|**HVAC - ASM**| [Package](./packages/hvac/asm_hvac.yaml) | [NO UI](./no_ui/asm_hvac_noui_starter.yaml) | [UI](./ui/asm_hvac_ui_starter.yaml) |
|**Microwave - ASM**| [Package](./packages/microwave/asm_microwave.yaml) | [NO UI](./no_ui/asm_microwave_noui_starter.yaml) | [UI](./ui/asm_microwave_ui_starter.yaml) |
|**Oven - ASM**| [Package](./packages/oven/asm_oven.yaml) | [NO UI](./no_ui/asm_oven_noui_starter.yaml) | [UI](./ui/asm_oven_ui_starter.yaml) |
|**Pool - ASM**| [Package](./packages/pool/asm_pool.yaml) | [NO UI](./no_ui/asm_pool_noui_starter.yaml) | [UI](./ui/asm_pool_ui_starter.yaml) |
|**Projector - ASM**| [Package](./packages/projector/asm_projector.yaml) | [NO UI](./no_ui/asm_projector_noui_starter.yaml) | [UI](./ui/asm_projector_ui_starter.yaml) |
|**Toaster - ASM**| [Package](./packages/toaster/asm_toaster.yaml) | [NO UI](./no_ui/asm_toaster_noui_starter.yaml) | [UI](./ui/asm_toaster_ui_starter.yaml) |
|**TV - ASM**| [Package](./packages/tv/asm_tv.yaml) | [NO UI](./no_ui/asm_tv_noui_starter.yaml) | [UI](./ui/asm_tv_ui_starter.yaml) |
|**Washing Machine - ASM**| [Package](./packages/washing_machine/asm_washing_machine.yaml) | [NO UI](./no_ui/asm_washing_machine_noui_starter.yaml) | [UI](./ui/asm_washing_machine_ui_starter.yaml) |
|**Water Well - ASM**| [Package](./packages/water_well/asm_water_well.yaml) | [NO UI](./no_ui/asm_water_well_noui_starter.yaml) | [UI](./ui/asm_water_well_ui_starter.yaml) |

## Yours is not present? Add your own
| Appliance | Package | Configuration files| |
|---|---|---|---|
|**Universal, adaptable - ASM**| [Package](./packages/universal/asm_your_appliance_name.yaml) | [NO UI](./no_ui/asm_your_appliance_name_noui_starter.yaml) | [UI](./ui/asm_your_appliance_name_ui_starter.yaml)|


---
---
## Other secondary utilities

- [**templates/**](./templates/) — Contains a collection of templates that can be used to extend some features of the automation. The necessary ones are already inside the `packages/` directory, so you likely won't need them.
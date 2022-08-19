# Use this command within your ssh client. 
# If your logger configuration inside of configuration.yaml is set like this:
#

# logger:
#   default: error
#   logs:
#     homeassistant.components.asm_blueprint: debug # Notice the logging level here is set to debug
#

# You should be able to read the logs from the blueprint.
# This feature is currently used to debug the code during development. It might be useful to diagnose issues
# although, this is an advanced method.

tail -f /config/home-assistant.log | grep "homeassistant.components.asm_blueprint"
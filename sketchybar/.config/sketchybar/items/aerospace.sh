# Aerospace Item configuration for SketchyBar
# It is intended to be sourced by other SketchyBar configuration scripts, not executed directly.
source "${CONFIG_DIR}/icons.sh"

sketchybar --add event aerospace_workspace_change

workspaces=""

if [[ -z "${workspaces}" ]]; then
    workspaces=$(aerospace list-workspaces --all)
fi

for sid in ${workspaces}; do
    apps=$(aerospace list-windows --workspace "${sid}" | awk -F '\\| *' '{print $2}')
    icons=""
    for app in ${apps}; do
        icons+="$(workspace_icons "${app}")"
        space_label="${apps[@]}"
    done

    space=(
        "background.drawing=off"
        "icon=${sid}"
        "label=${icons}"
        "click_script=aerospace workspace ${sid}"
        "script=${CONFIG_DIR}/plugins/aerospace.sh ${sid}"
    )

    if [[ -z "${apps}" ]]; then
        space+=("icon.drawing=off" "label.drawing=off")
    fi

    sketchybar --add item space."${sid}" left \
        --subscribe space."${sid}" front_app_switched aerospace_workspace_change \
        --set space."${sid}" "${space[@]}"
done

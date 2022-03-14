# Dropdown Terminal

This is an implementation for a dropdown terminal for any WM/DE that supports Window rules


# Requirements

- A WM/DE that supports window rules (like `bspwm`)
- A terminal that supports custom class names (like `kitty`)

# Installation

First move the script to any `bin` path (I.E. `/usr/bin/`, `~/.local/bin`, `/usr/local/bin`)

# Usage

- **drop_terminal show**    > show the dropdown terminal
- **drop_terminal hide**    > hide the dropdown terminal
- **drop_terminal toggle**  > toggle the view of the dropdown terminal


# Configuration

In your WM/DE just create a rule to have the terminal use the class `drop_terminal` and spawn in you desire location (I.E. top of the screen)

## bspwm sample

this will make the terminal with a class of `drop_terminal` appear on the right side of the screen (see preview below)

```bash
bspc rule -a drop_terminal state=floating rectangle=650x1070+1265+5
```

# Keybinding

You can have custom keybinding to show/hide/toggle the dropdown_terminal

## sxhkd sample

```
super + ctrl + q
	drop_terminal toggle
```

# Example

![preview](screenshots/preview_bspwm_rule.png)
![preview](screenshots/preview.gif)
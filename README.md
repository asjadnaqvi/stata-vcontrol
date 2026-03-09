

![StataMin](https://img.shields.io/badge/stata-2011-blue) ![issues](https://img.shields.io/github/issues/asjadnaqvi/stata-vcontrol) ![license](https://img.shields.io/github/license/asjadnaqvi/stata-vcontrol) ![Stars](https://img.shields.io/github/stars/asjadnaqvi/stata-vcontrol) ![version](https://img.shields.io/github/v/release/asjadnaqvi/stata-vcontrol) ![release](https://img.shields.io/github/release-date/asjadnaqvi/stata-vcontrol)

[Installation](#Installation) | [Examples](#Examples) | [Feedback](#Feedback) | [Change log](#Change-log)

---


<img width="100%" alt="banner_vcontrol" src="https://github.com/user-attachments/assets/145372ae-7e11-4160-84fa-a6d6fadde106" />



# vcontrol v1.0 (beta)
*(16 Feb 2026)*

`vcontrol` is a command-line utility for Stata that helps you manage and update your Stata packages by comparing versions available on **SSC** and **GitHub**, or another custom installation URL.

The installation source must include a `<package>.pkg` file with a distribution date line in the Stata package format (for example: `d Distribution-Date: 20260216`).


Requirements:

- Stata version 14.0 or higher
- Internet connection

## Installation


Install from SSC (XX)
```stata
ssc install vcontrol, replace
```

or install from GitHub (v1.0):

```stata
net install vcontrol, from("https://raw.githubusercontent.com/asjadnaqvi/stata-vcontrol/refs/heads/main/installation")
```



Syntax:

```stata
vcontrol package [, url(string) update replace]
```

Options:
- `package` - Name of the Stata package to check (required)
- `url(string)` - Custom installation URL (folder containing `<package>.pkg` and install files)
- `update` - Trigger installation logic after checking dates
- `replace` - Pass `replace` to `ssc install` or `net install`

## Examples

Check version of a package:

```stata
vcontrol tidytuesday
```

will display output:

```stata
SSC   : 20250513 
GitHub: 20260212 (latest) 
Click here to install the latest version.
```

Update directly from the best possible source:

```stata
vcontrol tidytuesday, update
```


Check with custom URL:

```stata
vcontrol mypackage, url("https://raw.githubusercontent.com/user/stata-mypackage/refs/heads/main/installation")
```

## Feedback

Please submit bugs, errors, and feature requests on [GitHub Issues](https://github.com/asjadnaqvi/stata-vcontrol/issues).


## Change log

**v1.0 (16 Feb 2026)**
- Beta version. Currently hardcoded for my own packages only. More flexible options coming soon.




![StataMin](https://img.shields.io/badge/stata-2011-blue) ![issues](https://img.shields.io/github/issues/asjadnaqvi/stata-vcontrol) ![license](https://img.shields.io/github/license/asjadnaqvi/stata-vcontrol) ![Stars](https://img.shields.io/github/stars/asjadnaqvi/stata-vcontrol) ![version](https://img.shields.io/github/v/release/asjadnaqvi/stata-vcontrol) ![release](https://img.shields.io/github/release-date/asjadnaqvi/stata-vcontrol)

[Installation](#Installation) | [Examples](#Examples) | [Feedback](#Feedback) | [Change log](#Change-log)

---


<img width="100%" alt="banner_vcontrol" src="https://github.com/user-attachments/assets/8b3f3ebb-e293-4633-baba-6d70c670579a" />


# vcontrol v1.0 (beta)
*(12 Feb 2026)*

`vcontrol` is a command-line utility for Stata that helps you manage and update your Stata packages by comparing versions available on **SSC (Statistical Software Components)** and **GitHub**, or another custom URL with installation files.
Note that the package requires the installation folder to have the `<package>.pkg` file in which line `Distribution date: XXXXXX` is specified.

Key Features:

- Version Comparison: Automatically checks the distribution dates of a package on both SSC and GitHub
- Source Identification: Identifies which source (SSC or GitHub) has the most recent version
- Automatic Updates: Can automatically install the latest version from the appropriate source
- Custom URLs: Supports custom URLs for packages hosted on personal websites


Requirements:

- Stata version 11.0 or higher
- Internet connection

## Installation


Install from SSC (XX)
```stata
ssc install vcontrol
```

or install from GitHub (v1.0):

```stata
net install vcontrol, from("https://raw.githubusercontent.com/asjadnaqvi/stata-vcontrol/main/installation/")  
```



Syntax:

```stata
vcontrol package [, url(string) update replace]
```

Options:
- `package` - Name of the Stata package to check (required)
- `url(string)` - Custom GitHub URL for the package repository (optional)
- `update` - Automatically install the latest version after checking
- `replace` - Replace existing installation when updating

## Examples

Check version of a package

```stata
vcontrol schemepack
```

Output:
```
SSC   : 20250115
GitHub: 20250201 (latest)
```

Check and update if newer version is available:

```stata
vcontrol schemepack, update
```


Check with custom URL:

```stata
vcontrol mypackage, url("<some url>")
```

## Feedback

Please submit bugs, errors, and feature requests on [GitHub Issues](https://github.com/asjadnaqvi/stata-vcontrol/issues).


## Change log

**v1.0 (12 Feb 2026)**
- Beta version. Currently hardcoded for my own packages only. More flexible options coming soon.


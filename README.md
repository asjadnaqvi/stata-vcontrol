# stata-vcontrol

![Version](https://img.shields.io/github/v/release/asjadnaqvi/stata-vcontrol)
![License](https://img.shields.io/github/license/asjadnaqvi/stata-vcontrol)

A Stata package for version control and management of Stata packages.

## What does vcontrol do?

`vcontrol` is a command-line utility for Stata that helps you manage and update your Stata packages by comparing versions available on **SSC (Statistical Software Components)** and **GitHub**.

### Key Features

- **Version Comparison**: Automatically checks the distribution dates of a package on both SSC and GitHub
- **Source Identification**: Identifies which source (SSC or GitHub) has the most recent version
- **Automatic Updates**: Can automatically install the latest version from the appropriate source
- **Custom URLs**: Supports custom GitHub URLs for packages hosted in non-standard locations
- **Version Transparency**: Displays distribution dates for both sources to help you make informed decisions

### How it works

1. **Fetches package metadata** from both SSC and GitHub repositories
2. **Extracts distribution dates** from the package files (.pkg)
3. **Compares the dates** to determine which version is newer
4. **Displays the results** showing both versions and highlighting the latest one
5. **Optionally installs** the latest version if the `update` option is specified

### Why use vcontrol?

Stata packages are often developed on GitHub with frequent updates, while SSC versions may lag behind. `vcontrol` helps you:

- Stay up-to-date with the latest package features and bug fixes
- Avoid manually checking multiple sources for updates
- Ensure you're using the most recent version of any package
- Streamline your Stata package management workflow

## Installation

```stata
* Install from GitHub (recommended)
net install vcontrol, from("https://raw.githubusercontent.com/asjadnaqvi/stata-vcontrol/refs/heads/main/installation")

* Or install from SSC
ssc install vcontrol
```

## Syntax

```stata
vcontrol package [, url(string) update replace]
```

### Parameters

- `package` - Name of the Stata package to check (required)

### Options

- `url(string)` - Custom GitHub URL for the package repository (optional)
- `update` - Automatically install the latest version after checking
- `replace` - Replace existing installation when updating

## Examples

### Check version of a package

```stata
vcontrol schemepack
```

Output:
```
SSC   : 20250115
GitHub: 20250201 (latest)
```

### Check and update if newer version is available

```stata
vcontrol schemepack, update
```

This will compare versions and automatically install the latest one.

### Check with custom GitHub URL

```stata
vcontrol mypackage, url("https://raw.githubusercontent.com/username/stata-mypackage/refs/heads/main/installation")
```

### Update and replace existing installation

```stata
vcontrol schemepack, update replace
```

## Use Cases

- **Before starting a project**: Ensure all packages are up-to-date
- **Regular maintenance**: Periodically check for package updates
- **Bug fixes**: Quickly get the latest version when a bug is fixed on GitHub
- **Development**: Stay current with packages you use frequently

## Requirements

- Stata version 14.0 or higher
- Internet connection to access SSC and GitHub

## Feedback

Please submit bugs, errors, and feature requests on [GitHub Issues](https://github.com/asjadnaqvi/stata-vcontrol/issues).

## Citation

If you use this package in your research, please cite it appropriately. Visit the [GitHub repository](https://github.com/asjadnaqvi/stata-vcontrol) for citation information.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Asjad Naqvi**
- GitHub: [@asjadnaqvi](https://github.com/asjadnaqvi)
- Email: asjadnaqvi@gmail.com
- Twitter/X: [@AsjadNaqvi](https://twitter.com/AsjadNaqvi)

## Related Packages

Check out other visualization and utility packages by the author:
`arcplot`, `alluvial`, `bimap`, `bumparea`, `bumpline`, `circlebar`, `circlepack`, `clipgeo`, `delaunay`, `graphfunctions`, `sankey`, `schemepack`, `spider`, `streamplot`, `sunburst`, `treemap`, `waffle`, and more.

Visit [https://github.com/asjadnaqvi](https://github.com/asjadnaqvi) for more information.

# Asterisk Inspec Profile

This InSpec compliance profile checks security best practices for the Asterisk Open Source PBX. Inspired by a lightning talk at [Commcon 2019](https://2019.commcon.xyz/)

# Requirements

* [InSpec](http://inspec.io/)
* An Asterisk target

# Usage

```
git clone https://github.com/meetupcall/inspec-asterisk
inspec -t ssh://user@yourasterisk.instance inspec-asterisk
```

You can also execute this profile directly from github

```
inspec -t ssh://user@yourasterisk.instance https://github.com/meetupcall/inspec-asterisk
````

# All PRs Welcome

If you have a new control to add to this project by all means submit a PR. The rule can be new Inspec controls or just plain English.

#TODO

* Config file paths are current hard coded, we should pull out the config file path that asterisk is using from asterisk.

* Config files are configurable and can include other files, we should parse the entire config output to be sure we've checked the entire running config. We currently do this on `control 'chan_sip-01'` but not on some other controls that need it.

* Dialplan checks need adding, that's some regex wizardry.

* PJSIP Config controls. Please throw some PRs at us for this one.

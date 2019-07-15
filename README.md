# Asterisk Inspec Profile

This InSpec compliance profile checks security best practices for the Asterisk Open Source PBX. Inspired by a lightning talk at [Commcon 2019](https://2019.commcon.xyz/)

# Requirements

* [InSpec](http://inspec.io/)
* An Asterisk target

# Usage

`
git clone https://github.com/meetupcall/inspec-asterisk
inspec -t ssh://user@yourasterisk.instance inspec-asterisk
`

You can also execute this profile directly from github

`
inspec -t ssh://user@yourasterisk.instance https://github.com/meetupcall/inspec-asterisk
`

# All PRs Welcome

If you have a new control to add to this project by all means submit a PR. The rule can be new Inspec controls or just plain English.

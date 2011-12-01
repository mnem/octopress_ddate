Octopress Discordian Date Liquid Tag
====================================

Simple plugin for Octopress to output a Discordian date.

Use:

    {% ddate %} # Will output the generation date as a Discordian date
    {% ddate date %} # Output the post date as a Discordian date
    {% ddate updated %} # Output the post updated date as a Discordian date
    {% ddate 1976-07-15 18:40 %} # Output a custom date as a Discordian date

Either copy ddate.rb to your Octopress plugins folder or add this repository
as a subodule in your plugins folder.

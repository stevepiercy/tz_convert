tz_convert
==========

Description
-----------

`tz_convert` converts datetime types from one time zone locale to another for Lasso 8.x.  This is especially useful for converting datetimes to and from UTC.  Using UTC makes performing calculations with datetime types simple because it avoids issues with time zones and daylight savings time.

This tag passes the parameters to the GNU coreutils `date` command via the custom tag `[shell]` and Lasso's `[os_process]`.  Compatible with Mac OS X and CentOS and other Linux variants.  Windows is not supported at this time.

Demo
----
[Online Demo](http://www.stevepiercy.com/lasso_stuff/tz_convert.lasso)


Usage
-----

`tz_convert` accepts five parameters.

`-dt` is required and must be a date type.  Its value should have an explicit time specified.

`-tzin` is optional and must be a valid time zone according to the [tz database](http://www.twinsun.com/tz/tz-link.htm).  The value is a user-friendly time zone representation parameter, containing a country, state, or city, e.g. "America/Los_Angeles".  If the time zone is not valid, then the default is UTC.  Thus to avoid unexpected results, the developer should validate the time zone prior to passing it into this tag.  It is the timezone from which the datetime will be converted.

`-tzout` is exactly the same as `-tzin`, except it is the timezone to which the datetime will be converted.

`-format` is optional.  If provided, `-format` must be an acceptable format according to `date` in coreutils.  Defaults to `%F %T`, i.e., "2013-03-31 08:00:00".  [See more formats](http://www.gnu.org/software/coreutils/manual/coreutils.html#date-invocation).

`-showcmd` is optional.  If `true`, then the command issued to coreutils `date` will be shown.  If `false`, then it will not be shown.  Defaults to `false`.  Useful for debugging your logic.

Sample Usage
------------

    local('dt' = date('2013-03-31 03:40:12'));
    local('tzin' = 'America/Los_Angeles');
    local('tzout' = 'UTC');
    local('format' = '%F %T');
    local('showcmd' = true);
    tz_convert(-dt=#dt, -tzin=#tzin, -tzout=#tzout, -format=#format, -showcmd=#showcmd);

    =>
    2013-03-31 10:40:12
    
    Command:
    
    export TZ="UTC";/opt/local/bin/gdate -d"TZ=\":America/Los_Angeles\" 2013-03-31 03:40:12" +"%F %T"

Installation and Requirements
-----------------------------
This document contains both the tag `tz_convert` and a web page containing a form.  When you install `tz_convert`, install only that portion of this file between the opening and closing square brackets and define_tag.

    [define_tag
    ...
    /define_tag]

Do not install the web page!  It is for demonstration purposes only.  However if you would like to use the interface, it requires two javascript libraries.  Make sure that versions are compatible.

[jQuery Datepicker](http://keith-wood.name/datepick.html)

[jQuery](http://jquery.com/)

Install and configure the following requirements.

* os_process - See Lasso Language Guide for installation and configuration.
* [shell](http://www.lassosoft.com/tagSwap/detail/shell)
* coreutils - Mac OS X has a useless implementation of date.  GNU coreutils must be installed to provide the necessary functionality of date required by this tag.


### Coreutils Installation

1. [Download and install Xcode](https://developer.apple.com/xcode/).  Requires an App Store or Apple Developer account to download.
1. After installation of Xcode, go to *Xcode > Preferences > Downloads* and download and install the *Command Line Tools*.
1. [Install macports](http://www.macports.org/install.php)
1. update macports

    `sudo port -d selfupdate`
    
1. upgrade installed ports

    `port upgrade outdated`

1. install coreutils

    `sudo port install coreutils`
    
1. The tools provided by GNU coreutils are prefixed with the character 'g' by default to distinguish them from the BSD commands.  For example, date becomes gdate, cp becomes gcp, and ls becomes gls.  If you want to use the GNU tools by default, add the following directory to the front of your PATH environment variable.
    
    `/opt/local/libexec/gnubin/`
    
More Information
----------------
[Sources for Time Zone and Daylight Saving Time Data](http://www.twinsun.com/tz/tz-link.htm)

[List of tz database time zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

[tz database, also called the zoneinfo database or IANA Time Zone Database](http://en.wikipedia.org/wiki/Tz_database)

[date formats for GNU coreutils date](http://www.gnu.org/software/coreutils/manual/coreutils.html#date-invocation)

OR

    man gdate

OR

    gdate --help

This video presentation from PyCon 2012 summarizes the complexities of date and time.

[What you need to know about datetimes](http://pyvideo.org/video/946/what-you-need-to-know-about-datetimes)

Lasso 9 provides a locale for date and other data types, so this tag is not necessary in that version.


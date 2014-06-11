tz_convert - Utility for converting datetime types between time zones in Lasso 8
################################################################################

Read the article on my `tz_convert - Convert datetime types between time zones in Lasso 8
<http://www.stevepiercy.com/articles/tz_convert-convert-datetime-types-between-time-zones-in-lasso-8/>`_.

Description
===========

``[tz_convert]`` converts datetime types from one time zone locale to another
for Lasso 8. This is especially useful for converting datetimes to and from
UTC. Using UTC makes performing calculations with datetime types simple
because it avoids issues with time zones and daylight savings time.

This tag passes the parameters to the GNU ``coreutils`` ``date`` command via
the custom tag ``[shell]`` and Lasso's ``[os_process]``. Compatible with Mac
OS X and CentOS and other Linux variants. Windows is not supported at this
time. Contributions to this project for Windows are accepted, either as code
or by making me an offer I cannot refuse.

Demo
====

`Demo <http://www.stevepiercy.com/lasso/tz_convert_demo/>`_.

Usage
=====

``tz_convert`` accepts five parameters.

``-dt`` is required and must be a date type. Its value should have an explicit
time specified.

``-tzin`` is optional and must be a valid time zone according to the `tz
database <http://www.twinsun.com/tz/tz-link.htm>`_. The value is a
user-friendly time zone representation parameter, containing a country, state,
or city, e.g., "America/Los_Angeles". If the time zone is not valid, then the
default is UTC. Thus to avoid unexpected results, the developer should
validate the time zone prior to passing it into this tag. It is the timezone
from which the datetime will be converted.

``-tzout`` is exactly the same as ``-tzin``, except it is the timezone to
which the datetime will be converted.

``-format`` is optional. If provided, ``-format`` must be an acceptable format
according to ``date`` in ``coreutils``. Defaults to ``%F %T``, i.e.,
`2013-03-31 08:00:00`. `See more formats
<http://www.gnu.org/software/coreutils/manual/coreutils.html#date-invocation>`_.

``-showcmd`` is optional.  If ``true``, then the command issued to
``coreutils`` ``date`` will be shown. If ``false``, then it will not be shown.
Defaults to ``false``. Useful for debugging your logic.

Example
=======

.. code-block:: lasso

    local('dt' = date('2013-03-31 03:40:12'));
    local('tzin' = 'America/Los_Angeles');
    local('tzout' = 'UTC');
    local('format' = '%F %T');
    local('showcmd' = true);
    tz_convert(-dt=#dt, -tzin=#tzin, -tzout=#tzout, -format=#format, -showcmd=#showcmd);

Output:

.. code-block:: text

    2013-03-31 10:40:12

    Command:

    export TZ="UTC";/opt/local/bin/gdate -d"TZ=\":America/Los_Angeles\" 2013-03-31 03:40:12" +"%F %T"

Installation and Requirements
=============================

This repository contains both the tag ``[tz_convert]`` in a file named
``tz_convert.inc`` and a directory ``tz_convert_demo`` containing the demo.
In this directory there is a web page named ``index.lasso`` containing the
``tz_convert`` tag followed by a web form. The demo includes a jQuery plugin
and jQuery itself.

* `jQuery Date/Time Entry <http://keith-wood.name/datetimeEntry.html>`_
* `jQuery <http://jquery.com/>`_

Install and configure the following requirements.

* ``os_process`` - See Lasso Language Guide for installation and configuration.
* `[shell] <http://www.lassosoft.com/tagSwap/detail/shell>`_
* ``coreutils`` - Mac OS X has a useless implementation of date. GNU
  ``coreutils`` must be installed to provide the necessary functionality of
  date required by this tag.

Coreutils Installation
----------------------

#. `Download and install Xcode <https://developer.apple.com/xcode/>`_.
   Requires an App Store or Apple Developer account to download.
#. After installation of Xcode, go to `Xcode > Preferences > Downloads` and
   download and install the ``Command Line Tools``.
#. Using your favorite package manager for Mac OS X, install ``coreutils``. As
   of this writing, the preferred package manager is `Homebrew
   <http://brew.sh/>`_, but macports and fink should work just as well.
#. The tools provided by GNU ``coreutils`` are prefixed with the character "g"
   by default to distinguish them from the BSD commands. For example, ``date``
   becomes ``gdate``, ``cp`` becomes ``gcp``, and ``ls`` becomes ``gls``. If
   you want to use the GNU tools by default, add the a directory to the front
   of your ``PATH`` environment variable, according to the package manager
   you used to install ``coreutils``.

   .. code-block:: bash

        /usr/local/libexec/gnubin/

#. Try using your local demo.

More Information
================

* `Sources for Time Zone and Daylight Saving Time Data
  <http://www.twinsun.com/tz/tz-link.htm>`_
* `List of tz database time zones
  <http://en.wikipedia.org/wiki/List_of_tz_database_time_zones>`_
* `tz database, also called the zoneinfo database or IANA Time Zone Database
  <http://en.wikipedia.org/wiki/Tz_database>`_
* `date formats for GNU coreutils date
  <http://www.gnu.org/software/coreutils/manual/coreutils.html#date-invocation>`_.
  Or use ``man gdate`` or ``gdate --help``.

A video presentation from PyCon 2012, `What you need to know about datetimes
<http://pyvideo.org/video/946/what-you-need-to-know-about-datetimes>`_,
summarizes the complexities of date and time.

Lasso 9 provides a locale for date and other data types, so this tag is not
necessary in that version.

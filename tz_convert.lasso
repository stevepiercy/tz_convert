[
define_tag('tz_convert',
            -required='dt', -type='date',
            -optional='tzin', -type='string',
            -optional='tzout', -type='string',
            -optional='format', -type='string',
            -optional='showcmd', -type='boolean',
            -encodenone,
            -description="
tz_convert converts datetime types from one time zone locale to another
for Lasso 8.x.  This is especially useful for converting datetimes to
and from UTC.  Using UTC makes performing calculations with datetime
types simple because it avoids issues with time zones and daylight
savings time.

This tag passes the parameters to the GNU coreutils 'date' command via
the custom tag [shell] and Lasso's [os_process].  Compatible with Mac OS
X and CentOS and other Linux variants.  Windows is not supported at this
time.

tz_convert accepts five parameters.

-dt is required and must be a date type.  Its value should have an
explicit time specified.

-tzin is optional and must be a valid time zone according to the tz
database (see http://www.twinsun.com/tz/tz-link.htm).  The value is a
user-friendly time zone representation parameter, containing a country,
state, or city, e.g. 'America/Los_Angeles'.  If the time zone is not
valid, then the default is UTC.  Thus to avoid unexpected results, the
developer should validate the time zone prior to passing it into this
tag.  It is the timezone from which the datetime will be converted.

-tzout is exactly the same as -tzin, except it is the timezone to which
the datetime will be converted.

-format is optional.  If provided, -format must be an acceptable format
according to 'date' in coreutils.  Defaults to '%F %T', e.g., 2013-03-31
08:00:00.  For more formats, see
http://www.gnu.org/software/coreutils/manual/coreutils.html#date-
invocation

-showcmd is optional.  If true, then the command issued to coreutils
'date' will be shown.  If false, then it will not be shown.  Defaults to
false.  Useful for debugging your logic.");

    local('out' = string);
    local('os' = lasso_version(-lassoplatform));
    local('gdate' = string);
    local('tzin') == '' ? #tzin = 'UTC';
    local('tzout') == '' ? #tzout = 'UTC';
    local('format') == '' ? #format = '%F %T';
    local('showcmd') == false ? #showcmd = false;

    if(#os >> 'Win');
        return('Windows is not supported.');
    else(#os >> 'Mac');
        #gdate = '/opt/local/bin/gdate'; // set to your command for GNU date.  Type 'which gdate' at a shell prompt (Terminal on Mac OS X) to determine its location.
    else;
        // default for Linux OSs
        #gdate = '/bin/date'; // set to your command for GNU date.
    /if;
    #dt = #dt->format('%Q %T');
    local('cmd' = 'export TZ="' + #tzout + '";' #gdate + ' -d"TZ=\\":' + #tzin + '\\" ' + #dt + '" +"' + #format + '"');
    #out = shell(#cmd);
    #showcmd ? #out += '<h3>Command:</h3><pre>' + #cmd +'</pre>';
    return(#out);
/define_tag;
]

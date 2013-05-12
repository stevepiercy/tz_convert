[define_tag('tz_convert',
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
[
define_tag(
    'tz_select',
    -required='name', -type='string',
    -optional='selected', -type='string');

    !local_defined('selected') ? local('selected' = '');
    
    local('lists' = array(
        'us_common',
        'america',
        'europe',
        'asia',
        'africa',
        'australia',
        'indian',
        'atlantic',
        'pacific',
        'antarctica',
        'arctic',
        'utc',
        'manual_offsets'));
    
    local('headers' = map(
        'us_common' = 'US (Common)',
        'america' = 'America',
        'europe' = 'Europe',
        'asia' = 'Asia',
        'africa' = 'Africa',
        'australia' = 'Australia',
        'indian' = 'Indian',
        'atlantic' = 'Atlantic',
        'pacific' = 'Pacific',
        'antarctica' = 'Antarctica',
        'arctic' = 'Arctic',
        'utc' = 'UTC',
        'manual_offsets' = 'Manual Offsets'));
    
    local('us_common' = array(
        'America/Puerto_Rico' = 'Puerto Rico (Atlantic)',
        'America/New_York' = 'New York (Eastern)',
        'America/Chicago' = 'Chicago (Central)',
        'America/Denver' = 'Denver (Mountain)',
        'America/Phoenix' = 'Phoenix (MST)',
        'America/Los_Angeles' = 'Los Angeles (Pacific)',
        'America/Anchorage' = 'Anchorage (Alaska)',
        'Pacific/Honolulu' = 'Honolulu (Hawaii)'));
    
    local('america' = array(
        'America/Adak' = 'Adak',
        'America/Anchorage' = 'Anchorage',
        'America/Anguilla' = 'Anguilla',
        'America/Antigua' = 'Antigua',
        'America/Araguaina' = 'Araguaina',
        'America/Argentina/Buenos_Aires' = 'Argentina - Buenos Aires',
        'America/Argentina/Catamarca' = 'Argentina - Catamarca',
        'America/Argentina/ComodRivadavia' = 'Argentina - ComodRivadavia',
        'America/Argentina/Cordoba' = 'Argentina - Cordoba',
        'America/Argentina/Jujuy' = 'Argentina - Jujuy',
        'America/Argentina/La_Rioja' = 'Argentina - La Rioja',
        'America/Argentina/Mendoza' = 'Argentina - Mendoza',
        'America/Argentina/Rio_Gallegos' = 'Argentina - Rio Gallegos',
        'America/Argentina/Salta' = 'Argentina - Salta',
        'America/Argentina/San_Juan' = 'Argentina - San Juan',
        'America/Argentina/San_Luis' = 'Argentina - San Luis',
        'America/Argentina/Tucuman' = 'Argentina - Tucuman',
        'America/Argentina/Ushuaia' = 'Argentina - Ushuaia',
        'America/Aruba' = 'Aruba',
        'America/Asuncion' = 'Asuncion',
        'America/Atikokan' = 'Atikokan',
        'America/Atka' = 'Atka',
        'America/Bahia' = 'Bahia',
        'America/Barbados' = 'Barbados',
        'America/Belem' = 'Belem',
        'America/Belize' = 'Belize',
        'America/Blanc-Sablon' = 'Blanc-Sablon',
        'America/Boa_Vista' = 'Boa Vista',
        'America/Bogota' = 'Bogota',
        'America/Boise' = 'Boise',
        'America/Buenos_Aires' = 'Buenos Aires',
        'America/Cambridge_Bay' = 'Cambridge Bay',
        'America/Campo_Grande' = 'Campo Grande',
        'America/Cancun' = 'Cancun',
        'America/Caracas' = 'Caracas',
        'America/Catamarca' = 'Catamarca',
        'America/Cayenne' = 'Cayenne',
        'America/Cayman' = 'Cayman',
        'America/Chicago' = 'Chicago',
        'America/Chihuahua' = 'Chihuahua',
        'America/Coral_Harbour' = 'Coral Harbour',
        'America/Cordoba' = 'Cordoba',
        'America/Costa_Rica' = 'Costa Rica',
        'America/Cuiaba' = 'Cuiaba',
        'America/Curacao' = 'Curacao',
        'America/Danmarkshavn' = 'Danmarkshavn',
        'America/Dawson' = 'Dawson',
        'America/Dawson_Creek' = 'Dawson Creek',
        'America/Denver' = 'Denver',
        'America/Detroit' = 'Detroit',
        'America/Dominica' = 'Dominica',
        'America/Edmonton' = 'Edmonton',
        'America/Eirunepe' = 'Eirunepe',
        'America/El_Salvador' = 'El Salvador',
        'America/Ensenada' = 'Ensenada',
        'America/Fortaleza' = 'Fortaleza',
        'America/Fort_Wayne' = 'Fort Wayne',
        'America/Glace_Bay' = 'Glace Bay',
        'America/Godthab' = 'Godthab',
        'America/Goose_Bay' = 'Goose Bay',
        'America/Grand_Turk' = 'Grand Turk',
        'America/Grenada' = 'Grenada',
        'America/Guadeloupe' = 'Guadeloupe',
        'America/Guatemala' = 'Guatemala',
        'America/Guayaquil' = 'Guayaquil',
        'America/Guyana' = 'Guyana',
        'America/Halifax' = 'Halifax',
        'America/Havana' = 'Havana',
        'America/Hermosillo' = 'Hermosillo',
        'America/Indiana/Indianapolis' = 'Indiana - Indianapolis',
        'America/Indiana/Knox' = 'Indiana - Knox',
        'America/Indiana/Marengo' = 'Indiana - Marengo',
        'America/Indiana/Petersburg' = 'Indiana - Petersburg',
        'America/Indiana/Tell_City' = 'Indiana - Tell City',
        'America/Indiana/Vevay' = 'Indiana - Vevay',
        'America/Indiana/Vincennes' = 'Indiana - Vincennes',
        'America/Indiana/Winamac' = 'Indiana - Winamac',
        'America/Indianapolis' = 'Indianapolis',
        'America/Inuvik' = 'Inuvik',
        'America/Iqaluit' = 'Iqaluit',
        'America/Jamaica' = 'Jamaica',
        'America/Jujuy' = 'Jujuy',
        'America/Juneau' = 'Juneau',
        'America/Kentucky/Louisville' = 'Kentucky - Louisville',
        'America/Kentucky/Monticello' = 'Kentucky - Monticello',
        'America/Knox_IN' = 'Knox IN',
        'America/La_Paz' = 'La Paz',
        'America/Lima' = 'Lima',
        'America/Los_Angeles' = 'Los Angeles',
        'America/Louisville' = 'Louisville',
        'America/Maceio' = 'Maceio',
        'America/Managua' = 'Managua',
        'America/Manaus' = 'Manaus',
        'America/Marigot' = 'Marigot',
        'America/Martinique' = 'Martinique',
        'America/Matamoros' = 'Matamoros',
        'America/Mazatlan' = 'Mazatlan',
        'America/Mendoza' = 'Mendoza',
        'America/Menominee' = 'Menominee',
        'America/Merida' = 'Merida',
        'America/Mexico_City' = 'Mexico City',
        'America/Miquelon' = 'Miquelon',
        'America/Moncton' = 'Moncton',
        'America/Monterrey' = 'Monterrey',
        'America/Montevideo' = 'Montevideo',
        'America/Montreal' = 'Montreal',
        'America/Montserrat' = 'Montserrat',
        'America/Nassau' = 'Nassau',
        'America/New_York' = 'New York',
        'America/Nipigon' = 'Nipigon',
        'America/Nome' = 'Nome',
        'America/Noronha' = 'Noronha',
        'America/North_Dakota/Center' = 'North Dakota - Center',
        'America/North_Dakota/New_Salem' = 'North Dakota - New Salem',
        'America/Ojinaga' = 'Ojinaga',
        'America/Panama' = 'Panama',
        'America/Pangnirtung' = 'Pangnirtung',
        'America/Paramaribo' = 'Paramaribo',
        'America/Phoenix' = 'Phoenix',
        'America/Port-au-Prince' = 'Port-au-Prince',
        'America/Porto_Acre' = 'Porto Acre',
        'America/Port_of_Spain' = 'Port of Spain',
        'America/Porto_Velho' = 'Porto Velho',
        'America/Puerto_Rico' = 'Puerto Rico',
        'America/Rainy_River' = 'Rainy River',
        'America/Rankin_Inlet' = 'Rankin Inlet',
        'America/Recife' = 'Recife',
        'America/Regina' = 'Regina',
        'America/Resolute' = 'Resolute',
        'America/Rio_Branco' = 'Rio Branco',
        'America/Rosario' = 'Rosario',
        'America/Santa_Isabel' = 'Santa Isabel',
        'America/Santarem' = 'Santarem',
        'America/Santiago' = 'Santiago',
        'America/Santo_Domingo' = 'Santo Domingo',
        'America/Sao_Paulo' = 'Sao Paulo',
        'America/Scoresbysund' = 'Scoresbysund',
        'America/Shiprock' = 'Shiprock',
        'America/St_Barthelemy' = 'St Barthelemy',
        'America/St_Johns' = 'St Johns',
        'America/St_Kitts' = 'St Kitts',
        'America/St_Lucia' = 'St Lucia',
        'America/St_Thomas' = 'St Thomas',
        'America/St_Vincent' = 'St Vincent',
        'America/Swift_Current' = 'Swift Current',
        'America/Tegucigalpa' = 'Tegucigalpa',
        'America/Thule' = 'Thule',
        'America/Thunder_Bay' = 'Thunder Bay',
        'America/Tijuana' = 'Tijuana',
        'America/Toronto' = 'Toronto',
        'America/Tortola' = 'Tortola',
        'America/Vancouver' = 'Vancouver',
        'America/Virgin' = 'Virgin',
        'America/Whitehorse' = 'Whitehorse',
        'America/Winnipeg' = 'Winnipeg',
        'America/Yakutat' = 'Yakutat',
        'America/Yellowknife' = 'Yellowknife'));
    
    local('europe' = array(
        'Europe/Amsterdam' = 'Amsterdam',
        'Europe/Andorra' = 'Andorra',
        'Europe/Athens' = 'Athens',
        'Europe/Belfast' = 'Belfast',
        'Europe/Belgrade' = 'Belgrade',
        'Europe/Berlin' = 'Berlin',
        'Europe/Bratislava' = 'Bratislava',
        'Europe/Brussels' = 'Brussels',
        'Europe/Bucharest' = 'Bucharest',
        'Europe/Budapest' = 'Budapest',
        'Europe/Chisinau' = 'Chisinau',
        'Europe/Copenhagen' = 'Copenhagen',
        'Europe/Dublin' = 'Dublin',
        'Europe/Gibraltar' = 'Gibraltar',
        'Europe/Guernsey' = 'Guernsey',
        'Europe/Helsinki' = 'Helsinki',
        'Europe/Isle_of_Man' = 'Isle of Man',
        'Europe/Istanbul' = 'Istanbul',
        'Europe/Jersey' = 'Jersey',
        'Europe/Kaliningrad' = 'Kaliningrad',
        'Europe/Kiev' = 'Kiev',
        'Europe/Lisbon' = 'Lisbon',
        'Europe/Ljubljana' = 'Ljubljana',
        'Europe/London' = 'London',
        'Europe/Luxembourg' = 'Luxembourg',
        'Europe/Madrid' = 'Madrid',
        'Europe/Malta' = 'Malta',
        'Europe/Mariehamn' = 'Mariehamn',
        'Europe/Minsk' = 'Minsk',
        'Europe/Monaco' = 'Monaco',
        'Europe/Moscow' = 'Moscow',
        'Europe/Nicosia' = 'Nicosia',
        'Europe/Oslo' = 'Oslo',
        'Europe/Paris' = 'Paris',
        'Europe/Podgorica' = 'Podgorica',
        'Europe/Prague' = 'Prague',
        'Europe/Riga' = 'Riga',
        'Europe/Rome' = 'Rome',
        'Europe/Samara' = 'Samara',
        'Europe/San_Marino' = 'San Marino',
        'Europe/Sarajevo' = 'Sarajevo',
        'Europe/Simferopol' = 'Simferopol',
        'Europe/Skopje' = 'Skopje',
        'Europe/Sofia' = 'Sofia',
        'Europe/Stockholm' = 'Stockholm',
        'Europe/Tallinn' = 'Tallinn',
        'Europe/Tirane' = 'Tirane',
        'Europe/Tiraspol' = 'Tiraspol',
        'Europe/Uzhgorod' = 'Uzhgorod',
        'Europe/Vaduz' = 'Vaduz',
        'Europe/Vatican' = 'Vatican',
        'Europe/Vienna' = 'Vienna',
        'Europe/Vilnius' = 'Vilnius',
        'Europe/Volgograd' = 'Volgograd',
        'Europe/Warsaw' = 'Warsaw',
        'Europe/Zagreb' = 'Zagreb',
        'Europe/Zaporozhye' = 'Zaporozhye',
        'Europe/Zurich' = 'Zurich'));
    
    local('asia' = array(
        'Asia/Aden' = 'Aden',
        'Asia/Almaty' = 'Almaty',
        'Asia/Amman' = 'Amman',
        'Asia/Anadyr' = 'Anadyr',
        'Asia/Aqtau' = 'Aqtau',
        'Asia/Aqtobe' = 'Aqtobe',
        'Asia/Ashgabat' = 'Ashgabat',
        'Asia/Ashkhabad' = 'Ashkhabad',
        'Asia/Baghdad' = 'Baghdad',
        'Asia/Bahrain' = 'Bahrain',
        'Asia/Baku' = 'Baku',
        'Asia/Bangkok' = 'Bangkok',
        'Asia/Beirut' = 'Beirut',
        'Asia/Bishkek' = 'Bishkek',
        'Asia/Brunei' = 'Brunei',
        'Asia/Calcutta' = 'Calcutta',
        'Asia/Choibalsan' = 'Choibalsan',
        'Asia/Chongqing' = 'Chongqing',
        'Asia/Chungking' = 'Chungking',
        'Asia/Colombo' = 'Colombo',
        'Asia/Dacca' = 'Dacca',
        'Asia/Damascus' = 'Damascus',
        'Asia/Dhaka' = 'Dhaka',
        'Asia/Dili' = 'Dili',
        'Asia/Dubai' = 'Dubai',
        'Asia/Dushanbe' = 'Dushanbe',
        'Asia/Gaza' = 'Gaza',
        'Asia/Harbin' = 'Harbin',
        'Asia/Ho_Chi_Minh' = 'Ho Chi Minh',
        'Asia/Hong_Kong' = 'Hong Kong',
        'Asia/Hovd' = 'Hovd',
        'Asia/Irkutsk' = 'Irkutsk',
        'Asia/Istanbul' = 'Istanbul',
        'Asia/Jakarta' = 'Jakarta',
        'Asia/Jayapura' = 'Jayapura',
        'Asia/Jerusalem' = 'Jerusalem',
        'Asia/Kabul' = 'Kabul',
        'Asia/Kamchatka' = 'Kamchatka',
        'Asia/Karachi' = 'Karachi',
        'Asia/Kashgar' = 'Kashgar',
        'Asia/Kathmandu' = 'Kathmandu',
        'Asia/Katmandu' = 'Katmandu',
        'Asia/Kolkata' = 'Kolkata',
        'Asia/Krasnoyarsk' = 'Krasnoyarsk',
        'Asia/Kuala_Lumpur' = 'Kuala Lumpur',
        'Asia/Kuching' = 'Kuching',
        'Asia/Kuwait' = 'Kuwait',
        'Asia/Macao' = 'Macao',
        'Asia/Macau' = 'Macau',
        'Asia/Magadan' = 'Magadan',
        'Asia/Makassar' = 'Makassar',
        'Asia/Manila' = 'Manila',
        'Asia/Muscat' = 'Muscat',
        'Asia/Nicosia' = 'Nicosia',
        'Asia/Novokuznetsk' = 'Novokuznetsk',
        'Asia/Novosibirsk' = 'Novosibirsk',
        'Asia/Omsk' = 'Omsk',
        'Asia/Oral' = 'Oral',
        'Asia/Phnom_Penh' = 'Phnom Penh',
        'Asia/Pontianak' = 'Pontianak',
        'Asia/Pyongyang' = 'Pyongyang',
        'Asia/Qatar' = 'Qatar',
        'Asia/Qyzylorda' = 'Qyzylorda',
        'Asia/Rangoon' = 'Rangoon',
        'Asia/Riyadh' = 'Riyadh',
        'Asia/Saigon' = 'Saigon',
        'Asia/Sakhalin' = 'Sakhalin',
        'Asia/Samarkand' = 'Samarkand',
        'Asia/Seoul' = 'Seoul',
        'Asia/Shanghai' = 'Shanghai',
        'Asia/Singapore' = 'Singapore',
        'Asia/Taipei' = 'Taipei',
        'Asia/Tashkent' = 'Tashkent',
        'Asia/Tbilisi' = 'Tbilisi',
        'Asia/Tehran' = 'Tehran',
        'Asia/Tel_Aviv' = 'Tel Aviv',
        'Asia/Thimbu' = 'Thimbu',
        'Asia/Thimphu' = 'Thimphu',
        'Asia/Tokyo' = 'Tokyo',
        'Asia/Ujung_Pandang' = 'Ujung Pandang',
        'Asia/Ulaanbaatar' = 'Ulaanbaatar',
        'Asia/Ulan_Bator' = 'Ulan Bator',
        'Asia/Urumqi' = 'Urumqi',
        'Asia/Vientiane' = 'Vientiane',
        'Asia/Vladivostok' = 'Vladivostok',
        'Asia/Yakutsk' = 'Yakutsk',
        'Asia/Yekaterinburg' = 'Yekaterinburg',
        'Asia/Yerevan' = 'Yerevan'));
    
    local('africa' = array(
        'Africa/Abidjan' = 'Abidjan',
        'Africa/Accra' = 'Accra',
        'Africa/Addis_Ababa' = 'Addis Ababa',
        'Africa/Algiers' = 'Algiers',
        'Africa/Asmara' = 'Asmara',
        'Africa/Asmera' = 'Asmera',
        'Africa/Bamako' = 'Bamako',
        'Africa/Bangui' = 'Bangui',
        'Africa/Banjul' = 'Banjul',
        'Africa/Bissau' = 'Bissau',
        'Africa/Blantyre' = 'Blantyre',
        'Africa/Brazzaville' = 'Brazzaville',
        'Africa/Bujumbura' = 'Bujumbura',
        'Africa/Cairo' = 'Cairo',
        'Africa/Casablanca' = 'Casablanca',
        'Africa/Ceuta' = 'Ceuta',
        'Africa/Conakry' = 'Conakry',
        'Africa/Dakar' = 'Dakar',
        'Africa/Dar_es_Salaam' = 'Dar es Salaam',
        'Africa/Djibouti' = 'Djibouti',
        'Africa/Douala' = 'Douala',
        'Africa/El_Aaiun' = 'El Aaiun',
        'Africa/Freetown' = 'Freetown',
        'Africa/Gaborone' = 'Gaborone',
        'Africa/Harare' = 'Harare',
        'Africa/Johannesburg' = 'Johannesburg',
        'Africa/Kampala' = 'Kampala',
        'Africa/Khartoum' = 'Khartoum',
        'Africa/Kigali' = 'Kigali',
        'Africa/Kinshasa' = 'Kinshasa',
        'Africa/Lagos' = 'Lagos',
        'Africa/Libreville' = 'Libreville',
        'Africa/Lome' = 'Lome',
        'Africa/Luanda' = 'Luanda',
        'Africa/Lubumbashi' = 'Lubumbashi',
        'Africa/Lusaka' = 'Lusaka',
        'Africa/Malabo' = 'Malabo',
        'Africa/Maputo' = 'Maputo',
        'Africa/Maseru' = 'Maseru',
        'Africa/Mbabane' = 'Mbabane',
        'Africa/Mogadishu' = 'Mogadishu',
        'Africa/Monrovia' = 'Monrovia',
        'Africa/Nairobi' = 'Nairobi',
        'Africa/Ndjamena' = 'Ndjamena',
        'Africa/Niamey' = 'Niamey',
        'Africa/Nouakchott' = 'Nouakchott',
        'Africa/Ouagadougou' = 'Ouagadougou',
        'Africa/Porto-Novo' = 'Porto-Novo',
        'Africa/Sao_Tome' = 'Sao Tome',
        'Africa/Timbuktu' = 'Timbuktu',
        'Africa/Tripoli' = 'Tripoli',
        'Africa/Tunis' = 'Tunis',
        'Africa/Windhoek' = 'Windhoek'));
    
    local('australia' = array(
        'Australia/ACT' = 'ACT',
        'Australia/Adelaide' = 'Adelaide',
        'Australia/Brisbane' = 'Brisbane',
        'Australia/Broken_Hill' = 'Broken Hill',
        'Australia/Canberra' = 'Canberra',
        'Australia/Currie' = 'Currie',
        'Australia/Darwin' = 'Darwin',
        'Australia/Eucla' = 'Eucla',
        'Australia/Hobart' = 'Hobart',
        'Australia/LHI' = 'LHI',
        'Australia/Lindeman' = 'Lindeman',
        'Australia/Lord_Howe' = 'Lord Howe',
        'Australia/Melbourne' = 'Melbourne',
        'Australia/North' = 'North',
        'Australia/NSW' = 'NSW',
        'Australia/Perth' = 'Perth',
        'Australia/Queensland' = 'Queensland',
        'Australia/South' = 'South',
        'Australia/Sydney' = 'Sydney',
        'Australia/Tasmania' = 'Tasmania',
        'Australia/Victoria' = 'Victoria',
        'Australia/West' = 'West',
        'Australia/Yancowinna' = 'Yancowinna'));
    
    local('indian' = array(
        'Indian/Antananarivo' = 'Antananarivo',
        'Indian/Chagos' = 'Chagos',
        'Indian/Christmas' = 'Christmas',
        'Indian/Cocos' = 'Cocos',
        'Indian/Comoro' = 'Comoro',
        'Indian/Kerguelen' = 'Kerguelen',
        'Indian/Mahe' = 'Mahe',
        'Indian/Maldives' = 'Maldives',
        'Indian/Mauritius' = 'Mauritius',
        'Indian/Mayotte' = 'Mayotte',
        'Indian/Reunion' = 'Reunion'));
    
    local('atlantic' = array(
        'Atlantic/Azores' = 'Azores',
        'Atlantic/Bermuda' = 'Bermuda',
        'Atlantic/Canary' = 'Canary',
        'Atlantic/Cape_Verde' = 'Cape Verde',
        'Atlantic/Faeroe' = 'Faeroe',
        'Atlantic/Faroe' = 'Faroe',
        'Atlantic/Jan_Mayen' = 'Jan Mayen',
        'Atlantic/Madeira' = 'Madeira',
        'Atlantic/Reykjavik' = 'Reykjavik',
        'Atlantic/South_Georgia' = 'South Georgia',
        'Atlantic/Stanley' = 'Stanley',
        'Atlantic/St_Helena' = 'St Helena'));
    
    local('pacific' = array(
        'Pacific/Apia' = 'Apia',
        'Pacific/Auckland' = 'Auckland',
        'Pacific/Chatham' = 'Chatham',
        'Pacific/Easter' = 'Easter',
        'Pacific/Efate' = 'Efate',
        'Pacific/Enderbury' = 'Enderbury',
        'Pacific/Fakaofo' = 'Fakaofo',
        'Pacific/Fiji' = 'Fiji',
        'Pacific/Funafuti' = 'Funafuti',
        'Pacific/Galapagos' = 'Galapagos',
        'Pacific/Gambier' = 'Gambier',
        'Pacific/Guadalcanal' = 'Guadalcanal',
        'Pacific/Guam' = 'Guam',
        'Pacific/Honolulu' = 'Honolulu',
        'Pacific/Johnston' = 'Johnston',
        'Pacific/Kiritimati' = 'Kiritimati',
        'Pacific/Kosrae' = 'Kosrae',
        'Pacific/Kwajalein' = 'Kwajalein',
        'Pacific/Majuro' = 'Majuro',
        'Pacific/Marquesas' = 'Marquesas',
        'Pacific/Midway' = 'Midway',
        'Pacific/Nauru' = 'Nauru',
        'Pacific/Niue' = 'Niue',
        'Pacific/Norfolk' = 'Norfolk',
        'Pacific/Noumea' = 'Noumea',
        'Pacific/Pago_Pago' = 'Pago Pago',
        'Pacific/Palau' = 'Palau',
        'Pacific/Pitcairn' = 'Pitcairn',
        'Pacific/Ponape' = 'Ponape',
        'Pacific/Port_Moresby' = 'Port Moresby',
        'Pacific/Rarotonga' = 'Rarotonga',
        'Pacific/Saipan' = 'Saipan',
        'Pacific/Samoa' = 'Samoa',
        'Pacific/Tahiti' = 'Tahiti',
        'Pacific/Tarawa' = 'Tarawa',
        'Pacific/Tongatapu' = 'Tongatapu',
        'Pacific/Truk' = 'Truk',
        'Pacific/Wake' = 'Wake',
        'Pacific/Wallis' = 'Wallis',
        'Pacific/Yap' = 'Yap'));
    
    local('antarctica' = array(
        'Antarctica/Casey' = 'Casey',
        'Antarctica/Davis' = 'Davis',
        'Antarctica/DumontDUrville' = 'DumontDUrville',
        'Antarctica/Macquarie' = 'Macquarie',
        'Antarctica/Mawson' = 'Mawson',
        'Antarctica/McMurdo' = 'McMurdo',
        'Antarctica/Palmer' = 'Palmer',
        'Antarctica/Rothera' = 'Rothera',
        'Antarctica/South_Pole' = 'South Pole',
        'Antarctica/Syowa' = 'Syowa',
        'Antarctica/Vostok' = 'Vostok'));
    
    local('arctic' = array(
        'Arctic/Longyearbyen' = 'Longyearbyen'));
    
    local('utc' = array(
        'UTC' = 'UTC'));
    
    local('manual_offsets' = array(
        'UTC-12' = 'UTC-12',
        'UTC-11' = 'UTC-11',
        'UTC-10' = 'UTC-10',
        'UTC-9' = 'UTC-9',
        'UTC-8' = 'UTC-8',
        'UTC-7' = 'UTC-7',
        'UTC-6' = 'UTC-6',
        'UTC-5' = 'UTC-5',
        'UTC-4' = 'UTC-4',
        'UTC-3' = 'UTC-3',
        'UTC-2' = 'UTC-2',
        'UTC-1' = 'UTC-1',
        'UTC+0' = 'UTC+0',
        'UTC+1' = 'UTC+1',
        'UTC+2' = 'UTC+2',
        'UTC+3' = 'UTC+3',
        'UTC+4' = 'UTC+4',
        'UTC+5' = 'UTC+5',
        'UTC+6' = 'UTC+6',
        'UTC+7' = 'UTC+7',
        'UTC+8' = 'UTC+8',
        'UTC+9' = 'UTC+9',
        'UTC+10' = 'UTC+10',
        'UTC+11' = 'UTC+11',
        'UTC+12' = 'UTC+12',
        'UTC+13' = 'UTC+13',
        'UTC+14' = 'UTC+14'));

    local('combined' = array);
    iterate(#lists, local('i'));
        #combined->insert('optgroup_label' = #headers->find(#i));
        #combined->merge(local(#i));
        #combined->insert('optgroup_end' = '');
    /iterate;

    local('out' = '<select name="' + #name + '" id="' + #name + '">\n<option disabled selected style="display:none;">Time Zone...</option>\n');

    iterate(#combined, local('i'));
        if(#i->first == 'optgroup_label');
            #out += '<optgroup label="'+#i->second+'">';
        else(#i->first == 'optgroup_end');
            #out += '</optgroup>';
        else;
            #out += '<option value="' + #i->first + '"';
            #selected == #i->first && #selected != '' ? #out += ' selected';
            #out += '>';
    
            #out += #i->second;
              
            #out += '</option>\n';
        /if;
    /iterate;
     
    #out += '</select>';
    return(@#out);
/define_tag;
]

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>tz_convert by Steve Piercy</title>
<link rel="stylesheet" type="text/css" media="screen" href="http://keith-wood.name/css/jquery.datetimeentry.css" />
</head>
<body>
<h1>Inputs</h1>
<form action="[response_filepath]" method="post">
<div>
Date Time
<input name="dt" id="dt" type="text" size="30" value="[action_param('dt')]">
</div>
<div>
Timezone From
[tz_select(-name='tzin', -selected=action_param('tzin'))]
</div>
<div>
Timezone To
[tz_select(-name='tzout', -selected=action_param('tzout'))]
</div>
<div>
Format
<input name="format" id="format" type="text" size="20" value="[action_param('format')]" placeholder="%F %T"> (See GNU coreutils <a href="http://www.gnu.org/software/coreutils/manual/coreutils.html#date-invocation" target="_blank">time, date, and literal conversion specifiers</a> for formats.)
</div>
<div>
<input name="showcmd" id="showcmd" type="radio" value="true" [action_param('showcmd') == 'true' ? 'checked="checked"']/>Show Command<br>
<input name="showcmd" id="showcmd" type="radio" value="false" [action_param('showcmd') != 'true' ? 'checked="checked"'] />Hide Command
</div>
<div>
<input name="submit" id="submit" type="submit" value="submit">
</div>
</form>

[if(action_param('submit') != '');
    local('dt' = date(action_param('dt')));
    local('tzin' = action_param('tzin'));
    local('tzout' = action_param('tzout'));
    local('format' = action_param('format'));
    local('showcmd' = boolean(action_param('showcmd')));
    '<h1>Conversion of ';
    #tzin == '' ? 'UTC' | #tzin;
    ' to ';
    #tzout == '' ? 'UTC' | #tzout;
    '</h1><p>';
    tz_convert(-dt=#dt, -tzin=#tzin, -tzout=#tzout, -format=#format, -showcmd=#showcmd);
    '</p>';
/if]

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="http://keith-wood.name/js/jquery.datetimeentry.js"></script>

<script type="text/javascript" language="javascript" charset="utf-8">
$(function () {
	$.datetimeEntry.setDefaults({spinnerImage: 'http://keith-wood.name/img/spinnerDefault.png'});
    $('#dt').datetimeEntry({datetimeFormat: 'Y-O-D H:M:S'});
});
</script>
</body>
</html>

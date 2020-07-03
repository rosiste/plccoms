# Description:

PLC communication server provide service for connection clients (TCP/IP) to PLC (EPSNET or SHARED module).

# Program arguments:
```
	Usage: PLCComS [-dtvh] [-c <configfile>] [-l <logfile>]

		-d, --daemon    fork into background
		-t, --terminate terminate if configuration file was changed
		-v, --verbose   verbose mode (multiple -v options increase the verbosity)
		-c, --config    configuration file
		-l, --log       log file
		-h, --help      display this help and exit

	Default values:

		configfile      PLCComS.ini
		logfile         PLCComS.log
```
# Client protocol:

Is simple text oriented protocol. Every line is ended new line character (DOS [\r\n] or UNIX [\n]). For testing is possible use telnet client.
```
	Commands:
    
		LIST:\n											- Get list of all variables in public file.
		SET:<variable_name,value>\n						- Set variable in PLC to requested value.
		GET:<variable_name>\n							- Get value of variable from PLC.
		EN:[variable_name] [delta]\n					- Enable variable(s) in public file and set variance delta.
		DI:[variable_name] [delta]\n					- Disable variable(s) in public file and set variance delta.
		HIDE:<variable_name>\n							- Hide variable(s) in public file.
		UNHIDE:<variable_name>\n						- Unhide variable(s) in public file.
		GETMEM:<variable_name mem_size>					- Get memory block from PLC.
		GETFILE:<file_name>\n							- Get file from PLC.
		GETFILEINFO:<file_name>\n						- Get informations about file from PLC.
		WRITEFILE:<file_name>[<block_size>]=data\n		- Write file into PLC or PC.
		WRITEFILEINFO:<file_name>[<block_size>]=data\n	- Write informations about file into PLC or PC.
		GETINFO:[name]\n								- Get informations about communication server.
			name:
				version					- Version of the communication server.
				epsnet_version			- Version of EPSNET library.
				version_ini				- Version of INI parsing library.
				version_plc				- PLC version.
				ipaddr					- IP address of PLC.
				epsaddr					- EPSNET source address.
				epsport					- EPSNET communication port.
				serial_device			- Settings of serial line.
				pubfile					- The names of actual public files.
				network					- List of connected clients.
		SETCONF:<variable_name,value>\n - Change variable listed in configuration file.
			variable_name:
				ipaddr					- IP address of PLC.
				epsaddr					- EPSNET source address (1 - 126).
				epsport					- EPSNET communication port.
				serial_device			- Name of serial line.
				serial_speed			- Communication speed for serial line.
				pubfile					- Public file.
				crlf					- End line character (yes = DOS [\r\n], no = UNIX [\n]).
				diff					- Enable or disable sending DIFF messages (yes = Enabled).

		HELP:\n                         - Display help message.

	Answers for commands:
    
		LIST:\n
		LIST:test_1\n
		LIST:test_2\n
		LIST:\n
	
		SET:test_1,123\n
		DIFF:test_1,123\n				- DIFF is send if any variables change value.
	
		GET:test_1\n
		GET:test_1,123\n
		GET:test_string\n
		GET:test_string,"Hello!"\n

		GETFILE://www/LOGIN.XML\n
		GETFILE://www/LOGIN.XML[195]=<?xml version="1.0"
		encoding="windows-1250" ?>\n
		<?xml-stylesheet type="text/xsl" href="login.xsl"
		version="1.0"?>\n
		<LOGIN>\n
			<USER VALUE=""/>\n
			<PASS VALUE=""/>\n
        		<ACER VALUE="0"/>\n
		</LOGIN>\n
		\n
		GETFILE://www/LOGIN.XML[0]=\n

		GETFILEINFO://www/LOGIN.XML\n
		GETFILEINFO://www/LOGIN.XML[36]=195 32 59391128503405 59391128503405\n

		GETINFO:\n
		GETINFO:VERSION,Ver 5.1 Oct 18 2019 11:21:30
		GETINFO:VERSION_EPSNET,Ver 2.9 Oct 18 2019 11:21:28
		GETINFO:VERSION_INI,Ver 3.2 Oct 18 2019 11:21:36
		GETINFO:VERSION_PLC,CP2980I   B 2.7 1.9
		GETINFO:IPADDR,192.168.134.176
		GETINFO:EPSADDR,1
		GETINFO:EPSPORT,61682
		GETINFO:PUBFILE,2/2 [FIXED_Foxtrot.pub,//iFoxtrot.pub]
		GETINFO:NETWORK,1/128 [127.0.0.1]
		GETINFO:\n
```
Commands and variable names is not case sensitive. Is possible combine upper and lower chracters. Closing connection in telnet client is via ansi escape sequence ctrl+d.

# Public file `*.pub`:

Describe feedback between PLC register names (Absolute address of variable in PLC) and symbolic names.

# Configuration file `PLCComS.ini`:

Describe connection between clients (Via TCP port number) and PLC (Via IP address). Name of public file (If public file is absent in local disk is downloaded from PLC).

# Installation:

On OS Linux, just run the Install.sh script `bash ./Install.sh`, which sets the server to start automatically when the system starts. Server output is stored to `/var/log/PLCComS.log` file.

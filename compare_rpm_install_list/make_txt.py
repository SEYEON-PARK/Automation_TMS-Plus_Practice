'''
centOS rpm 설치 목록(레드마인에서 txt 파일 다운로드하면 아래 딕셔너리 쉽게 얻을 수 있다.)
'''
centRPM = {
    "perl" :  
        {
            "perl.x86_64" : "4:5.16.3-299.el7_9",
            "perl-Carp.noarch" : "1.26-244.el7",
            "perl-Compress-Raw-Bzip2.x86_64" : "2.061-3.el7",
            "perl-Compress-Raw-Zlib.x86_64" : "1:2.061-4.el7",
            "perl-DBI.x86_64" : "1.627-4.el7",
            "perl-Data-Dumper.x86_64" : "2.145-3.el7",
            "perl-Encode.x86_64" : "2.51-7.el7",
            "perl-Exporter.noarch" : "5.68-3.el7",
            "perl-File-Path.noarch" : "2.09-2.el7",
            "perl-File-Temp.noarch" : "0.23.01-3.el7",
            "perl-Filter.x86_64" : "1.49-3.el7",
            "perl-Getopt-Long.noarch" : "2.40-3.el7",
            "perl-HTTP-Tiny.noarch" : "0.033-3.el7",
            "perl-IO-Compress.noarch" : "2.061-2.el7",
            "perl-Net-Daemon.noarch" : "0.48-5.el7",
            "perl-PathTools.x86_64" : "3.40-5.el7",
            "perl-PlRPC.noarch" : "0.2020-14.el7",
            "perl-Pod-Escapes.noarch" : "1:1.04-299.el7_9",
            "perl-Pod-Perldoc.noarch" : "3.20-4.el7",
            "perl-Pod-Simple.noarch" : "1:3.28-4.el7",
            "perl-Pod-Usage.noarch" : "1.63-3.el7",
            "perl-Scalar-List-Utils.x86_64" : "1.27-248.el7",
            "perl-Socket.x86_64" : "2.010-5.el7",
            "perl-Storable.x86_64" : "2.45-3.el7",
            "perl-Text-ParseWords.noarch" : "3.29-4.el7",
            "perl-Time-HiRes.x86_64" : "4:1.9725-3.el7",
            "perl-Time-Local.noarch" : "1.2300-2.el7",
            "perl-constant.noarch" : "1.27-2.el7",
            "perl-libs.x86_64" : "4:5.16.3-299.el7_9",
            "perl-macros.x86_64" : "4:5.16.3-299.el7_9",
            "perl-parent.noarch" : "1:0.225-244.el7",
            "perl-podlators.noarch" : "2.5.1-3.el7",
            "perl-threads.x86_64" : "1.87-4.el7",
            "perl-threads-shared.x86_64" : "1.43-6.el7" 
        },

        "net-tools" : 
        {
            "net-tools.x86_64" : "2.0-0.22.20131004git.el7"  
        },

        "ntsysv": 
        {
            "chkconfig.x86_64" : "1.7.6-1.el7",
            "ntsysv.x86_64" : "1.7.6-1.el7" 
        },

        "tcpdump": 
        {
            "tcpdump.x86_64" : "14:4.9.2-3.el7",
            "libpcap.x86_64" : "14:1.5.3-11.el7" 
        },

         "policycoreutils": 
         {
            "libselinux.x86_64" : "2.5-12.el7",
            "libselinux-python.x86_64" : "2.5-12.el7",
            "libselinux-utils.x86_64" : "2.5-12.el7",
            "libsepol.x86_64" : "2.5-8.el7",
            "policycoreutils.x86_64" : "2.5-22.el7" 

         },

         "dialog": 
         {
            "dialog.x86_64" : "1.2-4.20130523.el7" 
         },

         "ntpdate": 
         {
            "ntpdate.x86_64" : "4.2.6p5-28.el7.centos" 
         },

         "rdate": 
         {
            "rdate.x86_64" : "1.4-25.el7" 
         },

         "pciutils": 
         {
            "pciutils-libs.x86_64" : "3.5.1-3.el7",
            "pciutils.x86_64" : "3.5.1-3.el7" 
         },

         "smartmontools": 
         {
            "mailx.x86_64" : "12.5-19.el7",
            "smartmontools.x86_64" : "1:6.5-1.el7" 
         },

         "fontconfig":
         {
            "fontconfig.x86_64" : "2.10.95-11.el7",
            "fontpackages-filesystem.noarch" : "1.44-8.el7",
            "stix-fonts.noarch" : "1.1.0-5.el7" 
         },

         "ntp": 
         {
            "ntp.x86_64" : "4.2.6p5-28.el7.centos",
            "ntpdate.x86_64" : "4.2.6p5-28.el7.centos",
            "autogen-libopts.x86_64" : "5.18-5.el7" 
         },

         "sshpass": 
         {
            "sshpass.x86_64" : "1.06-2.el7" 
         },

         "gdb": 
         {
            "gdb.x86_64" : "7.6.1-110.el7" 
         },

         "wget": 
         {
            "wget.x86_64" : "1.14-15.el7_4.1" 
         },

         "iptables-services": 
         {
            "iptables.x86_64" : "1.4.21-28.el7",
            "iptables-services.x86_64" : "1.4.21-28.el7" 
         },

         "lsof": 
         {
            "lsof.x86_64" : "4.87-4.el7" 
         },

         "ipmitool": 
         {
            "OpenIPMI.x86_64" : "2.0.27-1.el7",
            "OpenIPMI-libs.x86_64" : "2.0.27-1.el7",
            "OpenIPMI-modalias.x86_64" : "2.0.27-1.el7",
            "ipmitool.x86_64" : "1.8.18-9.el7_7",
            "net-snmp-libs.x86_64" : "1:5.7.2-49.el7" 
         },

         "rsyslog": 
         {
            "libfastjson4.x86_64" : "0.99.9-1.el7",
            "libestr.x86_64" : "0.1.11-1.el7",
            "rsyslog.x86_64" : "8.2208.0-1.el7" 
         },

         "rsyslog-openssl": 
         {
            "trousers.x86_64" : "0.3.14-2.el7",
            "trousers-devel.x86_64" : "0.3.14-2.el7",
            "nettle.x86_64" : "2.7.1-8.el7",
            "gnutls.x86_64" :  "3.3.29-9.el7_6",
            "rsyslog-gnutls.x86_64 " : "8.2208.0-1.el7",
            "rsyslog-openssl.x86_64" :  "8.2208.0-1.el7" 
         },
         "ldap": 
         {
            "compat-openldap.x86_64" : "1:2.3.43-5.el7",
            "openldap.x86_64" : "2.4.44-23.el7_9",
            "openldap-clients.x86_64" : "2.4.44-23.el7_9",
            "openldap-devel.x86_64" : "2.4.44-23.el7_9",
            "openldap-servers.x86_64" : "2.4.44-23.el7_9",
            "openldap-servers-sql.x86_64" : "2.4.44-23.el7_9",
            "cyrus-sasl.x86_64" : "2.1.26-23.el7",
            "cyrus-sasl-devel.x86_64" : "2.1.26-23.el7",
            "cyrus-sasl-lib.x86_64" : "2.1.26-23.el7",
            "libtool-ltdl.x86_64" : "2.4.2-22.el7_3",
            "unixODBC.x86_64" : "2.3.1-14.el7" 
         },

         "radius": 
         {
            "apr.x86_64" : "1.4.8-7.el7",
            "apr-util.x86_64" : "1.5.2-6.el7",
            "boost-system.x86_64" : "1.53.0-28.el7",
            "freeradius.x86_64" : "3.0.13-15.el7",
            "freeradius-utils.x86_64" : "3.0.13-15.el7",
            "libtalloc.x86_64" : "2.1.16-1.el7",
            "log4cxx.x86_64" : "0.10.0-16.el7",
            "tncfhh.x86_64" : "0.8.3-16.el7",
            "tncfhh-libs.x86_64" : "0.8.3-16.el7",
            "tncfhh-utils.x86_64" : "0.8.3-16.el7",
            "xerces-c.x86_64" : "3.1.1-10.el7_7" 
         },

         "tacacs": 
         {
            "tac_plus.x86_64" : "4.0.4.26-1.el6.nux" 
         },

         "MegaCli": 
         {
            "MegaCli.noarch" : "8.07.14-1" 
         },

         "unzip" :
         {
            "unzip.x86_64" : "6.0-19.el7" 
         }
    }

# 파일에 항목들을 한 줄씩 저장
with open("centOS.txt", "w") as file:
    for category, items in centRPM.items():
        for item in items:
            file.write(item + "\n")
            
'''
rocky rpm 설치 목록(레드마인에서 txt 파일 다운로드하면 아래 딕셔너리 쉽게 얻을 수 있다.)
'''

rockyRPM = {
    "perl": [
        "dwz",
        "efi-srpm-macros",
        "ghc-srpm-macros",
        "go-srpm-macros",
        "make",
        "ocaml-srpm-macros",
        "openblas-srpm-macros",
        "perl",
        "perl-Algorithm-Diff",
        "perl-Archive-Tar",
        "perl-Archive-Zip",
        "perl-Attribute-Handlers",
        "perl-autodie",
        "perl-B-Debug",
        "perl-bignum",
        "perl-Carp",
        "perl-Compress-Bzip2",
        "perl-Compress-Raw-Bzip2",
        "perl-Compress-Raw-Zlib",
        "perl-Config-Perl-V",
        "perl-constant",
        "perl-CPAN",
        "perl-CPAN-Meta",
        "perl-CPAN-Meta-Requirements",
        "perl-CPAN-Meta-YAML",
        "perl-Data-Dumper",
        "perl-Data-OptList",
        "perl-Data-Section",
        "perl-DB_File",
        "perl-devel",
        "perl-Devel-Peek",
        "perl-Devel-PPPort",
        "perl-Devel-SelfStubber",
        "perl-Devel-Size",
        "perl-Digest",
        "perl-Digest-MD5",
        "perl-Digest-SHA",
        "perl-Encode",
        "perl-Encode-devel",
        "perl-Encode-Locale",
        "perl-encoding",
        "perl-Env",
        "perl-Errno",
        "perl-experimental",
        "perl-Exporter",
        "perl-ExtUtils-CBuilder",
        "perl-ExtUtils-Command",
        "perl-ExtUtils-Embed",
        "perl-ExtUtils-Install",
        "perl-ExtUtils-MakeMaker",
        "perl-ExtUtils-Manifest",
        "perl-ExtUtils-Miniperl",
        "perl-ExtUtils-MM-Utils",
        "perl-ExtUtils-ParseXS",
        "perl-File-Fetch",
        "perl-File-HomeDir",
        "perl-File-Path",
        "perl-File-Temp",
        "perl-File-Which",
        "perl-Filter",
        "perl-Filter-Simple",
        "perl-Getopt-Long",
        "perl-HTTP-Tiny",
        "perl-inc-latest",
        "perl-interpreter",
        "perl-IO",
        "perl-IO-Compress",
        "perl-IO-Socket-IP",
        "perl-IO-Socket-SSL",
        "perl-IO-Zlib",
        "perl-IPC-Cmd",
        "perl-IPC-System-Simple",
        "perl-IPC-SysV",
        "perl-JSON-PP",
        "perl-libnet",
        "perl-libnetcfg",
        "perl-libs",
        "perl-Locale-Codes",
        "perl-Locale-Maketext",
        "perl-Locale-Maketext-Simple",
        "perl-local-lib",
        "perl-macros",
        "perl-Math-BigInt",
        "perl-Math-BigInt-FastCalc",
        "perl-Math-BigRat",
        "perl-Math-Complex",
        "perl-Memoize",
        "perl-MIME-Base64",
        "perl-Module-Build",
        "perl-Module-CoreList",
        "perl-Module-CoreList-tools",
        "perl-Module-Load",
        "perl-Module-Load-Conditional",
        "perl-Module-Loaded",
        "perl-Module-Metadata",
        "perl-Mozilla-CA",
        "perl-MRO-Compat",
        "perl-Net-Ping",
        "perl-Net-SSLeay",
        "perl-open",
        "perl-Package-Generator",
        "perl-Params-Check",
        "perl-Params-Util",
        "perl-parent",
        "perl-PathTools",
        "perl-perlfaq",
        "perl-PerlIO-via-QuotedPrint",
        "perl-Perl-OSType",
        "perl-Pod-Checker",
        "perl-Pod-Escapes",
        "perl-Pod-Html",
        "perl-podlators",
        "perl-Pod-Parser",
        "perl-Pod-Perldoc",
        "perl-Pod-Simple",
        "perl-Pod-Usage",
        "perl-Scalar-List-Utils",
        "perl-SelfLoader",
        "perl-Socket",
        "perl-Software-License",
        "perl-srpm-macros",
        "perl-Storable",
        "perl-Sub-Exporter",
        "perl-Sub-Install",
        "perl-Sys-Syslog",
        "perl-Term-ANSIColor",
        "perl-Term-Cap",
        "perl-TermReadKey",
        "perl-Test",
        "perl-Test-Harness",
        "perl-Test-Simple",
        "perl-Text-Balanced",
        "perl-Text-Diff",
        "perl-Text-Glob",
        "perl-Text-ParseWords",
        "perl-Text-Tabs+Wrap",
        "perl-Text-Template",
        "perl-Thread-Queue",
        "perl-threads",
        "perl-threads-shared",
        "perl-Time-HiRes",
        "perl-Time-Local",
        "perl-Time-Piece",
        "perl-Unicode-Collate",
        "perl-Unicode-Normalize",
        "perl-URI",
        "perl-utils",
        "perl-version",
        "python3-pyparsing",
        "python3-rpm-macros",
        "python-rpm-macros",
        "python-srpm-macros",
        "qt5-srpm-macros",
        "redhat-rpm-config",
        "rust-srpm-macros",
        "systemtap-sdt-devel",
        "unzip",
        "zip"
    ],
    "nettools": [
        "chkconfig",
        "net-tools"
    ],
    "ntsysv": ["ntsysv"],
    "tcpdump": [
        "libibverbs", 
        "libpcap", 
        "tcpdump"
    ],
    "policycoreutils": [
        "libselinux",
        "libselinux-utils",
        "libsepol",
        "policycoreutils",
        "policycoreutils-python-utils",
        "python3-libselinux",
        "python3-policycoreutils"
    ],
    "dialog": ["dialog"],
    "pciutil": ["pciutils", "pciutils-libs"],
    "smartmontools": ["smartmontools"],
    "fontconfig": [
        "fontpackages-filesystem",
        "stix-fonts",
        "freetype",
        "fontconfig"
    ],
    "sshpass": ["sshpass"],
    "gdb": [
        "libbabeltrace",
        "libipt",
        "libicu",
        "boost-regex",
        "ctags",
        "source-highlight",
        "libatomic_ops",
        "gc",
        "libtool-ltdl",
        "guile",
        "gdb",
        "gdb-headless"
    ],
    "wget": ["binutils", "libmetalink", "wget"],
    "iptables": [
        "libnftnl",
        "libnfnetlink",
        "libnetfilter_conntrack",
        "iptables",
        "iptables-libs"
    ],
    "lsof": ["lsof"],
    "ipmitool": [
        "net-snmp-libs",
        "OpenIPMI",
        "OpenIPMI-libs",
        "ipmitool"
    ],
    "rsyslog": [
        "libfastjson",
        "libestr",
        "selinux-policy",
        "selinux-policy-targeted",
        "rsyslog",
        "rsyslog-gnutls",
        "rsyslog-openssl"
    ],
    "rsyslogopenssl": [
        "trousers",
        "trousers-lib",
        "nettle",
        "gnutls"
    ],
    "ldap": [
        "openldap",
        "openldap-clients",
        "libtool-ltdl",
        "openldap-servers",
        "unixODBC",
        "cyrus-sasl-lib",
        "cyrus-sasl",
        "libpkgconf",
        "pkgconf",
        "pkgconf-m4",
        "pkgconf-pkg-config",
        "cyrus-sasl-devel",
        "openldap-devel"
    ],
    "radius": [
        "libtalloc",
        "apr",
        "apr-util",
        "apr-util-bdb",
        "apr-util-openssl",
        "boost-system",
        "boost-thread",
        "perl-DBI",
        "freeradius",
        "freeradius-utils"
    ],
    "storcli": ["storcli"],
    "mongodbtool": ["mongodb-database-tools"]
}

# 파일에 항목들을 한 줄씩 저장
with open("rocky.txt", "w") as file:
    for category, items in rockyRPM.items():
        for item in items:
            file.write(item + "\n")
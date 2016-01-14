class php::install{
    package{'epel-release':
        provider => 'yum',
        ensure => installed
    }
    
    package { 'remi-release':
        ensure   => installed,
        source   => 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
        provider => rpm,
        require  => Package['epel-release'],
    }

    package{ 
        'httpd':
        provider => 'yum',
        ensure => 'latest',
        require => Package['remi-release']
    }

    package{ 
        'php':
        provider => 'yum',
        ensure => 'latest',
        install_options => ['--enablerepo=remi,remi-php56,epel','--noplugins'],
        require => Package['httpd']
    }

    package{ 
        'php-opcache':
        provider => 'yum',
        ensure => installed,
        install_options => ['--enablerepo=remi,remi-php56'],
        require => Package['php']
    }

    package{
        [
        'php-cli',
        'php-common',
        'php-pdo',
        'php-mbstring',
        'php-mysqlnd',
        'php-pecl-xdebug',
        'php-devel',
        'php-fpm',
        'php-xml',
        'php-mcrypt',
        'libmcrypt',
        'siege',
        'memcached',
        'php-pecl-memcached',
        'openssh-clients',
        'wget',
        'git',
        'screen',
        'unzip',
        'make',
        'dstat',
        'emacs',
        'vim-enhanced',
        'telnet',
        'tree',
        'sysstat',
        'perf',
        'cronie-noanacron',
        'npm',
        'varnish',
        ]:
        provider => 'yum',
        ensure => latest,
        install_options => ['--enablerepo=remi,remi-php56,epel','--noplugins'],
        require => Package['php-opcache']
    }

    package{
        [
        'cronie-anacron',
        ]:
        ensure => purged,
        require => Package['remi-release']
    }

}

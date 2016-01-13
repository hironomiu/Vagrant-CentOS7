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
        [
        'php',
        'php-cli',
        'php-common',
        'php-devel',
        'php-pdo',
        'php-xml',
        'php-mbstring',
        'php-mysqlnd',
        'php-pecl-xdebug',
        'php-opcache',
        'php-fpm',
        'php-mcrypt',
        'libmcrypt',
        ]:
        provider => 'yum',
        ensure => 'latest',
        install_options => ['--enablerepo=remi,remi-php56','--disablerepo=base'],
        require => Package['httpd']
    }

    package{
        [
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
        ]:
        provider => 'yum',
        ensure => latest,
        install_options => ['--enablerepo=remi'],
        require => Package[
        'php',
        'php-cli',
        'php-common',
        'php-devel',
        'php-pdo',
        'php-xml',
        'php-mbstring',
        'php-mysqlnd',
        'php-pecl-xdebug',
        'php-opcache',
        'php-fpm',
        'php-mcrypt',
        'libmcrypt']
    }

    package{
        [
        'cronie-anacron',
        ]:
        ensure => purged,
        require => Package['remi-release']
    }

}

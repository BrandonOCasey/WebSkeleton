class { 'apache': }
apache::vhost { 'example.com':
    port           => '80',
    docroot        => '/vagrant/webroot/test',
    docroot_owner  => 'vagrant',
    docroot_group  => 'vagrant'
}

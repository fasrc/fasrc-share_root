# Define: share_root::readme
# create the share_root directory and
# README.yaml files from a template
#
define share_root::readme (
  $date        = strftime("%Y-%m-%d"),
  $description = 'a new share',
  $path        = undef,
  $size        = undef,
  $ticket      = 'n/a',
  $owner       = 'root',
  $group       = 'root',
  $mode        = '0644',

) {
  ensure_resource(
    file,
    "${path}/share_root",
    {
      'ensure'  => 'directory',
      'owner'   => $owner,
      'group'   => $group,
      'mode'    => $mode,
      'require' => 'Mount["${path}"]',
    }
  )

  file { "${path}/README.yaml" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('share_root/readme.yaml.erb'),
    require => File["${path}/share_root"],
  }
}

#####################################
##### Salt Formula For Resolver #####
#####################################

# Include :download:`map file <map.jinja>` of OS-specific package names and
# # file paths. Values can be overridden using Pillar.
{% from "resolver/map.jinja" import resolver with context %}

# Resolver Configuration
/etc/resolv.conf:
  file.managed:
    - user: {{ resolver.owner }}
    - group: {{ resolver.group }}
    - mode: '0644'
    - source: salt://resolver/files/resolv.conf
    - template: jinja
    - defaults:
        nameservers: {{ salt['pillar.get']('resolver:nameservers', ['8.8.8.8','8.8.4.4']) }}
        searchpaths: {{ salt['pillar.get']('resolver:searchpaths', salt['grains.get']('domain')) }}

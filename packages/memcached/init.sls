memcached:
    pkg:
        - installed
    service.running:
        - enable: True
        - watch:
            - file: /etc/memcached.conf

/etc/memcached.conf:
    file.managed:
        - template: jinja
        - source: salt://packages/memcached/memcached.conf.jinja
        - mode: 640
        - defaults:
            ip: {{ grains.ip_interfaces.get("eth1", "127.0.0.1")[0] }}
            memory_cap: 256
redis_ppa:
    pkgrepo.managed:
        - ppa: rwky/redis

redis-server:
    pkg.latest:
        - refresh: True
        - require:
            - pkgrepo: redis_ppa
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: redis-server
        - watch:
            - file: /etc/redis/redis.conf

/etc/redis/redis.conf:
    file.managed:
        - template: jinja
        - source: salt://packages/redis/redis.conf.jinja
        - defaults:
            bind_address: {{ grains.ip_interfaces.get("eth1", ["127.0.0.1"])[0] }}
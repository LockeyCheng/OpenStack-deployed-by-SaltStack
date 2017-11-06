# OpenStack deployed by SaltStack

相关内容CSDN博客地址http://blog.csdn.net/lockey23/article/details/78453793

### 项目结构：

[root@ok-vm1 srv]# tree -L 3
.
├── pillar
│-- ├── openstack
│-- │-- └── args.sls
│-- └── top.sls
└── salt
    ├── chrony
    │-- ├── files
    │-- └── install.sls
    ├── mariadb
    │-- ├── files
    │-- └── install.sls
    ├── memcached
    │-- ├── files
    │-- └── install.sls
    ├── openstack
    │-- ├── cindercp.sls
    │-- ├── cinderctl.sls
    │-- ├── computor.sls
    │-- ├── contronller.sls
    │-- ├── dashboard.sls
    │-- ├── files
    │-- ├── glance.sls
    │-- ├── keystone.sls
    │-- ├── neutroncp.sls
    │-- ├── neutronctl.sls
    │-- ├── novacp.sls
    │-- └── novactl.sls
    ├── rabbitmq
    │-- └── install.sls
    └── top.sls
    
### 部分结果截图：
 
![ssh访问云主机](http://img.blog.csdn.net/20171106001510714?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTG9ja2V5MjM=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

通过浏览器访问云主机：

![浏览器访问云主机](http://img.blog.csdn.net/20171106001612271?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTG9ja2V5MjM=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

通过web界面查看云平台信息：

![Dashboard1](http://img.blog.csdn.net/20171106001655118?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTG9ja2V5MjM=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![Dashboard2](http://img.blog.csdn.net/20171106001705537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTG9ja2V5MjM=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![Dashboard3](http://img.blog.csdn.net/20171106001716039?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTG9ja2V5MjM=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

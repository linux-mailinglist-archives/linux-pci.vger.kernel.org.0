Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0459B35B
	for <lists+linux-pci@lfdr.de>; Sun, 21 Aug 2022 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiHULgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 07:36:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F00E18349;
        Sun, 21 Aug 2022 04:35:59 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M9YL46ljYzGpfF;
        Sun, 21 Aug 2022 19:34:20 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 21 Aug 2022 19:35:57 +0800
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 21 Aug 2022 19:35:57 +0800
Received: from dggpemm500007.china.huawei.com ([7.185.36.183]) by
 dggpemm500007.china.huawei.com ([7.185.36.183]) with mapi id 15.01.2375.024;
 Sun, 21 Aug 2022 19:35:57 +0800
From:   zhuangshengen <zhuangshengen@huawei.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>
Subject: Re: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Topic: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Index: Adi1Uhj9spPz1b9KT9CKr88dkJbU8g==
Date:   Sun, 21 Aug 2022 11:35:57 +0000
Message-ID: <0acb9dc40dc44e26ac4d65cce41a15de@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.222.141]
Content-Type: multipart/mixed;
        boundary="_002_0acb9dc40dc44e26ac4d65cce41a15dehuaweicom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--_002_0acb9dc40dc44e26ac4d65cce41a15dehuaweicom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> On Wed, Aug 17, 2022 at 07:43:34AM +0000, Zhoujian (jay) wrote:
> > Hi,
> >=20
> > Enable SRIOV concurrently with many different PFs in userspace seems wo=
rkable.
> > I'm trying to do it with 8 PFs(each one with 240+ VFs), but get some=20
> > warnings, here is the backtrace:
>=20
> This definitely seems like a problem that should be fixed.  If you have a=
 script that can reproduce it, that might help people work on it.  If you c=
an reproduce it in qemu, that would be even better.
>

  I am enclosing a demo that will echo sriov_totalvfs > /sys/bus/pci/device=
s/$PF_BDF/sriov_numvfs concurrently, which can help reproduce the problem, =
please find attached.

> Some comments on the patch below.
>=20
> > Warning 1:
> > ---
> > sysfs: cannot create duplicate filename '/devices/pci0000:30/0000:30:02=
.0/pci_bus/0000:32'
> > Call Trace:
> >  dump_stack+0x6f/0xab
> >  sysfs_warn_dup+0x56/0x70
> >  sysfs_create_dir_ns+0x80/0x90
> >  kobject_add_internal+0xa0/0x2b0
> >  kobject_add+0x71/0xd0
> >  device_add+0x126/0x630
> >  pci_add_new_bus+0x17c/0x4b0
> >  pci_iov_add_virtfn+0x336/0x390
> >  sriov_enable+0x26e/0x450
> >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > ---
> > The reason is that different VFs may create the same pci bus number=20
> > and try to add new bus concurrently in virtfn_add_bus.
> >=20
> > Warning 2:
> > ---
> > proc_dir_entry 'pci/33' already registered
> > WARNING: CPU: 71 PID: 893 at fs/proc/generic.c:360=20
> > proc_register+0xf8/0x130 Call Trace:
> >  proc_mkdir_data+0x5d/0x80
> >  pci_proc_attach_device+0xe9/0x120
> >  pci_bus_add_device+0x33/0x90
> >  pci_iov_add_virtfn+0x375/0x390
> >  sriov_enable+0x26e/0x450
> >  virtio_pci_sriov_configure+0x61/0xc0 [virtio_pci]
> > ---
> > The reason is that different VFs may create '/proc/bus/pci/bus_number'
> > directory using the same bus number in pci_proc_attach_device concurren=
tly.
> >=20
> > Mutex lock can avoid potential conflict. With the patch below the=20
> > warnings above are no longer appear.
> >=20
> > My question is that any plan to support enable PCI SRIOV concurrently i=
n kernel side?
> >=20
> > Thanks
> >=20
> > ---
> > drivers/pci/iov.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index=20
> > 952217572113..6a8a849298c4 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -16,6 +16,12 @@
> > =20
> >  #define VIRTFN_ID_LEN    16
> > =20
> > +static struct mutex add_bus_mutex;
> > +static int add_bus_mutex_initialized;
> > +
> > +static struct mutex add_device_mutex; static int=20
> > +add_device_mutex_initialized;
> > +
> >  int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)  {
> >      if (!dev->is_physfn)
> > @@ -127,13 +133,24 @@ static struct pci_bus *virtfn_add_bus(struct pci_=
bus *bus, int busnr)
> >      if (bus->number =3D=3D busnr)
> >          return bus;
> > =20
> > +    if (!add_bus_mutex_initialized) {
> > +        mutex_init(&add_bus_mutex);
> > +        add_bus_mutex_initialized =3D 1;
> > +    }
>=20
> I assume this patch works around the warning.  I see the intent here, but=
 I think would need some rework before merging it.  These locks protect pci=
_add_new_bus() and pci_bus_add_device(), but only for the callers in iov.c.=
  These interfaces are both called from places other than iov.c, and any mu=
tual exclusion should cover all of them.
>=20
> I'm actually not sure how the other callers are protected.  I assume we'r=
e holding a device_lock for some device farther up the chain.  Or, I see th=
at acpi_pci_root_add() and rescan_store() hold pci_rescan_remove_lock while=
 calling these.  We don't seem to hold that uniformly though, which bothers=
 me, because I think there are many other paths, e.g., pci_host_probe() and=
 its callers.
>=20
> > +    mutex_lock(&add_bus_mutex);
> > +
> >      child =3D pci_find_bus(pci_domain_nr(bus), busnr);
> > -    if (child)
> > +    if (child) {
> > +        mutex_unlock(&add_bus_mutex);
> >          return child;
> > +    }
> > =20
> >      child =3D pci_add_new_bus(bus, NULL, busnr);
> > -    if (!child)
> > +    if (!child) {
> > +        mutex_unlock(&add_bus_mutex);
> >          return NULL;
> > +    }
> > +    mutex_unlock(&add_bus_mutex);
> > =20
> >      pci_bus_insert_busn_res(child, busnr, busnr);
> > =20
> > @@ -339,8 +356,16 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id=
)
> >      if (rc)
> >          goto failed1;
> > =20
> > +    if (!add_device_mutex_initialized) {
> > +        mutex_init(&add_device_mutex);
> > +        add_device_mutex_initialized =3D 1;
> > +    }
> > +    mutex_lock(&add_device_mutex);
> > +
> >      pci_bus_add_device(virtfn);
> > =20
> > +    mutex_unlock(&add_device_mutex);
> > +
> >      return 0;
> > =20
> >  failed1:
> > ---

I write a new patch can fix the problem above. I add a new function pci_add=
_new_bus_locked which will do find bus and add new bus with mutex locked. a=
t most case in virtfn_add_bus, vf will find exiting bus and return, this is=
 a fast path and no need mutex protect; if bus is not exiting, and differen=
t vf in a race will add the same bus, they should call pci_add_new_bus_lock=
ed, this is the slower patch but safe;=20

I alse add a device_lock in pci_proc_attach_device when create bus->procdir=
, this will fix the conflict when different VFs may create '/proc/bus/pci/b=
us_number' directory using the same bus number concurrently

---
 drivers/pci/iov.c   |  7 ++++++-
 drivers/pci/probe.c | 26 ++++++++++++++++++++++++++
 drivers/pci/proc.c  |  6 +++++-
 include/linux/pci.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..cde0155749c5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -127,11 +127,16 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus =
*bus, int busnr)
 	if (bus->number =3D=3D busnr)
 		return bus;
=20
+	/*
+	 * here vf will find existing bus at most case; if not existing, it shoul=
d
+	 * go through slow path to create new bus with locked to support enable S=
RIOV
+	 * concurrently with many different PFs in userspace.
+	 */
 	child =3D pci_find_bus(pci_domain_nr(bus), busnr);
 	if (child)
 		return child;
=20
-	child =3D pci_add_new_bus(bus, NULL, busnr);
+	child =3D pci_add_new_bus_locked(bus, NULL, busnr);
 	if (!child)
 		return NULL;
=20
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5286b027f00..5dc2a6774fa9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -25,6 +25,8 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
=20
+DEFINE_MUTEX(add_bus_mutex);
+
 static struct resource busn_resource =3D {
 	.name	=3D "PCI busn",
 	.start	=3D 0,
@@ -1170,6 +1172,30 @@ struct pci_bus *pci_add_new_bus(struct pci_bus *pare=
nt, struct pci_dev *dev,
 }
 EXPORT_SYMBOL(pci_add_new_bus);
=20
+struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_=
dev *dev,
+                                int busnr)
+{
+        struct pci_bus *child;
+
+        mutex_lock(&add_bus_mutex);
+        child =3D pci_find_bus(pci_domain_nr(parent), busnr);
+        if (child) {
+                mutex_unlock(&add_bus_mutex);
+                return child;
+        }
+
+        child =3D pci_alloc_child_bus(parent, dev, busnr);
+        if (child) {
+                down_write(&pci_bus_sem);
+                list_add_tail(&child->node, &parent->children);
+                up_write(&pci_bus_sem);
+        }
+        mutex_unlock(&add_bus_mutex);
+
+        return child;
+}
+EXPORT_SYMBOL(pci_add_new_bus_locked);
+
 static void pci_enable_crs(struct pci_dev *pdev)
 {
 	u16 root_cap =3D 0;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f967709082d6..f927263c2fe0 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -421,6 +421,7 @@ int pci_proc_attach_device(struct pci_dev *dev)
 	if (!proc_initialized)
 		return -EACCES;
=20
+	device_lock(&bus->dev);
 	if (!bus->procdir) {
 		if (pci_proc_domain(bus)) {
 			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
@@ -429,9 +430,12 @@ int pci_proc_attach_device(struct pci_dev *dev)
 			sprintf(name, "%02x", bus->number);
 		}
 		bus->procdir =3D proc_mkdir(name, proc_bus_pci_dir);
-		if (!bus->procdir)
+		if (!bus->procdir) {
+			device_unlock(&bus->dev);
 			return -ENOMEM;
+		}
 	}
+	device_unlock(&bus->dev);
=20
 	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	e =3D proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..ec5b68b4c63d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1112,6 +1112,8 @@ struct pci_bus *pci_scan_root_bus(struct device *pare=
nt, int bus,
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *de=
v,
 				int busnr);
+struct pci_bus *pci_add_new_bus_locked(struct pci_bus *parent, struct pci_=
dev *dev,
++                                int busnr);
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
--

--_002_0acb9dc40dc44e26ac4d65cce41a15dehuaweicom_
Content-Type: text/plain; name="enable_sriov_demo.c"
Content-Description: enable_sriov_demo.c
Content-Disposition: attachment; filename="enable_sriov_demo.c"; size=4386;
	creation-date="Sun, 21 Aug 2022 11:35:36 GMT";
	modification-date="Sun, 21 Aug 2022 11:35:36 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzeXMv
c3RhdC5oPgoKI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KCiNkZWZpbmUg
TUFYX1BBVEhfU0laRSAgMTAyNAojZGVmaW5lIE1BWF9QRl9OVU0gICAgIDIwCiNkZWZpbmUgVkZf
UEFUSCAgIDY0CiNkZWZpbmUgVkZfTEVOICAgIDEwCiNkZWZpbmUgREVWSUNFX0RJUiAgICAgIi9z
eXMvYnVzL3BjaS9kZXZpY2VzIgojZGVmaW5lIFNUUkVRKGEsIGIpIChzdHJjbXAoYSwgYikgPT0g
MCkKCnR5cGVkZWYgc3RydWN0IFNyaW92RW5hYmxlVGhyZWFkIHsKICAgIHB0aHJlYWRfdCB0aHJl
YWQ7CiAgICBjaGFyIGJkZltWRl9QQVRIXTsKICAgIGNoYXIgdG90YWxWZnNbVkZfTEVOXTsKfSBT
cmlvdkVuYWJsZVRocmVhZDsKCnN0YXRpYyBpbnQgRmlsZVdyaXRlU3RyaW5nKGNvbnN0IGNoYXIg
KnBhdGgsIGNvbnN0IGNoYXIgKnN0cikKewogICAgaW50IGZkID0gb3BlbihwYXRoLCBPX1dST05M
WSB8IE9fVFJVTkMpOwogICAgaWYgKGZkID09IC0xKSB7CiAgICAgICAgcmV0dXJuIC0xOwogICAg
fQoKICAgIGlmICh3cml0ZShmZCwgc3RyLCBzdHJsZW4oc3RyKSkgPCAwKSB7CiAgICAgICAgY2xv
c2UoZmQpOwogICAgICAgIHJldHVybiAtMTsKICAgIH0KCiAgICBpZiAoY2xvc2UoZmQpICE9IDAp
IHsKICAgICAgICByZXR1cm4gLTE7CiAgICB9CgogICAgcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbnQg
RmlsZVJlYWRTdHJpbmcoY29uc3QgY2hhciAqZmlsZSwgY2hhciAqYnVmLCBpbnQgbGVuKQp7CiAg
ICBpbnQgZmQ7CiAgICBzc2l6ZV90IHN6OwoKICAgIGZkID0gb3BlbihmaWxlLCBPX1JET05MWSk7
CiAgICBpZiAoZmQgPCAwKSB7CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQoKICAgIHN6ID0gcmVh
ZChmZCwgYnVmLCBsZW4pOwogICAgY2xvc2UoZmQpOwogICAgaWYgKHN6IDwgMCkgewogICAgICAg
IHJldHVybiAtMTsKICAgIH0KCiAgICBpZiAoc3ogPT0gbGVuKSB7CiAgICAgICAgcHJpbnRmKCJT
dHJpbmcgbGVuICclZCcgaXMgdG9vIHNob3J0IHRvIHNhdmUgJXNcbiIsIGxlbiwgZmlsZSk7CiAg
ICAgICAgYnVmW2xlbiAtIDFdID0gJ1wwJzsKICAgICAgICByZXR1cm4gLTE7CiAgICB9CgogICAg
YnVmW3N6XSA9ICdcMCc7CiAgICByZXR1cm4gc3o7Cn0KCnN0YXRpYyB2b2lkICpEZXZpY2VTcmlv
dkVuYWJsZSh2b2lkICphcmcpCnsKICAgIGNoYXIgbnVtVmZzUGF0aFtWRl9QQVRIXSA9IHsgMCB9
OwogICAgU3Jpb3ZFbmFibGVUaHJlYWQgKnNyaW92VGhyZWFkID0gKFNyaW92RW5hYmxlVGhyZWFk
ICopYXJnOwogICAgY29uc3QgY2hhciAqYmRmID0gc3Jpb3ZUaHJlYWQtPmJkZjsKICAgIGNvbnN0
IGNoYXIgKnRvdGFsVmZzID0gc3Jpb3ZUaHJlYWQtPnRvdGFsVmZzOwoKICAgIHByaW50ZigiZWNo
byAlcyA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLyVzL3NyaW92X251bXZmc1xuIiwgdG90YWxWZnMs
IGJkZik7CgogICAgaWYgKHNucHJpbnRmKG51bVZmc1BhdGgsIHNpemVvZihudW1WZnNQYXRoKSAt
IDEsCiAgICAgICAgICAgICAgICAgICAiJXMvJXMvc3Jpb3ZfbnVtdmZzIiwgREVWSUNFX0RJUiwg
YmRmKSA8IDApIHsKICAgICAgICBwcmludGYoIkdldCBkZXZpY2Ugc3Jpb3ZfbnVtdmZzIGZhaWxc
biIpOwogICAgICAgIHB0aHJlYWRfZXhpdChOVUxMKTsKICAgIH0KCiAgICBpZiAoRmlsZVdyaXRl
U3RyaW5nKG51bVZmc1BhdGgsIHRvdGFsVmZzKSkgewogICAgICAgIHByaW50ZigiZW5hYmxlICcl
cycgc3Jpb3YgZmFpbFxuIiwgYmRmKTsKICAgICAgICBwdGhyZWFkX2V4aXQoTlVMTCk7CiAgICB9
CiAgICBwdGhyZWFkX2V4aXQoTlVMTCk7Cn0KCnN0YXRpYyBpbnQgRGV2aWNlQ2hlY2tTcmlvdkVu
YWJsZShjb25zdCBjaGFyICpiZGYpCnsKICAgIGNoYXIgcGF0aFtWRl9QQVRIXSA9IHsgMCB9Owog
ICAgaW50IHJldDsKCiAgICByZXQgPSBzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCkgLSAxLAog
ICAgICAgICAgICAgICAgICAgICAiJXMvJXMvc3Jpb3ZfdG90YWx2ZnMiLCBERVZJQ0VfRElSLCBi
ZGYpOwogICAgaWYgKHJldCA8IDApIHsKICAgICAgICByZXR1cm4gcmV0OwogICAgfQoKICAgIGlm
IChhY2Nlc3MocGF0aCwgUl9PSykgIT0gMCkgewogICAgICAgIHJldHVybiAwOwogICAgfQoKICAg
IHJldHVybiAxOwp9CgpzdGF0aWMgaW50IERldmljZVJlYWRWYWx1ZShjb25zdCBjaGFyICpiZGYs
IGNvbnN0IGNoYXIgKnBhdHRlcm4sIGNoYXIgKmJ1ZmZlciwgc2l6ZV90IGxlbikKewogICAgY2hh
ciBwYXRoW1ZGX1BBVEhdID0gezB9OwogICAgaW50IHJldDsKCiAgICByZXQgPSBzbnByaW50Zihw
YXRoLCBzaXplb2YocGF0aCkgLSAxLCAiJXMvJXMvJXMiLCBERVZJQ0VfRElSLAogICAgICAgICAg
ICAgICAgICAgICBiZGYsIHBhdHRlcm4pOwogICAgaWYgKHJldCA8IDApIHsKICAgICAgICBwcmlu
dGYoIlNldCBkZXZpY2VQYXRoIGZhaWxcbiIpOwogICAgICAgIHJldHVybiByZXQ7CiAgICB9Cgog
ICAgaWYgKEZpbGVSZWFkU3RyaW5nKHBhdGgsIGJ1ZmZlciwgbGVuKSA8IDApIHsKICAgICAgICBw
cmludGYoIlJlYWQgZGF0YSBmcm9tIGRldmljZVBhdGggJXMgZmFpbFxuIiwgcGF0aCk7CiAgICAg
ICAgcmV0dXJuIC0xOwogICAgfQoKICAgIHJldHVybiAwOwp9Cgp2b2lkIG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQp7CiAgICBpbnQgcmV0OwogICAgRElSKiBkaXJwOwogICAgaW50IGkgPSAw
OwogICAgc3RydWN0IGRpcmVudCAqZHAgPSBOVUxMOwogICAgY2hhciBidWZmZXJbVkZfTEVOXSA9
IHsgMCB9OwogICAgaW50IHNyaW92VGhyZWFkTGVuID0gc2l6ZW9mKFNyaW92RW5hYmxlVGhyZWFk
KSAqIE1BWF9QRl9OVU07CgogICAgZGlycCA9IG9wZW5kaXIoREVWSUNFX0RJUik7CiAgICBpZiAo
IWRpcnApIHsKICAgICAgICBwcmludGYoIkNhbiBub3QgZmluZCAlc1xuIiwgREVWSUNFX0RJUik7
CiAgICAgICAgcmV0dXJuOwogICAgfQoKICAgIFNyaW92RW5hYmxlVGhyZWFkICpzcmlvdlRocmVh
ZCA9IChTcmlvdkVuYWJsZVRocmVhZCAqKW1hbGxvYyhzcmlvdlRocmVhZExlbik7CiAgICBpZiAo
IXNyaW92VGhyZWFkKSB7CiAgICAgICAgcHJpbnRmKCJDYW4gbm90IGFsbG9jIHNyaW92VGhyZWFk
XG4iKTsKICAgICAgICBjbG9zZWRpcihkaXJwKTsKICAgICAgICByZXR1cm47CiAgICB9CiAgICBt
ZW1zZXQoc3Jpb3ZUaHJlYWQsIDAsIHNyaW92VGhyZWFkTGVuKTsKCiAgICB3aGlsZSAoKGRwID0g
cmVhZGRpcihkaXJwKSkgIT0gTlVMTCkgewogICAgICAgIGlmIChTVFJFUShkcC0+ZF9uYW1lLCAi
LiIpIHx8IFNUUkVRKGRwLT5kX25hbWUsICIuLiIpKSB7CiAgICAgICAgICAgIGNvbnRpbnVlOwog
ICAgICAgIH0KCiAgICAgICAgaWYgKERldmljZUNoZWNrU3Jpb3ZFbmFibGUoZHAtPmRfbmFtZSkg
PD0gMCkgewogICAgICAgICAgICBjb250aW51ZTsKICAgICAgICB9CgogICAgICAgIGlmIChEZXZp
Y2VSZWFkVmFsdWUoZHAtPmRfbmFtZSwgInNyaW92X3RvdGFsdmZzIiwgYnVmZmVyLCBzaXplb2Yo
YnVmZmVyKSkgPCAwKSB7CiAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAgIH0KCiAgICAgICAg
aWYgKGkgPj0gTUFYX1BGX05VTSkgewogICAgICAgICAgICBwcmludGYoInBmIG51bSBpcyBleGNl
ZWQgbWF4ICVkXG4iLCBNQVhfUEZfTlVNKTsKICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgfQoK
ICAgICAgICBzdHJjcHkoc3Jpb3ZUaHJlYWRbaV0uYmRmLCBkcC0+ZF9uYW1lKTsKICAgICAgICBz
dHJjcHkoc3Jpb3ZUaHJlYWRbaV0udG90YWxWZnMsIGJ1ZmZlcik7CiAgICAgICAgcmV0ID0gcHRo
cmVhZF9jcmVhdGUoJnNyaW92VGhyZWFkW2ldLnRocmVhZCwgTlVMTCwgRGV2aWNlU3Jpb3ZFbmFi
bGUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKikmc3Jpb3ZUaHJlYWRbaV0p
OwogICAgICAgIGlmIChyZXQpIHsKICAgICAgICAgICAgcHJpbnRmKCJjcmVhdGUgc3Jpb3YgdGhy
ZWFkICVkIGZvciAlcyBmYWlsZWQsIHJldCA6ICVkXG4iLCBpLCBzcmlvdlRocmVhZFtpXS5iZGYs
IHJldCk7CiAgICAgICAgICAgIGJyZWFrOwogICAgICAgIH0KICAgICAgICBpKys7CiAgICB9Cgog
ICAgY2xvc2VkaXIoZGlycCk7CiAgICAvKiB3YWl0IHVudGlsIGFsbCBzcmlvdiBlbmFibGUgdGhy
ZWFkIGZpbmlzaCAqLwogICAgZm9yIChpbnQgaiA9IDA7IGogPCBpOyBqKyspIHsKICAgICAgICBw
dGhyZWFkX2pvaW4oc3Jpb3ZUaHJlYWRbal0udGhyZWFkLCBOVUxMKTsKICAgIH0KCiAgICBwcmlu
dGYoInNyaW92IGVuYWJsZSBmaW5pc2hcbiIpOwogICAgZnJlZShzcmlvdlRocmVhZCk7Cn0K

--_002_0acb9dc40dc44e26ac4d65cce41a15dehuaweicom_--

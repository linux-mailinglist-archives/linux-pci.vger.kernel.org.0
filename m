Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21C41D0D2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbhI3BHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:24479 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347083AbhI3BHM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330102"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330102"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027362"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:28 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/6] driver core: Move the "authorized" attribute from USB/Thunderbolt to core
Date:   Wed, 29 Sep 2021 18:05:06 -0700
Message-Id: <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently bus drivers like "USB" or "Thunderbolt" implement a custom
version of device authorization to selectively authorize the driver
probes. Since there is a common requirement, move the "authorized"
attribute support to the driver core in order to allow it to be used
by other subsystems / buses.

Similar requirements have been discussed in the PCI [1] community for
PCI bus drivers as well.

No functional changes are intended. It just converts authorized
attribute from int to bool and moves it to the driver core. There
should be no user-visible change in the location or semantics of
attributes for USB devices.

Regarding thunderbolt driver, although it declares sw->authorized as
"int" and allows 0,1,2 as valid values for sw->authorized attribute,
but within the driver, in all authorized attribute related checks,
it is treated as bool value. So when converting the authorized
attribute from int to bool value, there should be no functional
changes other than value 2 being not visible to the user.

[1]: https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/thunderbolt/domain.c |  6 +++---
 drivers/thunderbolt/icm.c    |  9 +++++----
 drivers/thunderbolt/switch.c | 18 ++++++++----------
 drivers/thunderbolt/tb.c     |  2 +-
 drivers/thunderbolt/tb.h     |  2 --
 drivers/usb/core/driver.c    |  2 +-
 drivers/usb/core/generic.c   |  2 +-
 drivers/usb/core/hub.c       |  8 ++++----
 drivers/usb/core/message.c   |  2 +-
 drivers/usb/core/sysfs.c     |  3 +--
 drivers/usb/core/usb.c       | 10 +++++++++-
 include/linux/device.h       |  3 ++-
 include/linux/usb.h          |  6 ------
 13 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 7018d959f775..3e39686eff14 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -656,7 +656,7 @@ int tb_domain_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 	/* The parent switch must be authorized before this one */
 	parent_sw = tb_to_switch(sw->dev.parent);
-	if (!parent_sw || !parent_sw->authorized)
+	if (!parent_sw || !parent_sw->dev.authorized)
 		return -EINVAL;
 
 	return tb->cm_ops->approve_switch(tb, sw);
@@ -683,7 +683,7 @@ int tb_domain_approve_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	/* The parent switch must be authorized before this one */
 	parent_sw = tb_to_switch(sw->dev.parent);
-	if (!parent_sw || !parent_sw->authorized)
+	if (!parent_sw || !parent_sw->dev.authorized)
 		return -EINVAL;
 
 	ret = tb->cm_ops->add_switch_key(tb, sw);
@@ -720,7 +720,7 @@ int tb_domain_challenge_switch_key(struct tb *tb, struct tb_switch *sw)
 
 	/* The parent switch must be authorized before this one */
 	parent_sw = tb_to_switch(sw->dev.parent);
-	if (!parent_sw || !parent_sw->authorized)
+	if (!parent_sw || !parent_sw->dev.authorized)
 		return -EINVAL;
 
 	get_random_bytes(challenge, sizeof(challenge));
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6255f1ef9599..f5b784c1cabb 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -768,7 +768,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		 * sure our book keeping matches that.
 		 */
 		if (sw->depth == depth && sw_phy_port == phy_port &&
-		    !!sw->authorized == authorized) {
+		    sw->dev.authorized == authorized) {
 			/*
 			 * It was enumerated through another link so update
 			 * route string accordingly.
@@ -849,7 +849,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		sw->connection_key = pkg->connection_key;
 		sw->link = link;
 		sw->depth = depth;
-		sw->authorized = authorized;
+		sw->dev.authorized = authorized;
 		sw->security_level = security_level;
 		sw->boot = boot;
 		sw->link_speed = speed_gen3 ? 20 : 10;
@@ -1235,7 +1235,8 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 	sw = tb_switch_find_by_uuid(tb, &pkg->ep_uuid);
 	if (sw) {
 		/* Update the switch if it is still in the same place */
-		if (tb_route(sw) == route && !!sw->authorized == authorized) {
+		if (tb_route(sw) == route &&
+		    sw->dev.authorized == authorized) {
 			parent_sw = tb_to_switch(sw->dev.parent);
 			update_switch(parent_sw, sw, route, pkg->connection_id,
 				      0, 0, 0, boot);
@@ -1272,7 +1273,7 @@ __icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr,
 	sw = alloc_switch(parent_sw, route, &pkg->ep_uuid);
 	if (!IS_ERR(sw)) {
 		sw->connection_id = pkg->connection_id;
-		sw->authorized = authorized;
+		sw->dev.authorized = authorized;
 		sw->security_level = security_level;
 		sw->boot = boot;
 		sw->link_speed = speed_gen3 ? 20 : 10;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 3014146081c1..e640d764499a 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1494,9 +1494,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct tb_switch *sw = tb_to_switch(dev);
-
-	return sprintf(buf, "%u\n", sw->authorized);
+	return sprintf(buf, "%u\n", dev->authorized);
 }
 
 static int disapprove_switch(struct device *dev, void *not_used)
@@ -1505,7 +1503,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
 	struct tb_switch *sw;
 
 	sw = tb_to_switch(dev);
-	if (sw && sw->authorized) {
+	if (sw && sw->dev.authorized) {
 		int ret;
 
 		/* First children */
@@ -1517,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
 		if (ret)
 			return ret;
 
-		sw->authorized = 0;
+		dev->authorized = false;
 		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
 	}
 
@@ -1533,7 +1531,7 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	if (!mutex_trylock(&sw->tb->lock))
 		return restart_syscall();
 
-	if (!!sw->authorized == !!val)
+	if (sw->dev.authorized == !!val)
 		goto unlock;
 
 	switch (val) {
@@ -1564,12 +1562,12 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	}
 
 	if (!ret) {
-		sw->authorized = val;
+		sw->dev.authorized = !!val;
 		/*
 		 * Notify status change to the userspace, informing the new
 		 * value of /sys/bus/thunderbolt/devices/.../authorized.
 		 */
-		sprintf(envp_string, "AUTHORIZED=%u", sw->authorized);
+		sprintf(envp_string, "AUTHORIZED=%u", sw->dev.authorized);
 		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
 	}
 
@@ -1671,7 +1669,7 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
 	if (!mutex_trylock(&sw->tb->lock))
 		return restart_syscall();
 
-	if (sw->authorized) {
+	if (sw->dev.authorized) {
 		ret = -EBUSY;
 	} else {
 		kfree(sw->key);
@@ -2192,7 +2190,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 
 	/* Root switch is always authorized */
 	if (!route)
-		sw->authorized = true;
+		sw->dev.authorized = true;
 
 	device_initialize(&sw->dev);
 	sw->dev.parent = parent;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 2897a77d44c3..44d2fa893fa9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1323,7 +1323,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
 		 * send uevent to userspace.
 		 */
 		if (sw->boot)
-			sw->authorized = 1;
+			sw->dev.authorized = true;
 
 		dev_set_uevent_suppress(dev, false);
 		kobject_uevent(&dev->kobj, KOBJ_ADD);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 725104c83e3d..cfe869d8e826 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -130,7 +130,6 @@ struct tb_switch_tmu {
  * @safe_mode: The switch is in safe-mode
  * @boot: Whether the switch was already authorized on boot or not
  * @rpm: The switch supports runtime PM
- * @authorized: Whether the switch is authorized by user or policy
  * @security_level: Switch supported security level
  * @debugfs_dir: Pointer to the debugfs structure
  * @key: Contains the key used to challenge the device or %NULL if not
@@ -180,7 +179,6 @@ struct tb_switch {
 	bool safe_mode;
 	bool boot;
 	bool rpm;
-	unsigned int authorized;
 	enum tb_security_level security_level;
 	struct dentry *debugfs_dir;
 	u8 *key;
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 072968c40ade..fb476665f52d 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -331,7 +331,7 @@ static int usb_probe_interface(struct device *dev)
 	if (usb_device_is_owned(udev))
 		return error;
 
-	if (udev->authorized == 0) {
+	if (udev->dev.authorized == false) {
 		dev_err(&intf->dev, "Device is not authorized for usage\n");
 		return error;
 	} else if (intf->authorized == 0) {
diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 26f9fb9f67ca..7fa4ca77fa89 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -230,7 +230,7 @@ int usb_generic_driver_probe(struct usb_device *udev)
 	/* Choose and set the configuration.  This registers the interfaces
 	 * with the driver core and lets interface drivers bind to them.
 	 */
-	if (udev->authorized == 0)
+	if (udev->dev.authorized == false)
 		dev_err(&udev->dev, "Device is not authorized for usage\n");
 	else {
 		c = usb_choose_configuration(udev);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 86658a81d284..f58b19aa4f5f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2616,10 +2616,10 @@ int usb_new_device(struct usb_device *udev)
 int usb_deauthorize_device(struct usb_device *usb_dev)
 {
 	usb_lock_device(usb_dev);
-	if (usb_dev->authorized == 0)
+	if (usb_dev->dev.authorized == false)
 		goto out_unauthorized;
 
-	usb_dev->authorized = 0;
+	usb_dev->dev.authorized = false;
 	usb_set_configuration(usb_dev, -1);
 
 out_unauthorized:
@@ -2633,7 +2633,7 @@ int usb_authorize_device(struct usb_device *usb_dev)
 	int result = 0, c;
 
 	usb_lock_device(usb_dev);
-	if (usb_dev->authorized == 1)
+	if (usb_dev->dev.authorized == true)
 		goto out_authorized;
 
 	result = usb_autoresume_device(usb_dev);
@@ -2652,7 +2652,7 @@ int usb_authorize_device(struct usb_device *usb_dev)
 		}
 	}
 
-	usb_dev->authorized = 1;
+	usb_dev->dev.authorized = true;
 	/* Choose and set the configuration.  This registers the interfaces
 	 * with the driver core and lets interface drivers bind to them.
 	 */
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 4d59d927ae3e..47548ce1cfb1 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1962,7 +1962,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	struct usb_hcd *hcd = bus_to_hcd(dev->bus);
 	int n, nintf;
 
-	if (dev->authorized == 0 || configuration == -1)
+	if (dev->dev.authorized == false || configuration == -1)
 		configuration = 0;
 	else {
 		for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index fa2e49d432ff..3d63e345d0a0 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -726,8 +726,7 @@ usb_descriptor_attr(bMaxPacketSize0, "%d\n");
 static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct usb_device *usb_dev = to_usb_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
+	return snprintf(buf, PAGE_SIZE, "%u\n", dev->authorized);
 }
 
 /*
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62368c4ed37a..18f3ad39ccbc 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -579,6 +579,14 @@ static unsigned usb_bus_is_wusb(struct usb_bus *bus)
 	return hcd->wireless;
 }
 
+/*
+ * usb_dev_authorized() - Used to initialize the "authorized" status of
+ *                        the USB device.
+ * (user space) policy determines if we authorize this device to be
+ * used or not. By default, wired USB devices are authorized.
+ * WUSB devices are not, until we authorize them from user space.
+ * FIXME -- complete doc
+ */
 static bool usb_dev_authorized(struct usb_device *dev, struct usb_hcd *hcd)
 {
 	struct usb_hub *hub;
@@ -717,7 +725,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->active_duration = -jiffies;
 #endif
 
-	dev->authorized = usb_dev_authorized(dev, usb_hcd);
+	dev->dev.authorized = usb_dev_authorized(dev, usb_hcd);
 	if (!root_hub)
 		dev->wusb = usb_bus_is_wusb(bus) ? 1 : 0;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..899be9a2c0cb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -443,7 +443,7 @@ struct dev_links_info {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
- *
+ * @authorized:  Whether the device is authorized to bind to a driver.
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
@@ -562,6 +562,7 @@ struct device {
 
 	enum device_removable	removable;
 
+	bool			authorized:1;
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7ccaa76a9a96..796df4068e94 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -576,11 +576,6 @@ struct usb3_lpm_parameters {
  * @can_submit: URBs may be submitted
  * @persist_enabled:  USB_PERSIST enabled for this device
  * @have_langid: whether string_langid is valid
- * @authorized: policy has said we can use it;
- *	(user space) policy determines if we authorize this device to be
- *	used or not. By default, wired USB devices are authorized.
- *	WUSB devices are not, until we authorize them from user space.
- *	FIXME -- complete doc
  * @authenticated: Crypto authentication passed
  * @wusb: device is Wireless USB
  * @lpm_capable: device supports LPM
@@ -662,7 +657,6 @@ struct usb_device {
 	unsigned can_submit:1;
 	unsigned persist_enabled:1;
 	unsigned have_langid:1;
-	unsigned authorized:1;
 	unsigned authenticated:1;
 	unsigned wusb:1;
 	unsigned lpm_capable:1;
-- 
2.25.1


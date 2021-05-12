Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7437EEF8
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhELWja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347189AbhELVqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 17:46:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C0C06134C
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:35:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l8-20020a25b3080000b02904f8bd69022dso15886584ybj.9
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0M0wbVUu/mWC2gkH7zrIl7FErtbkZ0kL0d1N2HHWY3U=;
        b=HqQKorO3bjeywrRlcMXKLmXqXW8rmCW0Y4rZ13S0J6AF9VPjDEMGsoOJj47lTuYaWP
         GeG5unwltILpZSgEVGvDR0/INVzpCTrOc2j1ykn/hY9+0nIWoAXRdprqreUoNrAVt4GB
         3q+QBdhGq7c6nCmlEO9JwdqTH42m3wxqOo6G6vrtPojxG4NWIdQqabjsvKwVApeNPYQk
         Z9NnN4pghwxy7eZod20jLbDrOukN/rXc95zvPFp2xXNGb1rMsBql8f26ggc3/TKT68sB
         DUCDzslJ27TxK33Wv000OOXX90+hrLQhrrAZ2TKFSaSO6Cgn+Wx2B9PCvBAa96NEn3pg
         14tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0M0wbVUu/mWC2gkH7zrIl7FErtbkZ0kL0d1N2HHWY3U=;
        b=aeZAmdIwxIG+XtBVtSE59QzhDp+biSTe+6eaz2O40bfM17EYfXrPqBmIgWyV3vhOtV
         WE/ssXxa5DhS1wzZCJamlK5d8LOllAWmhQ23b3w+sEvX3qy8mwTQG4BJxSLeKiF9gyus
         K7Yb5hdbleOPoFfVC1cR2GjWFlzCcqgOnSvyiToIX+VDFLFM30Z2IExt6RpxpKrh2RDf
         hmOMPtfGCboCYS7iAle4eZfjGPGp2dPyNzA9ZLWxzEwb4DQbWDSwecyJlNQ0foyrREUK
         9IFJ8DlyKne9dVUcl3oHAxyIIZuk0wOvizOlCzdTgLTA9MXTFYuhehQnVuHYKrCcd9V1
         cHCw==
X-Gm-Message-State: AOAM532MGqH8+V+q0pYxolCA5+/6YLuxjveZlYg662ylVS0X1BcOajM7
        grz5vDRc+En+491uZrahThP7+YR4QnbG
X-Google-Smtp-Source: ABdhPJyy9Vqvar/Zui5V+18Ebaa9FXw19m3u5rZgx8hDZIZjuVEaYlmvXZPErZPQhIsJTqJRHyK0/beFAzb9
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:45af:4b75:ef28:4f6d])
 (user=rajatja job=sendgmr) by 2002:a25:5d0b:: with SMTP id
 r11mr51123258ybb.380.1620855301810; Wed, 12 May 2021 14:35:01 -0700 (PDT)
Date:   Wed, 12 May 2021 14:34:56 -0700
Message-Id: <20210512213457.1310774-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 1/2] driver core: Move the "removable" attribute from USB
 to core
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the "removable" attribute from USB to core in order to allow it to be
supported by other subsystem / buses. Individual buses that want to support
this attribute can opt-in by setting the supports_removable flag, and then
populating the removable property of the device while enumerating it. The
UAPI (location, symantics etc) for the attribute remains unchanged.

Signed-off-by: Rajat Jain <rajatja@google.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: - Minor commit log / comments updated.
    - use sysfs_emit()
    - Rename local variable name (state -> loc)
    - change supports_removable flag from bool to bitfield.
v2: Add documentation

 Documentation/ABI/testing/sysfs-bus-usb       | 11 -------
 .../ABI/testing/sysfs-devices-removable       | 17 ++++++++++
 drivers/base/core.c                           | 28 ++++++++++++++++
 drivers/usb/core/hub.c                        |  8 ++---
 drivers/usb/core/sysfs.c                      | 24 --------------
 drivers/usb/core/usb.c                        |  1 +
 include/linux/device.h                        | 32 +++++++++++++++++++
 include/linux/usb.h                           |  7 ----
 8 files changed, 82 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-removable

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index bf2c1968525f..73eb23bc1f34 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -154,17 +154,6 @@ Description:
 		files hold a string value (enable or disable) indicating whether
 		or not USB3 hardware LPM U1 or U2 is enabled for the device.
 
-What:		/sys/bus/usb/devices/.../removable
-Date:		February 2012
-Contact:	Matthew Garrett <mjg@redhat.com>
-Description:
-		Some information about whether a given USB device is
-		physically fixed to the platform can be inferred from a
-		combination of hub descriptor bits and platform-specific data
-		such as ACPI. This file will read either "removable" or
-		"fixed" if the information is available, and "unknown"
-		otherwise.
-
 What:		/sys/bus/usb/devices/.../ltm_capable
 Date:		July 2012
 Contact:	Sarah Sharp <sarah.a.sharp@linux.intel.com>
diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
new file mode 100644
index 000000000000..9dabcad7cdcd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../removable
+Date:		Apr 2021
+Contact:	Matthew Garrett <mjg@redhat.com>,
+		Rajat Jain <rajatja@google.com>
+Description:
+		Information about whether a given device is physically fixed to
+		the platform. This is determined by the device's subsystem in a
+		bus / platform-specific way. This attribute is only present for
+		buses that can support determining such information:
+
+		"removable": The device is external / removable from the system.
+		"fixed":     The device is internal / fixed to the system.
+		"unknown":   The information is unavailable.
+
+		Currently this is only supported by USB (which infers the
+		information from a combination of hub descriptor bits and
+		platform-specific data such as ACPI).
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4a8bf8cda52b..9e6bf9e71a7e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2404,6 +2404,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	const char *loc;
+
+	switch (dev->removable) {
+	case DEVICE_REMOVABLE:
+		loc = "removable";
+		break;
+	case DEVICE_FIXED:
+		loc = "fixed";
+		break;
+	default:
+		loc = "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", loc);
+}
+static DEVICE_ATTR_RO(removable);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2581,8 +2600,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_online;
 	}
 
+	if (type && type->supports_removable) {
+		error = device_create_file(dev, &dev_attr_removable);
+		if (error)
+			goto err_remove_dev_waiting_for_supplier;
+	}
+
 	return 0;
 
+ err_remove_dev_waiting_for_supplier:
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
 	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
@@ -2602,6 +2629,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b2bc4b7c4289..7a3c28b14ca1 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2443,11 +2443,11 @@ static void set_usb_port_removable(struct usb_device *udev)
 	 */
 	switch (hub->ports[udev->portnum - 1]->connect_type) {
 	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 		return;
 	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
 	case USB_PORT_NOT_USED:
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 		return;
 	default:
 		break;
@@ -2472,9 +2472,9 @@ static void set_usb_port_removable(struct usb_device *udev)
 	}
 
 	if (removable)
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 	else
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 
 }
 
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 5a168ba9fc51..fa2e49d432ff 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -301,29 +301,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(urbnum);
 
-static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct usb_device *udev;
-	char *state;
-
-	udev = to_usb_device(dev);
-
-	switch (udev->removable) {
-	case USB_DEVICE_REMOVABLE:
-		state = "removable";
-		break;
-	case USB_DEVICE_FIXED:
-		state = "fixed";
-		break;
-	default:
-		state = "unknown";
-	}
-
-	return sprintf(buf, "%s\n", state);
-}
-static DEVICE_ATTR_RO(removable);
-
 static ssize_t ltm_capable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -828,7 +805,6 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_avoid_reset_quirk.attr,
 	&dev_attr_authorized.attr,
 	&dev_attr_remove.attr,
-	&dev_attr_removable.attr,
 	&dev_attr_ltm_capable.attr,
 #ifdef CONFIG_OF
 	&dev_attr_devspec.attr,
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 62368c4ed37a..ce18e84528cf 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -569,6 +569,7 @@ struct device_type usb_device_type = {
 #ifdef CONFIG_PM
 	.pm =		&usb_device_pm_ops,
 #endif
+	.supports_removable = true,
 };
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 38a2071cf776..7e87ab048307 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -93,6 +93,8 @@ struct device_type {
 	void (*release)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+
+	bool supports_removable:1; /* subsystem can classify removable/fixed */
 };
 
 /* interface for exporting device attributes */
@@ -350,6 +352,19 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable is determined by its subsystem or bus.
+ * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown (default).
+ * @DEVICE_REMOVABLE: Device is removable by the user.
+ * @DEVICE_FIXED: Device is not removable by the user.
+ */
+enum device_removable {
+	DEVICE_REMOVABLE_UNKNOWN = 0,
+	DEVICE_REMOVABLE,
+	DEVICE_FIXED,
+};
+
 /**
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
@@ -431,6 +446,9 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -544,6 +562,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_removable	removable;
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -782,6 +802,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline void dev_set_removable(struct device *dev,
+				     enum device_removable removable)
+{
+	dev->removable = removable;
+}
+
+static inline bool dev_is_removable(struct device *dev)
+{
+	return dev && dev->type && dev->type->supports_removable
+	    && dev->removable == DEVICE_REMOVABLE;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index eaae24217e8a..b9bd664f44a1 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -473,12 +473,6 @@ struct usb_dev_state;
 
 struct usb_tt;
 
-enum usb_device_removable {
-	USB_DEVICE_REMOVABLE_UNKNOWN = 0,
-	USB_DEVICE_REMOVABLE,
-	USB_DEVICE_FIXED,
-};
-
 enum usb_port_connect_type {
 	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
 	USB_PORT_CONNECT_TYPE_HOT_PLUG,
@@ -703,7 +697,6 @@ struct usb_device {
 #endif
 	struct wusb_dev *wusb_dev;
 	int slot_id;
-	enum usb_device_removable removable;
 	struct usb2_lpm_parameters l1_params;
 	struct usb3_lpm_parameters u1_params;
 	struct usb3_lpm_parameters u2_params;
-- 
2.31.1.607.g51e8a6a459-goog


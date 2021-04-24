Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A099A369DCF
	for <lists+linux-pci@lfdr.de>; Sat, 24 Apr 2021 02:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhDXAaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 20:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhDXA37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Apr 2021 20:29:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948FBC06174A
        for <linux-pci@vger.kernel.org>; Fri, 23 Apr 2021 17:29:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q62-20020a6275410000b029026407f235dbso8464082pfc.23
        for <linux-pci@vger.kernel.org>; Fri, 23 Apr 2021 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IN+7hpfuilZwjXuucv+7rDMA58hZ+Pmp36t/KLM1cMw=;
        b=g+1yWDroVwsnWvXxUagwJlOAeimwDRkQ63OncNnDLg+sFstxe5ZnEz7JvM5tMy2LrZ
         b+PFOldLW3B8xzdZ/fsFTl90Wr4s2T+VM1XPtdAgMCf/pzyJNfYWMewADYTWKrvC3bz5
         G+YrM8Lod0/La+MGwv7rRnCyLwG2nIKFIADcwfjEjMZESYkQGD/IQBgKkC7m0Ou9ICI6
         3jUwzlNMb+Eq/8d4Etq3xFrKo4YUKzgbEgl2GphuEloomYeZGOWpgoJk8YRLzKcHgbB5
         0Zvlnmh0VaOAg0fHBAT8pxTzPku11UBW85rGzlN4+OCF3wC4Kqc/mP17nP1EeYRwj6eK
         w12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IN+7hpfuilZwjXuucv+7rDMA58hZ+Pmp36t/KLM1cMw=;
        b=gNAxKatYMTI79ECVlx+OUJD230RwSZGPPtLvwtknyCbkfDfimyQ9ZRfe0Xg2r5+ALG
         26ZANT9xu5ji0MwjfznHey0qDxIBJy63HGRPuuWv3kZ5ugiS/92YNgVTW+Zamqxl48qF
         eRMjaLEZalf/ryHSTuYQlhwNQSIFLw5NEO00IcnCApW1f6uPl1NTGeKlo5EEgjUvtnLb
         AZlHEAWxg6CKuOKwj/Spbd3wgCES4YJhQE1kvOLHGIl9qdZcS2nI0EcEzh1OR1y5HiTS
         o/SPB6prh+wzdbC2SwAZyw1gNqTgHR20/VZ7pnU0/Fyp8isEsLF+btL5ECfRfHny5/cp
         UqcQ==
X-Gm-Message-State: AOAM532BCT2A8Vt+qj/qgEMyEz8sBc1WRvBmCn1XeeGe43Di6ec55OaF
        VIxb4Sn7tkq895AArw2aj7aIURCgtbzI
X-Google-Smtp-Source: ABdhPJycZqWca6XT3XcA+7vy+xZvUsOwCq9bzaaj1UwM2i0BjgltOYKaHQB1q4nJ3AUaFhQeuLfqwWiRdo1w
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5cef:2faf:44cf:b69b])
 (user=rajatja job=sendgmr) by 2002:aa7:93aa:0:b029:25e:31ca:756f with SMTP id
 x10-20020aa793aa0000b029025e31ca756fmr6527446pff.70.1619224162041; Fri, 23
 Apr 2021 17:29:22 -0700 (PDT)
Date:   Fri, 23 Apr 2021 17:29:17 -0700
Message-Id: <20210424002918.1962649-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 1/2] driver core: Move the "removable" attribute from USB to core
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        helgaas@kernel.org
Cc:     rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the "removable" attribute from USB to core in order to allow
it to be supported by other subsystem / buses. Individual buses
that want to support this attribute can opt-in by setting the
supports_removable flag, and then populating the removable property
of the device while enumerating it.

Signed-off-by: Rajat Jain <rajatja@google.com>
Change-Id: I55a0ee5e13d87cd0c5d9cfc98403caba1989b518
---
 drivers/base/core.c      | 28 ++++++++++++++++++++++++++++
 drivers/usb/core/hub.c   |  8 ++++----
 drivers/usb/core/sysfs.c | 24 ------------------------
 drivers/usb/core/usb.c   |  1 +
 include/linux/device.h   | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/usb.h      |  7 -------
 6 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f29839382f81..b8ae4cc52805 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2327,6 +2327,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	const char *state;
+
+	switch (dev->removable) {
+	case DEVICE_REMOVABLE:
+		state = "removable";
+		break;
+	case DEVICE_FIXED:
+		state = "fixed";
+		break;
+	default:
+		state = "unknown";
+	}
+	return sprintf(buf, "%s\n", state);
+}
+static DEVICE_ATTR_RO(removable);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2504,8 +2523,16 @@ static int device_add_attrs(struct device *dev)
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
@@ -2525,6 +2552,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7f71218cc1e5..500e5648de04 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2442,11 +2442,11 @@ static void set_usb_port_removable(struct usb_device *udev)
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
@@ -2471,9 +2471,9 @@ static void set_usb_port_removable(struct usb_device *udev)
 	}
 
 	if (removable)
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 	else
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 
 }
 
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d85699bee671..e8ff3afdf7af 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -298,29 +298,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
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
@@ -825,7 +802,6 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_avoid_reset_quirk.attr,
 	&dev_attr_authorized.attr,
 	&dev_attr_remove.attr,
-	&dev_attr_removable.attr,
 	&dev_attr_ltm_capable.attr,
 #ifdef CONFIG_OF
 	&dev_attr_devspec.attr,
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index a566bb494e24..5a0f73a28196 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -523,6 +523,7 @@ struct device_type usb_device_type = {
 #ifdef CONFIG_PM
 	.pm =		&usb_device_pm_ops,
 #endif
+	.supports_removable = true,
 };
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index ba660731bd25..d6442b811607 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -93,6 +93,12 @@ struct device_type {
 	void (*release)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+
+	/*
+	 * Determines whether the subsystem supports classifying the devices of
+	 * this type into removable vs fixed.
+	 */
+	bool supports_removable;
 };
 
 /* interface for exporting device attributes */
@@ -350,6 +356,19 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable, is determined by its subsystem or bus.
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
@@ -431,6 +450,9 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -541,6 +563,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_removable	removable;
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -778,6 +802,18 @@ static inline bool dev_has_sync_state(struct device *dev)
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
index d6a41841b93e..0bbb9e8b18c7 100644
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
@@ -701,7 +695,6 @@ struct usb_device {
 #endif
 	struct wusb_dev *wusb_dev;
 	int slot_id;
-	enum usb_device_removable removable;
 	struct usb2_lpm_parameters l1_params;
 	struct usb3_lpm_parameters u1_params;
 	struct usb3_lpm_parameters u2_params;
-- 
2.31.1.498.g6c1eba8ee3d-goog


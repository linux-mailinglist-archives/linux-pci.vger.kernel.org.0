Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19920ECDD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 06:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgF3EuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 00:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgF3Et6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 00:49:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5FC061755
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:58 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z26so13682208qto.15
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2020 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LmsPf5jTSure7oX6gJRaMQO8tovJK9Co8tSqz8HCgCs=;
        b=pUFDPhuB/v2g/yvpNhhyyJ30IsV514WJIVZPfX5DchICNB/3GB3lrCK6wRqtA9Kdv1
         KirdW6N6jhQU3OKtY9lACnobzV8sB8+2CkYIz1YnW+Loh1i2w3neTw5UWwOXfihNQ1ff
         nA+KP13GeFBnWQp2ys6B8/qyELYdICgAPBmgVsWtLeEcU29Kws4iqqXBD7tOtSkYZdyu
         urkBWk/wQDdyOy2xwdLQOSVBFa0eV3POZYDjntsphRtU0JA474jLJpe4ICxh6YiBV06Q
         SQKxby71IyV7+sKNgl0upW0Pkq2p65CVWwppw1WE7mzrU9PiekhEdfP7SJASalXvti76
         5afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LmsPf5jTSure7oX6gJRaMQO8tovJK9Co8tSqz8HCgCs=;
        b=tULniEN8B2o7TBRQpvpZz5QwhJrBFMUksi4uvobZBxdlIH4B2u93C2XFaX+d/D5WB/
         mLYZ703W2XqadLC8qEMDJrFGcfndBP7cTAuzCf2YR6lNhlGxBm9f7qDc45d6NqSl6KRM
         wyXEqhEv5EacQykivqgdlKOpu6n7N7seFbnXcxjtvMUD3D0diK2sjKMu5JlYAFQGUibJ
         Zwzpw9AIvXj+5C0iVMwjPneaztpoovBhfLnBPV0vZ4wur0FmKQ9maq6yoGSQrTUFAMXf
         HHcqpb2l7tKgfmy111/H4zklafjsXnYztd5wpDItmUULnJAhMMbodIKXks4EpJPmYIC4
         ykNA==
X-Gm-Message-State: AOAM531gjLEy4p5vok+Y37Jq41Wp+wD8Q7ab4o4w7o4OlYFfifOJCwFD
        ZTAJcF5L0HMLKDHBKH89eqBCyqWNEeAq
X-Google-Smtp-Source: ABdhPJy6mFvmXqDrITIrdGqh6QYCNW4V7diNoS4nldl3h9MgHWUBDraMbYOO32BHpWqaZ1XfnXNP7f0yffta
X-Received: by 2002:a0c:83c4:: with SMTP id k62mr4468584qva.19.1593492597294;
 Mon, 29 Jun 2020 21:49:57 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:41 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-6-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 5/7] driver core: Add device location to "struct device"
 and expose it in sysfs
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new (optional) field to denote the physical location of a device
in the system, and expose it in sysfs. This was discussed here:
https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/

(The primary choice for attribute name i.e. "location" is already
exposed as an ABI elsewhere, so settled for "site"). Individual buses
that want to support this new attribute can opt-in by setting a flag in
bus_type, and then populating the location of device while enumerating
it.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: (Initial version)

 drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++
 include/linux/device.h     | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h |  8 ++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c7..14c815526b7fa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1778,6 +1778,32 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t site_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	const char *site;
+
+	device_lock(dev);
+	switch (dev->site) {
+	case SITE_INTERNAL:
+		site = "INTERNAL";
+		break;
+	case SITE_EXTENDED:
+		site = "EXTENDED";
+		break;
+	case SITE_EXTERNAL:
+		site = "EXTERNAL";
+		break;
+	case SITE_UNKNOWN:
+	default:
+		site = "UNKNOWN";
+		break;
+	}
+	device_unlock(dev);
+	return sprintf(buf, "%s\n", site);
+}
+static DEVICE_ATTR_RO(site);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -1949,8 +1975,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
+	if (bus_supports_site(dev->bus)) {
+		error = device_create_file(dev, &dev_attr_site);
+		if (error)
+			goto err_remove_dev_attr_online;
+	}
+
 	return 0;
 
+ err_remove_dev_attr_online:
+	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -1968,6 +2002,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_site);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024a..a4143735ae712 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -428,6 +428,31 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_site - Physical location of the device in the system.
+ * The semantics of values depend on subsystem / bus:
+ *
+ * @SITE_UNKNOWN:  Location is Unknown (default)
+ *
+ * @SITE_INTERNAL: Device is internal to the system, and cannot be (easily)
+ *                 removed. E.g. SoC internal devices, onboard soldered
+ *                 devices, internal M.2 cards (that cannot be removed
+ *                 without opening the chassis).
+ * @SITE_EXTENDED: Device sits an extension of the system. E.g. devices
+ *                 on external PCIe trays, docking stations etc. These
+ *                 devices may be removable, but are generally housed
+ *                 internally on an extension board, so they are removed
+ *                 only when that whole extension board is removed.
+ * @SITE_EXTERNAL: Devices truly external to the system (i.e. plugged on
+ *                 an external port) that may be removed or added frequently.
+ */
+enum device_site {
+	SITE_UNKNOWN = 0,
+	SITE_INTERNAL,
+	SITE_EXTENDED,
+	SITE_EXTERNAL,
+};
+
 /**
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
@@ -513,6 +538,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @site:	Physical location of the device w.r.t. the system
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -613,6 +639,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_site	site;	/* Device physical location */
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_site(struct device *dev, enum device_site site)
+{
+	if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
+		return -EINVAL;
+
+	dev->site = site;
+	return 0;
+}
+
+static inline bool dev_is_external(struct device *dev)
+{
+	return dev->site == SITE_EXTERNAL;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 1ea5e1d1545bd..e1079772e45af 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -69,6 +69,8 @@ struct fwnode_handle;
  * @lock_key:	Lock class key for use by the lock validator
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
+ * @supports_site:	Bus can differentiate between internal/external devices
+ *			and thus supports the device "site" attribute.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -112,6 +114,7 @@ struct bus_type {
 	struct lock_class_key lock_key;
 
 	bool need_parent_lock;
+	bool supports_site;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
@@ -246,6 +249,11 @@ bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
 }
 #endif
 
+static inline bool bus_supports_site(struct bus_type *bus)
+{
+	return bus && bus->supports_site;
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.27.0.212.ge8ba1cc988-goog


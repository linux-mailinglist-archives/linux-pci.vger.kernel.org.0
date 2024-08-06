Return-Path: <linux-pci+bounces-11400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A07949BC0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 01:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFC5B21BC7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458BB1741DA;
	Tue,  6 Aug 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCmuZyOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E28176AB6;
	Tue,  6 Aug 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985312; cv=none; b=FB7pkrzgs7MjcgWJ9fqXhu8uNzbzLMQv4jKnl2jF2aSasOHtmYPzHoI9ynxzS9WJwIRUsAhX3X/iiUQls2Xzkue1b1qMwIxcJjgpmiV4StwNtlo5xubvBTWyXpQ+vvdfJJtU+CySERqPT2eg+mZlcabfWDDvjBxaaceDz0sblso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985312; c=relaxed/simple;
	bh=KO7jfs2TgLEqYga30ZQedBWQkxKaRq9/xa6Gd+MXuiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KorhCEeCTj7tAoFMJlvvRkQBP0H7SfDS0o29TqExUEcuBVWrqta05EQ0v+s8LVaN6XT7qTE8YfqJ2aQK0Y9QU0b9fmmTSUcCDKoytjW8nAOaIgLDteqBxABJ3tj3cWtjXK7bvlC5g85ikrprNVgyTcwF6U4PVrEVe4ngxHWH4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCmuZyOV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7104f939aa7so905445b3a.1;
        Tue, 06 Aug 2024 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722985309; x=1723590109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuhsPmOnvfzH2aVBohpHkJgMNzD8vpge8Y7lGmsDU5A=;
        b=dCmuZyOVx1TCrHcOpMPpn75W90g0hiCmsgXv7ZUIyad5e4fkZW4cZAgVxPYaxoG+gF
         s5r/F5fSsL3YaTJgAzu0baipmzl15BH6OLcNGxdK6NN35gBpIJyutiw3SAwYbs3pDs4I
         4Uw1e0wLydbDAcwMwV8EcQlm73IlONqZ8UQhDfxmd4hJZCcoHxYECtLOlh6+cwKcdygA
         FlfwZeJva6weFbkWqxiAoJ8YVUUOvuSLF/tv7m8Ea1++kcZdM3VpeC3QjgfPjXHOyqQH
         /zepxH9duW+vF9Ja22o0LpR6+DKCerag12jsl54PjHVq16XxTSgv4Ri/NGeOO6IN11Hl
         OlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985309; x=1723590109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuhsPmOnvfzH2aVBohpHkJgMNzD8vpge8Y7lGmsDU5A=;
        b=UVN1GL5FVTf7MyseK7cplUeevBcrOUySKfRfrybsWXY23fGMvp6/XmQFsA9zRLcs2b
         11V5aTGXwurD3q/rF2mtuhcqPCkrq9+FbqCwV71IYSYMndXHlh5CIg5OuNjOuPyIPcmu
         NeWQAsEmWyXHqk/9PXBsVKLlOFvhaGshokeWICfCdu+3M1cxcWtY6JK+g6qArq2rQaeh
         lNlDfvpfcrlvrTkKNwLJraVdKCOrKJn1A2XQEvnTbJ1adegCffh97IQL1Mv3b/3jqkFd
         82jMrmHXL+1uTCy2yneUqI4r2ea8A0vcCcn+IklykiFxGJ1R3qgjiBTB7tRTCJczR37O
         UwWA==
X-Forwarded-Encrypted: i=1; AJvYcCWlT4XJAK8iCiSCofUUSISPDH+eJyeWOSiiUitv27lJMkSm1Cr03Nh9f0NSFrA9r0c+OrUTUnPHvAx1eN6PAYAlp1wPzjCBmf7/WpXpX4ZSgHDlozqDMynKZUkFuI9VMZqfP5ba1hYR
X-Gm-Message-State: AOJu0YxH5PlWA/1ViC6ZhHou6MQlNj7hjHKXTvrexIpTfWSSmnaASgPX
	c8aTyDUGgxytS33d8PAcigvd6Q7oOprYNbpkI2lmn73T4VjEgHB1
X-Google-Smtp-Source: AGHT+IEhFIq2phH3dKCdml4INS8n46f8eD7IaThGDAhAL0HwoW6Q48rxPIj0+h1uupeq9rgPj0T7MA==
X-Received: by 2002:a17:902:da83:b0:1fd:96e1:801e with SMTP id d9443c01a7336-1ff57404e3fmr211554085ad.51.1722985309349;
        Tue, 06 Aug 2024 16:01:49 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3997sm92780755ad.294.2024.08.06.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 16:01:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 3/4] PCI/DOE: Expose the DOE features via sysfs
Date: Wed,  7 Aug 2024 09:01:17 +1000
Message-ID: <20240806230118.1332763-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806230118.1332763-1-alistair.francis@wdc.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe 6 specification added support for the Data Object
Exchange (DOE).
When DOE is supported the DOE Discovery Feature must be implemented per
PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
information about the other DOE features supported by the device.

The kernel is already querying the DOE features supported and cacheing
the values. Expose the values in sysfs to allow user space to
determine which DOE features are supported by the PCIe device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported features we can
allow userspace to parse the list, which might include
vendor specific features as well as yet to be supported features.

As the DOE Discovery feature must always be supported we treat it as a
special named attribute case. This allows the usual PCI attribute_group
handling to correctly create the doe_features directory when registering
pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
will seg fault).

After this patch is supported you can see something like this when
attaching a DOE device

$ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
0001:01        0001:02        doe_discovery

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Using dev->groups and device_add() path as discussed earlier [1]
doesn't work nicley as the pci_doe_sysfs_group is global.

We end up needing to create a per device instance of dev->groups
that is dynamically modified at init and appended to pci_dev_attr_groups.

Something similar to:
https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L2029
except in this case groups is already assigned.

It's complex and doesn't provide any advantages compared to the approach
in this patch, where we can just use sysfs_add_file_to_group() to add
the sysfs attributes. This aligns with other PCIe DOE related sysfs
patches, such as [2]

1: https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
2: https://lore.kernel.org/all/77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de/

v15:
 - Move init/teardown from pci_{create,remove}_resource_files()
 - Remove `if (IS_ENABLED(CONFIG_PCI_DOE))` checks
v14:
 - Revert back to v12 with extra pci_remove_resource_files() call
v13:
 - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
     - As discussed in https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
       we can just modify pci_doe_sysfs_group at the DOE init and let
       device_add() handle the sysfs attributes.
v12:
 - Drop pci_doe_features_sysfs_attr_visible()
v11:
 - Gracefully handle multiple entried of same feature
 - Minor fixes and code cleanups
v10:
 - Rebase to use DEFINE_SYSFS_GROUP_VISIBLE and remove
   special setup function
v9:
 - Add a teardown function
 - Rename functions to be clearer
 - Tidy up the commit message
 - Remove #ifdef from header
v8:
 - Inlucde an example in the docs
 - Fixup removing a file that wasn't added
 - Remove a blank line
v7:
 - Fixup the #ifdefs to keep the test robot happy
v6:
 - Use "feature" instead of protocol
 - Don't use any devm_* functions
 - Add two more patches to the series
v5:
 - Return the file name as the file contents
 - Code cleanups and simplifications
v4:
 - Fixup typos in the documentation
 - Make it clear that the file names contain the information
 - Small code cleanups
 - Remove most #ifdefs
 - Remove extra NULL assignment
v3:
 - Expose each DOE feature as a separate file
v2:
 - Add documentation
 - Code cleanups

 Documentation/ABI/testing/sysfs-bus-pci |  28 +++++
 drivers/pci/doe.c                       | 144 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   3 +
 drivers/pci/pci.h                       |   9 ++
 drivers/pci/probe.c                     |   3 +
 drivers/pci/remove.c                    |   2 +
 6 files changed, 189 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..65a3238ab701 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,31 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		May 2024
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The features are
+		the file name. The contents of each file is the raw vendor id and
+		data object feature values.
+
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower (RHS of the colon) is
+		the data object type in hex. The upper (LHS of the colon)
+		is the vendor ID.
+
+		As all DOE devices must support the DOE discovery protocol, if
+		DOE is supported you will at least see the doe_discovery file, with
+		this contents
+
+		# cat doe_features/doe_discovery
+		0001:00
+
+		If the device supports other protocols you will see other files
+		as well. For example is CMA/SPDM and secure CMA/SPDM are supported
+		the doe_features directory will look like this
+
+		# ls doe_features
+		0001:01        0001:02        doe_discovery
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index defc4be81bd4..c0e1ed3bddfb 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -14,6 +14,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -47,6 +48,7 @@
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
+ * @sysfs_attrs: Array of sysfs device attributes
  */
 struct pci_doe_mb {
 	struct pci_dev *pdev;
@@ -56,6 +58,10 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+#ifdef CONFIG_SYSFS
+	struct device_attribute *sysfs_attrs;
+#endif
 };
 
 struct pci_doe_feature {
@@ -92,6 +98,144 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static ssize_t doe_discovery_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	return sysfs_emit(buf, "0001:00\n");
+}
+DEVICE_ATTR_RO(doe_discovery);
+
+static struct attribute *pci_doe_sysfs_feature_attrs[] = {
+	&dev_attr_doe_discovery.attr,
+	NULL
+};
+
+static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return !xa_empty(&pdev->doe_mbs);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
+
+const struct attribute_group pci_doe_sysfs_group = {
+	.name	    = "doe_features",
+	.attrs	    = pci_doe_sysfs_feature_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs),
+};
+
+static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attr->attr.name);
+}
+
+static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
+					 struct pci_doe_mb *doe_mb)
+{
+	struct device_attribute *attrs = doe_mb->sysfs_attrs;
+	struct device *dev = &pdev->dev;
+	unsigned long i;
+	void *entry;
+
+	if (!attrs)
+		return;
+
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->feats, i, entry) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
+						     pci_doe_sysfs_group.name);
+		kfree(attrs[i].attr.name);
+	}
+	kfree(attrs);
+}
+
+static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
+					  struct pci_doe_mb *doe_mb)
+{
+	struct device *dev = &pdev->dev;
+	struct device_attribute *attrs;
+	unsigned long num_features = 0;
+	unsigned long vid, type;
+	unsigned long i;
+	void *entry;
+	int ret;
+
+	xa_for_each(&doe_mb->feats, i, entry)
+		num_features++;
+
+	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	doe_mb->sysfs_attrs = attrs;
+	xa_for_each(&doe_mb->feats, i, entry) {
+		sysfs_attr_init(&attrs[i].attr);
+		vid = xa_to_value(entry) >> 8;
+		type = xa_to_value(entry) & 0xFF;
+
+		if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_FEATURE_DISCOVERY) {
+			/* DOE Discovery, manually displayed by `dev_attr_doe_discovery` */
+			continue;
+		}
+
+		attrs[i].attr.name = kasprintf(GFP_KERNEL,
+					       "%04lx:%02lx", vid, type);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = pci_doe_sysfs_feature_show;
+
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
+					      pci_doe_sysfs_group.name);
+		if (ret) {
+			attrs[i].show = NULL;
+			if (ret != -EEXIST)
+				goto fail;
+			else
+				kfree(attrs[i].attr.name);
+		}
+	}
+
+	return 0;
+
+fail:
+	pci_doe_sysfs_feature_remove(pdev, doe_mb);
+	return ret;
+}
+
+void pci_doe_sysfs_teardown(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb)
+		pci_doe_sysfs_feature_remove(pdev, doe_mb);
+}
+
+int pci_doe_sysfs_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+	int ret;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		ret = pci_doe_sysfs_feature_populate(pdev, doe_mb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
 static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
 {
 	if (wait_event_timeout(doe_mb->wq,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..eeda0c650537 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1661,6 +1661,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_DOE
+	&pci_doe_sysfs_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..abac97efc8fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -232,6 +232,7 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct attribute_group *pci_bus_groups[];
+extern const struct attribute_group pci_doe_sysfs_group;
 #else
 static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
 static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
@@ -398,6 +399,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
+int pci_doe_sysfs_init(struct pci_dev *pci_dev);
+void pci_doe_sysfs_teardown(struct pci_dev *pdev);
+#else
+static inline int pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
+static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..2bdb4fe37dbc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2593,6 +2593,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+
+	ret = pci_doe_sysfs_init(dev);
+	WARN_ON(ret < 0);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..d1e0bed53acb 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -34,6 +34,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (!dev->dev.kobj.parent)
 		return;
 
+	pci_doe_sysfs_teardown(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
-- 
2.45.2



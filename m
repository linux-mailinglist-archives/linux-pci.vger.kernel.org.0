Return-Path: <linux-pci+bounces-7744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8908CBF0E
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99191F2257D
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0A81AD2;
	Wed, 22 May 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKeifxjk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE081AC7;
	Wed, 22 May 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372744; cv=none; b=lsGo18LYMpj8M9YzeA29Ex8p+HZHLxIPoizjaG+QIO4fHaSDBM272gffLeh3xkdSA5YO8uc+SOh5fDG6dYRLpQhe1Juyq3eroqBIu1DvbIbYQ0Wx22xvNn1dfMsVEZXu8897v7uSXjDkKExZDTyAwOIQ5Y+/KRKhZ2PPX3WEnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372744; c=relaxed/simple;
	bh=Q5Mw0ADLirDNhz4Juqpk5DKo1rH5IRHHHinlJqeOWm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8fs8lJFnqPHo0eJWU8wlKi7Tg55mSqRk2CoZRH2ucC+WzPk0ZPNlnFo6gSVhy5iPCdoXqATbO82F9Xb3ZP5PDtbPEYVMzXG59zbCX1q/eBVfvFB97ybHNlB8cpyoVJUeMKLNun1ZFXQ6RyXMMnTJAPl8oSrVX94sccpGG3FpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKeifxjk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f32a3b9491so2130465ad.0;
        Wed, 22 May 2024 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716372742; x=1716977542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZh2zE5RkAxdyI3a/U+tzikza7gGwSs29helxu1XMSk=;
        b=kKeifxjkDNdMRXqb+JG5d5ASVaus5DM+dvH51PvUCJilv/9bZ4dk7x9/J4U/zvWcwb
         LrMbRShoON+vvPaCUlijNHWd5rjYTUIR5wmO5BhD0WZFoD9kPu4QyrHeIpwnkAdveNqH
         wr0t7VpGhDPOzyKffKS3C0OtgAbXWVcvkmjObClhXoXL8/sEhTM5f97BjbCpP84lW8b7
         ZWdmLZ1aLr5RCDcvk3riNYrdqNFE9fC6fWlDJNcqKuQCK8R1UGbXLv7s5jg2y3czZ4ik
         jQKRE+jHLLVSMkCEF3PLQMt68HzGdWVskz/sEwGLq5yCbwpdBD+BFe/2uSVoI9ReJXvX
         a8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372742; x=1716977542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZh2zE5RkAxdyI3a/U+tzikza7gGwSs29helxu1XMSk=;
        b=hWdisIQjQxf8xrHfKX/b/dzppNuMZpGSuqNvcDypjoeI7qskTyzw8uKamSNG6iaE+U
         5jWWWiZ29fhJCQl4hh4OOhxBajm4gf2AaBXT30k0/FYioURz/47EQdNmUMTmTN13jpKv
         IWaem2MxDIBHffqkq9r6YxQ9rBImhLP8Ub+9D1mkTrSdVnTXcpT+gCHWWzSxy9zSC/by
         VGAsXR7Y3VJkm56+hk1r5q/iqHnWyBchCSWH6cIdBhQc1Iby5JXdbFnDAJHm+AVO4RiQ
         6fKQtxrOOfHjuA+aAJLgqdv+WhEcxwnkYdzycOimU5MbTJDTbMoAvPjoL1ukAaiqRZmB
         dlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrk8lsjsku1QED5tR+dF9Q+2wefXeSy+GVE7AYjozg8YHTGMdU028YXlclUoyurgTuWs2WvnazpdomK9W0NaQy0JQ/130w2JZVsSJqaBcu5xBL4qBPMaOFozDC/WoiyjOzMEaPVA0M
X-Gm-Message-State: AOJu0Yyz73JAp1cSih5mYmhzHznqHRxVj4djHYml130XUN1BwuSR4V+X
	la7q7aJ41/yE9a3Pe2YyQozw+Y1uMXuABJI3MbCB0a2GfF4zffqa
X-Google-Smtp-Source: AGHT+IHNi4EbTIWKEc2r7n4D60LFs+iE3wrrLRjIbCbxh24xo/kzFk33dnGx09jmPw2Fyo354Adpiw==
X-Received: by 2002:a17:902:c950:b0:1eb:788:b424 with SMTP id d9443c01a7336-1f31c9dc0a1mr13601375ad.43.1716372742004;
        Wed, 22 May 2024 03:12:22 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-f22f-74ff-fe1e-41ce.ip6.aussiebb.net. [2403:580b:97e8:0:f22f:74ff:fe1e:41ce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3066594bdsm44593235ad.303.2024.05.22.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:12:21 -0700 (PDT)
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
Subject: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
Date: Wed, 22 May 2024 20:11:41 +1000
Message-ID: <20240522101142.559733-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101142.559733-1-alistair.francis@wdc.com>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
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
---
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

 Documentation/ABI/testing/sysfs-bus-pci |  28 ++++
 drivers/pci/doe.c                       | 175 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  13 ++
 drivers/pci/pci.h                       |  10 ++
 4 files changed, 226 insertions(+)

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
index defc4be81bd4..7a20a257df5a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -47,6 +47,7 @@
  * @wq: Wait queue for work item
  * @work_queue: Queue of pci_doe_work items
  * @flags: Bit array of PCI_DOE_FLAG_* flags
+ * @sysfs_attrs: Array of sysfs device attributes
  */
 struct pci_doe_mb {
 	struct pci_dev *pdev;
@@ -56,6 +57,10 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+#ifdef CONFIG_SYSFS
+	struct device_attribute *sysfs_attrs;
+#endif
 };
 
 struct pci_doe_feature {
@@ -92,6 +97,176 @@ struct pci_doe_task {
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
+	NULL,
+};
+
+static umode_t pci_doe_sysfs_attr_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	unsigned long vid, type;
+	void *entry;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->feats, j, entry) {
+			vid = xa_to_value(entry) >> 8;
+			type = xa_to_value(entry) & 0xFF;
+
+			if (vid == 0x01 && type == 0x00) {
+				/* This is the DOE discovery protocol
+				 * Every DOE instance must support this, so we
+				 * give it a useful name.
+				 */
+				return a->mode;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static bool pci_doe_sysfs_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	void *entry;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->feats, j, entry)
+			return true;
+	}
+
+	return false;
+}
+DEFINE_SYSFS_GROUP_VISIBLE(pci_doe_sysfs)
+
+const struct attribute_group pci_doe_sysfs_group = {
+	.name	    = "doe_features",
+	.attrs	    = pci_doe_sysfs_feature_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_doe_sysfs),
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
+		if (vid == 0x01 && type == 0x00) {
+			// DOE Discovery, manually displayed by `dev_attr_doe_discovery`
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
+			goto fail;
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
index 40cfa716392f..b5db191cb29f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/stat.h>
 #include <linux/export.h>
 #include <linux/topology.h>
@@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 {
 	int i;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE))
+		pci_doe_sysfs_teardown(pdev);
+
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct bin_attribute *res_attr;
 
@@ -1227,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	int i;
 	int retval;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE)) {
+		retval = pci_doe_sysfs_init(pdev);
+		if (retval)
+			return retval;
+	}
+
 	/* Expose the PCI resources from this device as files */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
@@ -1661,6 +1671,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
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
index fd44565c4756..3aee231dcb0c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -189,6 +189,7 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pci_dev_attr_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct attribute_group *pci_bus_groups[];
+extern const struct attribute_group pci_doe_sysfs_group;
 #else
 static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
 static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
@@ -196,6 +197,7 @@ static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #define pci_dev_attr_groups NULL
 #define pcibus_groups NULL
 #define pci_bus_groups NULL
+#define pci_doe_sysfs_group NULL
 #endif
 
 extern unsigned long pci_hotplug_io_size;
@@ -333,6 +335,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
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
-- 
2.45.1



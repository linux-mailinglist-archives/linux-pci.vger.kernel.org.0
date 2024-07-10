Return-Path: <linux-pci+bounces-10031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8392C897
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D3A1F23593
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C1182C5;
	Wed, 10 Jul 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwDoZbYx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1743B2BB;
	Wed, 10 Jul 2024 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578832; cv=none; b=ABm6eIxMzQow//12UW4noc4ExlxbYUf/ewkY6OeC/2K1tbASpYQ742BuS4XmXLi/IsUW3omWcwYlMmxxhJzrGLzUzwEezGrK7uZWZhYHxpFoC9HQczUXLuG7wFWEbBQnt15OS0opSVmmBlwS1lxiyEI3uPa8Vq3A/gZQ6kIwHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578832; c=relaxed/simple;
	bh=ZwQwlF47E7PtI7FlM+YTy9TdbgDQSr+oLU8C7pzy6Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSC/7b3sjahDhO5ibDCFvWWfI+dEiea/9f/3/tWpmd9IDSC2AHg/ZtUXHszx99F9VF2C6CQzgvJzNvcrCjj5CHWtxm5M+DaQkafoLfemfa3SkHqENtR5Cna/lhI20FFRi4XQnlgH7s8RFXLeMnvEEO/oDqNpwcWuQd/tHIQyTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwDoZbYx; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso70455b6e.2;
        Tue, 09 Jul 2024 19:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720578829; x=1721183629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjGiz+1O53z4zlo501+oylDw+437L8q98TUMeoGUWcQ=;
        b=lwDoZbYx/qwvt0zE8nRKvr2VvIAuPXwd0NnrTw25Nt2h8Gu0Nfy9zzT4uI4lmLlT90
         /72+3C95rYyRikEcw2geDdncMWClv4B4XThAGaGqVAIVk1g1TF5lmCTqGPUDVDLPPT8g
         tDYQpAsuOQOiG+miiVyVraeGs7IIQKLHMpWKyXAoiw9dEVhILn1aN6gPyo+yNFolq1d4
         1t3wezryOwUqRCjBFm062L22T1HGwfk6yPq90UUzr9/OQrz8pTQjC1bhfeBCaKoZcbRu
         7WZf9qkgMxe+MJSnAaRh2rF+DRlKlP+D5o1RvPunWjapmBebPejw2a8pDyJ/o81ppFoM
         ZwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720578829; x=1721183629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjGiz+1O53z4zlo501+oylDw+437L8q98TUMeoGUWcQ=;
        b=DaOg16TxTp4Lf/6vvfBMb3D6nP8Bt8G8XoThScNpL3iyZT6RXYt6YwODaW76s11BYZ
         yOB279I1ta1ZMzIMrY6gW9gZ8zSNrrvM59p4VdvDtFyyllhvRmWfzPaBCcmmU+cU2jD2
         6+F2aK6ZUgPrDALvGQP/EmWUj8Qk1AdUjmuHQfLySTFc7aEHc8SbNuI8MqSQtEv1QXmx
         Gm2c2IMy86a6mvkbcz6qv44+WHCSaOGEEZVaXS4Ab35E18bw+xtt9soo6Gs8S73d5vNq
         hmvzK6zoGFLTvjRrLZY927nbJlaCAKoNJgYaw+H4m5lvowz8JftgClrYQR9pCSDrdyaD
         /tdA==
X-Forwarded-Encrypted: i=1; AJvYcCXLwPrikOa+FE9orKMloplqqTYHO9z2eFl9ns3oNO4QhyaEX/SRgTAA/iJzcuUQsJRNqtU+7hHkWxcGWqex1s3j8K2IX8rHw3Ijvb+o72yc+9WVOeUIxId9ABqjyFfSM1BSvMfSa14x
X-Gm-Message-State: AOJu0Yyp2SMZn/iVAvCbYqZcaOpaGOeoLf5iWV/L9/6bThAJEgOU09rV
	HSv/Ur7rZjnFzbhs2/2liZSC6mtPE70qE40pJJyPmtzdgWNwJ9OKzfW/0Q==
X-Google-Smtp-Source: AGHT+IGjcQAOROW+mxC6HIuQRjAkTEOL9s11oGQVae8i4QFhFoteZU/eo1jOyzibxYPRsyVWOc2Ufw==
X-Received: by 2002:a05:6808:1911:b0:3d9:2ec9:4bb8 with SMTP id 5614622812f47-3d93c016d5amr5414568b6e.19.1720578829282;
        Tue, 09 Jul 2024 19:33:49 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm2630992b3a.178.2024.07.09.19.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 19:33:48 -0700 (PDT)
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
Subject: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
Date: Wed, 10 Jul 2024 12:33:09 +1000
Message-ID: <20240710023310.480713-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710023310.480713-1-alistair.francis@wdc.com>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
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
 drivers/pci/doe.c                       | 151 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  15 +++
 drivers/pci/pci.h                       |  10 ++
 4 files changed, 204 insertions(+)

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
index defc4be81bd4..580370dc71ee 100644
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
@@ -92,6 +98,151 @@ struct pci_doe_task {
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
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		if (!xa_empty(&doe_mb->feats))
+			return true;
+	}
+
+	return false;
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
+		if (vid == 0x01 && type == 0x00) {
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
index 40cfa716392f..db795bfe3c56 100644
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
 
@@ -1227,6 +1231,14 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	int i;
 	int retval;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE)) {
+		retval = pci_doe_sysfs_init(pdev);
+		if (retval) {
+			pci_remove_resource_files(pdev);
+			return retval;
+		}
+	}
+
 	/* Expose the PCI resources from this device as files */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
@@ -1661,6 +1673,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
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
2.45.2



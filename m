Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DB7910FD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352230AbjIDFo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 01:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352210AbjIDFo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 01:44:27 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742F103;
        Sun,  3 Sep 2023 22:44:22 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d4c3fa6a6so391145137.0;
        Sun, 03 Sep 2023 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693806262; x=1694411062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OuAAA+MjszGw1Zc9pNsypPpcFTo5HUWdibD+ivDk6c=;
        b=rjB2fyIrcn+hhUDVp2ydSKl+VtqVELANWbGFYRgReDQGBgQOsGDWOXCe0LxRhpP26B
         na1jP93SvLX3wGj+a8ajRkvpXwLlhhO6TW/HbZQ4YoGDDxRXk9EgaqaTOKqfIM9IJJjb
         EELC0K5lVBwsx9WAw2aAGKX9FM/n9HAZMNnlI5qWE5zO7WO0Gkb/sUD0MDPqiYjKeyDl
         qEWh2gaCZ0zNMVesu9NBTzQWYXs+eIK6i947K2sI2ZT0hq5V1if8bmWQtk0cUK4m/DfG
         LD/GznxB/WXap1KcTBN2J9yIdGRXbBrQ5LyocHjiSH97d548NbUVi5WAUcUpXFu0haTH
         owyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693806262; x=1694411062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OuAAA+MjszGw1Zc9pNsypPpcFTo5HUWdibD+ivDk6c=;
        b=QDW1iElVonEMd8o/uAPJwzLOeV+xr2rLe7i+2+3DF/0du2Tk8xjBXdGWRDgvFbRQtb
         gHFkKsoruO47DHPI8QbhAm1xsqO33opcxFLdKxRqE+24F5rBLubWPYVvCLwhTAGOLcv7
         cXeJHZWOL43tuPEigYfmOGLVpAYaB2JtyLhaSN/1dTNLScKV+uylc7Odnjr6MIz2VhRD
         k4XLDve3Yy33jZNnLGw3LhA/r1/PA8kI+57HshvtpZmwBDO6vhPtxR+VoBzAm4gWRYhK
         WdHd/4ZDK/7vp5BzxPCEo/OMTCACa2L3eDczyMXDbN0XfxFkrJ6Lvj3VGWumHHXn32n6
         kJyQ==
X-Gm-Message-State: AOJu0YzcyMxQVDN/6Y0p2JOpCgvHsR8hxlVtqb+mBhqhrafanrWKOfiS
        Hg654wQLq7qdt7FgG6BVg0Q=
X-Google-Smtp-Source: AGHT+IG+n5LtcGqKv514eDABB63U4tGAgEG0jRQJixiP2GFzFY3xuRvub6BW3l3Qcuqhy7U+2tRUZw==
X-Received: by 2002:a05:6102:52f:b0:44d:57aa:532f with SMTP id m15-20020a056102052f00b0044d57aa532fmr8192282vsa.31.1693806261860;
        Sun, 03 Sep 2023 22:44:21 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id h3-20020a63b003000000b0056c466b09a4sm6803450pgf.59.2023.09.03.22.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 22:44:21 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/3] PCI/DOE: Expose the DOE features via sysfs
Date:   Mon,  4 Sep 2023 15:43:28 +1000
Message-ID: <20230904054329.865151-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904054329.865151-1-alistair.francis@wdc.com>
References: <20230904054329.865151-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe 6 specification added support for the Data Object Exchange (DOE).
When DOE is supported the Discovery Data Object Protocol must be
implemented. The protocol allows a requester to obtain information about
the other DOE features supported by the device.

The kernel is already querying the DOE features supported and cacheing
the values. This patch exposes the values via sysfs. This will allow
userspace to determine which DOE features are supported by the PCIe
device.

By exposing the information to userspace tools like lspci can relay the
information to users. By listing all of the supported features we can
allow userspace to parse and support the list, which might include
vendor specific features as well as yet to be supported features.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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

This patch will create a doe_features directory for all
PCIe devies. This should be fixed by a pending sysfs fixup
patch.

 Documentation/ABI/testing/sysfs-bus-pci |  12 +++
 drivers/pci/doe.c                       | 111 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  10 +++
 drivers/pci/pci.h                       |   3 +
 include/linux/pci-doe.h                 |   1 +
 5 files changed, 137 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..e999e78cc2d5 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,15 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		August 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The feature values are in
+		the file name. The contents of each file are the same as the
+		name.
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object
+		type and the next two bytes are the vendor ID.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 047be8c9d191..69cd391dd120 100644
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
@@ -92,6 +97,112 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	void *entry;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->prots, j, entry)
+			return a->mode;
+	}
+
+	return 0;
+}
+
+static struct attribute *pci_dev_doe_feature_attrs[] = {
+	NULL,
+};
+
+const struct attribute_group pci_dev_doe_feature_group = {
+	.name	= "doe_features",
+	.attrs	= pci_dev_doe_feature_attrs,
+	.is_visible = pci_doe_sysfs_attr_is_visible,
+};
+
+static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attr->attr.name);
+}
+
+static int pci_doe_sysfs_feature_supports(struct pci_dev *pdev,
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
+	xa_for_each(&doe_mb->prots, i, entry)
+		num_features++;
+
+	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	doe_mb->sysfs_attrs = attrs;
+	xa_for_each(&doe_mb->prots, i, entry) {
+		sysfs_attr_init(&attrs[i].attr);
+		vid = xa_to_value(entry) >> 8;
+		type = xa_to_value(entry) & 0xFF;
+		attrs[i].attr.name = kasprintf(GFP_KERNEL,
+					       "0x%04lX:%02lX", vid, type);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = pci_doe_sysfs_feature_show;
+
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
+					      pci_dev_doe_feature_group.name);
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->prots, i, entry) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
+						     pci_dev_doe_feature_group.name);
+		kfree(attrs[i].attr.name);
+	}
+
+	kfree(attrs);
+
+	return ret;
+}
+
+int doe_sysfs_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+	int ret;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		ret = pci_doe_sysfs_feature_supports(pdev, doe_mb);
+
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
index d9eede2dbc0e..01bbd1f1cb9b 100644
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
@@ -1230,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	int i;
 	int retval;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE)) {
+		retval = doe_sysfs_init(pdev);
+		if (retval)
+			return retval;
+	}
+
 	/* Expose the PCI resources from this device as files */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 
@@ -1655,6 +1662,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_DOE
+	&pci_dev_doe_feature_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39a8932dc340..b85dd83ddfcb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -186,6 +186,9 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
+#ifdef CONFIG_SYSFS
+extern const struct attribute_group pci_dev_doe_feature_group;
+#endif
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..4cc13d9ccb50 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -22,4 +22,5 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
 	    void *response, size_t response_sz);
 
+int doe_sysfs_init(struct pci_dev *pci_dev);
 #endif
-- 
2.41.0


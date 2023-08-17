Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7E78020D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 01:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356206AbjHQX7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356331AbjHQX6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 19:58:42 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7826AA;
        Thu, 17 Aug 2023 16:58:40 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44bf676a086so112449137.3;
        Thu, 17 Aug 2023 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316719; x=1692921519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbxQJAuu/02g0YU9vrxi3SyQC4nxmr5UrgA6AsN18q8=;
        b=ZeJ60BzgGXd1SBSYMiwyHub3P6Rh+S9nGPGM8e/jAiCPC+0+3KqCr29x3LDNeS+Bwv
         uq/j5CapHUQHNMyMKsrxzjCfd3LVnaX2AN75H6Jz7smcBozlFy5A8nfNBHWbOm+p144Q
         UYfkIXz54exgW68FW4plva+rfrlWuxzlvpdfAdJctIGwmLxS1IH0gLIh8f2Y+ljTIG6Y
         R0U0rbT9SbecrwwFWJgbQv6RhJTGa4Fp25WGhaiy9/VuYHZsPkk/AfBgLJckS+v2E7ud
         C1iH4pgTpIVOrgSqTXjIPnqZU2MuvrvGPLE4MP42DZv2ASbrw1qdI/YdoXjmOuTsTSON
         narA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316719; x=1692921519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbxQJAuu/02g0YU9vrxi3SyQC4nxmr5UrgA6AsN18q8=;
        b=dAKDllIIKN1X5dB+4WwkFh+ZBmI6jPeyXHXpbrInFuaYPdlIG40nvE/UfxADWFXMui
         zT9YLMwy9XSpSNgCrYkQPCjscA2zFVRIHoWB+7p5+vTNgq024v6GRWfw9zSSH3d6yh/c
         Pp13aX8lVI/oX1op2ftn6QLBNcMFO3dMqvhW6pxFg8KRMIaKPZKqrhuIunpPGUPH+XXA
         A58/J+WfhV8/8kEGu3vtR6BPfN3Yth/kJzXfcvp7YEFgN0HDjR23+ffXHU6eS4S11uTs
         uJKAYuxo3FrtgQf/5okoIYZDnsyM8iIL1+5+BjTmH+q6rD6nlLU7Yrw0zYtqzUW9Ym8/
         1dlg==
X-Gm-Message-State: AOJu0Yw+huA4O9sB0Sed86trYM9WIKRxwJh2riN4nGPsgnYxHSht/APv
        FHl9DvbvZ4zxVgcDhQa+NTg=
X-Google-Smtp-Source: AGHT+IHj0DF5V6UPufpc5XTF58aPL9ESo5WVhPIU6toUFTeRwwxX94nFJ8ulAI7qDfEceBcb7nbimQ==
X-Received: by 2002:a05:6102:2858:b0:444:17aa:df60 with SMTP id az24-20020a056102285800b0044417aadf60mr1479117vsb.13.1692316719261;
        Thu, 17 Aug 2023 16:58:39 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
        by smtp.gmail.com with ESMTPSA id k19-20020a67c293000000b0044bf2750d30sm135182vsj.10.2023.08.17.16.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:38 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 1/3] PCI/DOE: Expose the DOE features via sysfs
Date:   Thu, 17 Aug 2023 19:58:08 -0400
Message-ID: <20230817235810.596458-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
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
PCIe devices without the next two patches

 Documentation/ABI/testing/sysfs-bus-pci |  11 +++
 drivers/pci/doe.c                       | 112 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  10 +++
 drivers/pci/pci.h                       |   3 +
 include/linux/pci-doe.h                 |   1 +
 5 files changed, 137 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..199ee5d27d9d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,14 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		August 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The feature values are in the
+		file name. The contents of each file are the same as the name.
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object
+		type and the next two bytes are the vendor ID.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 1b97a5ab71a9..316aac60ccd5 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -56,6 +56,8 @@ struct pci_doe_mb {
 	wait_queue_head_t wq;
 	struct workqueue_struct *work_queue;
 	unsigned long flags;
+
+	struct device_attribute *sysfs_attrs;
 };
 
 struct pci_doe_protocol {
@@ -92,6 +94,116 @@ struct pci_doe_task {
 	struct pci_doe_mb *doe_mb;
 };
 
+#ifdef CONFIG_SYSFS
+static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	unsigned long total_features = 0;
+	struct pci_doe_mb *doe_mb;
+	unsigned long index, j;
+	void *entry;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		xa_for_each(&doe_mb->prots, j, entry)
+			total_features++;
+	}
+
+	if (total_features == 0)
+		return 0;
+
+	return a->mode;
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
index ab32a91f287b..3f5104cf78b6 100644
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
@@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
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
 
@@ -1651,6 +1658,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
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
index a4c397434057..139d37a0d4cd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -180,6 +180,9 @@ extern const struct attribute_group *pci_dev_groups[];
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


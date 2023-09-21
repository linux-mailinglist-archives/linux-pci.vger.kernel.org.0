Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B457A9F86
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjIUUXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjIUUWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 16:22:45 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9C48AA9;
        Thu, 21 Sep 2023 10:14:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ab2436b57dso772777b6e.0;
        Thu, 21 Sep 2023 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316481; x=1695921281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1Z+4wJ7dsIwTfLYYwPGAAlK13JBxWGp5edHNOse4Yo=;
        b=KDTO99pBhjCYmTpyRXucOKHJ3yjMmQ2+JU86ZZ2VFwo0IaAuI7++sPwoico/KoMFQU
         IOnacjB4cvZSHn2r6Ds5rqqPjdNy6NtHAKHK88IKUM5fOmzXSDH561vZcLq5whFEjHkm
         K6md55tzWpzveiEVxaG0M4X4BExKsJR6ZO2f7GSh9WhgRKWu4bkJn1S46Y+1b8sU15UN
         zbhw6wnG7IR0h8Blry55BAfH62piiojQVtFuk0fZDFCuXFXyrZwg+H8I9DxN/oZGliNw
         E3iL6G5wm4vtiroOBKghW1JqzRQacbjqG7OL55CEHzUnBsv7NZhAZPjcqj6r7E1tzRP2
         sE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316481; x=1695921281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1Z+4wJ7dsIwTfLYYwPGAAlK13JBxWGp5edHNOse4Yo=;
        b=QTF7tKo+AwadU87fAMvOm0iNEkKxgqdYW+agWkHc2hKn5jmK+fGlyabkP8xGgXKNPw
         WoCsc/xqCavTPog+ddTXNABrzsGSqMFdK5g/8IlSfFWO5l0wxOK7bHHTKYTcW2MCNjNM
         KZcFCvfJyz4uIAAGxxNU4rANKo9JtgiTztxjxpn0TUaZMQ/55gg2ibLOvMtsL23+UIN/
         mct+vOFbueuIzDF7F84UnZ4ZI/KDRDikvjp41ip29YiUd/qELQSyMbunVoNhqiqBX0Zg
         JCVMR+fsH+1ixv2lG1O4BPl8KSwxKOMPWqCOPslfuYCqq3HMO/uKneqbXlQRQsDTTg20
         VIHQ==
X-Gm-Message-State: AOJu0Yzh+JuPRfwQeysYdB4ybo9lBmRn3VKHTH/8ttN5edtQc8KnEWEq
        0lZyi/A5VOhsONF9DuXjP9fDuqnF+QYG4W55
X-Google-Smtp-Source: AGHT+IGgdlyC0pmkzvxzBp7qhVK96MWdeH8cohemhiuuy7OYEpTqXIDzRmB+PxeYr6QsX6KAx1zUqQ==
X-Received: by 2002:a17:902:d2cf:b0:1bc:69d0:a024 with SMTP id n15-20020a170902d2cf00b001bc69d0a024mr5397011plc.33.1695275770986;
        Wed, 20 Sep 2023 22:56:10 -0700 (PDT)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001adf6b21c77sm502841plb.107.2023.09.20.22.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 22:56:10 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 2/3] PCI/DOE: Expose the DOE features via sysfs
Date:   Thu, 21 Sep 2023 15:55:30 +1000
Message-ID: <20230921055531.2028834-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921055531.2028834-1-alistair.francis@wdc.com>
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
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

This patch will create a doe_features directory for all
PCIe devies. This should be fixed by a pending sysfs fixup
patch.

 Documentation/ABI/testing/sysfs-bus-pci |  23 +++++
 drivers/pci/doe.c                       | 112 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  10 +++
 drivers/pci/pci.h                       |   3 +
 include/linux/pci-doe.h                 |   1 +
 5 files changed, 149 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..b52bb82a771e 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,26 @@ Description:
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
+
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower byte is the data object
+		type and the next two bytes are the vendor ID.
+
+		As all DOE devices must support the DOE discovery protocol, if
+		DOE is supported you will at least see this file, with this
+		contents
+
+		# cat doe_features/0x0001:00
+		0x0001:00
+
+		If the device supports other protocols you will see other files
+		as well.
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 78ce79e031cd..30826462d167 100644
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
@@ -92,6 +97,113 @@ struct pci_doe_task {
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
+		xa_for_each(&doe_mb->feats, j, entry)
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
+		if (ret) {
+			attrs[i].show = NULL;
+			goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	doe_mb->sysfs_attrs = NULL;
+	xa_for_each(&doe_mb->feats, i, entry) {
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A972A7C7C3E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJMDmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 23:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMDmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 23:42:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC9B7;
        Thu, 12 Oct 2023 20:42:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9e06f058bso9898815ad.0;
        Thu, 12 Oct 2023 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697168555; x=1697773355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+xt59PvYpRlaX7RhqH/nvriookQqY8liMk4TR3lSq4=;
        b=G8ctLGpMP7Z83e6k0+3hqDWRUt7D10zGAjbe6qPuqd94ZNTyLFw4h3aOKFovyAf4ll
         7TTKqpYutoCdK/+BR440sT06SZlFH9x1CWqMxiLNjwBKH+mF4m+Eyys+tzH1qzSLwFfM
         HGimZDXYH+pSaNxlaILOEVSsNC71P/yjZAtbwW2UAn0xnAgtl2dL1f9+UysQsh+uVVMm
         6jVGy6JYzoYtCB5Ytac2YssIgJqd9lp6c3ME0l1wZqeYcjxmAb3T3/4LmXYRItLSLj4/
         jv041EPqjO/rwNnvjvC4bpU2NfzyNo/FQ112TrLmfFm0na36QVWsTupTs38oy2xdp6r0
         TtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168555; x=1697773355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+xt59PvYpRlaX7RhqH/nvriookQqY8liMk4TR3lSq4=;
        b=aXgGXMy3QHx7kC6StLzF6FPi5svVz70o384uwtYp3f2+C+U71qDQQZDtJ9ChyJNjn7
         geRkfluvGKuuWOlV863xYojt96GwrpOgrHWUw6h4SbG3JubS+XWBqtC8YdyCU/unJD2O
         mXCXMRj4NRgDOwq7cgReApQBwIjzM046a8FIAOauEX2LUDbbuqMg6IE8uaWJ2wnvv4Ee
         1X37CA6WQCB7AOEmJVb2VoAnhclDlclCqs8foU0bXZRy/CYDbMRUbiTUcfxjDz7/CHCx
         ngYyP8AOhFPAmXP+JfxXjUELZIe3+zqN6hsbqgrr+m+LKQGBbS+swwtdGYcylFgQSn43
         ouTg==
X-Gm-Message-State: AOJu0YwGrruFrJ7F7zn4JEN2nexXo8xfRU8AtJV8xW06EO29PsxHn8Ug
        bkgkCBdAzS2pau6YTOhDKJM=
X-Google-Smtp-Source: AGHT+IEEq00uR+HsokCj0+LKDMULUznWOT+RtDd536ODx4d859WXRzXWY1QurSpL3Ma2iUT8mChZUA==
X-Received: by 2002:a17:902:6808:b0:1c9:c3eb:6551 with SMTP id h8-20020a170902680800b001c9c3eb6551mr11399079plk.10.1697168555297;
        Thu, 12 Oct 2023 20:42:35 -0700 (PDT)
Received: from toolbox.wdc.com (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net. [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b006933ea28070sm13045834pfo.12.2023.10.12.20.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:42:34 -0700 (PDT)
From:   Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 2/3] PCI/DOE: Expose the DOE features via sysfs
Date:   Fri, 13 Oct 2023 13:41:57 +1000
Message-Id: <20231013034158.2745127-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013034158.2745127-1-alistair.francis@wdc.com>
References: <20231013034158.2745127-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe 6 specification added support for the Data Object Exchange (DOE).
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
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

 Documentation/ABI/testing/sysfs-bus-pci |  24 +++++
 drivers/pci/doe.c                       | 134 ++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |  14 +++
 drivers/pci/pci.h                       |   1 +
 include/linux/pci-doe.h                 |   2 +
 5 files changed, 175 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..66d9d66e3584 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,27 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../doe_features
+Date:		October 2023
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		This directory contains a list of the supported
+		Data Object Exchange (DOE) features. The feature values are in
+		the file name. The contents of each file are the same as the
+		name.
+
+		The value comes from the device and specifies the vendor and
+		data object type supported. The lower (RHS of the colon) is
+		the data object type in hex. The upper (LHS of the colon)
+		is the vendor ID.
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
index db2a86edf2e1..1ffc5441e6d1 100644
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
@@ -92,6 +97,135 @@ struct pci_doe_task {
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
+static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
+					 struct pci_doe_mb *doe_mb)
+{
+	struct device *dev = &pdev->dev;
+	struct device_attribute *attrs = doe_mb->sysfs_attrs;
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
+						     pci_dev_doe_feature_group.name);
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
+	pci_doe_sysfs_feature_remove(pdev, doe_mb);
+	return ret;
+}
+
+void pci_doe_sysfs_teardown(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe_mb;
+	unsigned long index;
+
+	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
+		pci_doe_sysfs_feature_remove(pdev, doe_mb);
+	}
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
index d9eede2dbc0e..64bf765df5e2 100644
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
@@ -1153,6 +1154,10 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 {
 	int i;
 
+	if (IS_ENABLED(CONFIG_PCI_DOE)) {
+		pci_doe_sysfs_teardown(pdev);
+	}
+
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct bin_attribute *res_attr;
 
@@ -1230,6 +1235,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
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
 
@@ -1655,6 +1666,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
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
index 39a8932dc340..83065e07c491 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -186,6 +186,7 @@ extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pcibus_groups[];
 extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
+extern const struct attribute_group pci_dev_doe_feature_group;
 
 extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..c5529ae604ff 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -22,4 +22,6 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 	    const void *request, size_t request_sz,
 	    void *response, size_t response_sz);
 
+int pci_doe_sysfs_init(struct pci_dev *pci_dev);
+void pci_doe_sysfs_teardown(struct pci_dev *pdev);
 #endif
-- 
2.40.1


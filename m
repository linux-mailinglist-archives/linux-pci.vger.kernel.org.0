Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1393EAF06
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 05:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhHMD5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 23:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbhHMD5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 23:57:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C49C061756;
        Thu, 12 Aug 2021 20:56:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso14063161pjy.5;
        Thu, 12 Aug 2021 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDZHM5tor5ult41hvKx7VhtJrBeuaCQvjswI0iqoKEk=;
        b=teEwyN7nI92pDPzTWs3MBvWI1hPBS5rP3QTqZnoEJ87RbnZyDpob/4JHZnrTB7+N81
         DXSaJPbvqyCgHleHJw5PseSj8Vgh1bywMIadAjI1AIis1gmzkGq2oRU0F56jSWcf9po6
         sCT48BCGQ2BO7ChSzZER1dkOMOXy+GKvbi1hz1Ex3K1x9dtgpIbJcnhFfrBNmHeQCGD7
         kSJSV0vyQRUNOjalFK742nAaY2OneyGH5dMDRyMzUsqsHmcKAGytjhUOz+VOFfOdcxoU
         lT5BNV3h+CHJ4SQvsH/daPXBnvXhFUwhPsdeO0ZHrBFm+jQ6jDaQ59qnWl0IJjLFOk9+
         OKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDZHM5tor5ult41hvKx7VhtJrBeuaCQvjswI0iqoKEk=;
        b=LLCgMMnJJxIefIrgtWrPKcMobP9VdbPlJntQr/36OgvN0NuGEvMQ6tQ7UymzIP7mGF
         mBYCX9IMJqws7BAwJFAw/NRdrqLSJdSQuXNju4Q9b4BlyBoWUPCfcW5ZgbxVBG3bZboR
         yXzFl5cOAM3Ybzeslco8qtcGIZhVSDuwtKGjzv0GVjEWL2XexP6z/aXqAT7Sg+389jZi
         Za0KW4SCaK6ZscM9k4rzjjj9OttcV6tb54v/ZFzBuhj3oFJLhrKYjVOoDOTgv+ryrzDk
         WcWHHsWUbNyNXXpZTrbhwXIae825Hv0yYJZ7QKmC+Hy5o84PXjLgmC6RleDa6JpX1oqw
         KuTA==
X-Gm-Message-State: AOAM532/1w+0PqxzvvBpxLuDmBai8uGws12o54JaSTI+PlreELa8ebv7
        Zk67cdWcIxD6Dj3tdwXIOhsMnP42HhtLqSKx
X-Google-Smtp-Source: ABdhPJzfoiWQkRB+ekwFYIzK7wAl/WQ8RGkM1hd/AEP7LmlFT9cBdLDvkW+XDFLm/OBoPMnErSbi0w==
X-Received: by 2002:a17:90b:f83:: with SMTP id ft3mr524336pjb.173.1628827013551;
        Thu, 12 Aug 2021 20:56:53 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:f39c:9aee:21bf:36f5])
        by smtp.gmail.com with ESMTPSA id n25sm297791pfa.26.2021.08.12.20.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 20:56:53 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     bhelgaas@google.com, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, will@kernel.org
Subject: [PATCH v3 1/2] genirq/msi: Extract common sysfs populate entries to MSI core from PCI
Date:   Fri, 13 Aug 2021 15:56:27 +1200
Message-Id: <20210813035628.6844-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813035628.6844-1-21cnbao@gmail.com>
References: <20210813035628.6844-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

This patch makes PCI's MSI sysfs code common in MSI so that other busses
such as platform can reuse it.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/pci/msi.c   | 124 ++++--------------------------------------------
 include/linux/msi.h |   4 ++
 kernel/irq/msi.c    | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255..4b9c0bb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -338,9 +338,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 {
 	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
 	struct msi_desc *entry, *tmp;
-	struct attribute **msi_attrs;
-	struct device_attribute *dev_attr;
-	int i, count = 0;
+	int i;
 
 	for_each_pci_msi_entry(entry, dev)
 		if (entry->irq)
@@ -360,18 +358,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 	}
 
 	if (dev->msi_irq_groups) {
-		sysfs_remove_groups(&dev->dev.kobj, dev->msi_irq_groups);
-		msi_attrs = dev->msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr = container_of(msi_attrs[count],
-						struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(dev->msi_irq_groups[0]);
-		kfree(dev->msi_irq_groups);
+		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
 		dev->msi_irq_groups = NULL;
 	}
 }
@@ -452,102 +439,6 @@ void pci_restore_msi_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_restore_msi_state);
 
-static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct msi_desc *entry;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%s\n",
-			  entry->msi_attrib.is_msix ? "msix" : "msi");
-}
-
-static int populate_msi_sysfs(struct pci_dev *pdev)
-{
-	struct attribute **msi_attrs;
-	struct attribute *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	const struct attribute_group **msi_irq_groups;
-	struct msi_desc *entry;
-	int ret = -ENOMEM;
-	int num_msi = 0;
-	int count = 0;
-	int i;
-
-	/* Determine how many msi entries we have */
-	for_each_pci_msi_entry(entry, pdev)
-		num_msi += entry->nvec_used;
-	if (!num_msi)
-		return 0;
-
-	/* Dynamically create the MSI attributes for the PCI device */
-	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return -ENOMEM;
-	for_each_pci_msi_entry(entry, pdev) {
-		for (i = 0; i < entry->nvec_used; i++) {
-			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] = &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode = S_IRUGO;
-			msi_dev_attr->show = msi_mode_show;
-			++count;
-		}
-	}
-
-	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name = "msi_irqs";
-	msi_irq_group->attrs = msi_attrs;
-
-	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] = msi_irq_group;
-
-	ret = sysfs_create_groups(&pdev->dev.kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
-	pdev->msi_irq_groups = msi_irq_groups;
-
-	return 0;
-
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count = 0;
-	msi_attr = msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr = msi_attrs[count];
-	}
-	kfree(msi_attrs);
-	return ret;
-}
-
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -648,8 +539,9 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		return ret;
 	}
 
-	ret = populate_msi_sysfs(dev);
-	if (ret) {
+	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret = PTR_ERR(dev->msi_irq_groups);
 		msi_mask_irq(entry, mask, ~mask);
 		free_msi_irqs(dev);
 		return ret;
@@ -804,9 +696,11 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	msix_program_entries(dev, entries);
 
-	ret = populate_msi_sysfs(dev);
-	if (ret)
+	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret = PTR_ERR(dev->msi_irq_groups);
 		goto out_free;
+	}
 
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6aff469..375f1f9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -237,6 +237,10 @@ struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
+const struct attribute_group **msi_populate_sysfs(struct device *dev);
+void msi_destroy_sysfs(struct device *dev,
+		       const struct attribute_group **msi_irq_groups);
+
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e..f153bca 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include "internals.h"
 
@@ -69,6 +70,139 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct msi_desc *entry;
+	unsigned long irq;
+	int retval;
+	bool is_msix = false;
+
+	retval = kstrtoul(attr->attr.name, 10, &irq);
+	if (retval)
+		return retval;
+
+	entry = irq_get_msi_desc(irq);
+	if (!entry)
+		return -ENODEV;
+
+	if (dev_is_pci(dev))
+		is_msix = entry->msi_attrib.is_msix;
+
+	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+}
+
+/**
+ * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
+ * @dev:	The device(PCI, platform etc) who will get sysfs entries
+ *
+ * Return attribute_group ** so that specific bus MSI can save it to
+ * somewhere during initilizing msi irqs. If devices has no MSI irq,
+ * return NULL; if it fails to populate sysfs, return ERR_PTR
+ */
+const struct attribute_group **msi_populate_sysfs(struct device *dev)
+{
+	struct attribute **msi_attrs;
+	struct attribute *msi_attr;
+	struct device_attribute *msi_dev_attr;
+	struct attribute_group *msi_irq_group;
+	const struct attribute_group **msi_irq_groups;
+	struct msi_desc *entry;
+	int ret = -ENOMEM;
+	int num_msi = 0;
+	int count = 0;
+	int i;
+
+	/* Determine how many msi entries we have */
+	for_each_msi_entry(entry, dev)
+		num_msi += entry->nvec_used;
+	if (!num_msi)
+		return NULL;
+
+	/* Dynamically create the MSI attributes for the device */
+	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
+	if (!msi_attrs)
+		return ERR_PTR(-ENOMEM);
+	for_each_msi_entry(entry, dev) {
+		for (i = 0; i < entry->nvec_used; i++) {
+			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
+			if (!msi_dev_attr)
+				goto error_attrs;
+			msi_attrs[count] = &msi_dev_attr->attr;
+
+			sysfs_attr_init(&msi_dev_attr->attr);
+			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
+							    entry->irq + i);
+			if (!msi_dev_attr->attr.name)
+				goto error_attrs;
+			msi_dev_attr->attr.mode = 0444;
+			msi_dev_attr->show = msi_mode_show;
+			++count;
+		}
+	}
+
+	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
+	if (!msi_irq_group)
+		goto error_attrs;
+	msi_irq_group->name = "msi_irqs";
+	msi_irq_group->attrs = msi_attrs;
+
+	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
+	if (!msi_irq_groups)
+		goto error_irq_group;
+	msi_irq_groups[0] = msi_irq_group;
+
+	ret = sysfs_create_groups(&dev->kobj, msi_irq_groups);
+	if (ret)
+		goto error_irq_groups;
+
+	return msi_irq_groups;
+
+error_irq_groups:
+	kfree(msi_irq_groups);
+error_irq_group:
+	kfree(msi_irq_group);
+error_attrs:
+	count = 0;
+	msi_attr = msi_attrs[count];
+	while (msi_attr) {
+		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
+		kfree(msi_attr->name);
+		kfree(msi_dev_attr);
+		++count;
+		msi_attr = msi_attrs[count];
+	}
+	kfree(msi_attrs);
+	return ERR_PTR(ret);
+}
+
+/**
+ * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
+ * @dev:		The device(PCI, platform etc) who will remove sysfs entries
+ * @msi_irq_groups:	attribute_group for device msi_irqs entries
+ */
+void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
+{
+	struct attribute **msi_attrs;
+	struct device_attribute *dev_attr;
+	int count = 0;
+
+	if (msi_irq_groups) {
+		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+		msi_attrs = msi_irq_groups[0]->attrs;
+		while (msi_attrs[count]) {
+			dev_attr = container_of(msi_attrs[count],
+					struct device_attribute, attr);
+			kfree(dev_attr->attr.name);
+			kfree(dev_attr);
+			++count;
+		}
+		kfree(msi_attrs);
+		kfree(msi_irq_groups[0]);
+		kfree(msi_irq_groups);
+	}
+}
+
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
-- 
1.8.3.1


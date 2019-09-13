Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B53B16FF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfIMBOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMBOs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403715"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:47 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 6/7] ims-msi: Add APIs to allocate/free IMS interrupts
Date:   Thu, 12 Sep 2019 18:32:07 -0700
Message-Id: <1568338328-22458-7-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch introduces APIs to allocate and free IMS interrupts.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/base/ims-msi.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h    |   2 +
 2 files changed, 218 insertions(+)

diff --git a/drivers/base/ims-msi.c b/drivers/base/ims-msi.c
index df28ee2..3e579c9 100644
--- a/drivers/base/ims-msi.c
+++ b/drivers/base/ims-msi.c
@@ -7,9 +7,12 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 
+#define DEVIMS_ID_SHIFT        21
+
 struct dev_ims_priv_data {
 	struct device		*dev;
 	msi_alloc_info_t	arg;
@@ -17,6 +20,8 @@ struct dev_ims_priv_data {
 	struct dev_ims_ops	*ims_ops;
 };
 
+static DEFINE_IDA(dev_ims_devid_ida);
+
 u32 __dev_ims_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->dev_ims.masked;
@@ -126,3 +131,214 @@ void dev_ims_restore_irqs(struct device *dev)
 		if (entry->tag == IRQ_MSI_TAG_IMS)
 			dev_ims_restore_irq(dev, entry->irq);
 }
+
+static void dev_ims_free_descs(struct device *dev)
+{
+	struct msi_desc *desc, *tmp;
+
+	for_each_msi_entry(desc, dev)
+		if (desc->irq && desc->tag == IRQ_MSI_TAG_IMS)
+			BUG_ON(irq_has_action(desc->irq));
+
+	dev_ims_teardown_irqs(dev);
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		if (desc->tag == IRQ_MSI_TAG_IMS) {
+			list_del(&desc->list);
+			free_msi_entry(desc);
+		}
+	}
+}
+
+static int dev_ims_setup_msi_irqs(struct device *dev, int nvec)
+{
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(dev);
+	if (domain && irq_domain_is_hierarchy(domain))
+		return msi_domain_alloc_irqs(domain, dev, nvec);
+
+	return arch_setup_ims_irqs(dev, nvec);
+}
+
+static struct dev_ims_priv_data *
+dev_ims_alloc_priv_data(struct device *dev, unsigned int nvec,
+			struct dev_ims_ops *ops)
+{
+	struct dev_ims_priv_data *datap;
+	int ret;
+
+	/*
+	 * Currently there is no limit to the number of IRQs a device can
+	 * allocate.
+	 */
+	if (!nvec)
+		return ERR_PTR(-EINVAL);
+
+	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
+	if (!datap)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_simple_get(&dev_ims_devid_ida,
+				0, 1 << DEVIMS_ID_SHIFT, GFP_KERNEL);
+
+	if (ret < 0) {
+		kfree(datap);
+		return ERR_PTR(ret);
+	}
+
+	datap->devid = ret;
+	datap->ims_ops = ops;
+	datap->dev = dev;
+
+	return datap;
+}
+
+static int dev_ims_alloc_descs(struct device *dev,
+			       int nvec, struct dev_ims_priv_data *data,
+			       struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *curmsk, *masks = NULL;
+	struct msi_desc *desc;
+	int i, base = 0;
+
+	if (!list_empty(dev_to_msi_list(dev))) {
+		desc = list_last_entry(dev_to_msi_list(dev),
+					struct msi_desc, list);
+		base = desc->dev_ims.ims_index + 1;
+	}
+
+	if (affd) {
+		masks = irq_create_affinity_masks(nvec, affd);
+		if (!masks)
+			dev_err(dev, "Unable to allocate affinity masks, ignoring\n");
+	}
+
+	for (i = 0, curmsk = masks; i < nvec; i++) {
+		desc = alloc_msi_entry(dev, 1, NULL);
+		if (!desc)
+			break;
+
+		desc->dev_ims.priv = data;
+		desc->tag = IRQ_MSI_TAG_IMS;
+		desc->dev_ims.ims_index = base + i;
+
+		list_add_tail(&desc->list, dev_to_msi_list(dev));
+
+		if (masks)
+			curmsk++;
+	}
+
+	kfree(masks);
+
+	if (i != nvec) {
+		/* Clean up the mess */
+		dev_ims_free_descs(dev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void dev_ims_free_priv_data(struct dev_ims_priv_data *data)
+{
+	ida_simple_remove(&dev_ims_devid_ida, data->devid);
+	kfree(data);
+}
+
+/**
+ * dev_ims_enable_irqs - Allocate IMS interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @ops:		IMS device operations
+ * @affd:		optional description of the affinity requirements
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ */
+int dev_ims_enable_irqs(struct device *dev, unsigned int nvec,
+			struct dev_ims_ops *ops,
+			struct irq_affinity *affd)
+{
+	struct dev_ims_priv_data *priv_data;
+	int err;
+
+	priv_data = dev_ims_alloc_priv_data(dev, nvec, ops);
+	if (IS_ERR(priv_data))
+		return PTR_ERR(priv_data);
+
+	err = dev_ims_alloc_descs(dev, nvec, priv_data, affd);
+	if (err)
+		goto out_free_priv_data;
+
+	err = dev_ims_setup_msi_irqs(dev, nvec);
+	if (err)
+		goto out_free_desc;
+
+	return 0;
+
+out_free_desc:
+	dev_ims_free_descs(dev);
+out_free_priv_data:
+	dev_ims_free_priv_data(priv_data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_ims_enable_irqs);
+
+int __dev_ims_alloc_irqs(struct device *dev, int nvec,
+			 struct dev_ims_ops *ops,
+			 struct irq_affinity *affd)
+{
+	int nvec1;
+	int rc;
+
+	for (;;) {
+		if (affd) {
+			nvec1 = irq_calc_affinity_vectors(nvec, nvec, affd);
+			if (nvec < nvec1)
+				return -ENOSPC;
+		}
+
+		rc = dev_ims_enable_irqs(dev, nvec, ops, affd);
+		if (rc == 0)
+			return nvec;
+
+		if (rc < 0)
+			return rc;
+		if (rc < nvec)
+			return -ENOSPC;
+
+		nvec = rc;
+	}
+}
+
+/**
+ * dev_ims_alloc_irqs - Alloc IMS interrupts for @dev
+ * @dev:	The device for which to allocate interrupts
+ * @nvec:	The number of interrupts to allocate
+ * @ops:	IMS device operations
+ */
+int dev_ims_alloc_irqs(struct device *dev, int nvec, struct dev_ims_ops *ops)
+{
+	return __dev_ims_alloc_irqs(dev, nvec, ops, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_ims_alloc_irqs);
+
+/**
+ * dev_ims_domain_free_irqs - Free IMS interrupts for @dev
+ * @dev:	The device for which to free interrupts
+ */
+void dev_ims_free_irqs(struct device *dev)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev)
+		if (desc->tag == IRQ_MSI_TAG_IMS) {
+			dev_ims_free_priv_data(desc->dev_ims.priv);
+			break;
+	}
+
+	dev_ims_free_descs(dev);
+}
+EXPORT_SYMBOL_GPL(dev_ims_free_irqs);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 37070bf..4543bbf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -235,6 +235,8 @@ void dev_ims_mask_irq(struct irq_data *data);
 void dev_ims_write_msg(struct irq_data *data, struct msi_msg *msg);
 void dev_ims_teardown_irqs(struct device *dev);
 void dev_ims_restore_irqs(struct device *dev);
+int dev_ims_alloc_irqs(struct device *dev, int nvec, struct dev_ims_ops *ops);
+void dev_ims_free_irqs(struct device *dev);
 
 /*
  * The arch hooks to setup up msi irqs. Those functions are
-- 
2.7.4


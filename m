Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6220BB16FB
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfIMBOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMBOo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403699"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:43 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 2/7] drivers/base: Introduce callbacks for IMS interrupt domain
Date:   Thu, 12 Sep 2019 18:32:03 -0700
Message-Id: <1568338328-22458-3-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch serves as a preparatory patch to introduce a new IMS
(Interrupt Message Store) domain. It consists of APIs which would
be used as callbacks to the IRQ chip associated with the IMS domain.

The APIs introduced in this patch are:
dev_ims_mask_irq - Generic irq chip callback to mask IMS interrupts
dev_ims_unmask_irq - Generic irq chip callback to unmask IMS interrupts
dev_ims_domain_write_msg - Helper to write MSI message to Device IMS

It also introduces IMS specific structures namely:
dev_ims_ops - Callbacks for IMS domain ops
dev_ims_desc - Device specific IMS msi descriptor data
dev_ims_priv_data - Internal data structure containing a unique devid
and a pointer to the IMS domain ops

Lastly, it adds a new config option MSI_IMS which must be enabled by
any driver who would want to use the IMS infrastructure.

Since IMS is not PCI compliant (like platform-msi), most of the code is
similar to platform-msi.c.

TODO: Conclude if ims-msi.c and platform-msi.c can be merged.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/base/Kconfig   |  7 ++++
 drivers/base/Makefile  |  1 +
 drivers/base/ims-msi.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h    | 35 ++++++++++++++++++-
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/ims-msi.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index dc40449..038fabd 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -206,3 +206,10 @@ config GENERIC_ARCH_TOPOLOGY
 	  runtime.
 
 endmenu
+
+config MSI_IMS
+	bool "Device Specific Interrupt Message Storage (IMS)"
+	select GENERIC_MSI_IRQ
+	help
+	  This allows device drivers to enable device specific
+	  interrupt message storage (IMS) besides standard MSI-X interrupts.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 1574520..659b9b0 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
+obj-$(CONFIG_MSI_IMS) += ims-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 
 obj-y			+= test/
diff --git a/drivers/base/ims-msi.c b/drivers/base/ims-msi.c
new file mode 100644
index 0000000..68dc10f
--- /dev/null
+++ b/drivers/base/ims-msi.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2019 Intel Corporation.
+ *
+ * Author: Megha Dey <megha.dey@intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+
+struct dev_ims_priv_data {
+	struct device		*dev;
+	msi_alloc_info_t	arg;
+	int			devid;
+	struct dev_ims_ops	*ims_ops;
+};
+
+u32 __dev_ims_desc_mask_irq(struct msi_desc *desc, u32 flag)
+{
+	u32 mask_bits = desc->dev_ims.masked;
+	struct dev_ims_ops *ops;
+
+	ops = desc->dev_ims.priv->ims_ops;
+	if (!ops)
+		return 0;
+
+	if (flag) {
+		if (ops->irq_mask)
+			mask_bits = ops->irq_mask(desc);
+	} else {
+		if (ops->irq_unmask)
+			mask_bits = ops->irq_unmask(desc);
+	}
+
+	return mask_bits;
+}
+
+static void ims_mask_irq(struct msi_desc *desc, u32 flag)
+{
+	desc->dev_ims.masked = __dev_ims_desc_mask_irq(desc, flag);
+}
+
+static void ims_set_mask_bit(struct irq_data *data, u32 flag)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	ims_mask_irq(desc, flag);
+}
+
+static void __dev_write_ims_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct dev_ims_ops *ops;
+
+	ops = desc->dev_ims.priv->ims_ops;
+	if (ops && ops->irq_write_msi_msg)
+		ops->irq_write_msi_msg(desc, msg);
+
+	desc->msg = *msg;
+}
+
+/**
+ * dev_ims_mask_irq - Generic irq chip callback to mask IMS interrupts
+ * @data: pointer to irqdata associated to that interrupt
+ */
+void dev_ims_mask_irq(struct irq_data *data)
+{
+	ims_set_mask_bit(data, 1);
+}
+EXPORT_SYMBOL_GPL(dev_ims_mask_irq);
+
+/**
+ * dev_msi_unmask_irq - Generic irq chip callback to unmask IMS interrupts
+ * @data: pointer to irqdata associated to that interrupt
+ */
+void dev_ims_unmask_irq(struct irq_data *data)
+{
+	ims_set_mask_bit(data, 0);
+}
+EXPORT_SYMBOL_GPL(dev_ims_unmask_irq);
+
+/**
+ * dev_ims_write_msg - Helper to write MSI message to Device IMS
+ * @irq_data: Pointer to interrupt data of the MSI interrupt
+ * @msg:      Pointer to the message
+ */
+void dev_ims_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	__dev_write_ims_msg(desc, msg);
+}
+EXPORT_SYMBOL_GPL(dev_ims_write_msg);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 22591b6..246285a 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -17,6 +17,7 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
+struct dev_ims_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -40,6 +41,31 @@ struct platform_msi_desc {
 };
 
 /**
+ * dev_ims_ops - Callbacks for IMS domain ops
+ * @irq_mask:		mask an interrupt source
+ * @irq_unmask:		unmask an interrupt source
+ * @irq_write_msi_msg:	write message content
+ */
+struct dev_ims_ops {
+	unsigned int	(*irq_mask)(struct msi_desc *desc);
+	unsigned int	(*irq_unmask)(struct msi_desc *desc);
+	void		(*irq_write_msi_msg)(struct msi_desc *desc,
+						struct msi_msg *msg);
+};
+
+/**
+ * dev_ims_desc - Device specific interrupt message storage msi desc data
+ * @ims_priv_data:	Pointer to device private data
+ * @ims_index:		The index of the MSI descriptor
+ * @masked:		mask bits
+ */
+struct dev_ims_desc {
+	struct dev_ims_priv_data	*priv;
+	u16				ims_index;
+	u32				masked;
+};
+
+/**
  * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
  * @msi_index:		The index of the MSI descriptor
  */
@@ -90,6 +116,7 @@ enum msi_desc_tags {
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
+ * @dev_ims:	[dev_ims]   Device specific IMS msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -136,6 +163,7 @@ struct msi_desc {
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
 		struct ti_sci_inta_msi_desc inta;
+		struct dev_ims_desc dev_ims;
 	};
 };
 
@@ -180,6 +208,7 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
+
 #else /* CONFIG_PCI_MSI */
 static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
@@ -201,6 +230,10 @@ u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
+void dev_ims_unmask_irq(struct irq_data *data);
+void dev_ims_mask_irq(struct irq_data *data);
+void dev_ims_write_msg(struct irq_data *data, struct msi_msg *msg);
+
 /*
  * The arch hooks to setup up msi irqs. Those functions are
  * implemented as weak symbols so that they /can/ be overriden by
@@ -228,7 +261,7 @@ struct msi_controller {
 	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
 };
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#if defined(CONFIG_GENERIC_MSI_IRQ_DOMAIN) || defined(CONFIG_MSI_IMS)
 
 #include <linux/irqhandler.h>
 #include <asm/msi.h>
-- 
2.7.4


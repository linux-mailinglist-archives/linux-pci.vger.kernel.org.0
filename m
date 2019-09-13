Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68260B1702
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfIMBO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfIMBOr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403712"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:46 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 5/7] x86/ims: Introduce x86_ims_ops
Date:   Thu, 12 Sep 2019 18:32:06 -0700
Message-Id: <1568338328-22458-6-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch introduces an x86 specific indirect mechanism to setup the
interrupt message storage. The IMS specific functions (setup, teardown,
restore) become function pointers in an x86_ims_ops struct, that
defaults to their implementations in ims.c and ims-msi.c.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/include/asm/pci.h      |  4 ++++
 arch/x86/include/asm/x86_init.h | 10 ++++++++++
 arch/x86/kernel/apic/ims.c      | 18 ++++++++++++++++++
 arch/x86/kernel/x86_init.c      | 23 +++++++++++++++++++++++
 drivers/base/ims-msi.c          | 34 ++++++++++++++++++++++++++++++++++
 include/linux/msi.h             |  6 ++++++
 6 files changed, 95 insertions(+)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f98..2ef513f 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -114,6 +114,10 @@ struct msi_desc;
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void native_teardown_msi_irq(unsigned int irq);
 void native_restore_msi_irqs(struct pci_dev *dev);
+#ifdef CONFIG_MSI_IMS
+int native_setup_ims_irqs(struct device *dev, int nvec);
+#endif
+
 #else
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ac09341..9c2cbbb 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -287,6 +287,15 @@ struct x86_msi_ops {
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
+struct device;
+
+struct x86_ims_ops {
+	int (*setup_ims_irqs)(struct device *dev, int nvec);
+	void (*teardown_ims_irq)(unsigned int irq);
+	void (*teardown_ims_irqs)(struct device *dev);
+	void (*restore_ims_irqs)(struct device *dev);
+};
+
 struct x86_apic_ops {
 	unsigned int	(*io_apic_read)   (unsigned int apic, unsigned int reg);
 	void		(*restore)(void);
@@ -297,6 +306,7 @@ extern struct x86_cpuinit_ops x86_cpuinit;
 extern struct x86_platform_ops x86_platform;
 extern struct x86_msi_ops x86_msi;
 extern struct x86_apic_ops x86_apic_ops;
+extern struct x86_ims_ops x86_ims;
 
 extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
diff --git a/arch/x86/kernel/apic/ims.c b/arch/x86/kernel/apic/ims.c
index d9808a5..a539666 100644
--- a/arch/x86/kernel/apic/ims.c
+++ b/arch/x86/kernel/apic/ims.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/mdev.h>
 #include <linux/pci.h>
+#include <asm/irq_remapping.h>
 
 /*
  * Determine if a dev is mdev or not. Return NULL if not mdev device.
@@ -45,6 +46,23 @@ static struct pci_dev *ims_get_pci_dev(struct device *dev)
 	return pdev;
 }
 
+int native_setup_ims_irqs(struct device *dev, int nvec)
+{
+	struct irq_domain *domain;
+	struct irq_alloc_info info;
+	struct pci_dev *pdev = ims_get_pci_dev(dev);
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_MSIX;
+	info.msi_dev = pdev;
+
+	domain = irq_remapping_get_ims_irq_domain(&info);
+	if (!domain)
+		return -ENOSYS;
+
+	return msi_domain_alloc_irqs(domain, dev, nvec);
+}
+
 int dev_ims_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1bef687..3ce42d4 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -153,6 +153,29 @@ void arch_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
+#if defined(CONFIG_MSI_IMS)
+struct x86_ims_ops x86_ims __ro_after_init = {
+	.setup_ims_irqs		= native_setup_ims_irqs,
+	.teardown_ims_irqs	= dev_ims_teardown_irqs,
+	.restore_ims_irqs	= dev_ims_restore_irqs,
+};
+
+int arch_setup_ims_irqs(struct device *dev, int nvec)
+{
+	return x86_ims.setup_ims_irqs(dev, nvec);
+}
+
+void arch_teardown_ims_irqs(struct device *dev)
+{
+	x86_ims.teardown_ims_irqs(dev);
+}
+
+void arch_restore_ims_irqs(struct device *dev)
+{
+	x86_ims.restore_ims_irqs(dev);
+}
+#endif
+
 struct x86_apic_ops x86_apic_ops __ro_after_init = {
 	.io_apic_read	= native_io_apic_read,
 	.restore	= native_restore_boot_irq_mode,
diff --git a/drivers/base/ims-msi.c b/drivers/base/ims-msi.c
index 68dc10f..df28ee2 100644
--- a/drivers/base/ims-msi.c
+++ b/drivers/base/ims-msi.c
@@ -92,3 +92,37 @@ void dev_ims_write_msg(struct irq_data *data, struct msi_msg *msg)
 	__dev_write_ims_msg(desc, msg);
 }
 EXPORT_SYMBOL_GPL(dev_ims_write_msg);
+
+void dev_ims_teardown_irqs(struct device *dev)
+{
+	struct msi_desc *entry;
+
+	for_each_msi_entry(entry, dev)
+		if (entry->irq && entry->tag == IRQ_MSI_TAG_IMS)
+			arch_teardown_msi_irq(entry->irq);
+}
+
+static void dev_ims_restore_irq(struct device *dev, int irq)
+{
+	struct msi_desc *entry = NULL;
+	struct dev_ims_ops *ops;
+
+	for_each_msi_entry(entry, dev)
+		if (irq == entry->irq && entry->tag == IRQ_MSI_TAG_IMS)
+			break;
+
+	if (entry) {
+		ops = entry->dev_ims.priv->ims_ops;
+		if (ops && ops->irq_write_msi_msg)
+			ops->irq_write_msi_msg(entry, &entry->msg);
+	}
+}
+
+void dev_ims_restore_irqs(struct device *dev)
+{
+	struct msi_desc *entry;
+
+	for_each_msi_entry(entry, dev)
+		if (entry->tag == IRQ_MSI_TAG_IMS)
+			dev_ims_restore_irq(dev, entry->irq);
+}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 246285a..37070bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -233,6 +233,8 @@ void pci_msi_unmask_irq(struct irq_data *data);
 void dev_ims_unmask_irq(struct irq_data *data);
 void dev_ims_mask_irq(struct irq_data *data);
 void dev_ims_write_msg(struct irq_data *data, struct msi_msg *msg);
+void dev_ims_teardown_irqs(struct device *dev);
+void dev_ims_restore_irqs(struct device *dev);
 
 /*
  * The arch hooks to setup up msi irqs. Those functions are
@@ -245,6 +247,10 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
 void arch_restore_msi_irqs(struct pci_dev *dev);
 
+int arch_setup_ims_irqs(struct device *dev, int nvec);
+void arch_teardown_ims_irqs(struct device *dev);
+void arch_restore_ims_irqs(struct device *dev);
+
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
-- 
2.7.4


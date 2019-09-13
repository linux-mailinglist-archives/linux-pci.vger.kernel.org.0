Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A8B1701
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfIMBOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMBOt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403719"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:48 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [RFC V1 7/7] ims: Add the set_desc callback
Date:   Thu, 12 Sep 2019 18:32:08 -0700
Message-Id: <1568338328-22458-8-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the set_desc callback to the ims domain ops.

The set_desc callback is used to find a unique hwirq number from a given
domain.

Each mdev can have a maximum of 2048 IMS interrupts.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 arch/x86/kernel/apic/ims.c | 7 +++++++
 drivers/base/ims-msi.c     | 9 +++++++++
 include/linux/msi.h        | 1 +
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/apic/ims.c b/arch/x86/kernel/apic/ims.c
index a539666..7e36571 100644
--- a/arch/x86/kernel/apic/ims.c
+++ b/arch/x86/kernel/apic/ims.c
@@ -76,11 +76,18 @@ int dev_ims_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 }
 EXPORT_SYMBOL_GPL(dev_ims_prepare);
 
+void dev_ims_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->msi_hwirq = dev_ims_calc_hwirq(desc);
+}
+EXPORT_SYMBOL_GPL(dev_ims_set_desc);
+
 #ifdef CONFIG_IRQ_REMAP
 
 static struct msi_domain_ops dev_ims_domain_ops = {
 	.get_hwirq	= msi_get_hwirq,
 	.msi_prepare	= dev_ims_prepare,
+	.set_desc       = dev_ims_set_desc,
 };
 
 static struct irq_chip dev_ims_ir_controller = {
diff --git a/drivers/base/ims-msi.c b/drivers/base/ims-msi.c
index 3e579c9..48f3d24 100644
--- a/drivers/base/ims-msi.c
+++ b/drivers/base/ims-msi.c
@@ -22,6 +22,15 @@ struct dev_ims_priv_data {
 
 static DEFINE_IDA(dev_ims_devid_ida);
 
+irq_hw_number_t dev_ims_calc_hwirq(struct msi_desc *desc)
+{
+	u32 devid;
+
+	devid = desc->dev_ims.priv->devid;
+
+	return (devid << (32 - DEVIMS_ID_SHIFT)) | desc->dev_ims.ims_index;
+}
+
 u32 __dev_ims_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->dev_ims.masked;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4543bbf..fe4678e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -237,6 +237,7 @@ void dev_ims_teardown_irqs(struct device *dev);
 void dev_ims_restore_irqs(struct device *dev);
 int dev_ims_alloc_irqs(struct device *dev, int nvec, struct dev_ims_ops *ops);
 void dev_ims_free_irqs(struct device *dev);
+irq_hw_number_t dev_ims_calc_hwirq(struct msi_desc *desc);
 
 /*
  * The arch hooks to setup up msi irqs. Those functions are
-- 
2.7.4


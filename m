Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05D141422
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAQWag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:30:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:34039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgAQWaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:33 -0800
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="219052229"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:32 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 7/7] x86/PCI: Remove X86_DEV_DMA_OPS
Date:   Fri, 17 Jan 2020 09:27:29 -0700
Message-Id: <1579278449-174098-8-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

There are no users of X86_DEV_DMA_OPS left, so remove the code.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/Kconfig              |  3 ---
 arch/x86/include/asm/device.h | 10 ----------
 arch/x86/pci/common.c         | 38 --------------------------------------
 3 files changed, 51 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..77f9426 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2955,9 +2955,6 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
-config X86_DEV_DMA_OPS
-	bool
-
 source "drivers/firmware/Kconfig"
 
 source "arch/x86/kvm/Kconfig"
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 5e12c63..7e31f7f 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -8,16 +8,6 @@ struct dev_archdata {
 #endif
 };
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-struct dma_domain {
-	struct list_head node;
-	const struct dma_map_ops *dma_ops;
-	int domain_nr;
-};
-void add_dma_domain(struct dma_domain *domain);
-void del_dma_domain(struct dma_domain *domain);
-#endif
-
 struct pdev_archdata {
 };
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index fe21a5c..df1d959 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -625,43 +625,6 @@ unsigned int pcibios_assign_all_busses(void)
 	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
 }
 
-#if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-static LIST_HEAD(dma_domain_list);
-static DEFINE_SPINLOCK(dma_domain_list_lock);
-
-void add_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_add(&domain->node, &dma_domain_list);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(add_dma_domain);
-
-void del_dma_domain(struct dma_domain *domain)
-{
-	spin_lock(&dma_domain_list_lock);
-	list_del(&domain->node);
-	spin_unlock(&dma_domain_list_lock);
-}
-EXPORT_SYMBOL_GPL(del_dma_domain);
-
-static void set_dma_domain_ops(struct pci_dev *pdev)
-{
-	struct dma_domain *domain;
-
-	spin_lock(&dma_domain_list_lock);
-	list_for_each_entry(domain, &dma_domain_list, node) {
-		if (pci_domain_nr(pdev->bus) == domain->domain_nr) {
-			pdev->dev.dma_ops = domain->dma_ops;
-			break;
-		}
-	}
-	spin_unlock(&dma_domain_list_lock);
-}
-#else
-static void set_dma_domain_ops(struct pci_dev *pdev) {}
-#endif
-
 static void set_dev_domain_options(struct pci_dev *pdev)
 {
 	if (is_vmd(pdev->bus))
@@ -697,7 +660,6 @@ int pcibios_add_device(struct pci_dev *dev)
 		pa_data = data->next;
 		memunmap(data);
 	}
-	set_dma_domain_ops(dev);
 	set_dev_domain_options(dev);
 	return 0;
 }
-- 
1.8.3.1


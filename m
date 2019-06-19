Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3E4C32E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfFSVlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:41:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:10385 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfFSVlo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:41:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="170683453"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2019 14:41:43 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com, Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 1/6] PCI/MSI: New structures/macros for dynamic MSI-X allocation
Date:   Wed, 19 Jun 2019 15:03:39 -0700
Message-Id: <1560981824-3966-2-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
References: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a preparatory patch to introduce the dynamic allocation of
MSI-X vectors. In this patch, we add new structure members and macros
which will be consumed by the API that will dynamically allocate
MSI-X vectors.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 include/linux/device.h | 3 +++
 include/linux/msi.h    | 9 +++++++++
 include/linux/pci.h    | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 848fc71..99d4951 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -967,6 +967,7 @@ struct dev_links_info {
  *              device.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @grp_first_desc: Pointer to the first msi_desc in every MSI-X group
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -1062,6 +1063,8 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+	/* For dynamic MSI-X allocation */
+	struct msi_desc		*grp_first_desc;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index d48e919..91273cd 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -74,6 +74,7 @@ struct ti_sci_inta_msi_desc {
  * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
  * @mask_pos:	[PCI MSI]   Mask register position
  * @mask_base:	[PCI MSI-X] Mask register base address
+ * @group_id:	[PCI MSI-X] group to which this descriptor belongs
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
@@ -107,6 +108,7 @@ struct msi_desc {
 				u8	mask_pos;
 				void __iomem *mask_base;
 			};
+			unsigned int	group_id;
 		};
 
 		/*
@@ -131,6 +133,10 @@ struct msi_desc {
 	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
+/* Iterate through MSI entries of device dev starting from a given desc */
+#define for_each_msi_entry_from(desc, dev)				\
+	desc = (*dev).grp_first_desc;					\
+	list_for_each_entry_from((desc), dev_to_msi_list((dev)), list)	\
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
@@ -159,6 +165,9 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
 	for_each_msi_entry((desc), &(pdev)->dev)
+/* Iterate through PCI-MSI entries of pdev starting from a given desc */
+#define for_each_pci_msi_entry_from(desc, pdev)        \
+	for_each_msi_entry_from((desc), &(pdev)->dev)
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da..b9a1d41 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -465,6 +465,12 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	/* For dynamic MSI-X allocation */
+	unsigned int	num_msix;	/* Number of MSI-X vectors supported */
+	void __iomem	*base;		/* Holds base address of MSI-X table */
+	struct idr	*grp_idr;       /* IDR to assign group to MSI-X vecs */
+	unsigned long	*entry;         /* Bitmap to represent MSI-X entries */
+	bool		one_shot;	/* If true, oneshot MSI-X allocation */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.7.4


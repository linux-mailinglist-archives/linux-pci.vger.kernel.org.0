Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4272322B9C1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 00:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGWWhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 18:37:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:61893 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgGWWhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 18:37:33 -0400
IronPort-SDR: uYU1abVSkjql+DCz576wkVhPpEXy8JIXAHBpJPFauwq7WzxAkHQG1wMzGA6bWqbQsivE2lllVL
 NPQnajQOAY4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148553145"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="148553145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:37:32 -0700
IronPort-SDR: EY9s5rW5U1aQy5GNQAR9ZgvrDr76Axq9ss9gxITH1EAgoJHJ+6EbSpbf8LmFYkpNc8X3sUts6d
 rG4eADnva0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="272425639"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 15:37:32 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v3 1/1] PCI/ATS: Check PRI supported on the PF device when SRIOV is enabled
Date:   Thu, 23 Jul 2020 15:37:29 -0700
Message-Id: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PASID and PRI capabilities are only enumerated in PF devices. VF devices
do not enumerate these capabilites. IOMMU drivers also need to enumerate
them before enabling features in the IOMMU. Extending the same support as
PASID feature discovery (pci_pasid_features) for PRI.

Fixes: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

To: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <joro@8bytes.com>
To: Lu Baolu <baolu.lu@intel.com>
Cc: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: iommu@lists.linux-foundation.org
---
v3: Added Fixes tag
v2: Fixed build failure reported from lkp when CONFIG_PRI=n

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/pci/ats.c           | 13 +++++++++++++
 include/linux/pci-ats.h     |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..276452f5e6a7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2560,7 +2560,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
+			    pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b761c1f72f67..2e6cf0c700f7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -325,6 +325,19 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+
+/**
+ * pci_pri_supported - Check if PRI is supported.
+ * @pdev: PCI device structure
+ *
+ * Returns true if PRI capability is present, false otherwise.
+ */
+bool pci_pri_supported(struct pci_dev *pdev)
+{
+	/* VFs share the PF PRI configuration */
+	return !!(pci_physfn(pdev)->pri_cap);
+}
+EXPORT_SYMBOL_GPL(pci_pri_supported);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346d..df54cd5b15db 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,10 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+bool pci_pri_supported(struct pci_dev *pdev);
+#else
+static inline bool pci_pri_supported(struct pci_dev *pdev)
+{ return false; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.7.4


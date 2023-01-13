Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F78668944
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 02:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjAMBwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 20:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbjAMBwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 20:52:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004056144B;
        Thu, 12 Jan 2023 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673574730; x=1705110730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fB0iGXDWuyL8rchNy46SKRF6kk1f2kOIhvmNTUPvuVY=;
  b=UyEuHR+uQ3a49y2VOXIc/aE0oHK4D2zxYR1Qft5PtmPKwTutkDakiKzt
   imw4MORxSyetpHz26APCEV80a17LOBT0rxdECcJn72X3PLlW1xwJBO4zj
   M29ehhOJuigulUgkcCjCUK3EIMNxiyKkQ1DGdy3MYej5Upq4WKdBb4hQy
   zPM6wEw+h8riqc3EBOl4VH/s7sf12MhU/LTSroW1LVRUCMSQ1BxvJU8mM
   qSNyaq0e+I8zBaq/Df9xn4Q/jLobLo8x+yxaZmeIXzL25UQ27OYNJ3nRa
   23JVWrd5OM8k/EQOC2btFtRF86Mt1db8lTZSDPePBesP5ng7WK1n39gdn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="311742622"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="311742622"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="658060007"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="658060007"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 17:52:05 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: [PATCH v2 1/1] PCI: Add translated request only flag for pci_enable_pasid()
Date:   Fri, 13 Jan 2023 09:44:09 +0800
Message-Id: <20230113014409.752405-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe fabric routes Memory Requests based on the TLP address, ignoring
the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
Enable PASID only when ACS RR & UF enabled on upstream path") requires
some ACS features being supported on device's upstream path when enabling
PCI/PASID.

One alternative is ATS which lets the device resolve the PASID+addr pair
before a memory request is made into a routeable TLB address through the
TA. Those resolved addresses are then cached on the device instead of
in the IOMMU TLB and the device always sets the translated bit for PASID.
One example of those devices are AMD graphic devices that always have ACS
or ATS enabled together with PASID.

This adds a flag parameter in the pci_enable_pasid() helper, with which
the device driver could opt-in the fact that device always sets the
translated bit for PASID.

It also applies this opt-in for AMD graphic devices. Without this change,
kernel boots to black screen on a system with below AMD graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
        [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
        (prog-if 00 [VGA controller])
	DeviceName: ATI EG BROADWAY
	Subsystem: Hewlett-Packard Company Device 8332

At present, it is a common practice to enable/disable PCI PASID in the
iommu drivers. Considering that the device driver knows more about the
specific device, we will follow up by moving pci_enable_pasid() into
the specific device drivers.

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci-ats.h                     | 6 ++++--
 drivers/iommu/amd/iommu.c                   | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/intel/iommu.c                 | 3 ++-
 drivers/pci/ats.c                           | 8 ++++++--
 5 files changed, 14 insertions(+), 7 deletions(-)

Change log:
v2:
 - Convert the bool to a named flag;
 - Convert TRANSLED to XLATED.

v1:
 - https://lore.kernel.org/linux-iommu/20230112084629.737653-1-baolu.lu@linux.intel.com/

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..750fca736ef4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+#define PCI_PASID_XLATED_REQ_ONLY	BIT(0)
+
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 bool pci_ats_supported(struct pci_dev *dev);
@@ -35,12 +37,12 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-int pci_enable_pasid(struct pci_dev *pdev, int features);
+int pci_enable_pasid(struct pci_dev *pdev, int features, int flags);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features, int flags)
 { return -EINVAL; }
 static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..64a8c03d7dfa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1700,7 +1700,7 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	int ret;
 
 	/* Only allow access to user-accessible pages */
-	ret = pci_enable_pasid(pdev, 0);
+	ret = pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY);
 	if (ret)
 		goto out_err;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..891bf53c45dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2350,7 +2350,7 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	if (num_pasids <= 0)
 		return num_pasids;
 
-	ret = pci_enable_pasid(pdev, features);
+	ret = pci_enable_pasid(pdev, features, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable PASID\n");
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..5cc13f02a5ac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1425,7 +1425,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	   undefined. So always enable PASID support on devices which
 	   have it, even if we can't yet know if we're ever going to
 	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1, 0))
 		info->pasid_enabled = 1;
 
 	if (info->pri_supported &&
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..3a2d9e0ba1d8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
  * @features: Features to enable
+ * @flags: device-specific flags
+ *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device only issues PASID
+ *                                memory requests of translated type.
  *
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
  */
-int pci_enable_pasid(struct pci_dev *pdev, int features)
+int pci_enable_pasid(struct pci_dev *pdev, int features, int flags)
 {
 	u16 control, supported;
 	int pasid = pdev->pasid_cap;
@@ -382,7 +385,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+	if (!(flags & PCI_PASID_XLATED_REQ_ONLY) &&
+	    !pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
-- 
2.34.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD695666D1C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjALI4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 03:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjALIzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 03:55:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C56392FD;
        Thu, 12 Jan 2023 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513665; x=1705049665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbZLbVJ1FtTUzxWrLWMc69Y2p0n8V6X7/TxYZupX72g=;
  b=fG7IJCaoqRs8oL5EaezhfA4EboiA/bTrFgK8DUqzwvvfDvAr/HdoNsOh
   pDAESPi/xQIssXvuVcbK77MefMFKoqDX2h6vRzqqpJaYTuII65hZJfV8v
   sGSgeq155oIphuT/XeQaI6v8hxzMUUZ/vIW36JBhmN1ogxVkhQPinA75R
   hm5a8fIFuNJp+eExe6v6zEWfHisBN7wtrQWNiykFMRZh/mWc7p7fSkuoY
   FTLMKsLns9OQbbBwHK8GJtsPy/yVECWV7cPySzZ+hTPgeqzBv8jzohv+o
   pLob8cwJzQAxlaAawc45oNKkjcUqJ5cPUsVreBUYm+pec5/DFitzv99Ea
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303349657"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303349657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765526296"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="765526296"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2023 00:54:22 -0800
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
Subject: [PATCH 1/1] PCI: Add translated request only opt-in for pci_enable_pasid()
Date:   Thu, 12 Jan 2023 16:46:29 +0800
Message-Id: <20230112084629.737653-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

This adds an extra parameter in the pci_enable_pasid() helper, with which
the device driver could opt-in the fact that device always sets the
translated bit for PASID.

It also applies this opt-in for AMD graphic devices. Without this change,
kernel boots to black screen on a system with below AMD graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
        [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
        (prog-if 00 [VGA controller])
	DeviceName: ATI EG BROADWAY
	Subsystem: Hewlett-Packard Company Device 8332

Refer to kernel bugzilla through below link for more details.

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci-ats.h                     | 5 +++--
 drivers/iommu/amd/iommu.c                   | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 drivers/iommu/intel/iommu.c                 | 3 ++-
 drivers/pci/ats.c                           | 7 +++++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index df54cd5b15db..78a37821fff4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -35,12 +35,13 @@ static inline bool pci_pri_supported(struct pci_dev *pdev)
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-int pci_enable_pasid(struct pci_dev *pdev, int features);
+int pci_enable_pasid(struct pci_dev *pdev, int features, bool transled_only);
 void pci_disable_pasid(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
+static inline int pci_enable_pasid(struct pci_dev *pdev, int features,
+				   bool transled_only)
 { return -EINVAL; }
 static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..a89734b30947 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1700,7 +1700,7 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	int ret;
 
 	/* Only allow access to user-accessible pages */
-	ret = pci_enable_pasid(pdev, 0);
+	ret = pci_enable_pasid(pdev, 0, true);
 	if (ret)
 		goto out_err;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..f5f224f023ba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2350,7 +2350,7 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	if (num_pasids <= 0)
 		return num_pasids;
 
-	ret = pci_enable_pasid(pdev, features);
+	ret = pci_enable_pasid(pdev, features, false);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable PASID\n");
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 317af67b6098..2dd7773ce5c0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1424,7 +1424,8 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	   undefined. So always enable PASID support on devices which
 	   have it, even if we can't yet know if we're ever going to
 	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1, false))
 		info->pasid_enabled = 1;
 
 	if (info->pri_supported &&
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..eb14ca8ec4e6 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -353,12 +353,14 @@ void pci_pasid_init(struct pci_dev *pdev)
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
  * @features: Features to enable
+ * @transled_only: True if the device issues MemRd/Wr TLPs with a PASID TLP
+ *                 prefix only when the AT field is set to translated.
  *
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
  */
-int pci_enable_pasid(struct pci_dev *pdev, int features)
+int pci_enable_pasid(struct pci_dev *pdev, int features, bool transled_only)
 {
 	u16 control, supported;
 	int pasid = pdev->pasid_cap;
@@ -382,7 +384,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+	if (!transled_only &&
+	    !pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
-- 
2.34.1


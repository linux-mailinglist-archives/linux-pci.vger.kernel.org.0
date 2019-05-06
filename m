Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1EC152A6
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEFRWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 13:22:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:31139 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfEFRWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 13:22:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="230014471"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 10:22:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 1/5] PCI/ATS: Add PRI support for PCIe VF devices
Date:   Mon,  6 May 2019 10:20:03 -0700
Message-Id: <f773440c0eee2a8d4e5d6e2856717404ac836458.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

When IOMMU tries to enable PRI for VF device in
iommu_enable_dev_iotlb(), it always fails because PRI support for PCIe
VF device is currently broken in PCIE driver. Current implementation
expects the given PCIe device (PF & VF) to implement PRI capability
before enabling the PRI support. But this assumption is incorrect. As
per PCIe spec r4.0, sec 9.3.7.11, all VFs associated with PF can only
use the Page Request Interface (PRI) of the PF and not implement it.
Hence we need to create exception for handling the PRI support for PCIe
VF device.

Since PRI is shared between PF/VF devices, following rules should apply.

1. Enable PRI in VF only if its already enabled in PF.
2. When enabling/disabling PRI for VF, instead of configuring the
registers just increase/decrease the usage count (pri_ref_cnt) of PF.
3. Disable PRI in PF only if pr_ref_cnt is zero.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 53 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 97c08146534a..5582e5d83a3f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -181,12 +181,39 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	u16 control, status;
 	u32 max_requests;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+
+	if (pdev->is_virtfn) {
+		/*
+		 * Per PCIe r4.0, sec 9.3.7.11, VF must not implement PRI
+		 * Capability.
+		 */
+		if (pos) {
+			dev_err(&pdev->dev, "VF must not implement PRI");
+			return -EINVAL;
+		}
+
+		pf = pci_physfn(pdev);
+
+		/* If VF config does not match with PF, return error */
+		if (!pf->pri_enabled)
+			return -EINVAL;
+
+		pdev->pri_reqs_alloc = pf->pri_reqs_alloc;
+		pdev->pri_enabled = 1;
+
+		/* Increment PF PRI refcount */
+		atomic_inc(&pf->pri_ref_cnt);
+
+		return 0;
+	}
+
+	if (pdev->is_physfn && !pos)
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
@@ -202,7 +229,6 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 1;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pri);
@@ -217,10 +243,27 @@ void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
+	/* All VFs should be disabled before disabling PF */
+	if (atomic_read(&pdev->pri_ref_cnt))
+		return;
+
+	if (pdev->is_virtfn) {
+		/* Since VF shares PRI with PF, use PF config. */
+		pf = pci_physfn(pdev);
+
+		/* Decrement PF PRI refcount */
+		atomic_dec(&pf->pri_ref_cnt);
+
+		pdev->pri_enabled = 0;
+
+		return;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -246,6 +289,9 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	if (!pdev->pri_enabled)
 		return;
 
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -270,6 +316,9 @@ int pci_reset_pri(struct pci_dev *pdev)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
+	if (pdev->is_virtfn)
+		return 0;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..699c79c99a39 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -450,6 +450,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_PRI
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
+	atomic_t	pri_ref_cnt;	/* Number of VFs with PRI enabled */
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_features;
-- 
2.20.1


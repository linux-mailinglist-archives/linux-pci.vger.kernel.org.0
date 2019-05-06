Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED915414
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEFS7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 14:59:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:13387 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEFS67 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 14:58:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 11:58:58 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2019 11:58:58 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 2/5] PCI/ATS: Add PASID support for PCIe VF devices
Date:   Mon,  6 May 2019 11:57:10 -0700
Message-Id: <72e8403a18efe4eac30b6f672841a65c830d5a99.1557168473.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557168473.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557168473.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: 078b169334b4996d03d8608f205942c061590681.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

When IOMMU tries to enable PASID for VF device in
iommu_enable_dev_iotlb(), it always fails because PASID support for PCIe
VF device is currently broken in PCIE driver. Current implementation
expects the given PCIe device (PF & VF) to implement PASID capability
before enabling the PASID support. But this assumption is incorrect. As
per PCIe spec r4.0, sec 9.3.7.14, all VFs associated with PF can only
use the PASID of the PF and not implement it.

Since PASID is shared between PF/VF devices, following rules should
apply.

1. Enable PASID in VF only if its already enabled in PF.
2. Enable PASID in VF only if the requested features matches with PF
config, otherwise return error.
3. When enabling/disabling PASID for VF, instead of configuring the PF
registers just increase/decrease the usage count (pasid_ref_cnt).
4. Disable PASID in PF (configuring the registers) only if pasid_ref_cnt
is zero.
5. When reading PASID features/settings for VF, use registers of
corresponding PF.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Updates:
 * Fixed a typo

 drivers/pci/ats.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |  1 +
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5582e5d83a3f..d65784ca8847 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -345,6 +345,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
@@ -353,7 +354,33 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 		return -EINVAL;
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+
+	if (pdev->is_virtfn) {
+		/*
+		 * Per PCIe r4.0, sec 9.3.7.14, VF must not implement
+		 * Process Address Space ID (PASID) Capability.
+		*/
+		if (pos) {
+			dev_err(&pdev->dev, "VF must not implement PASID\n");
+			return -EINVAL;
+		}
+		/* Since VF shares PASID with PF, use PF config */
+		pf = pci_physfn(pdev);
+
+		/* If VF config does not match with PF, return error */
+		if (!pf->pasid_enabled || pf->pasid_features != features)
+			return -EINVAL;
+
+		pdev->pasid_features = features;
+		pdev->pasid_enabled = 1;
+
+		/* Increment PF PASID refcount */
+		atomic_inc(&pf->pasid_ref_cnt);
+
+		return 0;
+	}
+
+	if (pdev->is_physfn && !pos)
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
@@ -382,10 +409,27 @@ void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
 	int pos;
+	struct pci_dev *pf;
 
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
+	/* All VFs PASID should be disabled before disabling PF PASID*/
+	if (atomic_read(&pdev->pasid_ref_cnt))
+		return;
+
+	if (pdev->is_virtfn) {
+		/* Since VF shares PASID with PF, use PF config. */
+		pf = pci_physfn(pdev);
+
+		/* Decrement PF PASID refcount */
+		atomic_dec(&pf->pasid_ref_cnt);
+
+		pdev->pasid_enabled = 0;
+
+		return;
+	}
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -408,6 +452,9 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 	if (!pdev->pasid_enabled)
 		return;
 
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -432,6 +479,9 @@ int pci_pasid_features(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
@@ -488,6 +538,9 @@ int pci_max_pasids(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 699c79c99a39..2a761ea63f8d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -454,6 +454,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_features;
+	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
 #endif
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
-- 
2.20.1


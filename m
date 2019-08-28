Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07800A0D68
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfH1WSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 18:18:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:11613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfH1WSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197662421"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 15:18:06 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 5/7] PCI/ATS: Add PASID support for PCIe VF devices
Date:   Wed, 28 Aug 2019 15:14:05 -0700
Message-Id: <8ba1ac192e4ac737508b6ac15002158e176bab91.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
use the PASID of the PF and not implement it. Hence we need to create
exception for handling the PASID support for PCIe VF device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c | 49 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9af1e518a9ab..893674520bbf 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,6 +43,15 @@ static void pci_pasid_init(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_PASID
 	int pos;
 
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.14, only PF is permitted to
+	 * implement PASID Capability and all associated VFs can
+	 * only use it. Since PF already initialized the PASID
+	 * parameters there is no need to proceed further.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -355,7 +364,20 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
+	struct pci_dev *pf = pci_physfn(pdev);
 
+	/*
+	 * IOMMU is the only user of this function and as per
+	 * current usage, PF PASID enable always happens before
+	 * VF and hence we don't need to do anything special
+	 * for VF. So just return success if PASID is enabled in PF.
+	 */
+	if (pdev->is_virtfn) {
+		if (pf->pasid_enabled)
+			return 0;
+		else
+			return -EINVAL;
+	}
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
@@ -392,6 +414,14 @@ void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
 
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.14, only PF is permitted to
+	 * implement PASID Capability and all associated VFs can
+	 * only use it. So don't do anything for VF and just return.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
@@ -412,6 +442,13 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 {
 	u16 control;
 
+	/*
+	 * PF should have already restored the PASID state. So for
+	 * VF, just return.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
 	if (!pdev->pasid_enabled)
 		return;
 
@@ -436,12 +473,12 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 int pci_pasid_features(struct pci_dev *pdev)
 {
 	u16 supported;
+	struct pci_dev *pf = pci_physfn(pdev);
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
-			     &supported);
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
 
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
@@ -492,12 +529,12 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 int pci_max_pasids(struct pci_dev *pdev)
 {
 	u16 supported;
+	struct pci_dev *pf = pci_physfn(pdev);
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
-			     &supported);
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
 
 	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
 
-- 
2.21.0


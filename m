Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38EDA0D6A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH1WSI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 18:18:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:11613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfH1WSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197662417"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 15:18:06 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Date:   Wed, 28 Aug 2019 15:14:04 -0700
Message-Id: <b971e31f8695980da8e4a7f93e3b6a3edba3edaa.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

When IOMMU tries to enable Page Request Interface (PRI) for VF device
in iommu_enable_dev_iotlb(), it always fails because PRI support for
PCIe VF device is currently broken. Current implementation expects
the given PCIe device (PF & VF) to implement PRI capability before
enabling the PRI support. But this assumption is incorrect. As per PCIe
spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
PRI of the PF and not implement it. Hence we need to create exception
for handling the PRI support for PCIe VF device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 022698a85c98..9af1e518a9ab 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -21,6 +21,15 @@ static void pci_pri_init(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_PRI
 	int pos;
 
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.11, only PF is permitted to
+	 * implement PRI and all associated VFs can only use it.
+	 * Since PF already initialized the PRI parameters there is
+	 * no need to proceed further.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -210,6 +219,20 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 {
 	u16 control, status;
 	u32 max_requests;
+	struct pci_dev *pf = pci_physfn(pdev);
+
+	/*
+	 * IOMMU is the only user of this function and as per
+	 * current usage, PF PRI enable always happens before
+	 * VF and hence we don't need to do anything special
+	 * for VF. So just return success if PRI is enabled in PF.
+	 */
+	if (pdev->is_virtfn) {
+		if (pf->pri_enabled)
+			return 0;
+		else
+			return -EINVAL;
+	}
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
@@ -246,6 +269,14 @@ void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
 
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.11, only PF is permitted to
+	 * implement PRI and all associated VFs can only use it.
+	 * So don't do anything for VF and just return.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
@@ -269,6 +300,9 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	u16 control = PCI_PRI_CTRL_ENABLE;
 	u32 reqs = pdev->pri_reqs_alloc;
 
+	if (pdev->is_virtfn)
+		return;
+
 	if (!pdev->pri_enabled)
 		return;
 
@@ -291,6 +325,9 @@ int pci_reset_pri(struct pci_dev *pdev)
 {
 	u16 control;
 
+	if (pdev->is_virtfn)
+		return 0;
+
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
@@ -427,11 +464,12 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	u16 status;
+	struct pci_dev *pf = pci_physfn(pdev);
 
-	if (!pdev->pri_cap)
+	if (!pf->pri_cap)
 		return 0;
 
-	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
+	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
 
 	if (status & PCI_PRI_STATUS_PASID)
 		return 1;
-- 
2.21.0


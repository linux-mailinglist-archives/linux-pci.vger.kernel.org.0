Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34090BAF
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfHQANp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:6694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195010"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 5/8] PCI/ATS: Add PRI support for PCIe VF devices
Date:   Fri, 16 Aug 2019 17:10:19 -0700
Message-Id: <06f7a6bb9fca94fa8731e5225e91a14a676d07ca.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Also, since PRI is a shared resource between PF/VF, following rules
should apply.

1. Use proper locking before accessing/modifying PF resources in VF
   PRI enable/disable call.
2. Use reference count logic to track the usage of PRI resource.
3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 121 ++++++++++++++++++++++++++++++++++----------
 include/linux/pci.h |   1 +
 2 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 022698a85c98..e71187d83401 100644
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
@@ -208,31 +217,55 @@ EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
  */
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 {
-	u16 control, status;
+	u16 status;
 	u32 max_requests;
+	int ret = 0;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	if (!pdev->pri_cap)
+	if (!pf->pri_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
-	if (!(status & PCI_PRI_STATUS_STOPPED))
-		return -EBUSY;
+	pci_physfn_reslock(pdev);
+
+	if (pdev->is_virtfn && pf->pri_enabled)
+		goto update_status;
 
-	pci_read_config_dword(pdev, pdev->pri_cap + PCI_PRI_MAX_REQ,
-			      &max_requests);
+	/*
+	 * Before updating PRI registers, make sure there is no
+	 * outstanding PRI requests.
+	 */
+	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
+	if (!(status & PCI_PRI_STATUS_STOPPED)) {
+		ret = -EBUSY;
+		goto done;
+	}
+
+	pci_read_config_dword(pf, pf->pri_cap + PCI_PRI_MAX_REQ, &max_requests);
 	reqs = min(max_requests, reqs);
-	pdev->pri_reqs_alloc = reqs;
-	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
+	pf->pri_reqs_alloc = reqs;
+	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
 
-	control = PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
+	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL,
+			      PCI_PRI_CTRL_ENABLE);
 
-	pdev->pri_enabled = 1;
+	/*
+	 * If PRI is not already enabled in PF, increment the PF
+	 * pri_ref_cnt to track the usage of PRI interface.
+	 */
+	if (pdev->is_virtfn && !pf->pri_enabled) {
+		atomic_inc(&pf->pri_ref_cnt);
+		pf->pri_enabled = 1;
+	}
 
-	return 0;
+update_status:
+	atomic_inc(&pf->pri_ref_cnt);
+	pdev->pri_enabled = 1;
+done:
+	pci_physfn_resunlock(pdev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pri);
 
@@ -245,18 +278,32 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
 void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
-	if (!pdev->pri_cap)
+	if (!pf->pri_cap)
 		return;
 
-	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, &control);
+	pci_physfn_reslock(pdev);
+
+	atomic_dec(&pf->pri_ref_cnt);
+
+	/*
+	 * If pri_ref_cnt is not zero, then don't modify hardware
+	 * registers.
+	 */
+	if (atomic_read(&pf->pri_ref_cnt))
+		goto done;
+
+	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
 	control &= ~PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
+	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
 
+done:
 	pdev->pri_enabled = 0;
+	pci_physfn_resunlock(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_disable_pri);
 
@@ -266,17 +313,29 @@ EXPORT_SYMBOL_GPL(pci_disable_pri);
  */
 void pci_restore_pri_state(struct pci_dev *pdev)
 {
-	u16 control = PCI_PRI_CTRL_ENABLE;
-	u32 reqs = pdev->pri_reqs_alloc;
+	u16 control;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (!pdev->pri_enabled)
 		return;
 
-	if (!pdev->pri_cap)
+	if (!pf->pri_cap)
 		return;
 
-	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
-	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
+	pci_physfn_reslock(pdev);
+
+	/* If PRI is already enabled by other VF's or PF, return */
+	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
+	if (control & PCI_PRI_CTRL_ENABLE)
+		goto done;
+
+	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ,
+			       pf->pri_reqs_alloc);
+	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL,
+			      PCI_PRI_CTRL_ENABLE);
+
+done:
+	pci_physfn_resunlock(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 
@@ -289,17 +348,24 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
  */
 int pci_reset_pri(struct pci_dev *pdev)
 {
-	u16 control;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	if (!pdev->pri_cap)
+	if (!pf->pri_cap)
 		return -EINVAL;
 
-	control = PCI_PRI_CTRL_RESET;
-	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
+	pci_physfn_reslock(pdev);
+
+	/* If PRI is already enabled in PF, skip reset and return */
+	if (pf->pri_enabled)
+		goto done;
 
+	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL,
+			      PCI_PRI_CTRL_RESET);
+done:
+	pci_physfn_resunlock(pdev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_pri);
@@ -427,11 +493,12 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27224c0db849..cd07b2d071c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -457,6 +457,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
+	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_cap;	/* PASID Capability offset */
-- 
2.21.0


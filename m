Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2390BA6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHQANZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:6694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195013"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 6/8] PCI/ATS: Add PASID support for PCIe VF devices
Date:   Fri, 16 Aug 2019 17:10:20 -0700
Message-Id: <9a16830464e035035fb17199395d57b8570fe6ae.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

When IOMMU tries to enable PASID for VF device in
iommu_enable_dev_iotlb(), it always fails because PASID support for PCIe
VF device is currently broken in PCIE driver. Current implementation
expects the given PCIe device (PF & VF) to implement PASID capability
before enabling the PASID support. But this assumption is incorrect. As
per PCIe spec r4.0, sec 9.3.7.14, all VFs associated with PF can only
use the PASID of the PF and not implement it.

Also, since PASID is a shared resource between PF/VF, following rules
should apply.

1. Use proper locking before accessing/modifying PF resources in VF
   PASID enable/disable call.
2. Use reference count logic to track the usage of PASID resource.
3. Disable PASID only if the PASID reference count (pasid_ref_cnt) is zero.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 88 +++++++++++++++++++++++++++++++++++----------
 include/linux/pci.h |  1 +
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e71187d83401..ca633482e565 100644
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
@@ -384,6 +393,8 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
+	int ret = 0;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
@@ -391,25 +402,42 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pdev->eetlp_prefix_path)
 		return -EINVAL;
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
-			     &supported);
+	pci_physfn_reslock(pdev);
+
+	if (pdev->is_virtfn && pf->pasid_enabled)
+		goto update_status;
+
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
 	/* User wants to enable anything unsupported? */
-	if ((supported & features) != features)
-		return -EINVAL;
+	if ((supported & features) != features) {
+		ret = -EINVAL;
+		goto done;
+	}
 
 	control = PCI_PASID_CTRL_ENABLE | features;
-	pdev->pasid_features = features;
-
+	pf->pasid_features = features;
 	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
 
-	pdev->pasid_enabled = 1;
+	/*
+	 * If PASID is not already enabled in PF, increment pasid_ref_cnt
+	 * to count PF PASID usage.
+	 */
+	if (pdev->is_virtfn && !pf->pasid_enabled) {
+		atomic_inc(&pf->pasid_ref_cnt);
+		pf->pasid_enabled = 1;
+	}
 
-	return 0;
+update_status:
+	atomic_inc(&pf->pasid_ref_cnt);
+	pdev->pasid_enabled = 1;
+done:
+	pci_physfn_resunlock(pdev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pasid);
 
@@ -420,16 +448,28 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
 void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap)
 		return;
 
-	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
+	pci_physfn_reslock(pdev);
+
+	atomic_dec(&pf->pasid_ref_cnt);
 
+	if (atomic_read(&pf->pasid_ref_cnt))
+		goto done;
+
+	/* Disable PASID only if pasid_ref_cnt is zero */
+	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
+
+done:
 	pdev->pasid_enabled = 0;
+	pci_physfn_resunlock(pdev);
+
 }
 EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
@@ -440,15 +480,25 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
 void pci_restore_pasid_state(struct pci_dev *pdev)
 {
 	u16 control;
+	struct pci_dev *pf = pci_physfn(pdev);
 
 	if (!pdev->pasid_enabled)
 		return;
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap)
 		return;
 
+	pci_physfn_reslock(pdev);
+
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, &control);
+	if (control & PCI_PASID_CTRL_ENABLE)
+		goto done;
+
 	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
-	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
+	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
+
+done:
+	pci_physfn_resunlock(pdev);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 
@@ -465,12 +515,12 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
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
 
@@ -521,12 +571,12 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
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
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd07b2d071c1..735dc731e0aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -462,6 +462,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_cap;	/* PASID Capability offset */
 	u16		pasid_features;
+	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
 #endif
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
-- 
2.21.0


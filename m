Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAB4DB86
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfFTUlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 16:41:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:28566 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFTUk6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 16:40:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 13:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="311788171"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 13:40:56 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 5/7] PCI/ATS: Add PASID support for PCIe VF devices
Date:   Thu, 20 Jun 2019 13:38:46 -0700
Message-Id: <13605c1a32dc8e2da15e4a49197d158dc86145e1.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/pci/ats.c   | 117 ++++++++++++++++++++++++++++++++++----------
 include/linux/pci.h |   2 +
 2 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index d321953e64ec..13fe88829306 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -67,6 +67,8 @@ static void pci_pasid_init(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		return;
 
+	mutex_init(&pdev->pasid_lock);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
@@ -438,32 +440,57 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
+	int ret = 0;
+	struct pci_dev *pf = pci_physfn(pdev);
 
-	if (WARN_ON(pdev->pasid_enabled))
-		return -EBUSY;
+	mutex_lock(&pf->pasid_lock);
 
-	if (!pdev->eetlp_prefix_path)
-		return -EINVAL;
+	if (WARN_ON(pdev->pasid_enabled)) {
+		ret = -EBUSY;
+		goto pasid_unlock;
+	}
 
-	if (!pdev->pasid_cap)
-		return -EINVAL;
+	if (!pdev->eetlp_prefix_path) {
+		ret = -EINVAL;
+		goto pasid_unlock;
+	}
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
-			     &supported);
+	if (!pf->pasid_cap) {
+		ret = -EINVAL;
+		goto pasid_unlock;
+	}
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
+		goto pasid_unlock;
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
+pasid_unlock:
+	mutex_unlock(&pf->pasid_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pasid);
 
@@ -474,16 +501,29 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
 void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
+	struct pci_dev *pf = pci_physfn(pdev);
+
+	mutex_lock(&pf->pasid_lock);
 
 	if (WARN_ON(!pdev->pasid_enabled))
-		return;
+		goto pasid_unlock;
 
-	if (!pdev->pasid_cap)
-		return;
+	if (!pf->pasid_cap)
+		goto pasid_unlock;
 
-	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
+	atomic_dec(&pf->pasid_ref_cnt);
+
+	if (atomic_read(&pf->pasid_ref_cnt))
+		goto done;
+
+	/* Disable PASID only if pasid_ref_cnt is zero */
+	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
 
+done:
 	pdev->pasid_enabled = 0;
+pasid_unlock:
+	mutex_unlock(&pf->pasid_lock);
+
 }
 EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
@@ -494,15 +534,25 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
 void pci_restore_pasid_state(struct pci_dev *pdev)
 {
 	u16 control;
+	struct pci_dev *pf = pci_physfn(pdev);
+
+	mutex_lock(&pf->pasid_lock);
 
 	if (!pdev->pasid_enabled)
-		return;
+		goto pasid_unlock;
 
-	if (!pdev->pasid_cap)
-		return;
+	if (!pf->pasid_cap)
+		goto pasid_unlock;
+
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, &control);
+	if (control & PCI_PASID_CTRL_ENABLE)
+		goto pasid_unlock;
 
 	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
-	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
+	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
+
+pasid_unlock:
+	mutex_unlock(&pf->pasid_lock);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 
@@ -519,15 +569,22 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 int pci_pasid_features(struct pci_dev *pdev)
 {
 	u16 supported;
+	struct pci_dev *pf = pci_physfn(pdev);
+
+	mutex_lock(&pf->pasid_lock);
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap) {
+		mutex_unlock(&pf->pasid_lock);
 		return -EINVAL;
+	}
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP,
 			     &supported);
 
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
+	mutex_unlock(&pf->pasid_lock);
+
 	return supported;
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
@@ -581,15 +638,21 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 int pci_max_pasids(struct pci_dev *pdev)
 {
 	u16 supported;
+	struct pci_dev *pf = pci_physfn(pdev);
+
+	mutex_lock(&pf->pasid_lock);
 
-	if (!pdev->pasid_cap)
+	if (!pf->pasid_cap) {
+		mutex_unlock(&pf->pasid_lock);
 		return -EINVAL;
+	}
 
-	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
-			     &supported);
+	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
 
 	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
 
+	mutex_unlock(&pf->pasid_lock);
+
 	return (1 << supported);
 }
 EXPORT_SYMBOL_GPL(pci_max_pasids);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d0075413b63f..a317c3115d69 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -458,8 +458,10 @@ struct pci_dev {
 	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
 #endif
 #ifdef CONFIG_PCI_PASID
+	struct mutex	pasid_lock;	/* PASID enable lock */
 	u16		pasid_cap;	/* PASID Capability offset */
 	u16		pasid_features;
+	atomic_t	pasid_ref_cnt;	/* Number of VFs with PASID enabled */
 #endif
 #ifdef CONFIG_PCI_P2PDMA
 	struct pci_p2pdma *p2pdma;
-- 
2.21.0


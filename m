Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0F7E705
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 02:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfHBAIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 20:08:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:59856 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfHBAIr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 20:08:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 17:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; 
   d="scan'208";a="177993961"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2019 17:08:44 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 3/7] PCI/ATS: Initialize PASID in pci_ats_init()
Date:   Thu,  1 Aug 2019 17:06:00 -0700
Message-Id: <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, PASID Capability checks are repeated across all PASID API's.
Instead, cache the capability check result in pci_pasid_init() and use
it in other PASID API's. Also, since PASID is a shared resource between
PF/VF, initialize PASID features with default values in pci_pasid_init().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c       | 74 +++++++++++++++++++++++++++++------------
 include/linux/pci-ats.h |  5 +++
 include/linux/pci.h     |  1 +
 3 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 280be911f190..1f4be27a071d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,8 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 
 	pci_pri_init(dev);
+
+	pci_pasid_init(dev);
 }
 
 /**
@@ -315,6 +317,40 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
+
+void pci_pasid_init(struct pci_dev *pdev)
+{
+	u16 supported;
+	int pos;
+
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.14, only PF is permitted to
+	 * implement PASID Capability and all associated VFs can
+	 * only use it. Since PF already initialized the PASID
+	 * parameters there is no need to proceed further.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
+	if (!pos)
+		return;
+
+	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+
+	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
+
+	/*
+	 * Enable all supported features. Since PASID is a shared
+	 * resource between PF/VF, we must not set this feature as
+	 * a per device property in pci_enable_pasid().
+	 */
+	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, supported);
+
+	pdev->pasid_features = supported;
+	pdev->pasid_cap = pos;
+}
+
 /**
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
@@ -323,11 +359,13 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
+ *
+ * TODO: Since PASID is a shared resource between PF/VF, don't update
+ * PASID features in the same API as a per device feature.
  */
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
-	int pos;
 
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
@@ -335,11 +373,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pdev->eetlp_prefix_path)
 		return -EINVAL;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pdev->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+			     &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
 	/* User wants to enable anything unsupported? */
@@ -349,7 +387,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	control = PCI_PASID_CTRL_ENABLE | features;
 	pdev->pasid_features = features;
 
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
 
 	pdev->pasid_enabled = 1;
 
@@ -364,16 +402,14 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
 void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
-	int pos;
 
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pdev->pasid_cap)
 		return;
 
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
 
 	pdev->pasid_enabled = 0;
 }
@@ -386,17 +422,15 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
 void pci_restore_pasid_state(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
 
 	if (!pdev->pasid_enabled)
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pdev->pasid_cap)
 		return;
 
 	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 
@@ -413,13 +447,12 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 int pci_pasid_features(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pos;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pdev->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+			     &supported);
 
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
@@ -469,13 +502,12 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 int pci_max_pasids(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pos;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pdev->pasid_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+			     &supported);
 
 	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
 
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 33653d4ca94f..bc7f815d38ff 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -40,6 +40,7 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
 
 #ifdef CONFIG_PCI_PASID
 
+void pci_pasid_init(struct pci_dev *pdev);
 int pci_enable_pasid(struct pci_dev *pdev, int features);
 void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
@@ -48,6 +49,10 @@ int pci_max_pasids(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
+static inline void pci_pasid_init(struct pci_dev *pdev)
+{
+}
+
 static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 56b55db099fc..27224c0db849 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -459,6 +459,7 @@ struct pci_dev {
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
 #endif
 #ifdef CONFIG_PCI_PASID
+	u16		pasid_cap;	/* PASID Capability offset */
 	u16		pasid_features;
 #endif
 #ifdef CONFIG_PCI_P2PDMA
-- 
2.21.0


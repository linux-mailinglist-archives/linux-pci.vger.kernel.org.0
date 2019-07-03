Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50E5EDDE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfGCUtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:49:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:7207 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfGCUsi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:48:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="172258086"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2019 13:48:37 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Date:   Wed,  3 Jul 2019 13:46:19 -0700
Message-Id: <744998862eebecfae79afd23c42d518264231a22.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, PRI Capability checks are repeated across all PRI API's.
Instead, cache the capability check result in pci_pri_init() and use it
in other PRI API's. Also, since PRI is a shared resource between PF/VF,
initialize default values for common PRI features in pci_pri_init().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 83 +++++++++++++++++++++++++++++++--------------
 include/linux/pci.h |  1 +
 2 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9eeb7db0db3..a14ab20f1c28 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -16,6 +16,40 @@
 
 #include "pci.h"
 
+#ifdef CONFIG_PCI_PRI
+static void pci_pri_init(struct pci_dev *pdev)
+{
+	u32 max_requests;
+	int pos;
+
+	/*
+	 * As per PCIe r4.0, sec 9.3.7.11, only PF is permitted to
+	 * implement PRI and all associated VFs can only use it.
+	 * Since PF already initialized the PRI parameters there is
+	 * no need to proceed further.
+	 */
+	if (pdev->is_virtfn)
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
+
+	/*
+	 * Since PRI is a shared resource between PF and VF, we must not
+	 * configure Outstanding Page Allocation Quota as a per device
+	 * resource in pci_enable_pri(). So use maximum value possible
+	 * as default value.
+	 */
+	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, max_requests);
+
+	pdev->pri_reqs_alloc = max_requests;
+	pdev->pri_cap = pos;
+}
+#endif
+
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
@@ -28,6 +62,10 @@ void pci_ats_init(struct pci_dev *dev)
 		return;
 
 	dev->ats_cap = pos;
+
+#ifdef CONFIG_PCI_PRI
+	pci_pri_init(dev);
+#endif
 }
 
 /**
@@ -175,31 +213,34 @@ EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
  * @ pdev: PCI device structure
  *
  * Returns 0 on success, negative value on error
+ *
+ * TODO: Since PRI is a shared resource between PF/VF, don't update
+ * Outstanding Page Allocation Quota in the same API as a per device
+ * feature.
  */
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 {
 	u16 control, status;
 	u32 max_requests;
-	int pos;
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pdev->pri_cap)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
 	if (!(status & PCI_PRI_STATUS_STOPPED))
 		return -EBUSY;
 
-	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
+	pci_read_config_dword(pdev, pdev->pri_cap + PCI_PRI_MAX_REQ,
+			      &max_requests);
 	reqs = min(max_requests, reqs);
 	pdev->pri_reqs_alloc = reqs;
-	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
+	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
 
 	control = PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 1;
 
@@ -216,18 +257,16 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
 void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
 
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pdev->pri_cap)
 		return;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
+	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, &control);
 	control &= ~PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 0;
 }
@@ -241,17 +280,15 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 {
 	u16 control = PCI_PRI_CTRL_ENABLE;
 	u32 reqs = pdev->pri_reqs_alloc;
-	int pos;
 
 	if (!pdev->pri_enabled)
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pdev->pri_cap)
 		return;
 
-	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
+	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 
@@ -265,17 +302,15 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 int pci_reset_pri(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
 
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pdev->pri_cap)
 		return -EINVAL;
 
 	control = PCI_PRI_CTRL_RESET;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
 
 	return 0;
 }
@@ -410,13 +445,11 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	u16 status;
-	int pos;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pdev->pri_cap)
 		return 0;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
 
 	if (status & PCI_PRI_STATUS_PASID)
 		return 1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc..f3fe625bc8bb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,6 +452,7 @@ struct pci_dev {
 	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
+	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
 #endif
 #ifdef CONFIG_PCI_PASID
-- 
2.21.0


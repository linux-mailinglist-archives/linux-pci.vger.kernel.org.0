Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D44CEFA2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 01:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfJGXfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 19:35:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:50779 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfJGXfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 19:35:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 16:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="199661906"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2019 16:35:09 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/ATS: Optimize pci_prg_resp_pasid_required() function
Date:   Mon,  7 Oct 2019 16:32:42 -0700
Message-Id: <f594928de550e151d3537fdd64099de34ffa30da.1570490792.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, pci_prg_resp_pasid_required() function reads the
PASID Required bit status from register every time we call
the function. Since PASID Required bit is a read-only value,
instead of reading it from register every time, read it once and
cache it in struct pci_dev.

Also, since we are caching PASID Required bit in pci_pri_init()
function, move the caching of PRI Capability check result to the same
function. This will group all PRI related caching at one place.

Since "pasid_required" structure member is protected by CONFIG_PRI,
its users should also be protected by same #ifdef. So correct the #ifdef
dependency of pci_prg_resp_pasid_required() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/ats.c   | 50 ++++++++++++++++++++++++---------------------
 include/linux/pci.h |  1 +
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index cb4f62da7b8a..2b5df5ea208f 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -16,6 +16,24 @@
 
 #include "pci.h"
 
+static void pci_pri_init(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_PRI
+	int pos;
+	u16 status;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return;
+
+	pdev->pri_cap = pos;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+	if (status & PCI_PRI_STATUS_PASID)
+		pdev->pasid_required = 1;
+#endif
+}
+
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
@@ -28,6 +46,8 @@ void pci_ats_init(struct pci_dev *dev)
 		return;
 
 	dev->ats_cap = pos;
+
+	pci_pri_init(dev);
 }
 
 /**
@@ -185,12 +205,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	if (!pri) {
-		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-		if (!pri)
-			return -EINVAL;
-		pdev->pri_cap = pri;
-	}
+	if (!pri)
+		return -EINVAL;
 
 	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
 	if (!(status & PCI_PRI_STATUS_STOPPED))
@@ -425,6 +441,7 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
+#ifdef CONFIG_PCI_PRI
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
  *				 status.
@@ -432,31 +449,18 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
  *
  * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
  *
- * Even though the PRG response PASID status is read from PRI Status
- * Register, since this API will mainly be used by PASID users, this
- * function is defined within #ifdef CONFIG_PCI_PASID instead of
- * CONFIG_PCI_PRI.
+ * Since this API has dependency on both PRI and PASID, protect it
+ * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
  */
 int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
-	u16 status;
-	int pri;
-
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pri)
-		return 0;
-
-	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
-
-	if (status & PCI_PRI_STATUS_PASID)
-		return 1;
-
-	return 0;
+	return pdev->pasid_required;
 }
 EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
+#endif /* CONFIG_PCI_PRI */
 
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6542100bd2dd..f1131fee7fcd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -456,6 +456,7 @@ struct pci_dev {
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
+	unsigned int	pasid_required:1; /* PRG Response PASID Required bit status */
 #endif
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_cap;	/* PASID Capability offset */
-- 
2.21.0


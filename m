Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1207A0D6F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 00:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfH1WSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 18:18:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:11611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfH1WSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 18:18:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197662405"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 15:18:06 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
Date:   Wed, 28 Aug 2019 15:14:01 -0700
Message-Id: <ef40dbdc4eae32490caec47bed5b57eeb438dd80.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Since pci_prg_resp_pasid_required() function has dependency on both
PASID and PRI, define it only if both CONFIG_PCI_PRI and
CONFIG_PCI_PASID config options are enabled.

Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
interface.")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c       | 10 ++++++----
 include/linux/pci-ats.h | 12 +++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e18499243f84..cdd936d10f68 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -395,6 +395,8 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
+#ifdef CONFIG_PCI_PRI
+
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
  *				 status.
@@ -402,10 +404,8 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
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
@@ -425,6 +425,8 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 
+#endif
+
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 1ebb88e7c184..1a0bdaee2f32 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -40,7 +40,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
-int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -67,11 +66,18 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 	return -EINVAL;
 }
 
+#endif /* CONFIG_PCI_PASID */
+
+#if defined(CONFIG_PCI_PRI) && defined(CONFIG_PCI_PASID)
+
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+
+#else /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
+
 static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	return 0;
 }
-#endif /* CONFIG_PCI_PASID */
-
+#endif
 
 #endif /* LINUX_PCI_ATS_H*/
-- 
2.21.0


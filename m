Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23114DB8A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFTUl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 16:41:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:28566 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfFTUk5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 16:40:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="311788159"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 13:40:56 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required() dependency issues
Date:   Thu, 20 Jun 2019 13:38:42 -0700
Message-Id: <a0534c2ec69e0d7e03c4da3e8d539e8591a5686c.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 97c08146534a..f9eeb7db0db3 100644
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


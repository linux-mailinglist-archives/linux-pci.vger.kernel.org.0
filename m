Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208C1D1C23
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfJIWqv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJIWqu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:46:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2189C218AC;
        Wed,  9 Oct 2019 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661209;
        bh=G4qaDJvkgucJqayGdIGRgColYPN7u9fMFeBqJUjKfz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gr469wBofiAFIdOGgkpSdkNgSeQMWQW+3lG3nQ7+YuABSj9TtzblnULya9ZAbb3ZV
         AnNOC2RkF1flKoPor+TBb/ggYQ6mwg7mIw+vkTJs4+dreg5w1AUipBYYc6N/cRq1Om
         j8AzddchSO4UXHhYCAzAhMkMdTVL/JV/8/t850jE=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI
Date:   Wed,  9 Oct 2019 17:45:51 -0500
Message-Id: <20191009224551.179497-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_prg_resp_pasid_required() returns the value of the "PRG Response PASID
Required" bit from the PRI capability, but the interface was previously
defined under #ifdef CONFIG_PCI_PASID.

Move it from CONFIG_PCI_PASID to CONFIG_PCI_PRI so it's with the other
PRI-related things.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
 include/linux/pci-ats.h | 11 ++++-----
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e18499243f84..0d06177252c7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -280,6 +280,31 @@ int pci_reset_pri(struct pci_dev *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_pri);
+
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	if (status & PCI_PRI_STATUS_PASID)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -395,36 +420,6 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
-/**
- * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
- *				 status.
- * @pdev: PCI device structure
- *
- * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
- *
- * Even though the PRG response PASID status is read from PRI Status
- * Register, since this API will mainly be used by PASID users, this
- * function is defined within #ifdef CONFIG_PCI_PASID instead of
- * CONFIG_PCI_PRI.
- */
-int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return 0;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	if (status & PCI_PRI_STATUS_PASID)
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
-
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 1ebb88e7c184..a7a2b3d94fcc 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI_PRI */
 
@@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
 	return -ENODEV;
 }
 
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
-int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 {
 	return -EINVAL;
 }
-
-static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	return 0;
-}
 #endif /* CONFIG_PCI_PASID */
 
 
-- 
2.23.0.581.g78d2f28ef7-goog


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64D90BAD
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfHQANi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:12917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195004"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 3/8] PCI/ATS: Cache PASID capability check result
Date:   Fri, 16 Aug 2019 17:10:17 -0700
Message-Id: <8dab6ec5eb5b600311111986aaca0b831472c7e5.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Currently, PASID capability checks are repeated across all PASID API's.
Instead, cache the capability check result in pci_pasid_init() and use
it in other PASID API's.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 50 ++++++++++++++++++++++++++-------------------
 include/linux/pci.h |  1 +
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b863562b6702..022698a85c98 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -29,6 +29,19 @@ static void pci_pri_init(struct pci_dev *pdev)
 #endif
 }
 
+static void pci_pasid_init(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_PASID
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
+	if (!pos)
+		return;
+
+	pdev->pasid_cap = pos;
+#endif
+}
+
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
@@ -43,6 +56,8 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 
 	pci_pri_init(dev);
+
+	pci_pasid_init(dev);
 }
 
 /**
@@ -303,7 +318,6 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
-	int pos;
 
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
@@ -311,11 +325,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
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
@@ -325,7 +339,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	control = PCI_PASID_CTRL_ENABLE | features;
 	pdev->pasid_features = features;
 
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
 
 	pdev->pasid_enabled = 1;
 
@@ -340,16 +354,14 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
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
@@ -362,17 +374,15 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
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
 
@@ -389,13 +399,12 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
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
 
@@ -445,13 +454,12 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
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


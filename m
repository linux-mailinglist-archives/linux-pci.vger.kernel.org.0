Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77E90BAE
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHQANY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:12918 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHQANY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195001"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 2/8] PCI/ATS: Cache PRI capability check result
Date:   Fri, 16 Aug 2019 17:10:16 -0700
Message-Id: <9e4ed11d29d3af4df7420a88f37e6dfed12eac86.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Currently, PRI capability checks are repeated across all PRI API's.
Instead, cache the capability check result in pci_pri_init() and use it
in other PRI API's.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c   | 56 +++++++++++++++++++++++++--------------------
 include/linux/pci.h |  1 +
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index cdd936d10f68..b863562b6702 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -16,6 +16,19 @@
 
 #include "pci.h"
 
+static void pci_pri_init(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_PRI
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return;
+
+	pdev->pri_cap = pos;
+#endif
+}
+
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
@@ -28,6 +41,8 @@ void pci_ats_init(struct pci_dev *dev)
 		return;
 
 	dev->ats_cap = pos;
+
+	pci_pri_init(dev);
 }
 
 /**
@@ -180,26 +195,25 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
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
 
@@ -216,18 +230,16 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
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
@@ -241,17 +253,15 @@ void pci_restore_pri_state(struct pci_dev *pdev)
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
 
@@ -265,17 +275,15 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
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
@@ -410,13 +418,11 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
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
index 9e700d9f9f28..56b55db099fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -455,6 +455,7 @@ struct pci_dev {
 	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
+	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
 #endif
 #ifdef CONFIG_PCI_PASID
-- 
2.21.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35968AAC0A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfIETcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfIETcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:32:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6B720825;
        Thu,  5 Sep 2019 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711933;
        bh=OPMmCHgbsFi0lCF9+YlnzBgLFCDefCa0F0PH5xZy1yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHwt4gPjfY7cjHquw3naVLDZsDVyW7chSAFaCDRuDROzjag72lXjXdelTQUgnbKml
         ByhIxANTY7AaVPUIJMxkGna0uJsWuxuli+XHp45fWIfK/J52sxNmANmvgfG3cNb5IR
         SiwzSTJJXKA+ir6FSBV6w8Gl/C1eiYd3xqsOS9vA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] PCI/ATS: Cache PRI Capability offset
Date:   Thu,  5 Sep 2019 14:31:45 -0500
Message-Id: <20190905193146.90250-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190905193146.90250-1-helgaas@kernel.org>
References: <20190905193146.90250-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Previously each PRI interface searched for the PRI Capability.  Cache the
capability offset the first time we use it instead of searching each time.

[bhelgaas: commit log, reorder patch to later, save offset directly in
pci_enable_pri() rather than adding pci_pri_init()]
Link: https://lore.kernel.org/r/0c5495d376faf6dbb8eb2165204c474438aaae65.156
7029860.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c   | 52 ++++++++++++++++++++++-----------------------
 include/linux/pci.h |  1 +
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 920deeccf38d..bc463e2ecc61 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -169,7 +169,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 {
 	u16 control, status;
 	u32 max_requests;
-	int pos;
+	int pri = pdev->pri_cap;
 
 	/*
 	 * VFs must not implement the PRI Capability.  If their PF
@@ -185,21 +185,24 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return -EINVAL;
+	if (!pri) {
+		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+		if (!pri)
+			return -EINVAL;
+		pdev->pri_cap = pri;
+	}
 
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
 	if (!(status & PCI_PRI_STATUS_STOPPED))
 		return -EBUSY;
 
-	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
+	pci_read_config_dword(pdev, pri + PCI_PRI_MAX_REQ, &max_requests);
 	reqs = min(max_requests, reqs);
 	pdev->pri_reqs_alloc = reqs;
-	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
+	pci_write_config_dword(pdev, pri + PCI_PRI_ALLOC_REQ, reqs);
 
 	control = PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pri + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 1;
 
@@ -216,7 +219,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
 void pci_disable_pri(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
+	int pri = pdev->pri_cap;
 
 	/* VFs share the PF PRI */
 	if (pdev->is_virtfn)
@@ -225,13 +228,12 @@ void pci_disable_pri(struct pci_dev *pdev)
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pri)
 		return;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
+	pci_read_config_word(pdev, pri + PCI_PRI_CTRL, &control);
 	control &= ~PCI_PRI_CTRL_ENABLE;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pri + PCI_PRI_CTRL, control);
 
 	pdev->pri_enabled = 0;
 }
@@ -245,7 +247,7 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 {
 	u16 control = PCI_PRI_CTRL_ENABLE;
 	u32 reqs = pdev->pri_reqs_alloc;
-	int pos;
+	int pri = pdev->pri_cap;
 
 	if (pdev->is_virtfn)
 		return;
@@ -253,12 +255,11 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	if (!pdev->pri_enabled)
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pri)
 		return;
 
-	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, reqs);
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_dword(pdev, pri + PCI_PRI_ALLOC_REQ, reqs);
+	pci_write_config_word(pdev, pri + PCI_PRI_CTRL, control);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 
@@ -272,7 +273,7 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 int pci_reset_pri(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
+	int pri = pdev->pri_cap;
 
 	if (pdev->is_virtfn)
 		return 0;
@@ -280,12 +281,11 @@ int pci_reset_pri(struct pci_dev *pdev)
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	if (!pri)
 		return -EINVAL;
 
 	control = PCI_PRI_CTRL_RESET;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+	pci_write_config_word(pdev, pri + PCI_PRI_CTRL, control);
 
 	return 0;
 }
@@ -440,16 +440,16 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 {
 	u16 status;
-	int pos;
+	int pri;
 
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
+	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pri)
 		return 0;
 
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
 
 	if (status & PCI_PRI_STATUS_PASID)
 		return 1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a73e8d28a896..c81a24172b14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -454,6 +454,7 @@ struct pci_dev {
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
 #ifdef CONFIG_PCI_PRI
+	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
 #endif
 #ifdef CONFIG_PCI_PASID
-- 
2.23.0.187.g17f5b7556c-goog


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D85AAC0B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfIETcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403870AbfIETcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:32:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEF120825;
        Thu,  5 Sep 2019 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711936;
        bh=dWtd5+nLhoJSM/SHkQ3WS9gV06tdwTIBSFEzPozW0Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q78vl1fchrY026ueIJKBt96kYirxW3RG3SvX05USlSF8XWFsZHqYGisifVMxr/kqB
         lrXJr0YMIS2kUJaLrxdnGWFWqB4OXgRqCJZdS1u3hRLNYfEjnMeGDxvm22vLDtSD81
         Rxg8BkvfESKLxyzVzRHcTcPW0QTMVHJCPs7loA6c=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] PCI/ATS: Cache PASID Capability offset
Date:   Thu,  5 Sep 2019 14:31:46 -0500
Message-Id: <20190905193146.90250-6-helgaas@kernel.org>
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

Previously each PASID interface searched for the PASID Capability.  Cache
the capability offset the first time we use it instead of searching each
time.

[bhelgaas: commit log, reorder patch to later, save offset directly in
pci_enable_pasid() rather than adding pci_pasid_init()]
Link: https://lore.kernel.org/r/4957778959fa34eab3e8b3065d1951989c61cb0f.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c   | 43 +++++++++++++++++++++----------------------
 include/linux/pci.h |  1 +
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index bc463e2ecc61..cb4f62da7b8a 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -305,7 +305,7 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
-	int pos;
+	int pasid = pdev->pasid_cap;
 
 	/*
 	 * VFs must not implement the PASID Capability, but if a PF
@@ -323,11 +323,14 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pdev->eetlp_prefix_path)
 		return -EINVAL;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
-		return -EINVAL;
+	if (!pasid) {
+		pasid = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
+		if (!pasid)
+			return -EINVAL;
+		pdev->pasid_cap = pasid;
+	}
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
 	/* User wants to enable anything unsupported? */
@@ -337,7 +340,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	control = PCI_PASID_CTRL_ENABLE | features;
 	pdev->pasid_features = features;
 
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pasid + PCI_PASID_CTRL, control);
 
 	pdev->pasid_enabled = 1;
 
@@ -352,7 +355,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
 void pci_disable_pasid(struct pci_dev *pdev)
 {
 	u16 control = 0;
-	int pos;
+	int pasid = pdev->pasid_cap;
 
 	/* VFs share the PF PASID configuration */
 	if (pdev->is_virtfn)
@@ -361,11 +364,10 @@ void pci_disable_pasid(struct pci_dev *pdev)
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pasid)
 		return;
 
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pasid + PCI_PASID_CTRL, control);
 
 	pdev->pasid_enabled = 0;
 }
@@ -378,7 +380,7 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
 void pci_restore_pasid_state(struct pci_dev *pdev)
 {
 	u16 control;
-	int pos;
+	int pasid = pdev->pasid_cap;
 
 	if (pdev->is_virtfn)
 		return;
@@ -386,12 +388,11 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 	if (!pdev->pasid_enabled)
 		return;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pasid)
 		return;
 
 	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
-	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+	pci_write_config_word(pdev, pasid + PCI_PASID_CTRL, control);
 }
 EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 
@@ -408,16 +409,15 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 int pci_pasid_features(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pos;
+	int pasid = pdev->pasid_cap;
 
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pasid)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
@@ -470,16 +470,15 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 int pci_max_pasids(struct pci_dev *pdev)
 {
 	u16 supported;
-	int pos;
+	int pasid = pdev->pasid_cap;
 
 	if (pdev->is_virtfn)
 		pdev = pci_physfn(pdev);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
-	if (!pos)
+	if (!pasid)
 		return -EINVAL;
 
-	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
+	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 
 	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c81a24172b14..7ddbb6445e1a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -458,6 +458,7 @@ struct pci_dev {
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
 #endif
 #ifdef CONFIG_PCI_PASID
+	u16		pasid_cap;	/* PASID Capability offset */
 	u16		pasid_features;
 #endif
 #ifdef CONFIG_PCI_P2PDMA
-- 
2.23.0.187.g17f5b7556c-goog


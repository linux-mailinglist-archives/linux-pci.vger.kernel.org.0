Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CA5B4088
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiIIUZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiIIUZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A01B6021;
        Fri,  9 Sep 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3606B8263E;
        Fri,  9 Sep 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DDBC433C1;
        Fri,  9 Sep 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755123;
        bh=osBGQBq81cdigo1SlHO1QZx8Vb8RHqcYx6aePTtgeXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzMIjXfcpO2JYUy2jUpXt8Ihq/NuZbb3yeLMok0Yp6r2kp42k6C0bHylgvCDn6Wm5
         3OM/d++3STagNEAdXXUqdkihqXIWgKEmJX1r9p4pt88oftfqjP/d4sNXypcddxIqd1
         4w7Vt+QEaIpEfGSKsQeeiXMvmmQEij0hTYwvdyT43oo0gEWIn6XThsJ9DiLlG139XE
         ePoyYwRUxmgMdhm8g06cU0O/Hk+h8JEva0uhKgn+LdyX0wO/VdTZPtRu/iUuIfDfqe
         2MeA25cxDGI6Z4LLeFATzfoQNpBAOs9SG2g2zwOGJBROHBA/pF7McwBB19NuAOuost
         +QcMMxXxEMDig==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 7/9] PCI/PTM: Reorder functions in logical order
Date:   Fri,  9 Sep 2022 15:25:03 -0500
Message-Id: <20220909202505.314195-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202505.314195-1-helgaas@kernel.org>
References: <20220909202505.314195-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_ptm() and pci_disable_ptm() were separated.
pci_save_ptm_state() and pci_restore_ptm_state() dangled at the top.  Move
them to logical places.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 124 ++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 5b8598b222b0..b4e5f553467c 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -9,68 +9,6 @@
 #include <linux/pci.h>
 #include "../pci.h"
 
-static void __pci_disable_ptm(struct pci_dev *dev)
-{
-	u16 ptm = dev->ptm_cap;
-	u32 ctrl;
-
-	if (!ptm)
-		return;
-
-	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
-	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
-}
-
-/**
- * pci_disable_ptm() - Disable Precision Time Measurement
- * @dev: PCI device
- *
- * Disable Precision Time Measurement for @dev.
- */
-void pci_disable_ptm(struct pci_dev *dev)
-{
-	if (dev->ptm_enabled) {
-		__pci_disable_ptm(dev);
-		dev->ptm_enabled = 0;
-	}
-}
-EXPORT_SYMBOL(pci_disable_ptm);
-
-void pci_save_ptm_state(struct pci_dev *dev)
-{
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
-}
-
-void pci_restore_ptm_state(struct pci_dev *dev)
-{
-	u16 ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
-	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
-}
-
 /*
  * If the next upstream device supports PTM, return it; otherwise return
  * NULL.  PTM Messages are local, so both link partners must support it.
@@ -146,6 +84,40 @@ void pci_ptm_init(struct pci_dev *dev)
 		pci_enable_ptm(dev, NULL);
 }
 
+void pci_save_ptm_state(struct pci_dev *dev)
+{
+	u16 ptm = dev->ptm_cap;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
+}
+
+void pci_restore_ptm_state(struct pci_dev *dev)
+{
+	u16 ptm = dev->ptm_cap;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
+}
+
 /* Enable PTM in the Control register if possible */
 static int __pci_enable_ptm(struct pci_dev *dev)
 {
@@ -226,6 +198,34 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 }
 EXPORT_SYMBOL(pci_enable_ptm);
 
+static void __pci_disable_ptm(struct pci_dev *dev)
+{
+	u16 ptm = dev->ptm_cap;
+	u32 ctrl;
+
+	if (!ptm)
+		return;
+
+	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
+	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
+}
+
+/**
+ * pci_disable_ptm() - Disable Precision Time Measurement
+ * @dev: PCI device
+ *
+ * Disable Precision Time Measurement for @dev.
+ */
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	if (dev->ptm_enabled) {
+		__pci_disable_ptm(dev);
+		dev->ptm_enabled = 0;
+	}
+}
+EXPORT_SYMBOL(pci_disable_ptm);
+
 /*
  * Disable PTM, but preserve dev->ptm_enabled so we silently re-enable it on
  * resume if necessary.
-- 
2.25.1


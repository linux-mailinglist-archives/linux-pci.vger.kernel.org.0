Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C75AF7EF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIFWYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIFWYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA4AEDA9;
        Tue,  6 Sep 2022 15:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E87D8CE18A3;
        Tue,  6 Sep 2022 22:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D77C43149;
        Tue,  6 Sep 2022 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503052;
        bh=RqustZvweOUGMZRzXAxz1L58dl8uzoXmJZ6vgqdeZw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVzSCHFQefHgDDstD/MthGIhvD0pGHpJ+v3D2GtaJxL/NlaD0nIbblnfoctu7hbr6
         QsFxSOS724ILyn1x6fALh2JzRt2SXKig/m8zF1D1Sx+ON/sefyroJkWXH6pWBGUzmO
         Wuw9Ag22NPPAIZ1VXf5J0puU3BdLtM47iOrN6g/xOIaNgz96UegXZ49S+jmTKTxCKS
         ausPxIZMnThbUldg0CLzLki/pwFQQQlKN8d6NFkypHEfDc2KbKqYrkIwLgRdyHU2xh
         k88FISCnglQ7o6l59yluzs6ayy+NDGAMnmW7UobDyEZUHglQH3IVsRCrS4HHe1TA7+
         WeqLHF3GL9mFQ==
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
Subject: [PATCH v3 09/10] PCI/PTM: Reorder functions in logical order
Date:   Tue,  6 Sep 2022 17:23:50 -0500
Message-Id: <20220906222351.64760-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906222351.64760-1-helgaas@kernel.org>
References: <20220906222351.64760-1-helgaas@kernel.org>
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
them to logical places.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 108 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index d65f5af9700d..6c09e00a7b51 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -9,60 +9,6 @@
 #include <linux/pci.h>
 #include "../pci.h"
 
-static void __pci_disable_ptm(struct pci_dev *dev)
-{
-	int ptm = dev->ptm_cap;
-	u16 ctrl;
-
-	if (!ptm)
-		return;
-
-	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
-	ctrl &= ~PCI_PTM_CTRL_ENABLE;
-	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
-}
-
-void pci_disable_ptm(struct pci_dev *dev)
-{
-	__pci_disable_ptm(dev);
-	dev->ptm_enabled = 0;
-}
-EXPORT_SYMBOL(pci_disable_ptm);
-
-void pci_save_ptm_state(struct pci_dev *dev)
-{
-	int ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
-}
-
-void pci_restore_ptm_state(struct pci_dev *dev)
-{
-	int ptm = dev->ptm_cap;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!ptm)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state)
-		return;
-
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
-}
-
 /*
  * If the next upstream device supports PTM, return it; otherwise return
  * NULL.  PTM Messages are local, so both link partners must support it.
@@ -132,6 +78,40 @@ void pci_ptm_init(struct pci_dev *dev)
 		pci_enable_ptm(dev, NULL);
 }
 
+void pci_save_ptm_state(struct pci_dev *dev)
+{
+	int ptm = dev->ptm_cap;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
+}
+
+void pci_restore_ptm_state(struct pci_dev *dev)
+{
+	int ptm = dev->ptm_cap;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+}
+
 static int __pci_enable_ptm(struct pci_dev *dev)
 {
 	int ptm = dev->ptm_cap;
@@ -193,6 +173,26 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 }
 EXPORT_SYMBOL(pci_enable_ptm);
 
+static void __pci_disable_ptm(struct pci_dev *dev)
+{
+	int ptm = dev->ptm_cap;
+	u16 ctrl;
+
+	if (!ptm)
+		return;
+
+	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
+	ctrl &= ~PCI_PTM_CTRL_ENABLE;
+	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+}
+
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	__pci_disable_ptm(dev);
+	dev->ptm_enabled = 0;
+}
+EXPORT_SYMBOL(pci_disable_ptm);
+
 /*
  * Disable PTM, but leave dev->ptm_enabled so we silently re-enable it on
  * resume.
-- 
2.25.1


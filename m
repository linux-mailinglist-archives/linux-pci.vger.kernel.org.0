Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823145AB515
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiIBP0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiIBPZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:25:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80F11174;
        Fri,  2 Sep 2022 07:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74F4B82AA5;
        Fri,  2 Sep 2022 14:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7EDC433D6;
        Fri,  2 Sep 2022 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130726;
        bh=uzY06CopRRaEJRGHbkvXaWAGjIg0UAO24abGF6DIl4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pnq6ep8pp4OnVahvn2SuBrvUKdu7qRlJtn2lPDXpVUkrqIu/OppfnQDKis2Ci2wQY
         /RtTjMx/JsAQoEjDNG2kJbYpk5k/pAf+TdYKW/1kwW81V954x4+TP7XQr7cs5Q4P4x
         8YSJQhJu380iTCuhq5HT9vYh6u98lfbtzURTtxNfTziD6mpXoDDBkrShLAmam/IGYe
         zin1BYydt9+FeLYmx+9RpB3iMCvAuDfqdY23PDOGEWMWhjwxtJMgtq/52ZFMG1Vcg5
         ylWZeN6zB+YWP3Qp+6n5GQ+vpjEDmtVJF9Ww9rU3NQrYDJGpz93IxmZJ/8GLr5MmLc
         +U2T05gVNmeRA==
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
Subject: [PATCH 4/4] PCI/PTM: Cache PTM Capability offset
Date:   Fri,  2 Sep 2022 09:58:35 -0500
Message-Id: <20220902145835.344302-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902145835.344302-1-helgaas@kernel.org>
References: <20220902145835.344302-1-helgaas@kernel.org>
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

Cache the PTM Capability offset in struct pci_dev so we don't have to
search for it every time we enable/disable/save/restore.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 46 ++++++++++++++++--------------------------
 include/linux/pci.h    |  1 +
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 3115601a85ef..8f38ba7b386c 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -31,14 +31,10 @@ static void pci_ptm_info(struct pci_dev *dev)
 
 void pci_disable_ptm(struct pci_dev *dev)
 {
-	int ptm;
+	u16 ptm = dev->ptm_cap;
 	u16 ctrl;
 
-	if (!pci_is_pcie(dev))
-		return;
-
-	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!ptm)
+	if (!ptm || !dev->ptm_enabled)
 		return;
 
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
@@ -48,14 +44,10 @@ void pci_disable_ptm(struct pci_dev *dev)
 
 void pci_save_ptm_state(struct pci_dev *dev)
 {
-	int ptm;
+	u16 ptm = dev->ptm_cap;
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
-		return;
-
-	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
 
@@ -69,16 +61,15 @@ void pci_save_ptm_state(struct pci_dev *dev)
 
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
+	u16 ptm = dev->ptm_cap;
 	struct pci_cap_saved_state *save_state;
-	int ptm;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (!ptm)
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state || !ptm)
+	if (!save_state)
 		return;
 
 	cap = (u16 *)&save_state->cap.data[0];
@@ -95,10 +86,10 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 
 void pci_ptm_init(struct pci_dev *dev)
 {
-	int pos;
+	struct pci_dev *ups;
+	u16 ptm;
 	u32 cap, ctrl;
 	u8 local_clock;
-	struct pci_dev *ups;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -125,13 +116,14 @@ void pci_ptm_init(struct pci_dev *dev)
 		return;
 	}
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!pos)
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	dev->ptm_cap = ptm;
+	if (!ptm)
 		return;
 
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
 
-	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
 	/*
@@ -156,7 +148,7 @@ void pci_ptm_init(struct pci_dev *dev)
 	}
 
 	ctrl |= dev->ptm_granularity << 8;
-	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
 	pci_ptm_info(dev);
@@ -164,18 +156,14 @@ void pci_ptm_init(struct pci_dev *dev)
 
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
-	int pos;
+	u16 ptm = dev->ptm_cap;
 	u32 cap, ctrl;
 	struct pci_dev *ups;
 
-	if (!pci_is_pcie(dev))
+	if (!ptm)
 		return -EINVAL;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!pos)
-		return -EINVAL;
-
-	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	if (!(cap & PCI_PTM_CAP_REQ))
 		return -EINVAL;
 
@@ -200,7 +188,7 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 
 	ctrl = PCI_PTM_CTRL_ENABLE;
 	ctrl |= dev->ptm_granularity << 8;
-	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
 	pci_ptm_info(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..f6c162d06bff 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,6 +475,7 @@ struct pci_dev {
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
 #endif
 #ifdef CONFIG_PCIE_PTM
+	u16		ptm_cap;		/* PTM Capability offset */
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_enabled:1;
 	u8		ptm_granularity;
-- 
2.25.1


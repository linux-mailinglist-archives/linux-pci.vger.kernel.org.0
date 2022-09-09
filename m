Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A95B4078
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIIUZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIIUZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877D9AFCF;
        Fri,  9 Sep 2022 13:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA2A1B8262E;
        Fri,  9 Sep 2022 20:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66654C433C1;
        Fri,  9 Sep 2022 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755111;
        bh=xqULWsTalOs94hkmDd/bX7sHzFXKvkTiUGOJQyppO3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8P+RSBUMwdwMlJPY4+/pBk+RovC7nforXvQYK8FNfL0YXV9Oh/MY8ND0iZserc3a
         MH4DXmeDtFbjzEceIhQVCuL27H0LJKejxzrVV80QV5j4PgdxadX74e8IvdYRjeSNTR
         PjohfnBjdtsRW2vo5NIBQV6a9qwHgVxKz0FqSP3IfQ3nvSy88jzTdtPJQz84FX4C8U
         PqsS36JkTUkWk5ZZvZEa3P6pxlsmCd2pxww/6wr46K8bzJdiJCL0gS+agJ+Z6bDo+m
         OtWGeswdVYEQ16Y4gidDAuF5wCgcLXOjjXEwupgvrX2p+NfBDpx/2bht1Zer1EPKQ6
         53RyotpRxUoEA==
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
Subject: [PATCH v4 1/9] PCI/PTM: Cache PTM Capability offset
Date:   Fri,  9 Sep 2022 15:24:57 -0500
Message-Id: <20220909202505.314195-2-helgaas@kernel.org>
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

Cache the PTM Capability offset instead of searching for it every time we
enable/disable PTM or save/restore PTM state.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 41 +++++++++++++++++------------------------
 include/linux/pci.h    |  1 +
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..85382c135885 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -31,13 +31,9 @@ static void pci_ptm_info(struct pci_dev *dev)
 
 void pci_disable_ptm(struct pci_dev *dev)
 {
-	int ptm;
+	u16 ptm = dev->ptm_cap;
 	u16 ctrl;
 
-	if (!pci_is_pcie(dev))
-		return;
-
-	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
 
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
@@ -87,7 +78,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 
 void pci_ptm_init(struct pci_dev *dev)
 {
-	int pos;
+	u16 ptm;
 	u32 cap, ctrl;
 	u8 local_clock;
 	struct pci_dev *ups;
@@ -117,13 +108,14 @@ void pci_ptm_init(struct pci_dev *dev)
 		return;
 	}
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!pos)
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!ptm)
 		return;
 
+	dev->ptm_cap = ptm;
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
 
-	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
 	/*
@@ -148,7 +140,7 @@ void pci_ptm_init(struct pci_dev *dev)
 	}
 
 	ctrl |= dev->ptm_granularity << 8;
-	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
 	pci_ptm_info(dev);
@@ -156,18 +148,19 @@ void pci_ptm_init(struct pci_dev *dev)
 
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
-	int pos;
+	u16 ptm;
 	u32 cap, ctrl;
 	struct pci_dev *ups;
 
 	if (!pci_is_pcie(dev))
 		return -EINVAL;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
-	if (!pos)
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!ptm)
 		return -EINVAL;
 
-	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	dev->ptm_cap = ptm;
+	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	if (!(cap & PCI_PTM_CAP_REQ))
 		return -EINVAL;
 
@@ -192,7 +185,7 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 
 	ctrl = PCI_PTM_CTRL_ENABLE;
 	ctrl |= dev->ptm_granularity << 8;
-	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
 	pci_ptm_info(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..54be939023a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -475,6 +475,7 @@ struct pci_dev {
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
 #endif
 #ifdef CONFIG_PCIE_PTM
+	u16		ptm_cap;		/* PTM Capability */
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_enabled:1;
 	u8		ptm_granularity;
-- 
2.25.1


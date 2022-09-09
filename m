Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F735B4084
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiIIUZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIIUZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE0B5E58;
        Fri,  9 Sep 2022 13:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E51620D8;
        Fri,  9 Sep 2022 20:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DD4C433D6;
        Fri,  9 Sep 2022 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755121;
        bh=gCTTUyJFlkhMjMmtwMVdlaO1Gacl19G9VgV01rTVCXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7M0P30jMkBdmRH4hy74hPm+jIw/qPzmn5wLoc0x0DP0XXvxTCB9FTv0ZREty8DsB
         5dRQUv4ngfX4cnwx7FdEiLiu3/9gfJEabW8fKuPq0fmFkEEqPHc64ggN1bzDkltdQu
         Jf6N+/zSfusH9Ke5efmwYwoBN6/k9ZPGxNtaI6P/kGbVfMrBSE6vE2qeiS9i8VeG0Y
         m//uHdAsQv0Ue+TBm/r1I+ap/hjmQA52hNdOqDSRu99X13IDplWATkgus62oWRR38u
         Hidolb639QpBSSwwetsrfJulcMUybLClHRAcXgi1LZXuGqXJtU1uA/w7m7diLs5po0
         cyTi7Lt5xAd9A==
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
Subject: [PATCH v4 6/9] PCI/PTM: Preserve RsvdP bits in PTM Control register
Date:   Fri,  9 Sep 2022 15:25:02 -0500
Message-Id: <20220909202505.314195-7-helgaas@kernel.org>
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

Even though only the low 16 bits of PTM Control are currently defined, the
register is 32 bits wide and the unused bits are RsvdP ("Reserved and
Preserved"), so software must preserve the values of those bits when
writing the register.

Update PTM Control reads and writes to use 32-bit accesses and preserve the
reserved bits on writes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index fc296b352fe2..5b8598b222b0 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -12,14 +12,14 @@
 static void __pci_disable_ptm(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
-	u16 ctrl;
+	u32 ctrl;
 
 	if (!ptm)
 		return;
 
-	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
+	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
-	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 }
 
 /**
@@ -41,7 +41,7 @@ void pci_save_ptm_state(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u32 *cap;
 
 	if (!ptm)
 		return;
@@ -50,15 +50,15 @@ void pci_save_ptm_state(struct pci_dev *dev)
 	if (!save_state)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, cap);
 }
 
 void pci_restore_ptm_state(struct pci_dev *dev)
 {
 	u16 ptm = dev->ptm_cap;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u32 *cap;
 
 	if (!ptm)
 		return;
@@ -67,8 +67,8 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 	if (!save_state)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, *cap);
 }
 
 /*
@@ -112,7 +112,7 @@ void pci_ptm_init(struct pci_dev *dev)
 		return;
 
 	dev->ptm_cap = ptm;
-	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
+	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u32));
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
 	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
@@ -170,7 +170,10 @@ static int __pci_enable_ptm(struct pci_dev *dev)
 			return -EINVAL;
 	}
 
-	ctrl = PCI_PTM_CTRL_ENABLE;
+	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
+
+	ctrl |= PCI_PTM_CTRL_ENABLE;
+	ctrl &= ~PCI_PTM_GRANULARITY_MASK;
 	ctrl |= dev->ptm_granularity << 8;
 	if (dev->ptm_root)
 		ctrl |= PCI_PTM_CTRL_ROOT;
-- 
2.25.1


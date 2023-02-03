Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3268A650
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBCWsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBCWsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 17:48:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6355295;
        Fri,  3 Feb 2023 14:48:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B206203D;
        Fri,  3 Feb 2023 22:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F03C433EF;
        Fri,  3 Feb 2023 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675464516;
        bh=mBTynaOHvB5wijqQWawf4+XzyNc0Grg7uVCjcdRmT44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQi68DURfPuhzRtLyA3bUVMFd0yfQN/zzQoK6kmL5JoWCUiHABqSN5cCjLF2Rbziw
         B5UBX/ki0vRljrGRfKVt8UO+vPu8x1fUc60xpCbZJh3ZwqrH/5QvPQVG+T7G26BPCi
         ItpmkA4R5Bd4XmUCavs8PMNWb+KJEYIMMXdBe01/RMcxzLZ0US762bYz9L0cmZgqbf
         Q1pI72PugS/0BlBmb0tM4fg8hLx+5vh7zdp/sbV6oTdLaARtXb5lo9oYNlzYbjmlgf
         E2g9fPGiMEhrG/DKK5Zq2hmi7v1mOYhfq/124qtKIK2kEh2QQ+AZ3VBhcp5avsM59B
         4B3eDDizQtuYQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Witt <kernel@witt.link>, Vidya Sagar <vidyas@nvidia.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] Revert "PCI/ASPM: Refactor L1 PM Substates Control Register programming"
Date:   Fri,  3 Feb 2023 16:48:20 -0600
Message-Id: <20230203224820.2056582-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203224820.2056582-1-helgaas@kernel.org>
References: <20230203224820.2056582-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 5e85eba6f50dc288c22083a7e213152bcc4b8208.

Thomas Witt reported that 5e85eba6f50d ("PCI/ASPM: Refactor L1 PM Substates
Control Register programming") broke suspend/resume on a Tuxedo
Infinitybook S 14 v5, which seems to use a Clevo L140CU Mainboard.

The main symptom is:

  iwlwifi 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
  nvme 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible

and the machine is only partially usable after resume.  It can't run dmesg
and can't do a clean reboot.  This happens on every suspend/resume cycle.

Revert 5e85eba6f50d until we can figure out the root cause.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=216877
Reported-by: Thomas Witt <kernel@witt.link>
Tested-by: Thomas Witt <kernel@witt.link>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pcie/aspm.c | 72 +++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 915cbd939dd9..4b4184563a92 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -470,31 +470,6 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 	pci_write_config_dword(pdev, pos, val);
 }
 
-static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
-{
-	u16 l1ss = dev->l1ss;
-	u32 l1_2_enable;
-
-	/*
-	 * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
-	 * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
-	 */
-	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
-
-	/*
-	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
-	 * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
-	 * enable bits, even though they're all in PCI_L1SS_CTL1.
-	 */
-	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
-	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
-
-	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
-	if (l1_2_enable)
-		pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
-				       ctl1 | l1_2_enable);
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -504,6 +479,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
+	u32 pl1_2_enables, cl1_2_enables;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
@@ -552,21 +528,39 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
 
-	pctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
-		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
-	pctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
-			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
-	aspm_program_l1ss(parent, pctl1, ctl2);
+	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
+	pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
 
-	cctl1 &= ~(PCI_L1SS_CTL1_CM_RESTORE_TIME |
-		   PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-		   PCI_L1SS_CTL1_LTR_L12_TH_SCALE);
-	cctl1 |= (ctl1 & (PCI_L1SS_CTL1_CM_RESTORE_TIME |
-			  PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-			  PCI_L1SS_CTL1_LTR_L12_TH_SCALE));
-	aspm_program_l1ss(child, cctl1, ctl2);
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+	}
+
+	/* Program T_POWER_ON times in both ports */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/* Program Common_Mode_Restore_Time in upstream device */
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+
+	/* Program LTR_L1.2_THRESHOLD time in both ports */
+	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
+					pl1_2_enables);
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
+					cl1_2_enables);
+	}
 }
 
 static void aspm_l1ss_init(struct pcie_link_state *link)
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069435984B6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbiHRNvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiHRNvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7006110B
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE4CB82195
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39BC4347C;
        Thu, 18 Aug 2022 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830707;
        bh=G+gw4VfrgeslPZXeo4NP+QRBVZNGHXSb8Gk3ybhCeNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCe6mgF8NVsLo4WYzxxNSY0CYnqJa4nUXwrnntOyCfVtluPUbEjhmpGnjX2IBuYa5
         lDRXerOBflsgFVaPAFLZ0XFIPTB/W5AKNOAKaanT5131FSp4YDOOQG0K7sWzq2SYnr
         04a8tWUDUvTRHldJNk0UgtVTs0+s6hiejZUL+nYGJNFKV5+BS4S8eX+Vlnm8LzpqQX
         c73prcmgPcPMozScCGRpMiRVjynpsZRCfuj1QsMuGBDSC25M3v/aLNy7dV3fzDoHQq
         xZu4T4oMV+KPcm09/qxup5cPFnI72SnrRLzX9IZoOBH4d2iwGYM9C3E2lplSCzYoI2
         39+dJnulE7a3w==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 01/11] PCI: pciehp: Enable DLLSC interrupt only if supported
Date:   Thu, 18 Aug 2022 15:51:30 +0200
Message-Id: <20220818135140.5996-2-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Don't enable Data Link Layer State Changed interrupt if it isn't
supported.

Data Link Layer Link Active Reporting Capable bit in Link Capabilities
register indicates if Data Link Layer State Changed Enable is supported.

Although Lukas Wunner says [1]
  According to PCIe r6.0, sec. 7.5.3.6, "For a hot-plug capable
  Downstream Port [...], this bit must be hardwired to 1b."
the reason we want this is because of the pci-bridge-emul driver, which
emulates a bridge, but does not support asynchronous operations (since
implementing them is unneeded and would require massive changes to the
whole driver). Therefore enabling DLLSC unconditionally makes the
corresponding bit set only in the emulated configuration space of the
pci-bridge-emul driver, which
- results in confusing information when dumping the config space (it
  says that the interrupt is not supported but enabled), which may
  confuse developers when debugging PCIe issues,
- may cause bugs in the future if someone adds code that checks whether
  DLLSC is enabled and then waits for the interrupt.

[1] https://www.spinics.net/lists/linux-pci/msg124727.html

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since batch 5:
- changed commit message, previously we wrote that the change is needed
  to fix a bug where kernel was waiting for an event which did not
  come. This turns out to be false. See
  https://lore.kernel.org/linux-pci/20220818142243.4c046c59@dellmb/T/#u
---
 drivers/pci/hotplug/pciehp_hpc.c | 30 +++++++++++++++++++++++-------
 drivers/pci/hotplug/pnv_php.c    | 13 +++++++++----
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 040ae076ec0e..373bb396fe22 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -788,6 +788,7 @@ static int pciehp_poll(void *data)
 static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
+	u32 link_cap;
 
 	/*
 	 * TBD: Power fault detected software notification support.
@@ -800,12 +801,17 @@ static void pcie_enable_notification(struct controller *ctrl)
 	 * next power fault detected interrupt was notified again.
 	 */
 
+	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
+
 	/*
-	 * Always enable link events: thus link-up and link-down shall
-	 * always be treated as hotplug and unplug respectively. Enable
-	 * presence detect only if Attention Button is not present.
+	 * Enable link events if their support is indicated in Link Capability
+	 * register: thus link-up and link-down shall always be treated as
+	 * hotplug and unplug respectively. Enable presence detect only if
+	 * Attention Button is not present.
 	 */
-	cmd = PCI_EXP_SLTCTL_DLLSCE;
+	cmd = 0;
+	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
+		cmd |= PCI_EXP_SLTCTL_DLLSCE;
 	if (ATTN_BUTTN(ctrl))
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	else
@@ -844,9 +850,14 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
 
 void pcie_enable_interrupt(struct controller *ctrl)
 {
+	u32 link_cap;
 	u16 mask;
 
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
+
+	mask = PCI_EXP_SLTCTL_HPIE;
+	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
+		mask |= PCI_EXP_SLTCTL_DLLSCE;
 	pcie_write_cmd(ctrl, mask, mask);
 }
 
@@ -904,19 +915,24 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
+	u32 link_cap;
 	int rc;
 
 	if (probe)
 		return 0;
 
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
+
 	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
 	}
-	ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
-	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
+	if (link_cap & PCI_EXP_LNKCAP_DLLLARC) {
+		ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+		stat_mask |= PCI_EXP_SLTSTA_DLLSC;
+	}
 
 	pcie_write_cmd(ctrl, 0, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 881d420637bf..118b514f66b9 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -841,6 +841,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	struct pci_dev *pdev = php_slot->pdev;
 	u32 broken_pdc = 0;
 	u16 sts, ctrl;
+	u32 link_cap;
 	int ret;
 
 	/* Allocate workqueue */
@@ -874,17 +875,21 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 		return;
 	}
 
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
+
 	/* Enable the interrupts */
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
 	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
 		ctrl &= ~PCI_EXP_SLTCTL_PDCE;
-		ctrl |= (PCI_EXP_SLTCTL_HPIE |
-			 PCI_EXP_SLTCTL_DLLSCE);
+		ctrl |= PCI_EXP_SLTCTL_HPIE;
 	} else {
 		ctrl |= (PCI_EXP_SLTCTL_HPIE |
-			 PCI_EXP_SLTCTL_PDCE |
-			 PCI_EXP_SLTCTL_DLLSCE);
+			 PCI_EXP_SLTCTL_PDCE);
 	}
+	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
+		ctrl |= PCI_EXP_SLTCTL_DLLSCE;
+	else
+		ctrl &= ~PCI_EXP_SLTCTL_DLLSCE;
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
 
 	/* The interrupt is initialized successfully when @irq is valid */
-- 
2.35.1


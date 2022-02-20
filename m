Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851D4BD0FE
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiBTTe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiBTTe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDD4506A
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D07B60EF2
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D3C340F7;
        Sun, 20 Feb 2022 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385645;
        bh=+DIDG7ZqJRenehV9m8WH6MaZnxN7NQnEWQVZ2bUhJ/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHQWjFAvD2/2yYKJR1FAlCDln77yr07SSWw2KZ9jHFb5spba0d3bzb92nCpaSm3ck
         4DigKxy6dH+DbX6RATKL63EDZLce9OToFt/ngOY0YdAq+B6m+L+7LO+GmYrIVRDte6
         w7an8ar3rhJAXkdXCA8UPmvAL/KrIHxPZREpOEeI6blczQO/12Zvjt53xWshXp8SDN
         nPx6fmx+WnBUblJJMaSUz8ZoN9B3zZe2uIvs6kpl29gXCbfoFfIH3lSr5zk3ByFTC+
         m7yTyYSEI94WupbSEL/d+tBdssd+sejref88b4Gu8+3lxLWxqC+tIYT7y2HGNJHpEg
         0Ntamb9n1HM7w==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 06/18] PCI: pciehp: Enable DLLSC interrupt only if supported
Date:   Sun, 20 Feb 2022 20:33:34 +0100
Message-Id: <20220220193346.23789-7-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Pali Rohár <pali@kernel.org>

Don't enable Data Link Layer State Changed interrupt if it isn't
supported.

Data Link Layer Link Active Reporting Capable bit in Link Capabilities
register indicates if Data Link Layer State Changed Enable is supported.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
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
index f4c2e6e01be0..e05e8460eb2c 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -840,6 +840,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	struct pci_dev *pdev = php_slot->pdev;
 	u32 broken_pdc = 0;
 	u16 sts, ctrl;
+	u32 link_cap;
 	int ret;
 
 	/* Allocate workqueue */
@@ -873,17 +874,21 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
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
2.34.1


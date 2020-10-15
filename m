Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97F28F984
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbgJOTbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391669AbgJOTbK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:10 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020812072D;
        Thu, 15 Oct 2020 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790269;
        bh=JutDbIjNo+0FiqISzqPkyw0jmSNipIeACOXqS9f0RQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9/nhA1GbVN+TnsOFMWZHvlA6cVcArYawDwceJL18WEmftWVkXFnoT8wE+585yVer
         1+BIRrxxTMyGHppvRyFvO7OaH4qrfA9KZQB2rVB4GEXv/ihoRcD3EjgGmgZ8MERIVR
         sLoWa5/gYlaOft+U6f6HXpXhwcEmTlR9bvKRKHUo=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 11/12] PCI/ASPM: Remove struct aspm_register_info.l1ss_cap
Date:   Thu, 15 Oct 2020 14:30:38 -0500
Message-Id: <20201015193039.12585-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we stored the L1SS Capabilities value in the struct
aspm_register_info.

We only need this information in one place, so read it there and remove
struct aspm_register_info completely, since it's now empty.  No functional
change intended.

[bhelgaas: split up, don't cache l1ss_cap in pci_dev]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 53 ++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8c6b976d8b50..d76f23908d67 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -382,26 +382,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	}
 }
 
-struct aspm_register_info {
-	/* L1 substates */
-	u32 l1ss_cap;
-};
-
-static void pcie_get_aspm_reg(struct pci_dev *pdev,
-			      struct aspm_register_info *info)
-{
-	/* Read L1 PM substate capabilities */
-	info->l1ss_cap = 0;
-
-	if (!pdev->l1ss)
-		return;
-
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP,
-			      &info->l1ss_cap);
-	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		info->l1ss_cap = 0;
-}
-
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_switch_latency = 0;
@@ -527,9 +507,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
+	u32 parent_l1ss_cap, child_l1ss_cap;
 	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 	struct pci_bus *linkbus = parent->subordinate;
-	struct aspm_register_info upreg, dwreg;
 
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -560,8 +540,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
 
 	/*
 	 * Setup L0s state
@@ -589,27 +567,38 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
 	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
-	/* Setup L1 substate
+	/* Setup L1 substate */
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
+			      &parent_l1ss_cap);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
+			      &child_l1ss_cap);
+
+	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		parent_l1ss_cap = 0;
+	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		child_l1ss_cap = 0;
+
+	/*
 	 * If we don't have LTR for the entire path from the Root Complex
 	 * to this device, we can't use ASPM L1.2 because it relies on the
 	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
 	 */
 	if (!child->ltr_path)
-		dwreg.l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
 
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
-	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
 
-	if (upreg.l1ss_cap)
+	if (parent_l1ss_cap)
 		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				      &parent_l1ss_ctl1);
-	if (dwreg.l1ss_cap)
+	if (child_l1ss_cap)
 		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				      &child_l1ss_ctl1);
 
@@ -623,7 +612,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, upreg.l1ss_cap, dwreg.l1ss_cap);
+		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
 
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
-- 
2.25.1


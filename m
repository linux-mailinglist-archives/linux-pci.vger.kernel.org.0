Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEB28F981
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbgJOTbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391663AbgJOTbG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:06 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43EE7206DD;
        Thu, 15 Oct 2020 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790265;
        bh=OR17RUHbbCdmzYzX8/EpGdbQZ2+xd5ITl0T/6gUEYfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcD1Hhz2getDd6qENJV6NODbXhV6KRDy4Y3T4fyCWZlFFbr2hdyeUj5AUyXf19XEw
         36NuZHQa09d+ohVtgQhPeEpmqlYeqr7/mOMBul2il1L3+hgwJWIL8BMG6wCOhyaYJM
         7SWlRVvCtEftKnmHUX+9wYeg4p8lf/pdY6DGDpik=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 09/12] PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl1
Date:   Thu, 15 Oct 2020 14:30:36 -0500
Message-Id: <20201015193039.12585-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we stored the L1SS Control 1 register in the struct
aspm_register_info.

We only need this information in one place, so read it there and remove it
from struct aspm_register_info.  No functional change intended.

[bhelgaas: split ctl1/ctl2]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3afa6c418f54..896f6c0b08c6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -385,27 +385,21 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 struct aspm_register_info {
 	/* L1 substates */
 	u32 l1ss_cap;
-	u32 l1ss_ctl1;
 };
 
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
 	/* Read L1 PM substate capabilities */
-	info->l1ss_cap = info->l1ss_ctl1 = 0;
+	info->l1ss_cap = 0;
 
 	if (!pdev->l1ss)
 		return;
 
 	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP,
 			      &info->l1ss_cap);
-	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS)) {
+	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
 		info->l1ss_cap = 0;
-		return;
-	}
-
-	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
-			      &info->l1ss_ctl1);
 }
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
@@ -534,6 +528,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
+	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
 
@@ -612,13 +607,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
 		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
 
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+	if (upreg.l1ss_cap)
+		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				      &parent_l1ss_ctl1);
+	if (dwreg.l1ss_cap)
+		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				      &child_l1ss_ctl1);
+
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
 		link->aspm_enabled |= ASPM_STATE_L1_1;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
 		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
-	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
 	if (link->aspm_support & ASPM_STATE_L1SS)
-- 
2.25.1


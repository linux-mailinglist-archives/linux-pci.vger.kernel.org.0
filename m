Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5928F97B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbgJOTbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391634AbgJOTa6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:58 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A58206DD;
        Thu, 15 Oct 2020 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790257;
        bh=ImMkU88F5g3mY5suNRCtu2cVYxORtR49r56fUGVzaFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WW4z/2KiXlOjaQr9oQMyToCWXiDC8CqLQJgIuIl+vYa7/TzIXD+s0WuNrtuNMdV7X
         8o4upWU5IyoIkSf1OrIkFZTt2rFz2S0IQ8DI0UEM0EMpD9y7ghXP5JGmv8L9twNA1V
         5TGpvAKUnmjMaX/hZzpTIWE1feXPHboAtIzDLdR8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 05/12] PCI/ASPM: Remove struct aspm_register_info.enabled
Date:   Thu, 15 Oct 2020 14:30:32 -0500
Message-Id: <20201015193039.12585-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we stored the "ASPM Control" bits from the Link Control register
in the struct aspm_register_info.

Read PCI_EXP_LNKCTL directly when needed.  This means we can use the
PCI_EXP_LNKCTL_ASPM_* bits directly instead of the similar but different
PCIE_LINK_STATE_* bits.  No functional change intended.

[bhelgaas: drop get_aspm_enable() and read LNKCTL once directly]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 82ce34e2ef53..36540879586b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -381,10 +381,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 enabled:2;
 	u32 latency_encoding_l0s;
 	u32 latency_encoding_l1;
-
 	/* L1 substates */
 	u32 l1ss_cap_ptr;
 	u32 l1ss_cap;
@@ -395,14 +393,11 @@ struct aspm_register_info {
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
-	u16 reg16;
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
 	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
-	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
 
 	/* Read L1 PM substate capabilities */
 	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
@@ -549,6 +544,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
+	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
 
@@ -579,6 +575,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 */
 	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
 	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
+	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 	pcie_get_aspm_reg(parent, &upreg);
 	pcie_get_aspm_reg(child, &dwreg);
 
@@ -592,9 +590,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
 
-	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
+	if (child_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
-	if (upreg.enabled & PCIE_LINK_STATE_L0S)
+	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
 	link->latency_dw.l0s = calc_l0s_latency(dwreg.latency_encoding_l0s);
@@ -603,7 +601,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
 		link->aspm_support |= ASPM_STATE_L1;
 
-	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
+	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
-- 
2.25.1


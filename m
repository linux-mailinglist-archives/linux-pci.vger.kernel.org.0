Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11A28F983
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbgJOTbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391674AbgJOTbQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:16 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4260206ED;
        Thu, 15 Oct 2020 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790271;
        bh=20VF0dUejZGIec0Iens0CsGAB0kFAAjoztVbOd3j29w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCykd/HYdHRQgMN6Z+vuCV6bXrA0lC1BBANa57dhbchwVjudkNCYwplm+magj7Kwy
         MJxkr7hZKfJm9cFpDjvtm/bM/ItIombX6pdK1SWqUrDdKKCTv1vxdjEtAMCjzxQO3h
         rGusy83lEHoHMhE/YaXOrJhK1fAV0SGbM6iLsGQk=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 12/12] PCI/ASPM: Remove struct pcie_link_state.l1ss
Date:   Thu, 15 Oct 2020 14:30:39 -0500
Message-Id: <20201015193039.12585-13-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we computed L1.2 parameters in the enumeration path, saved them
in struct pcie_link_state.l1ss, and programmed them into the devices
whenever we enabled or disabled L1.2 on the link.  But these parameters are
constant and don't need to be updated when enabling/disabling L1.2.

Compute and program the L1.2 parameters once during enumeration and remove
the struct pcie_link_state.l1ss member.  No functional change intended.

[bhelgaas: rework to program L1.2 parameters during enumeration]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 55 +++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d76f23908d67..361eaa0c615d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -74,12 +74,6 @@ struct pcie_link_state {
 	 * has one slot under it, so at most there are 8 functions.
 	 */
 	struct aspm_latency acceptable[8];
-
-	/* L1 PM Substate info */
-	struct {
-		u32 ctl1;		/* value to be programmed in ctl1 */
-		u32 ctl2;		/* value to be programmed in ctl2 */
-	} l1ss;
 };
 
 static int aspm_disabled, aspm_force;
@@ -461,8 +455,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
-
-	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
+	u32 ctl1 = 0, ctl2 = 0;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
@@ -480,10 +473,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 	if (calc_l1ss_pwron(parent, scale1, val1) >
 	    calc_l1ss_pwron(child, scale2, val2)) {
-		link->l1ss.ctl2 |= scale1 | (val1 << 3);
+		ctl2 |= scale1 | (val1 << 3);
 		t_power_on = calc_l1ss_pwron(parent, scale1, val1);
 	} else {
-		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+		ctl2 |= scale2 | (val2 << 3);
 		t_power_on = calc_l1ss_pwron(child, scale2, val2);
 	}
 
@@ -499,7 +492,23 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
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
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
@@ -679,30 +688,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 						   PCI_EXP_LNKCTL_ASPM_L1, 0);
 	}
 
-	if (enable_req & ASPM_STATE_L1_2_MASK) {
-
-		/* Program T_POWER_ON times in both ports */
-		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
-		pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
-
-		/* Program Common_Mode_Restore_Time in upstream device */
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_CM_RESTORE_TIME,
-					link->l1ss.ctl1);
-
-		/* Program LTR_L1.2_THRESHOLD time in both ports */
-		pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
-	}
-
 	val = 0;
 	if (state & ASPM_STATE_L1_1)
 		val |= PCI_L1SS_CTL1_ASPM_L1_1;
-- 
2.25.1


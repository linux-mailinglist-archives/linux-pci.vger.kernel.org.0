Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9106828F986
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391652AbgJOTbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391629AbgJOTbC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:02 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6DF20776;
        Thu, 15 Oct 2020 19:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790261;
        bh=DsIgBKxRXuJv/hTxg7yIUIDKWsTz1FUIZxPkb8yzog8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kizkFFCnftiIBBRYDI/GBKo1dtEZLVHN1LqdWIYJKDDV4AK9XIRQhhuwzNIm0YHh2
         o3BIl/sFq8ckIZ5DXtQGXI2wvMmPcY5sX0AHF+nYfhv5QndK183dyZKav3gqFGaSXK
         l96nOIwLKHEu9m42l+J6oV+VAaNfsvGQ9tTt3LNU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 07/12] PCI/ASPM: Remove struct aspm_register_info.l1ss_cap_ptr
Date:   Thu, 15 Oct 2020 14:30:34 -0500
Message-Id: <20201015193039.12585-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Save the L1 Substates Capability pointer in struct pci_dev.  Then we don't
have to keep track of it in the struct aspm_register_info and struct
pcie_link_state, which makes the code easier to read.  No functional change
intended.

[bhelgaas: split to a separate patch]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 36 +++++++++++++++---------------------
 drivers/pci/probe.c     |  3 +++
 include/linux/pci.h     |  1 +
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index fd6e597b9d74..77316262f982 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -77,8 +77,6 @@ struct pcie_link_state {
 
 	/* L1 PM Substate info */
 	struct {
-		u32 up_cap_ptr;		/* L1SS cap ptr in upstream dev */
-		u32 dw_cap_ptr;		/* L1SS cap ptr in downstream dev */
 		u32 ctl1;		/* value to be programmed in ctl1 */
 		u32 ctl2;		/* value to be programmed in ctl2 */
 	} l1ss;
@@ -386,7 +384,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 
 struct aspm_register_info {
 	/* L1 substates */
-	u32 l1ss_cap_ptr;
 	u32 l1ss_cap;
 	u32 l1ss_ctl1;
 	u32 l1ss_ctl2;
@@ -397,19 +394,20 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 {
 	/* Read L1 PM substate capabilities */
 	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
-	info->l1ss_cap_ptr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!info->l1ss_cap_ptr)
+
+	if (!pdev->l1ss)
 		return;
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CAP,
+
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP,
 			      &info->l1ss_cap);
 	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS)) {
 		info->l1ss_cap = 0;
 		return;
 	}
 
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
-	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2,
 			      &info->l1ss_ctl2);
 }
 
@@ -494,8 +492,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 
-	link->l1ss.up_cap_ptr = upreg->l1ss_cap_ptr;
-	link->l1ss.dw_cap_ptr = dwreg->l1ss_cap_ptr;
 	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
@@ -664,8 +660,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
-	u32 up_cap_ptr = link->l1ss.up_cap_ptr;
-	u32 dw_cap_ptr = link->l1ss.dw_cap_ptr;
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -683,9 +677,9 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 */
 
 	/* Disable all L1 substates */
-	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				PCI_L1SS_CTL1_L1SS_MASK, 0);
-	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				PCI_L1SS_CTL1_L1SS_MASK, 0);
 	/*
 	 * If needed, disable L1, and it gets enabled later
@@ -701,22 +695,22 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	if (enable_req & ASPM_STATE_L1_2_MASK) {
 
 		/* Program T_POWER_ON times in both ports */
-		pci_write_config_dword(parent, up_cap_ptr + PCI_L1SS_CTL2,
+		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
 				       link->l1ss.ctl2);
-		pci_write_config_dword(child, dw_cap_ptr + PCI_L1SS_CTL2,
+		pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
 				       link->l1ss.ctl2);
 
 		/* Program Common_Mode_Restore_Time in upstream device */
-		pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 					PCI_L1SS_CTL1_CM_RESTORE_TIME,
 					link->l1ss.ctl1);
 
 		/* Program LTR_L1.2_THRESHOLD time in both ports */
-		pci_clear_and_set_dword(parent,	up_cap_ptr + PCI_L1SS_CTL1,
+		pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
 					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
 					link->l1ss.ctl1);
-		pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
 					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
 					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
 					link->l1ss.ctl1);
@@ -733,9 +727,9 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/* Enable what we need to enable */
-	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				PCI_L1SS_CTL1_L1SS_MASK, val);
-	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
 				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..06f6bbcd8131 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2106,6 +2106,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/* Read L1 PM substate capabilities */
+	dev->l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..c5288cd71a2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -380,6 +380,7 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
+	int		l1ss;		/* L1SS Capability pointer */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.25.1


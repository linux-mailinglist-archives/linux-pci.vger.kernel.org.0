Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C3D28F97A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391630AbgJOTa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391633AbgJOTa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:56 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57948206E5;
        Thu, 15 Oct 2020 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790255;
        bh=BIWdlt3KOFitTsFFJJmAHPLrPeeq0eDqqnfZrl8ia9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOKmVGIZxLBBdzS/Rb95uD5mEwEpILfigVY672NDEy52ts6q1wT6epWy4LriiC4wo
         mP+sMUBeWS2uM3n7Hlc9HGdlg/fHeMRxlsBc8VV0yWZAnZOV92atC4P5RYM6H15DhC
         oiT8n50ud9AgSQQBrPJTrRQp0N2WgyvPNv8CGOLA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 04/12] PCI/ASPM: Remove struct aspm_register_info.support
Date:   Thu, 15 Oct 2020 14:30:31 -0500
Message-Id: <20201015193039.12585-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we stored the "ASPM Support" field from the Link Capabilities
register in the struct aspm_register_info.

Read the Link Capabilities directly when needed and remove it from the
struct aspm_register_info.  No functional change intended.

[bhelgaas: remove pci_dev cached copy since LNKCAP isn't truly read-only,
add PCI_EXP_LNKCAP_ASPM_L0S & PCI_EXP_LNKCAP_ASPM_L1, check them directly
instead of adding aspm_support()]
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c       | 25 ++++++++++++++-----------
 include/uapi/linux/pci_regs.h |  2 ++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0725511cbeb5..82ce34e2ef53 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -381,7 +381,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 support:2;
 	u32 enabled:2;
 	u32 latency_encoding_l0s;
 	u32 latency_encoding_l1;
@@ -400,7 +399,6 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
-	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
 	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
@@ -550,6 +548,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_lnkcap, child_lnkcap;
 	struct pci_bus *linkbus = parent->subordinate;
 	struct aspm_register_info upreg, dwreg;
 
@@ -560,24 +559,26 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
-	/* Get upstream/downstream components' register state */
-	pcie_get_aspm_reg(parent, &upreg);
-	pcie_get_aspm_reg(child, &dwreg);
-
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
 	 */
-	if (!(upreg.support & dwreg.support))
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
+	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
+	if (!(parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPMS))
 		return;
 
 	/* Configure common clock before checking latencies */
 	pcie_aspm_configure_common_clock(link);
 
 	/*
-	 * Re-read upstream/downstream components' register state
-	 * after clock configuration
+	 * Re-read upstream/downstream components' register state after
+	 * clock configuration.  L0s & L1 exit latencies in the otherwise
+	 * read-only Link Capabilities may change depending on common clock
+	 * configuration (PCIe r5.0, sec 7.5.3.6).
 	 */
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &parent_lnkcap);
+	pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &child_lnkcap);
 	pcie_get_aspm_reg(parent, &upreg);
 	pcie_get_aspm_reg(child, &dwreg);
 
@@ -588,8 +589,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 * given link unless components on both sides of the link each
 	 * support L0s.
 	 */
-	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
+	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
+
 	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
@@ -598,8 +600,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l0s = calc_l0s_latency(dwreg.latency_encoding_l0s);
 
 	/* Setup L1 state */
-	if (upreg.support & dwreg.support & PCIE_LINK_STATE_L1)
+	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
 		link->aspm_support |= ASPM_STATE_L1;
+
 	if (upreg.enabled & dwreg.enabled & PCIE_LINK_STATE_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f9701410d3b5..06846ec2e071 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -532,6 +532,8 @@
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
+#define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
+#define  PCI_EXP_LNKCAP_ASPM_L1  0x00000800 /* ASPM L1 Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
 #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
 #define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* Clock Power Management */
-- 
2.25.1


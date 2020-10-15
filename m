Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1078E28F97C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391634AbgJOTbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391639AbgJOTbA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:31:00 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B988206ED;
        Thu, 15 Oct 2020 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790259;
        bh=RLHkM1QIOUSxqpToyowl1bo3pN3+QbP1dLvimrH1T9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTCpHvcX5vNSICS49zdHUmwf3bu0fTWFIzNIwM5WmlKD+XxZQ1ZuYY2RfzWThivIw
         SHgwuRMNJdEBWJAVX5njEIp49YP0tNvNXeXis8WwDbFDGHiGY+XNaYXhY7E+JKA8I3
         VICsTH23nSAAbkC83QkchvCXU7FLJWu1LWm6Tp3A=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 06/12] PCI/ASPM: Remove struct aspm_register_info.latency_encoding
Date:   Thu, 15 Oct 2020 14:30:33 -0500
Message-Id: <20201015193039.12585-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>

Previously we stored L0s and L1 Exit Latency information from the Link
Capabilities register in the struct aspm_register_info.

We only need these latencies when we already have the Link Capabilities
values, so use those directly and remove the latencies from struct
aspm_register_info.  No functional change intended.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 36540879586b..fd6e597b9d74 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -308,8 +308,10 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 }
 
 /* Convert L0s latency encoding to ns */
-static u32 calc_l0s_latency(u32 encoding)
+static u32 calc_l0s_latency(u32 lnkcap)
 {
+	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L0SEL) >> 12;
+
 	if (encoding == 0x7)
 		return (5 * 1000);	/* > 4us */
 	return (64 << encoding);
@@ -324,8 +326,10 @@ static u32 calc_l0s_acceptable(u32 encoding)
 }
 
 /* Convert L1 latency encoding to ns */
-static u32 calc_l1_latency(u32 encoding)
+static u32 calc_l1_latency(u32 lnkcap)
 {
+	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L1EL) >> 15;
+
 	if (encoding == 0x7)
 		return (65 * 1000);	/* > 64us */
 	return (1000 << encoding);
@@ -381,8 +385,6 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 }
 
 struct aspm_register_info {
-	u32 latency_encoding_l0s;
-	u32 latency_encoding_l1;
 	/* L1 substates */
 	u32 l1ss_cap_ptr;
 	u32 l1ss_cap;
@@ -393,12 +395,6 @@ struct aspm_register_info {
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
-	u32 reg32;
-
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
-	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
-	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
-
 	/* Read L1 PM substate capabilities */
 	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
 	info->l1ss_cap_ptr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
@@ -594,8 +590,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
 	if (parent_lnkctl & PCI_EXP_LNKCTL_ASPM_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
-	link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
-	link->latency_dw.l0s = calc_l0s_latency(dwreg.latency_encoding_l0s);
+	link->latency_up.l0s = calc_l0s_latency(parent_lnkcap);
+	link->latency_dw.l0s = calc_l0s_latency(child_lnkcap);
 
 	/* Setup L1 state */
 	if (parent_lnkcap & child_lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
@@ -603,8 +599,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
-	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
-	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
+	link->latency_up.l1 = calc_l1_latency(parent_lnkcap);
+	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate
 	 * If we don't have LTR for the entire path from the Root Complex
-- 
2.25.1


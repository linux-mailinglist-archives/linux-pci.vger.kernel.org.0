Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD15F4DF5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 04:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJEC6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJEC6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 22:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE24D157;
        Tue,  4 Oct 2022 19:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F7366155E;
        Wed,  5 Oct 2022 02:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F5C433B5;
        Wed,  5 Oct 2022 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664938699;
        bh=KaoG7Mw4EA6SkUssCmAPKI3eFd74L2+tV8cQAQoz6NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaTzGjB8L5ZMRWuK99pGECE/uC1uTZ+owQagQfUiByTDncbcHsrUDMQGw4le7py0I
         cOmx73ZOC9cEJp+uDtUvvORrTF+YuSHJTP1GdCYJQrGZfC/XyBiV6PIIJwRr2tjLGU
         MUHV103pwfJ2zEk+t159KOqmHHW/neV00X0lyxORaTJuTihfZ1+dw3eEN19qniXXRl
         VEvV98SqtwR94Yrx1aMcO/0ct3v+rFMXp0MVasf2nxqpdwVRDKqDrnmGXIwUzxGq0E
         TYk6FGCmB2K3V2nrrKgHB2W7g+TxaRcZzC6mU5C6Yh7YnKJY+vL3/Np7B2j/j7zT7U
         HnY5lkxYyhsYQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/ASPM: Factor out L1 PM Substates configuration
Date:   Tue,  4 Oct 2022 21:58:07 -0500
Message-Id: <20221005025809.2247547-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005025809.2247547-1-helgaas@kernel.org>
References: <20221005025809.2247547-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move L1 PM Substates configuration from pcie_aspm_cap_init() to a new
aspm_l1ss_init() function.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 103 +++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 016d222b07c7..4535228e4a64 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -554,13 +554,65 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	aspm_program_l1ss(child, cctl1, ctl2);
 }
 
+static void aspm_l1ss_init(struct pcie_link_state *link)
+{
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 parent_l1ss_cap, child_l1ss_cap;
+	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
+
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
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use ASPM L1.2 because it relies on the
+	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!child->ltr_path)
+		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
+		link->aspm_support |= ASPM_STATE_L1_1;
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
+		link->aspm_support |= ASPM_STATE_L1_2;
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
+		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
+	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
+		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
+
+	if (parent_l1ss_cap)
+		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				      &parent_l1ss_ctl1);
+	if (child_l1ss_cap)
+		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				      &child_l1ss_ctl1);
+
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+		link->aspm_enabled |= ASPM_STATE_L1_1;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+		link->aspm_enabled |= ASPM_STATE_L1_2;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
+	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
+
+	if (link->aspm_support & ASPM_STATE_L1SS)
+		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
-	u32 parent_l1ss_cap, child_l1ss_cap;
-	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 	struct pci_bus *linkbus = parent->subordinate;
 
 	if (blacklist) {
@@ -615,52 +667,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (parent_lnkctl & child_lnkctl & PCI_EXP_LNKCTL_ASPM_L1)
 		link->aspm_enabled |= ASPM_STATE_L1;
 
-	/* Setup L1 substate */
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-			      &parent_l1ss_cap);
-	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
-			      &child_l1ss_cap);
-
-	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		parent_l1ss_cap = 0;
-	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		child_l1ss_cap = 0;
-
-	/*
-	 * If we don't have LTR for the entire path from the Root Complex
-	 * to this device, we can't use ASPM L1.2 because it relies on the
-	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
-	 */
-	if (!child->ltr_path)
-		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
-
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
-		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
-	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
-		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
-
-	if (parent_l1ss_cap)
-		pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				      &parent_l1ss_ctl1);
-	if (child_l1ss_cap)
-		pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				      &child_l1ss_ctl1);
-
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
-		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
-	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
-		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
-
-	if (link->aspm_support & ASPM_STATE_L1SS)
-		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);
+	aspm_l1ss_init(link);
 
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
-- 
2.25.1


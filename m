Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC26FF253
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjEKNPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbjEKNPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:15:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFF8A60;
        Thu, 11 May 2023 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810902; x=1715346902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cOrn7/cpLCrv5L5ReZoYicQpok0tgDJFiEZ5nKlG+E=;
  b=YpEmLhE3PxCrVWefVyIrLhO10qvy4gk4FdZF9TIqEpd04v9JsxDZXT49
   AG5hI6noGyHEq28WkV/hpjF5441iUkdQ15m8DS1lXeQv/zZywWF7MLj0o
   Lb4rsQCNhprb1/1iWsc0m60CbzcWoxW7btK7pcBj9jSVghnUXYhWFGXVK
   5+/Z1/qIU85V3LVkVZh2Sk/brWRBP970Leentn70TbwugV8WK/5joWNkt
   7FteMEKBUDhWKQJ7ALjfULhuOm8U95hCUDEad0pNWYZNcem+bneHqdA4O
   pd6aLup9BODiQTHBsgvwGEOmrZWjdLUNr3CmAno5eOErC9C9v8+m1VJpf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619353"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169506"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169506"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/17] PCI/ASPM: Use pcie_lnkctl_clear_and_set()
Date:   Thu, 11 May 2023 16:14:27 +0300
Message-Id: <20230511131441.45704-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that the device is fully under the control of ASPM and
use pcie_lnkctl_clear_and_set() which does proper locking to avoid
losing concurrent updates to the register values.

If configuration fails in pcie_aspm_configure_common_clock(), the
function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
than the content of the whole LNKCTL registers. It aligns better with
how pcie_lnkctl_clear_and_set() expects its parameter and makes the
code more obvious to understand.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 48 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dde1ef13d0d1..6dbef0332c2b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -147,9 +147,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
 	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_CLKREQ_EN,
-						   val);
+		pcie_lnkctl_clear_and_set(child, PCI_EXP_LNKCTL_CLKREQ_EN, val);
 	link->clkpm_enabled = !!enable;
 }
 
@@ -213,7 +211,6 @@ static bool pcie_wait_for_retrain(struct pci_dev *pdev)
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
-	u16 reg16;
 
 	/*
 	 * Ensure the updated LNKCTL parameters are used during link
@@ -224,17 +221,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	if (!pcie_wait_for_retrain(parent))
 		return false;
 
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_lnkctl_clear_and_set(parent, 0, PCI_EXP_LNKCTL_RL);
 	if (parent->clear_retrain_link) {
 		/*
 		 * Due to an erratum in some devices the Retrain Link bit
 		 * needs to be cleared again manually to allow the link
 		 * training to succeed.
 		 */
-		reg16 &= ~PCI_EXP_LNKCTL_RL;
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+		pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_RL, 0);
 	}
 
 	return pcie_wait_for_retrain(parent);
@@ -248,7 +242,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
-	u16 reg16, parent_reg, child_reg[8];
+	u16 reg16, parent_old_ccc, child_old_ccc[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -270,6 +264,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
@@ -289,22 +284,14 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	/* Configure downstream component, all functions */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		child_reg[PCI_FUNC(child->devfn)] = reg16;
-		if (same_clock)
-			reg16 |= PCI_EXP_LNKCTL_CCC;
-		else
-			reg16 &= ~PCI_EXP_LNKCTL_CCC;
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
+		child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
+		pcie_lnkctl_clear_and_set(child, PCI_EXP_LNKCTL_CCC,
+					  same_clock ? PCI_EXP_LNKCTL_CCC : 0);
 	}
 
 	/* Configure upstream component */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	parent_reg = reg16;
-	if (same_clock)
-		reg16 |= PCI_EXP_LNKCTL_CCC;
-	else
-		reg16 &= ~PCI_EXP_LNKCTL_CCC;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_CCC,
+				  same_clock ? PCI_EXP_LNKCTL_CCC : 0);
 
 	if (pcie_retrain_link(link))
 		return;
@@ -312,9 +299,9 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	/* Training failed. Restore common clock configurations */
 	pci_err(parent, "ASPM: Could not configure common clock\n");
 	list_for_each_entry(child, &linkbus->devices, bus_list)
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_reg[PCI_FUNC(child->devfn)]);
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+		pcie_lnkctl_clear_and_set(child, PCI_EXP_LNKCTL_CCC,
+					  child_old_ccc[PCI_FUNC(child->devfn)]);
+	pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_CCC, parent_old_ccc);
 }
 
 /* Convert L0s latency encoding to ns */
@@ -745,10 +732,8 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 * in pcie_config_aspm_link().
 	 */
 	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
-		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pcie_lnkctl_clear_and_set(child, PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_ASPM_L1, 0);
 	}
 
 	val = 0;
@@ -770,8 +755,7 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
-	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, val);
+	pcie_lnkctl_clear_and_set(pdev, PCI_EXP_LNKCTL_ASPMC, val);
 }
 
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
-- 
2.30.2


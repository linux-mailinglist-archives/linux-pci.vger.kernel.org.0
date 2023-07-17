Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018AA75625E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGQMGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjGQMF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 08:05:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0D1B1;
        Mon, 17 Jul 2023 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595555; x=1721131555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XeQx82qVljJ0TpFDj49Er9A926gpfXyoEO2h/wB5nf4=;
  b=IZiBVrGozGOJkDOKHDGZZnsNBrR2G+nrJq7C24OxbZitDgm/JxC/eSW9
   jLCJ50ylLa7kGqdCNHOlRD7SSlLfWDAhzzIrEpKo5tcIM36qDKK/IsDdO
   2EW7vTZMdKaogPlikzXuOsgmC8pHkETVfXstbQoX1NJ9s7vQoKY1b4DZz
   gM17UiM5WyUatmHQ33bxvLS14Daw4zxHh5V+6znH+N3WiMsA/a+8ES0rT
   FnPtwZTv2hKvlN5pMbfdMT3DKYDQ0bgcTPZy5/YKwr3DdOhDcp4TEM3za
   fYsQAz1uOJOeOMNCOi+DOL2B/wKYhe6IKdVM0PJPZFKlOiz8zON9nOH5u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432081585"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432081585"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752875985"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752875985"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:05:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Shaohua Li <shaohua.li@intel.com>,
        Thomas Renninger <trenn@suse.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 04/11] PCI/ASPM: Use RMW accessors for changing LNKCTL
Date:   Mon, 17 Jul 2023 15:04:56 +0300
Message-Id: <20230717120503.15276-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
References: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that the device is fully under the control of ASPM and use
RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register values.

If configuration fails in pcie_aspm_configure_common_clock(), the
function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
than the content of the whole LNKCTL registers. It aligns better with
how pcie_lnkctl_clear_and_set() expects its parameter and makes the
code more obvious to understand.

Fixes: 2a42d9dba784 ("PCIe: ASPM: Break out of endless loop waiting for PCI config bits to switch")
Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/pcie/aspm.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3dafba0b5f41..1bf630059264 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -199,7 +199,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
-	u16 reg16, parent_reg, child_reg[8];
+	u16 reg16, ccc, parent_old_ccc, child_old_ccc[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -221,6 +221,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
@@ -237,34 +238,29 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		pci_info(parent, "ASPM: current common clock configuration is inconsistent, reconfiguring\n");
 	}
 
+	ccc = same_clock ? PCI_EXP_LNKCTL_CCC : 0;
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
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, ccc);
 	}
 
 	/* Configure upstream component */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	parent_reg = reg16;
-	if (same_clock)
-		reg16 |= PCI_EXP_LNKCTL_CCC;
-	else
-		reg16 &= ~PCI_EXP_LNKCTL_CCC;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CCC, ccc);
 
 	if (pcie_retrain_link(link->pdev, true)) {
 
 		/* Training failed. Restore common clock configurations */
 		pci_err(parent, "ASPM: Could not configure common clock\n");
 		list_for_each_entry(child, &linkbus->devices, bus_list)
-			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_reg[PCI_FUNC(child->devfn)]);
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+			pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_CCC,
+							   child_old_ccc[PCI_FUNC(child->devfn)]);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, parent_old_ccc);
 	}
 }
 
-- 
2.30.2


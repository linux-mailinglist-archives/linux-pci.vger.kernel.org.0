Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4F6B3F5C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCJMfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 07:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCJMfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 07:35:19 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABB5B10E275;
        Fri, 10 Mar 2023 04:35:16 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,249,1673881200"; 
   d="scan'208";a="152181166"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2023 21:35:14 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3F29C423B070;
        Fri, 10 Mar 2023 21:35:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v11 08/13] PCI: dwc: Add dw_pcie_num_lanes_setup()
Date:   Fri, 10 Mar 2023 21:35:05 +0900
Message-Id: <20230310123510.675685-9-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dw_pcie_num_lanes_setup() to setup PCI_EXP_LNKCAP_MLW.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c   |  5 +----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89b8ec29da7f..47860da5738e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -696,6 +696,18 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 
+void dw_pcie_num_lanes_setup(struct dw_pcie *pci, int num_lanes)
+{
+	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_MLW;
+	val |= num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
+	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_num_lanes_setup);
+
 static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 {
 	u32 cap, ctrl2, link_speed;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..36f3e2c818fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -415,6 +415,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
+void dw_pcie_num_lanes_setup(struct dw_pcie *pci, int num_lanes);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			      u64 cpu_addr, u64 pci_addr, u64 size);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..befe17d57e2a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -902,10 +902,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Configure Max lane width from DT */
-	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
-	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
+	dw_pcie_num_lanes_setup(pci, pcie->num_lanes);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
-- 
2.25.1


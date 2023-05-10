Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA76FD6D0
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 08:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjEJGWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjEJGWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 02:22:43 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EC6F40CE;
        Tue,  9 May 2023 23:22:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,263,1677510000"; 
   d="scan'208";a="158801585"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 May 2023 15:22:37 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 884D3401140D;
        Wed, 10 May 2023 15:22:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v16 11/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Date:   Wed, 10 May 2023 15:22:23 +0900
Message-Id: <20230510062234.201499-12-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add dw_pcie_link_set_max_cap_width() to set PCI_EXP_LNKCAP_MLW.
In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
field there is another one which needs to be updated. It's
LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
the very least the maximum link-width capability CSR won't expose
the actual maximum capability.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.60a, March 2015, p.1032
[2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.70a, March 2016, p.1065
[3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.90a, March 2016, p.1057
...
[X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
      Version 5.40a, March 2019, p.1396
[X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
      Version 5.40a, March 2019, p.1266

The commit description is suggested by Serge Semin.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5dc423dd2f21..8b2978c6eb23 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -758,6 +758,21 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
 }
 
+static void dw_pcie_link_set_max_cap_width(struct dw_pcie *pci, int num_lanes)
+{
+	u32 val;
+	u8 cap;
+
+	if (!num_lanes)
+		return;
+
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_MLW;
+	val |= num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
+	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
+}
+
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
@@ -1040,4 +1055,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
+	dw_pcie_link_set_max_cap_width(pci, pci->num_lanes);
 }
-- 
2.25.1


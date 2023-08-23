Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18017853D7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjHWJ0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjHWJYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 05:24:07 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2625BAD;
        Wed, 23 Aug 2023 02:12:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="177395332"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 18:12:03 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EA903400294A;
        Wed, 23 Aug 2023 18:12:02 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v19 07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
Date:   Wed, 23 Aug 2023 18:11:41 +0900
Message-Id: <20230823091153.2578417-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
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

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 976dcc511fdc..065644580cdb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -724,7 +724,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
-	u32 lwsc, plc;
+	u32 lnkcap, lwsc, plc;
+	u8 cap;
 
 	if (!num_lanes)
 		return;
@@ -760,6 +761,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
+
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
+	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
-- 
2.25.1


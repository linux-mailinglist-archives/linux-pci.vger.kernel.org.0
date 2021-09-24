Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4257416D7B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhIXIOS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 04:14:18 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:36044 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhIXIOR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Sep 2021 04:14:17 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 04:14:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632471165; x=1664007165;
  h=from:to:cc:subject:date:message-id;
  bh=qJ9EaKrEBGYgsWxnX3MhIVjCcoom979TP/eYeQZJVsI=;
  b=DFxsgM6lHkbUGJCM813dQBx/G7mG/tNbZzQG215bO65sK4tdoSMVCveg
   JysmJZKBvJYZA8pLw0VolxxPB853HxyJ6ikK/F3NmrUIzeHHoe/kWArnO
   IkIKZKMrsAp4rp/dP9FzDQlYEeZy2hkHSCuoe1JZJZkvZxXKwrb4Q7J83
   b6i7dKYEFDvo99oAEpEJ8DMXi4IQiVT5kVDhbqHzLv7hGvuWrR/g7vy6n
   DOoo/LicCQkBeSuYoXXksKzxbT2lqBoM4wv9YqrXN+uzg0j3BNCkcS55S
   IJhXbrMyhPK2Nlh5V57mgH5HInGZSYZkMZm5JTLqm7hVI9+JLwG4xv8ZR
   A==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624312800"; 
   d="scan'208";a="19688819"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Sep 2021 10:05:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 24 Sep 2021 10:05:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 24 Sep 2021 10:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1632470736; x=1664006736;
  h=from:to:cc:subject:date:message-id;
  bh=qJ9EaKrEBGYgsWxnX3MhIVjCcoom979TP/eYeQZJVsI=;
  b=G+K+9oePcnlrWNSApGGgorKYm/XRgB96idXqguVWevM+PMP/4j5VT+sp
   wupae+BbV1GttIDMJFizskDq/22u2gqBEHql24nn5xtwq3Btb/9nZR494
   OZRv9KG0l4mpJiZai0FCPc7HmpJ8k87rJM0eGHf7Lt9WWkoSszw+UduOY
   GES2xpzhrfOM3mF8GRrcuTw1p8yB64o2gBE9JKbeX9TexfzDuNdgfbB3o
   gzkI570Rg9pE+kWE5BCN1o//itdZTPhhdvjevbI+ALNIVzjWRFGgqWt7A
   W/lMzbAnyfpF0c462Cd2GA+sZw3MnNGmCATAnHL8tKCh/y2Ou3/Kgsslh
   w==;
X-IronPort-AV: E=Sophos;i="5.85,319,1624312800"; 
   d="scan'208";a="19688818"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Sep 2021 10:05:36 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3DC38280070;
        Fri, 24 Sep 2021 10:05:36 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [RFC] PCI: imx6: add support for internal oscillator on i.MX7D
Date:   Fri, 24 Sep 2021 10:05:15 +0200
Message-Id: <81c77a29362433fc5629ada442f0489046ce1051.1632319151.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds support for a DT property fsl,internal-osc to select the internal
oscillator for the PCIe PHY.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---

Okay, so while this patch is nice and short, I'm note sure if it's a good
solution, hence I submit it as an RFC. It is roughly based on code from
older linux-imx versions [1] - although it seems this feature was never
supported on i.MX7D even by linux-imx (possibly because of compliance
issues with the internal clock, however I haven't found a definitive
erratum backing this), but only on other SoC like i.MX6QP.

The device tree binding docs of the driver are somewhat lacking, but
looking at [1] it seems that an external reference clock takes the place of
the "pcie_bus" clock - various pieces of the driver skip enabling/disabling
this clock when an external clock is configured.

From this I've come to the conclusion that the clock settings in
imx7d.dtsi do not really make sense: The pcie_bus clock is configured to
PLL_ENET_MAIN_100M_CLK, but this seems wrong for both internal and
external reference clocks:

- For the internal clock, the correct clock should be PCIE_PHY_ROOT_CLK
  according to the reference manual
- The external clocks, this should refer to an actual external clock, or
  possibly a fixed-clock node

I would be great if someone with more insight into this could chime in
and tell me if my reasoning here is correct or not.

Unfortunately I only have our MBa7x at my disposal for further
experimentation. This board does not have an external reference clock for
the PCIe PHY, so I cannot test the behaviour for settings that use an
external clock. Without this patch (and adding the new flag to the MBa7x
DTS), the boot will hang while waiting for the PCIe link to come up.

So, for the actual question (given that my thoughts above make any sense):
How do we want to implement this?

1. A simple boolean flag, like this patch provides
2. Allow Device Trees not to specify a "pcie_bus" clock at all, meaning
   it should use the internal clock
3. Special handling when the "pcie_bus" clock is configured to
   PCIE_PHY_ROOT_CLK - is such a thing even possible, or is this
   breaking the clock driver's abstraction too much?
4. Something more involved, with a proper clock sel as the source for
   "pcie_bus"

Solution 4. seems difficult to implement nicely, as the PCIe driver
also fiddles with IMX7D_GPR12_PCIE_PHY_REFCLK_SEL for power management:
the clock selection is switched back to the internal clock in
imx6_pcie_clk_disable(), which also disables its source PCIE_PHY_ROOT_CLK,
effectively gating the clock.

Regards,
Matthias


[1] https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/pci/host/pci-imx6.c?h=imx_4.1.15_2.0.0_ga

 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..021499b9ee7c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -83,6 +83,7 @@ struct imx6_pcie {
 	struct regulator	*vpcie;
 	struct regulator	*vph;
 	void __iomem		*phy_base;
+	bool			internal_osc;
 
 	/* power domain for pcie */
 	struct device		*pd_pcie;
@@ -637,7 +638,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   imx6_pcie->internal_osc ?
+					IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1130,6 +1133,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 				 &imx6_pcie->tx_swing_low))
 		imx6_pcie->tx_swing_low = 127;
 
+	if (of_property_read_bool(node, "fsl,internal-osc"))
+		imx6_pcie->internal_osc = true;
+
 	/* Limit link speed */
 	pci->link_gen = 1;
 	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
-- 
2.17.1


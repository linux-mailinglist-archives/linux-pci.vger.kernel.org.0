Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02943304498
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbhAZRFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:05:48 -0500
Received: from muru.com ([72.249.23.125]:53174 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390145AbhAZIbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:22 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id DD1228B15;
        Tue, 26 Jan 2021 08:27:56 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 16/27] ARM: OMAP2+: Drop legacy platform data for dra7 pcie
Date:   Tue, 26 Jan 2021 10:27:05 +0200
Message-Id: <20210126082716.54358-17-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts data.
Let's drop the related platform data and custom ti,hwmods dts property.

As we're just dropping data, and the early platform data init is based on
the custom ti,hwmods property, we want to drop both the platform data and
ti,hwmods property in a single patch.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi               |   3 -
 arch/arm/mach-omap2/common.h              |   9 --
 arch/arm/mach-omap2/omap_hwmod.c          |   8 --
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 114 ----------------------
 4 files changed, 134 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -215,7 +215,6 @@ pcie1_rc: pcie@51000000 {
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <0>;
-				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
 				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
@@ -243,7 +242,6 @@ pcie1_ep: pcie_ep@51000000 {
 				num-lanes = <1>;
 				num-ib-windows = <4>;
 				num-ob-windows = <16>;
-				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
 				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
@@ -288,7 +286,6 @@ pcie2_rc: pcie@51800000 {
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <1>;
-				ti,hwmods = "pcie2";
 				phys = <&pcie2_phy>;
 				phy-names = "pcie-phy0";
 				interrupt-map-mask = <0 0 0 7>;
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -343,15 +343,6 @@ static inline void omap5_secondary_hyp_startup(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_DRA7XX
-extern int dra7xx_pciess_reset(struct omap_hwmod *oh);
-#else
-static inline int dra7xx_pciess_reset(struct omap_hwmod *oh)
-{
-	return 0;
-}
-#endif
-
 struct omap_system_dma_plat_info;
 
 void pdata_quirks_init(const struct of_device_id *);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3495,10 +3495,6 @@ static const struct omap_hwmod_reset omap24xx_reset_quirks[] = {
 	{ .match = "msdi", .len = 4, .reset = omap_msdi_reset, },
 };
 
-static const struct omap_hwmod_reset dra7_reset_quirks[] = {
-	{ .match = "pcie", .len = 4, .reset = dra7xx_pciess_reset, },
-};
-
 static const struct omap_hwmod_reset omap_reset_quirks[] = {
 	{ .match = "dss_core", .len = 8, .reset = omap_dss_reset, },
 	{ .match = "hdq1w", .len = 5, .reset = omap_hdq1w_reset, },
@@ -3534,10 +3530,6 @@ omap_hwmod_init_reset_quirks(struct device *dev, struct omap_hwmod *oh,
 					    omap24xx_reset_quirks,
 					    ARRAY_SIZE(omap24xx_reset_quirks));
 
-	if (soc_is_dra7xx())
-		omap_hwmod_init_reset_quirk(dev, oh, data, dra7_reset_quirks,
-					    ARRAY_SIZE(dra7_reset_quirks));
-
 	omap_hwmod_init_reset_quirk(dev, oh, data, omap_reset_quirks,
 				    ARRAY_SIZE(omap_reset_quirks));
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -266,84 +266,6 @@ static struct omap_hwmod dra7xx_mpu_hwmod = {
 	},
 };
 
-
-/*
- * 'PCIE' class
- *
- */
-
-/*
- * As noted in documentation for _reset() in omap_hwmod.c, the stock reset
- * functionality of OMAP HWMOD layer does not deassert the hardreset lines
- * associated with an IP automatically leaving the driver to handle that
- * by itself. This does not work for PCIeSS which needs the reset lines
- * deasserted for the driver to start accessing registers.
- *
- * We use a PCIeSS HWMOD class specific reset handler to deassert the hardreset
- * lines after asserting them.
- */
-int dra7xx_pciess_reset(struct omap_hwmod *oh)
-{
-	int i;
-
-	for (i = 0; i < oh->rst_lines_cnt; i++) {
-		omap_hwmod_assert_hardreset(oh, oh->rst_lines[i].name);
-		omap_hwmod_deassert_hardreset(oh, oh->rst_lines[i].name);
-	}
-
-	return 0;
-}
-
-static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
-	.name	= "pcie",
-	.reset	= dra7xx_pciess_reset,
-};
-
-/* pcie1 */
-static struct omap_hwmod_rst_info dra7xx_pciess1_resets[] = {
-	{ .name = "pcie", .rst_shift = 0 },
-};
-
-static struct omap_hwmod dra7xx_pciess1_hwmod = {
-	.name		= "pcie1",
-	.class		= &dra7xx_pciess_hwmod_class,
-	.clkdm_name	= "pcie_clkdm",
-	.rst_lines	= dra7xx_pciess1_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess1_resets),
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
-			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* pcie2 */
-static struct omap_hwmod_rst_info dra7xx_pciess2_resets[] = {
-	{ .name = "pcie", .rst_shift = 1 },
-};
-
-/* pcie2 */
-static struct omap_hwmod dra7xx_pciess2_hwmod = {
-	.name		= "pcie2",
-	.class		= &dra7xx_pciess_hwmod_class,
-	.clkdm_name	= "pcie_clkdm",
-	.rst_lines	= dra7xx_pciess2_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess2_resets),
-	.main_clk	= "l4_root_clk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS2_CLKCTRL_OFFSET,
-			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_PCIESS2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'qspi' class
  *
@@ -579,38 +501,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> pciess1 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess1 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_pciess1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> pciess1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess1 = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pciess1_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3_main_1 -> pciess2 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess2 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_pciess2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> pciess2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess2 = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_pciess2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> qspi */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__qspi = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -675,10 +565,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__bb2d,
 	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l4_cfg__mpu,
-	&dra7xx_l3_main_1__pciess1,
-	&dra7xx_l4_cfg__pciess1,
-	&dra7xx_l3_main_1__pciess2,
-	&dra7xx_l4_cfg__pciess2,
 	&dra7xx_l3_main_1__qspi,
 	&dra7xx_l4_cfg__sata,
 	&dra7xx_l3_main_1__vcp1,
-- 
2.30.0

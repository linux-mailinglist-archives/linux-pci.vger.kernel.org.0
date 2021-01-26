Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647A53037F4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 09:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbhAZIcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 03:32:12 -0500
Received: from muru.com ([72.249.23.125]:53190 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390152AbhAZIbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:47 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C3E348BE9;
        Tue, 26 Jan 2021 08:28:17 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 26/27] ARM: OMAP2+: Drop legacy platform data for dra7 l3
Date:   Tue, 26 Jan 2021 10:27:15 +0200
Message-Id: <20210126082716.54358-27-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now probe interconnects with simple-pm-bus and genpd.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 162 ----------------------
 1 file changed, 162 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -26,172 +26,10 @@
 /* Base offset for all DRA7XX interrupts external to MPUSS */
 #define DRA7XX_IRQ_GIC_START	32
 
-/*
- * IP blocks
- */
-
-/*
- * 'l3' class
- * instance(s): l3_instr, l3_main_1, l3_main_2
- */
-static struct omap_hwmod_class dra7xx_l3_hwmod_class = {
-	.name	= "l3",
-};
-
-/* l3_instr */
-static struct omap_hwmod dra7xx_l3_instr_hwmod = {
-	.name		= "l3_instr",
-	.class		= &dra7xx_l3_hwmod_class,
-	.clkdm_name	= "l3instr_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-};
-
-/* l3_main_1 */
-static struct omap_hwmod dra7xx_l3_main_1_hwmod = {
-	.name		= "l3_main_1",
-	.class		= &dra7xx_l3_hwmod_class,
-	.clkdm_name	= "l3main1_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_L3_MAIN_1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3MAIN1_L3_MAIN_1_CONTEXT_OFFSET,
-		},
-	},
-};
-
-/* l3_main_2 */
-static struct omap_hwmod dra7xx_l3_main_2_hwmod = {
-	.name		= "l3_main_2",
-	.class		= &dra7xx_l3_hwmod_class,
-	.clkdm_name	= "l3instr_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INSTR_L3_MAIN_2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INSTR_L3_MAIN_2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
-		},
-	},
-};
-
-/*
- * 'bb2d' class
- *
- */
-
-static struct omap_hwmod_class dra7xx_bb2d_hwmod_class = {
-	.name	= "bb2d",
-};
-
-/* bb2d */
-static struct omap_hwmod dra7xx_bb2d_hwmod = {
-	.name		= "bb2d",
-	.class		= &dra7xx_bb2d_hwmod_class,
-	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dpll_core_h24x2_ck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DSS_BB2D_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_DSS_BB2D_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/*
- * 'vcp' class
- *
- */
-
-static struct omap_hwmod_class dra7xx_vcp_hwmod_class = {
-	.name	= "vcp",
-};
-
-/* vcp1 */
-static struct omap_hwmod dra7xx_vcp1_hwmod = {
-	.name		= "vcp1",
-	.class		= &dra7xx_vcp_hwmod_class,
-	.clkdm_name	= "l3main1_clkdm",
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_VCP1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3MAIN1_VCP1_CONTEXT_OFFSET,
-		},
-	},
-};
-
-/* vcp2 */
-static struct omap_hwmod dra7xx_vcp2_hwmod = {
-	.name		= "vcp2",
-	.class		= &dra7xx_vcp_hwmod_class,
-	.clkdm_name	= "l3main1_clkdm",
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_VCP2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3MAIN1_VCP2_CONTEXT_OFFSET,
-		},
-	},
-};
-
-
-
 /*
  * Interfaces
  */
-
-/* l3_main_2 -> l3_instr */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_2__l3_instr = {
-	.master		= &dra7xx_l3_main_2_hwmod,
-	.slave		= &dra7xx_l3_instr_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3_main_1 -> l3_main_2 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l3_main_2 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_l3_main_2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU,
-};
-
-/* l3_main_1 -> bb2d */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__bb2d = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_bb2d_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3_main_1 -> vcp1 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__vcp1 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_vcp1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3_main_1 -> vcp2 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__vcp2 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_vcp2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
-	&dra7xx_l3_main_2__l3_instr,
-	&dra7xx_l3_main_1__l3_main_2,
-	&dra7xx_l3_main_1__bb2d,
-	&dra7xx_l3_main_1__vcp1,
-	&dra7xx_l3_main_1__vcp2,
 	NULL,
 };
 
-- 
2.30.0

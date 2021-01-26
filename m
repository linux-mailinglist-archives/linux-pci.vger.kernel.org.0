Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2084430475A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbhAZRGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:06:17 -0500
Received: from muru.com ([72.249.23.125]:53184 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390092AbhAZIbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:47 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A10168B66;
        Tue, 26 Jan 2021 08:28:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 21/27] ARM: OMAP2+: Drop legacy platform data for dra7 l4_wkup
Date:   Tue, 26 Jan 2021 10:27:10 +0200
Message-Id: <20210126082716.54358-22-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 54 +----------------------
 1 file changed, 1 insertion(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -81,7 +81,7 @@ static struct omap_hwmod dra7xx_l3_main_2_hwmod = {
 
 /*
  * 'l4' class
- * instance(s): l4_cfg, l4_per1, l4_per2, l4_per3, l4_wkup
+ * instance(s): l4_cfg, l4_per1, l4_per2, l4_per3
  */
 static struct omap_hwmod_class dra7xx_l4_hwmod_class = {
 	.name	= "l4",
@@ -139,19 +139,6 @@ static struct omap_hwmod dra7xx_l4_per3_hwmod = {
 	},
 };
 
-/* l4_wkup */
-static struct omap_hwmod dra7xx_l4_wkup_hwmod = {
-	.name		= "l4_wkup",
-	.class		= &dra7xx_l4_hwmod_class,
-	.clkdm_name	= "wkupaon_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_L4_WKUP_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_WKUPAON_L4_WKUP_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'atl' class
  *
@@ -200,27 +187,6 @@ static struct omap_hwmod dra7xx_bb2d_hwmod = {
 	},
 };
 
-/*
- * 'ctrl_module' class
- *
- */
-
-static struct omap_hwmod_class dra7xx_ctrl_module_hwmod_class = {
-	.name	= "ctrl_module",
-};
-
-/* ctrl_module_wkup */
-static struct omap_hwmod dra7xx_ctrl_module_wkup_hwmod = {
-	.name		= "ctrl_module_wkup",
-	.class		= &dra7xx_ctrl_module_hwmod_class,
-	.clkdm_name	= "wkupaon_clkdm",
-	.prcm = {
-		.omap4 = {
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
-		},
-	},
-};
-
 /*
  * 'vcp' class
  *
@@ -328,14 +294,6 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_per3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> l4_wkup */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_wkup = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_l4_wkup_hwmod,
-	.clk		= "wkupaon_iclk_mux",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_per2 -> atl */
 static struct omap_hwmod_ocp_if dra7xx_l4_per2__atl = {
 	.master		= &dra7xx_l4_per2_hwmod,
@@ -352,14 +310,6 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__bb2d = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_wkup -> ctrl_module_wkup */
-static struct omap_hwmod_ocp_if dra7xx_l4_wkup__ctrl_module_wkup = {
-	.master		= &dra7xx_l4_wkup_hwmod,
-	.slave		= &dra7xx_ctrl_module_wkup_hwmod,
-	.clk		= "wkupaon_iclk_mux",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> vcp1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__vcp1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -401,10 +351,8 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__l4_per1,
 	&dra7xx_l3_main_1__l4_per2,
 	&dra7xx_l3_main_1__l4_per3,
-	&dra7xx_l3_main_1__l4_wkup,
 	&dra7xx_l4_per2__atl,
 	&dra7xx_l3_main_1__bb2d,
-	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l3_main_1__vcp1,
 	&dra7xx_l4_per2__vcp1,
 	&dra7xx_l3_main_1__vcp2,
-- 
2.30.0

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051AF304772
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbhAZREe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:04:34 -0500
Received: from muru.com ([72.249.23.125]:53176 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390147AbhAZIbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:22 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 46E5B8B46;
        Tue, 26 Jan 2021 08:28:03 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 19/27] ARM: OMAP2+: Drop legacy platform data for dra7 mpu
Date:   Tue, 26 Jan 2021 10:27:08 +0200
Message-Id: <20210126082716.54358-20-tony@atomide.com>
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

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi               |  1 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 42 -----------------------
 2 files changed, 43 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -158,7 +158,6 @@ l4_per1: interconnect@48000000 {
 
 		target-module@48210000 {
 			compatible = "ti,sysc-omap4-simple", "ti,sysc";
-			ti,hwmods = "mpu";
 			power-domains = <&prm_mpu>;
 			clocks = <&mpu_clkctrl DRA7_MPU_CLKCTRL 0>;
 			clock-names = "fck";
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -242,30 +242,6 @@ static struct omap_hwmod dra7xx_ctrl_module_wkup_hwmod = {
 	},
 };
 
-/*
- * 'mpu' class
- *
- */
-
-static struct omap_hwmod_class dra7xx_mpu_hwmod_class = {
-	.name	= "mpu",
-};
-
-/* mpu */
-static struct omap_hwmod dra7xx_mpu_hwmod = {
-	.name		= "mpu",
-	.class		= &dra7xx_mpu_hwmod_class,
-	.clkdm_name	= "mpu_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "dpll_mpu_m2_ck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_MPU_MPU_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_MPU_MPU_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'vcp' class
  *
@@ -333,14 +309,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* mpu -> l3_main_1 */
-static struct omap_hwmod_ocp_if dra7xx_mpu__l3_main_1 = {
-	.master		= &dra7xx_mpu_hwmod,
-	.slave		= &dra7xx_l3_main_1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU,
-};
-
 /* l3_main_1 -> l3_main_2 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l3_main_2 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -421,14 +389,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_wkup__ctrl_module_wkup = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> mpu */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_mpu_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> vcp1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__vcp1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -465,7 +425,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
 	&dra7xx_l4_cfg__l3_main_1,
-	&dra7xx_mpu__l3_main_1,
 	&dra7xx_l3_main_1__l3_main_2,
 	&dra7xx_l4_cfg__l3_main_2,
 	&dra7xx_l3_main_1__l4_cfg,
@@ -476,7 +435,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per2__atl,
 	&dra7xx_l3_main_1__bb2d,
 	&dra7xx_l4_wkup__ctrl_module_wkup,
-	&dra7xx_l4_cfg__mpu,
 	&dra7xx_l3_main_1__vcp1,
 	&dra7xx_l4_per2__vcp1,
 	&dra7xx_l3_main_1__vcp2,
-- 
2.30.0

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278E304494
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbhAZREy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:04:54 -0500
Received: from muru.com ([72.249.23.125]:53170 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390132AbhAZIbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:22 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2F3838B3E;
        Tue, 26 Jan 2021 08:28:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 18/27] ARM: OMAP2+: Drop legacy platform data for dra7 sata
Date:   Tue, 26 Jan 2021 10:27:07 +0200
Message-Id: <20210126082716.54358-19-tony@atomide.com>
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

Cc: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi            |  1 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 47 -----------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -576,7 +576,6 @@ target-module@8000 {			/* 0x4a108000, ap 29 1e.0 */
 
 		target-module@40000 {			/* 0x4a140000, ap 31 06.0 */
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			ti,hwmods = "sata";
 			reg = <0x400fc 4>,
 			      <0x41100 4>;
 			reg-names = "rev", "sysc";
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -266,44 +266,6 @@ static struct omap_hwmod dra7xx_mpu_hwmod = {
 	},
 };
 
-/*
- * 'sata' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_sata_sysc = {
-	.rev_offs	= 0x00fc,
-	.sysc_offs	= 0x0000,
-	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class dra7xx_sata_hwmod_class = {
-	.name	= "sata",
-	.sysc	= &dra7xx_sata_sysc,
-};
-
-/* sata */
-
-static struct omap_hwmod dra7xx_sata_hwmod = {
-	.name		= "sata",
-	.class		= &dra7xx_sata_hwmod_class,
-	.clkdm_name	= "l3init_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "func_48m_fclk",
-	.mpu_rt_idx	= 1,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L3INIT_SATA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'vcp' class
  *
@@ -467,14 +429,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> sata */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__sata = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_sata_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> vcp1 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__vcp1 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -523,7 +477,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__bb2d,
 	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l4_cfg__mpu,
-	&dra7xx_l4_cfg__sata,
 	&dra7xx_l3_main_1__vcp1,
 	&dra7xx_l4_per2__vcp1,
 	&dra7xx_l3_main_1__vcp2,
-- 
2.30.0

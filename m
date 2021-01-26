Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F9304754
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbhAZRGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:06:49 -0500
Received: from muru.com ([72.249.23.125]:53186 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389915AbhAZIbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:47 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D6A398B99;
        Tue, 26 Jan 2021 08:28:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 24/27] ARM: OMAP2+: Drop legacy platform data for dra7 l4_per3
Date:   Tue, 26 Jan 2021 10:27:13 +0200
Message-Id: <20210126082716.54358-25-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 24 +----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -81,7 +81,7 @@ static struct omap_hwmod dra7xx_l3_main_2_hwmod = {
 
 /*
  * 'l4' class
- * instance(s): l4_cfg, l4_per3
+ * instance(s): l4_cfg
  */
 static struct omap_hwmod_class dra7xx_l4_hwmod_class = {
 	.name	= "l4",
@@ -100,19 +100,6 @@ static struct omap_hwmod dra7xx_l4_cfg_hwmod = {
 	},
 };
 
-/* l4_per3 */
-static struct omap_hwmod dra7xx_l4_per3_hwmod = {
-	.name		= "l4_per3",
-	.class		= &dra7xx_l4_hwmod_class,
-	.clkdm_name	= "l4per3_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_L4_PER3_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
-		},
-	},
-};
-
 /*
  * 'bb2d' class
  *
@@ -220,14 +207,6 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_cfg = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> l4_per3 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_per3 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_l4_per3_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> bb2d */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__bb2d = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -258,7 +237,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__l3_main_2,
 	&dra7xx_l4_cfg__l3_main_2,
 	&dra7xx_l3_main_1__l4_cfg,
-	&dra7xx_l3_main_1__l4_per3,
 	&dra7xx_l3_main_1__bb2d,
 	&dra7xx_l3_main_1__vcp1,
 	&dra7xx_l3_main_1__vcp2,
-- 
2.30.0

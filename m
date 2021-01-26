Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF7304762
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbhAZRGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:06:44 -0500
Received: from muru.com ([72.249.23.125]:53180 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390150AbhAZIbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:47 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BC10A8B87;
        Tue, 26 Jan 2021 08:28:09 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 22/27] ARM: OMAP2+: Drop legacy platform data for dra7 l4_per1
Date:   Tue, 26 Jan 2021 10:27:11 +0200
Message-Id: <20210126082716.54358-23-tony@atomide.com>
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
- * instance(s): l4_cfg, l4_per1, l4_per2, l4_per3
+ * instance(s): l4_cfg, l4_per2, l4_per3
  */
 static struct omap_hwmod_class dra7xx_l4_hwmod_class = {
 	.name	= "l4",
@@ -100,19 +100,6 @@ static struct omap_hwmod dra7xx_l4_cfg_hwmod = {
 	},
 };
 
-/* l4_per1 */
-static struct omap_hwmod dra7xx_l4_per1_hwmod = {
-	.name		= "l4_per1",
-	.class		= &dra7xx_l4_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_L4_PER1_CLKCTRL_OFFSET,
-			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
-		},
-	},
-};
-
 /* l4_per2 */
 static struct omap_hwmod dra7xx_l4_per2_hwmod = {
 	.name		= "l4_per2",
@@ -270,14 +257,6 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_cfg = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3_main_1 -> l4_per1 */
-static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_per1 = {
-	.master		= &dra7xx_l3_main_1_hwmod,
-	.slave		= &dra7xx_l4_per1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> l4_per2 */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__l4_per2 = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -348,7 +327,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__l3_main_2,
 	&dra7xx_l4_cfg__l3_main_2,
 	&dra7xx_l3_main_1__l4_cfg,
-	&dra7xx_l3_main_1__l4_per1,
 	&dra7xx_l3_main_1__l4_per2,
 	&dra7xx_l3_main_1__l4_per3,
 	&dra7xx_l4_per2__atl,
-- 
2.30.0

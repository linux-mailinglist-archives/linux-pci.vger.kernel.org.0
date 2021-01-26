Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9E303D55
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbhAZMmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:42:38 -0500
Received: from muru.com ([72.249.23.125]:53454 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391855AbhAZMlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 07:41:45 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F270C89BE;
        Tue, 26 Jan 2021 12:40:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 12/15] ARM: dts: Configure simple-pm-bus for dra7 l4_per2
Date:   Tue, 26 Jan 2021 14:40:01 +0200
Message-Id: <20210126124004.52550-13-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126124004.52550-1-tony@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now probe interconnects with device tree only configuration using
simple-pm-bus and genpd.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2302,7 +2302,10 @@ segment@200000 {					/* 0x48200000 */
 };
 
 &l4_per2 {						/* 0x48400000 */
-	compatible = "ti,dra7-l4-per2", "simple-bus";
+	compatible = "ti,dra7-l4-per2", "simple-pm-bus";
+	power-domains = <&prm_l4per>;
+	clocks = <&l4per2_clkctrl DRA7_L4PER2_L4_PER2_CLKCTRL 0>;
+	clock-names = "fck";
 	reg = <0x48400000 0x800>,
 	      <0x48400800 0x800>,
 	      <0x48401000 0x400>,
@@ -2322,7 +2325,7 @@ &l4_per2 {						/* 0x48400000 */
 		 <0x48454000 0x48454000 0x400000>;	/* L3 data port */
 
 	segment@0 {					/* 0x48400000 */
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00000000 0x00000000 0x000800>,	/* ap 0 */
-- 
2.30.0

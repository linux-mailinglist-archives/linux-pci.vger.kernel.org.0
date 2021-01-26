Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B0304774
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbhAZRCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:02:21 -0500
Received: from muru.com ([72.249.23.125]:53178 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbhAZIaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:30:25 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D61128A43;
        Tue, 26 Jan 2021 08:27:46 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 11/27] ARM: dts: Configure simple-pm-bus for dra7 l4_per1
Date:   Tue, 26 Jan 2021 10:27:00 +0200
Message-Id: <20210126082716.54358-12-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now probe interconnects with device tree only configuration using
simple-pm-bus and genpd.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -1029,7 +1029,10 @@ target-module@36000 {			/* 0x4a236000, ap 119 62.0 */
 };
 
 &l4_per1 {						/* 0x48000000 */
-	compatible = "ti,dra7-l4-per1", "simple-bus";
+	compatible = "ti,dra7-l4-per1", "simple-pm-bus";
+	power-domains = <&prm_l4per>;
+	clocks = <&l4per_clkctrl DRA7_L4PER_L4_PER1_CLKCTRL 0>;
+	clock-names = "fck";
 	reg = <0x48000000 0x800>,
 	      <0x48000800 0x800>,
 	      <0x48001000 0x400>,
@@ -1043,7 +1046,7 @@ &l4_per1 {						/* 0x48000000 */
 		 <0x00200000 0x48200000 0x200000>;	/* segment 1 */
 
 	segment@0 {					/* 0x48000000 */
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00000000 0x00000000 0x000800>,	/* ap 0 */
@@ -2292,7 +2295,7 @@ target-module@d5000 {			/* 0x480d5000, ap 73 30.0 */
 	};
 
 	segment@200000 {					/* 0x48200000 */
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
-- 
2.30.0

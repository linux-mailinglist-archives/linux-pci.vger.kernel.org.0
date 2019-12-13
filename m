Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4881E11E830
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfLMQZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 11:25:17 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:57214 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfLMQZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 11:25:16 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id dUR1210015USYZQ01UR1w4; Fri, 13 Dec 2019 17:25:12 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ifnkS-0006mS-TP; Fri, 13 Dec 2019 17:25:00 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ifnkS-0000Sl-QS; Fri, 13 Dec 2019 17:25:00 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: dts: rcar-gen2: Fix PCI high address in interrupt-map-mask
Date:   Fri, 13 Dec 2019 17:24:59 +0100
Message-Id: <20191213162459.1731-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"make dtbs_check" emits warnings like:

    pci@ee090000: interrupt-map-mask:0:0: 65280 is greater than the maximum of 63488
    pci@ee0b0000: interrupt-map-mask:0:0: 65280 is greater than the maximum of 63488
    pci@ee0d0000: interrupt-map-mask:0:0: 65280 is greater than the maximum of 63488

According to dt-schemas/schemas/pci/pci-bus.yaml, the PCI high address
cell value in the "interrupt-map-mask" property must lie in the range
0..0xf800.

Fix this by correcting the values from 0xff00 to 0xf800 in all affected
R-Car Gen2 and RZ/G1 DTS files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7744.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7745.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7790.dtsi | 6 +++---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index de981d629bdddec3..5f88d9f585988c0c 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1461,7 +1461,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1496,7 +1496,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index fa74a262107bce6c..446dbb5409e67aeb 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1461,7 +1461,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1496,7 +1496,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index c53f7ff20695f04a..04f1ca1828b15954 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1337,7 +1337,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1372,7 +1372,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 5a2747758f676a4b..cf7bf7d7caee1808 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1388,7 +1388,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1423,7 +1423,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0a0000 0 0xee0a0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
@@ -1446,7 +1446,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a8266e76d7e50739..e5fa01034666616b 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1427,7 +1427,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1462,7 +1462,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8d797d34816e3625..945b1378dc40d53a 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1176,7 +1176,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1211,7 +1211,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1


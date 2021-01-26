Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142E4303D5F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391718AbhAZMmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:42:51 -0500
Received: from muru.com ([72.249.23.125]:53448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhAZMlk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 07:41:40 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D26D98379;
        Tue, 26 Jan 2021 12:40:32 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 07/15] ARM: dts: Configure interconnect target module for dra7 sata
Date:   Tue, 26 Jan 2021 14:39:56 +0200
Message-Id: <20210126124004.52550-8-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126124004.52550-1-tony@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
time warnings. The legacy property will be removed in later patches
together with the legacy platform data.

Note that the old sysc register offset is wrong, the real offset is at
0x1100 as listed in TRM for SATA_SYSCONFIG register. Looks like we've been
happily using sata on the bootloader configured sysconfig register and
nobody noticed. Also the old register range for SATAMAC_wrapper registers
is wrong at 7 while it should be 8. But that too seems harmless.

There is also an L3 parent interconnect range that we don't seem to be
using. That can be added as needed later on.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 29 ++++++++++++++++++++++++++---
 arch/arm/boot/dts/dra7.dtsi    | 12 ------------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -572,11 +572,34 @@ target-module@8000 {			/* 0x4a108000, ap 29 1e.0 */
 		};
 
 		target-module@40000 {			/* 0x4a140000, ap 31 06.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
-			#address-cells = <1>;
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "sata";
+			reg = <0x400fc 4>,
+			      <0x41100 4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			power-domains = <&prm_l3init>;
+			clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 0>;
+			clock-names = "fck";
 			#size-cells = <1>;
+			#address-cells = <1>;
 			ranges = <0x0 0x40000 0x10000>;
+
+			sata: sata@0 {
+				compatible = "snps,dwc-ahci";
+				reg = <0 0x1100>, <0x1100 0x8>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&sata_phy>;
+				phy-names = "sata-phy";
+				clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
+				ports-implemented = <0x1>;
+			};
 		};
 
 		target-module@51000 {			/* 0x4a151000, ap 33 50.0 */
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -785,18 +785,6 @@ qspi: spi@0 {
 			};
 		};
 
-		/* OCP2SCP3 */
-		sata: sata@4a141100 {
-			compatible = "snps,dwc-ahci";
-			reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&sata_phy>;
-			phy-names = "sata-phy";
-			clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
-			ti,hwmods = "sata";
-			ports-implemented = <0x1>;
-		};
-
 		/* OCP2SCP1 */
 		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
 
-- 
2.30.0

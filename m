Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD35304477
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbhAZRCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:02:01 -0500
Received: from muru.com ([72.249.23.125]:53168 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbhAZIaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:30:25 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 60EFF8931;
        Tue, 26 Jan 2021 08:27:36 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 06/27] ARM: dts: Configure interconnect target module for dra7 qspi
Date:   Tue, 26 Jan 2021 10:26:55 +0200
Message-Id: <20210126082716.54358-7-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
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

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 41 ++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -752,20 +752,37 @@ abb_gpu: regulator-abb-gpu {
 			>;
 		};
 
-		qspi: spi@4b300000 {
-			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>,
-			      <0x5c000000 0x4000000>;
-			reg-names = "qspi_base", "qspi_mmap";
-			syscon-chipselects = <&scm_conf 0x558>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+		target-module@4b300000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "qspi";
-			clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
+			reg = <0x4b300000 0x4>,
+			      <0x4b300010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>,
+					<SYSC_IDLE_SMART_WKUP>;
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 0>;
 			clock-names = "fck";
-			num-cs = <4>;
-			interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x4b300000 0x1000>,
+				 <0x5c000000 0x5c000000 0x4000000>;
+
+			qspi: spi@0 {
+				compatible = "ti,dra7xxx-qspi";
+				reg = <0 0x100>,
+				      <0x5c000000 0x4000000>;
+				reg-names = "qspi_base", "qspi_mmap";
+				syscon-chipselects = <&scm_conf 0x558>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
+				clock-names = "fck";
+				num-cs = <4>;
+				interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		/* OCP2SCP3 */
-- 
2.30.0

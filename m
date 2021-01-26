Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B8304792
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbhAZRAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:00:44 -0500
Received: from muru.com ([72.249.23.125]:52972 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389104AbhAZI2I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:28:08 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0D5F88327;
        Tue, 26 Jan 2021 08:27:29 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 03/27] ARM: dts: Configure interconnect target module for dra7 pcie
Date:   Tue, 26 Jan 2021 10:26:52 +0200
Message-Id: <20210126082716.54358-4-tony@atomide.com>
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

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -166,8 +166,21 @@ l4_per2: interconnect@48400000 {
 		l4_per3: interconnect@48800000 {
 		};
 
-		axi@0 {
-			compatible = "simple-bus";
+		/*
+		 * Register access seems to have complex dependencies and also
+		 * seems to need an enabled phy. See the TRM chapter for "Table
+		 * 26-678. Main Sequence PCIe Controller Global Initialization"
+		 * and also dra7xx_pcie_probe().
+		 */
+		axi0: target-module@51000000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			power-domains = <&prm_l3init>;
+			resets = <&prm_l3init 0>;
+			reset-names = "rstctrl";
+			clocks = <&pcie_clkctrl DRA7_PCIE_PCIE1_CLKCTRL 0>,
+				 <&pcie_clkctrl DRA7_PCIE_PCIE1_CLKCTRL 9>,
+				 <&pcie_clkctrl DRA7_PCIE_PCIE1_CLKCTRL 10>;
+			clock-names = "fck", "phy-clk", "phy-clk-div";
 			#size-cells = <1>;
 			#address-cells = <1>;
 			ranges = <0x51000000 0x51000000 0x3000>,
@@ -229,8 +242,21 @@ pcie1_ep: pcie_ep@51000000 {
 			};
 		};
 
-		axi@1 {
-			compatible = "simple-bus";
+		/*
+		 * Register access seems to have complex dependencies and also
+		 * seems to need an enabled phy. See the TRM chapter for "Table
+		 * 26-678. Main Sequence PCIe Controller Global Initialization"
+		 * and also dra7xx_pcie_probe().
+		 */
+		axi1: target-module@51800000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			clocks = <&pcie_clkctrl DRA7_PCIE_PCIE2_CLKCTRL 0>,
+				 <&pcie_clkctrl DRA7_PCIE_PCIE2_CLKCTRL 9>,
+				 <&pcie_clkctrl DRA7_PCIE_PCIE2_CLKCTRL 10>;
+			clock-names = "fck", "phy-clk", "phy-clk-div";
+			power-domains = <&prm_l3init>;
+			resets = <&prm_l3init 1>;
+			reset-names = "rstctrl";
 			#size-cells = <1>;
 			#address-cells = <1>;
 			ranges = <0x51800000 0x51800000 0x3000>,
-- 
2.30.0

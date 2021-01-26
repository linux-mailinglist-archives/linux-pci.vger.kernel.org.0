Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85264304497
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 18:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbhAZRF0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:05:26 -0500
Received: from muru.com ([72.249.23.125]:53178 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390139AbhAZIbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:31:22 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F0BAB8AF6;
        Tue, 26 Jan 2021 08:27:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 15/27] ARM: dts: Configure simple-pm-bus for dra7 l3
Date:   Tue, 26 Jan 2021 10:27:04 +0200
Message-Id: <20210126082716.54358-16-tony@atomide.com>
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
 arch/arm/boot/dts/dra7.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -132,12 +132,14 @@ opp_high@1500000000 {
 	 * hierarchy.
 	 */
 	ocp: ocp {
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
+		power-domains = <&prm_core>;
+		clocks = <&l3main1_clkctrl DRA7_L3MAIN1_L3_MAIN_1_CLKCTRL 0>,
+			 <&l3instr_clkctrl DRA7_L3INSTR_L3_MAIN_2_CLKCTRL 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>;
-		ti,hwmods = "l3_main_1", "l3_main_2";
 
 		l3-noc@44000000 {
 			compatible = "ti,dra7-l3-noc";
-- 
2.30.0

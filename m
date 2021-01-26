Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF9C30476C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbhAZRCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:02:39 -0500
Received: from muru.com ([72.249.23.125]:53164 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbhAZIaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:30:25 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4218788B3;
        Tue, 26 Jan 2021 08:27:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 05/27] ARM: dts: Move dra7 l3 noc to a separate node
Date:   Tue, 26 Jan 2021 10:26:54 +0200
Message-Id: <20210126082716.54358-6-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to prepare for probing l3 with genpd, we need to move l3 noc
into a separate node for l3 interconnect to have it's own regs, and
to avoid it claiming more than it needs for the io regions.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -144,16 +144,20 @@ mpu {
 	 * hierarchy.
 	 */
 	ocp: ocp {
-		compatible = "ti,dra7-l3-noc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>;
 		ti,hwmods = "l3_main_1", "l3_main_2";
-		reg = <0x0 0x44000000 0x0 0x1000000>,
-		      <0x0 0x45000000 0x0 0x1000>;
-		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+
+		l3-noc@44000000 {
+			compatible = "ti,dra7-l3-noc";
+			reg = <0x44000000 0x1000>,
+			      <0x45000000 0x1000>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		};
 
 		l4_cfg: interconnect@4a000000 {
 		};
-- 
2.30.0

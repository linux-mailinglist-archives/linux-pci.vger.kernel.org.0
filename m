Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF59430478E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbhAZRAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:00:40 -0500
Received: from muru.com ([72.249.23.125]:52962 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388921AbhAZI2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 03:28:06 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E46B6820C;
        Tue, 26 Jan 2021 08:27:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Balaji T K <balajitk@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 02/27] ARM: dts: Update pcie ranges for dra7
Date:   Tue, 26 Jan 2021 10:26:51 +0200
Message-Id: <20210126082716.54358-3-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126082716.54358-1-tony@atomide.com>
References: <20210126082716.54358-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to update pcie to probe with ti-sysc and genpd, let's update the
pcie ranges to not use address 0 for 0x20000000 and 0x30000000. The range
for 0 is typically used for child devices as the offset from the module
base. In the following patches, we will update pcie to probe with ti-sysc,
and the patches become a bit confusing to read compared to other similar
modules unless we update the ranges first. So let's just use the full
addresses for ranges for the 0x20000000 and 0x30000000 ranges.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,22 +170,24 @@ axi@0 {
 			compatible = "simple-bus";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51000000 0x51000000 0x3000
-				  0x0	     0x20000000 0x10000000>;
+			ranges = <0x51000000 0x51000000 0x3000>,
+				 <0x20000000 0x20000000 0x10000000>;
 			dma-ranges;
 			/**
 			 * To enable PCI endpoint mode, disable the pcie1_rc
 			 * node and enable pcie1_ep mode.
 			 */
 			pcie1_rc: pcie@51000000 {
-				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
+				reg = <0x51000000 0x2000>,
+				      <0x51002000 0x14c>,
+				      <0x20001000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 232 0x4>, <0 233 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0          0x03000 0 0x00010000
-					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
+				ranges = <0x81000000 0 0x00000000 0x20003000 0 0x00010000>,
+					 <0x82000000 0 0x20013000 0x20013000 0 0x0ffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
@@ -209,7 +211,10 @@ pcie1_intc: interrupt-controller {
 			};
 
 			pcie1_ep: pcie_ep@51000000 {
-				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
+				reg = <0x51000000 0x28>,
+				      <0x51002000 0x14c>,
+				      <0x51001000 0x28>,
+				      <0x20001000 0x10000000>;
 				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
 				interrupts = <0 232 0x4>;
 				num-lanes = <1>;
@@ -228,19 +233,21 @@ axi@1 {
 			compatible = "simple-bus";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51800000 0x51800000 0x3000
-				  0x0	     0x30000000 0x10000000>;
+			ranges = <0x51800000 0x51800000 0x3000>,
+				 <0x30000000 0x30000000 0x10000000>;
 			dma-ranges;
 			status = "disabled";
 			pcie2_rc: pcie@51800000 {
-				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
+				reg = <0x51800000 0x2000>,
+				      <0x51802000 0x14c>,
+				      <0x30001000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 355 0x4>, <0 356 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0          0x03000 0 0x00010000
-					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
+				ranges = <0x81000000 0 0x00000000 0x30003000 0 0x00010000>,
+					 <0x82000000 0 0x30013000 0x30013000 0 0x0ffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
-- 
2.30.0

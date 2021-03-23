Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D303345662
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWDkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 23:40:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54255 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229840AbhCWDkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 23:40:00 -0400
X-UUID: 3dc416eb8f2f41a1baa1c535f34c5eb5-20210323
X-UUID: 3dc416eb8f2f41a1baa1c535f34c5eb5-20210323
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2034568792; Tue, 23 Mar 2021 11:39:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 11:39:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 11:39:54 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>
CC:     <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <jianjun.wang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        <frank-w@public-files.de>
Subject: [PATCH v8 4/4] ARM: dts: mediatek: Update MT7629 PCIe node for new format
Date:   Tue, 23 Mar 2021 11:38:33 +0800
Message-ID: <20210323033833.14954-5-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210323033833.14954-1-chuanjia.liu@mediatek.com>
References: <20210323033833.14954-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To match the new dts binding. Remove "subsys",unused
interrupt and slot node.Add "interrupt-names",
"linux,pci-domain" and pciecfg node.

Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7629-rfb.dts |  3 ++-
 arch/arm/boot/dts/mt7629.dtsi    | 45 +++++++++++++++-----------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
index 9980c10c6e29..eb536cbebd9b 100644
--- a/arch/arm/boot/dts/mt7629-rfb.dts
+++ b/arch/arm/boot/dts/mt7629-rfb.dts
@@ -140,9 +140,10 @@
 	};
 };
 
-&pcie {
+&pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
 };
 
 &pciephy1 {
diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 5cbb3d244c75..ca6789acf057 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -360,16 +360,21 @@
 			#reset-cells = <1>;
 		};
 
-		pcie: pcie@1a140000 {
+		pciecfg: pciecfg@1a140000 {
+			compatible = "mediatek,generic-pciecfg", "syscon";
+			reg = <0x1a140000 0x1000>;
+		};
+
+		pcie1: pcie@1a145000 {
 			compatible = "mediatek,mt7629-pcie";
 			device_type = "pci";
-			reg = <0x1a140000 0x1000>,
-			      <0x1a145000 0x1000>;
-			reg-names = "subsys","port1";
+			reg = <0x1a145000 0x1000>;
+			reg-names = "port1";
+			linux,pci-domain = <1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "pcie_irq";
 			clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
 				 <&pciesys CLK_PCIE_P0_AHB_EN>,
 				 <&pciesys CLK_PCIE_P1_AUX_EN>,
@@ -390,26 +395,18 @@
 			power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
 			bus-range = <0x00 0xff>;
 			ranges = <0x82000000 0 0x20000000 0x20000000 0 0x10000000>;
+			status = "disabled";
 
-			pcie1: pcie@1,0 {
-				device_type = "pci";
-				reg = <0x0800 0 0 0 0>;
-				#address-cells = <3>;
-				#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
 				#interrupt-cells = <1>;
-				ranges;
-				num-lanes = <1>;
-				interrupt-map-mask = <0 0 0 7>;
-				interrupt-map = <0 0 0 1 &pcie_intc1 0>,
-						<0 0 0 2 &pcie_intc1 1>,
-						<0 0 0 3 &pcie_intc1 2>,
-						<0 0 0 4 &pcie_intc1 3>;
-
-				pcie_intc1: interrupt-controller {
-					interrupt-controller;
-					#address-cells = <0>;
-					#interrupt-cells = <1>;
-				};
 			};
 		};
 
-- 
2.18.0


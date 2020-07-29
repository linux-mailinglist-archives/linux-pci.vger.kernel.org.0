Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6EC232190
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgG2PbS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 11:31:18 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10011 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgG2PbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 11:31:08 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2020 08:31:07 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 29 Jul 2020 08:31:02 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 7517321A13; Wed, 29 Jul 2020 21:00:55 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, sivaprak@codeaurora.org,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/7] arm64: dts: ipq8074: Fixup PCIe dts nodes
Date:   Wed, 29 Jul 2020 21:00:07 +0530
Message-Id: <1596036607-11877-8-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ipq8074 PCIe nodes missing required properties to make them work.
Add these properties.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts |   8 +--
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     | 109 ++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index f4a7616..de6171d 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -52,19 +52,19 @@
 
 &pcie0 {
 	status = "ok";
-	perst-gpio = <&tlmm 61 0x1>;
+	perst-gpio = <&tlmm 58 0x1>;
 };
 
 &pcie1 {
 	status = "ok";
-	perst-gpio = <&tlmm 58 0x1>;
+	perst-gpio = <&tlmm 61 0x1>;
 };
 
-&pcie_phy0 {
+&qmp_pcie_phy0 {
 	status = "ok";
 };
 
-&pcie_phy1 {
+&qmp_pcie_phy1 {
 	status = "ok";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 96a5ec8..148b8f9 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -167,34 +167,66 @@
 			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
 		};
 
-		pcie_phy0: phy@86000 {
-			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x00086000 0x1000>;
-			#phy-cells = <0>;
-			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
-			clock-names = "pipe_clk";
-			clock-output-names = "pcie20_phy0_pipe_clk";
+		qmp_pcie_phy0: phy@84000 {
+			compatible = "qcom,ipq8074-qmp-pcie-gen3-phy";
+			reg = <0x00084000 0x1bc>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
 
 			resets = <&gcc GCC_PCIE0_PHY_BCR>,
-				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
 			reset-names = "phy",
 				      "common";
+
 			status = "disabled";
+			pcie_phy0: lane@84200 {
+				reg = <0x84200 0x16c>, /* Serdes Tx */
+				      <0x84400 0x200>, /* Serdes Rx */
+				      <0x84800 0x4f4>; /* PCS: Lane0, COM, PCIE */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie0_pipe_clk_src";
+				clock-output-rate = <250000000>;
+				#clock-cells = <0>;
+			};
 		};
 
-		pcie_phy1: phy@8e000 {
+		qmp_pcie_phy1: phy@8e000 {
 			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x0008e000 0x1000>;
-			#phy-cells = <0>;
-			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
-			clock-names = "pipe_clk";
-			clock-output-names = "pcie20_phy1_pipe_clk";
+			reg = <0x8e000 0x1c4>; /* Serdes PLL */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
 
 			resets = <&gcc GCC_PCIE1_PHY_BCR>,
-				<&gcc GCC_PCIE1PHY_PHY_BCR>;
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
 			reset-names = "phy",
 				      "common";
+
 			status = "disabled";
+			pcie_phy1: lane@8e200 {
+				reg = <0x8e200 0x130>, /* Serdes Tx */
+				      <0x8e400 0x200>, /* Serdes Rx */
+				      <0x8e800 0x1f8>; /* PCS */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie1_pipe_clk_src";
+				clock-output-rate = <125000000>;
+				#clock-cells = <0>;
+			};
 		};
 
 		tlmm: pinctrl@1000000 {
@@ -559,10 +591,10 @@
 
 		pcie1: pci@10000000 {
 			compatible = "qcom,pcie-ipq8074";
-			reg =  <0x10000000 0xf1d
-				0x10000f20 0xa8
-				0x00088000 0x2000
-				0x10100000 0x1000>;
+			reg =  <0x10000000 0xf1d>,
+			       <0x10000f20 0xa8>,
+			       <0x00088000 0x2000>,
+			       <0x10100000 0x1000>;
 			reg-names = "dbi", "elbi", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
@@ -575,9 +607,9 @@
 			phy-names = "pciephy";
 
 			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x100000   /* downstream I/O */
-				  0x82000000 0 0x10300000 0x10300000
-				  0 0xd00000>; /* non-prefetchable memory */
+				  0 0x100000>,   /* downstream I/O */
+				 <0x82000000 0 0x10220000 0x10220000
+				  0 0xfde0000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -620,12 +652,13 @@
 		};
 
 		pcie0: pci@20000000 {
-			compatible = "qcom,pcie-ipq8074";
-			reg =  <0x20000000 0xf1d
-				0x20000f20 0xa8
-				0x00080000 0x2000
-				0x20100000 0x1000>;
-			reg-names = "dbi", "elbi", "parf", "config";
+			compatible = "qcom,pcie-ipq8074-gen3";
+			reg =  <0x20000000 0xf1d>,
+			       <0x20000f20 0xa8>,
+			       <0x20001000 0x1000>,
+			       <0x00080000 0x4000>,
+			       <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -637,9 +670,9 @@
 			phy-names = "pciephy";
 
 			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x100000   /* downstream I/O */
-				  0x82000000 0 0x20300000 0x20300000
-				  0 0xd00000>; /* non-prefetchable memory */
+				  0 0x100000>,   /* downstream I/O */
+				 <0x82000000 0 0x20220000 0x20220000
+				  0 0xfde0000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -658,27 +691,33 @@
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,
 				 <&gcc GCC_PCIE0_AXI_S_CLK>,
 				 <&gcc GCC_PCIE0_AHB_CLK>,
-				 <&gcc GCC_PCIE0_AUX_CLK>;
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE0_RCHNG_CLK>;
 
 			clock-names = "iface",
 				      "axi_m",
 				      "axi_s",
 				      "ahb",
-				      "aux";
+				      "aux",
+				      "axi_bridge",
+				      "rchng";
 			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
 				 <&gcc GCC_PCIE0_SLEEP_ARES>,
 				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
 				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
 				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
 				 <&gcc GCC_PCIE0_AHB_ARES>,
-				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>;
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
 			reset-names = "pipe",
 				      "sleep",
 				      "sticky",
 				      "axi_m",
 				      "axi_s",
 				      "ahb",
-				      "axi_m_sticky";
+				      "axi_m_sticky",
+				      "axi_s_sticky";
 			status = "disabled";
 		};
 	};
-- 
2.7.4


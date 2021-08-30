Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B53FB270
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhH3I0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 04:26:09 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:50742 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234861AbhH3I0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 04:26:09 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 14E3F440CD0;
        Mon, 30 Aug 2021 11:24:54 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: ipq6018: Add pcie support
Date:   Mon, 30 Aug 2021 11:24:52 +0300
Message-Id: <0a6bfc7e9a94eb5c032a019299c9b2477d4d8c1d.1630311481.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630311481.git.baruch@tkos.co.il>
References: <cover.1630311481.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>

ipq6018 has 1 pcie gen3 port. This patch adds the support for the same.

The GICv2m reg property value is a guess based on similar SoCs
description in downstream Codeaurora kernel. It appears to work.

Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
[baruch: adjust #address-cells/#size-cells; drop unsupported property;
 increase parf registers size; add 'max-link-speed']
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3: add 'max-link-speed'

v2: remove 'msi-parent'; doesn't really work
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 100 ++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index ab701da582e5..aaab8d2ee189 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -384,6 +384,106 @@ intc: interrupt-controller@b000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie_phy: phy@84000 {
+			compatible = "qcom,ipq6018-qmp-pcie-phy";
+			reg = <0x0 0x84000 0x0 0x1bc>; /* Serdes PLL */
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
+				<&gcc GCC_PCIE0_AHB_CLK>;
+			clock-names = "aux", "cfg_ahb";
+
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				<&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			pcie_phy0: lane@84200 {
+				reg = <0x0 0x84200 0x0 0x16c>, /* Serdes Tx */
+				      <0x0 0x84400 0x0 0x200>, /* Serdes Rx */
+				      <0x0 0x84800 0x0 0x4f4>; /* PCS: Lane0, COM, PCIE */
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_pcie0_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
+		pcie0: pci@20000000 {
+			compatible = "qcom,pcie-ipq6018";
+			reg = <0x0 0x20000000 0x0 0xf1d>,
+			      <0x0 0x20000f20 0x0 0xa8>,
+			      <0x0 0x20001000 0x0 0x1000>,
+			      <0x0 0x80000 0x0 0x4000>,
+			      <0x0 0x20100000 0x0 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_phy0>;
+			phy-names = "pciephy";
+
+			ranges = <0x81000000 0 0x20200000 0 0x20200000
+				  0 0x10000>, /* downstream I/O */
+				 <0x82000000 0 0x20220000 0 0x20220000
+				  0 0xfde0000>; /* non-prefetchable memory */
+
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 75
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+				 <&gcc PCIE0_RCHNG_CLK>;
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			status = "disabled";
+		};
+
 		watchdog@b017000 {
 			compatible = "qcom,kpss-wdt";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
-- 
2.33.0


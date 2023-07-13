Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E77529AC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGMRTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGMRS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 13:18:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBC2708;
        Thu, 13 Jul 2023 10:18:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-214-236.ewe-ip-backbone.de [91.248.214.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6C536607053;
        Thu, 13 Jul 2023 18:18:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689268736;
        bh=7jLBbWCpB/tZLCVIuH0NgH3tkSVr74qYfvPJihqPkog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nm36yIPwqE+rAA59em2MI8agz010jFeYsx59Oqq9FaeB6INm2P/R2sjT+N0v6+vGK
         ERXa55cYGh5ZhjxFZaZsawX7vJbawRXhExzUDrbXXESfIqXMKlLCpUTHwcYrbWLnWJ
         hKw/llKC9pxcm+849JPAsda+CgLNiBQ1UBA26/5EMQ+fvWVikr07ZdUWnUJg6gn0uY
         7FXzosctIOmVIyAHmpISUmgWcnQQFKuDHQteXnw2UZDqL9q2uQ3y8DDbyNsX98AN6A
         F+XKICrbK+QPG9S5gGTDSXafI1dXgzW2zgng1zzkH6jAvc5OYS7bIWSVMzUhMa82G3
         /LA4rqsDHfo+Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CD6F9480087; Thu, 13 Jul 2023 19:18:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: rk3588: add PCIe2 support
Date:   Thu, 13 Jul 2023 19:18:51 +0200
Message-Id: <20230713171851.73052-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713171851.73052-1-sebastian.reichel@collabora.com>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add all three PCIe2 IP blocks to the RK3588 DT. Note, that RK3588
also has two PCIe3 IP blocks, that will be handled separately.

Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  |  54 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 108 ++++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 6be9bf81c09c..4d66ca6c2e4c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -80,6 +80,60 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	pcie2x1l0: pcie@fe170000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x20 0x2f>;
+		clocks = <&cru ACLK_PCIE_1L0_MSTR>, <&cru ACLK_PCIE_1L0_SLV>,
+			 <&cru ACLK_PCIE_1L0_DBI>, <&cru PCLK_PCIE_1L0>,
+			 <&cru CLK_PCIE_AUX2>, <&cru CLK_PCIE1L0_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l0_intc 0>,
+				<0 0 0 2 &pcie2x1l0_intc 1>,
+				<0 0 0 3 &pcie2x1l0_intc 2>,
+				<0 0 0 4 &pcie2x1l0_intc 3>;
+		linux,pci-domain = <2>;
+		num-ib-windows = <8>;
+		num-ob-windows = <8>;
+		num-viewport = <4>;
+		max-link-speed = <2>;
+		msi-map = <0x2000 &its0 0x2000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy1_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>;
+		reg = <0xa 0x40800000 0x0 0x00400000>,
+		      <0x0 0xfe170000 0x0 0x00010000>,
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE2_POWER_UP>, <&cru SRST_P_PCIE2>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l0_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac0: ethernet@fe1b0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1b0000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index c9f9dd2472f5..27d711d114d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1227,6 +1227,114 @@ qos_vop_m1: qos@fdf82200 {
 		reg = <0x0 0xfdf82200 0x0 0x20>;
 	};
 
+	pcie2x1l1: pcie@fe180000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x30 0x3f>;
+		clocks = <&cru ACLK_PCIE_1L1_MSTR>, <&cru ACLK_PCIE_1L1_SLV>,
+			 <&cru ACLK_PCIE_1L1_DBI>, <&cru PCLK_PCIE_1L1>,
+			 <&cru CLK_PCIE_AUX3>, <&cru CLK_PCIE1L1_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l1_intc 0>,
+				<0 0 0 2 &pcie2x1l1_intc 1>,
+				<0 0 0 3 &pcie2x1l1_intc 2>,
+				<0 0 0 4 &pcie2x1l1_intc 3>;
+		linux,pci-domain = <3>;
+		num-ib-windows = <8>;
+		num-ob-windows = <8>;
+		num-viewport = <4>;
+		max-link-speed = <2>;
+		msi-map = <0x3000 &its0 0x3000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2_psu PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>;
+		reg = <0xa 0x40c00000 0x0 0x00400000>,
+		      <0x0 0xfe180000 0x0 0x00010000>,
+		      <0x0 0xf3000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE3_POWER_UP>, <&cru SRST_P_PCIE3>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l1_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie2x1l2: pcie@fe190000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x40 0x4f>;
+		clocks = <&cru ACLK_PCIE_1L2_MSTR>, <&cru ACLK_PCIE_1L2_SLV>,
+			 <&cru ACLK_PCIE_1L2_DBI>, <&cru PCLK_PCIE_1L2>,
+			 <&cru CLK_PCIE_AUX4>, <&cru CLK_PCIE1L2_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l2_intc 0>,
+				<0 0 0 2 &pcie2x1l2_intc 1>,
+				<0 0 0 3 &pcie2x1l2_intc 2>,
+				<0 0 0 4 &pcie2x1l2_intc 3>;
+		linux,pci-domain = <4>;
+		num-ib-windows = <8>;
+		num-ob-windows = <8>;
+		num-viewport = <4>;
+		max-link-speed = <2>;
+		msi-map = <0x4000 &its0 0x4000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy0_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x41000000 0x0 0x00400000>,
+		      <0x0 0xfe190000 0x0 0x00010000>,
+		      <0x0 0xf4000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie2x1l2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
-- 
2.40.1


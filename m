Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349F7541E6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjGNRzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjGNRz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 13:55:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FB272B;
        Fri, 14 Jul 2023 10:54:51 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-179.ewe-ip-backbone.de [91.248.208.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56B4D660705F;
        Fri, 14 Jul 2023 18:53:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689357226;
        bh=fGlSMsKWMzL+vLAsojC3j/NluxPVAZbuMrm90oW6/3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNthRf1s5IXke6d0bCNH0vmadOB4ZmyoYpBSynrwrBoOZcRx0zp+yJhIAE1Ph0eV3
         Ci+9Kkht+prB95dClBYSoJpS7pd80mg2j4vfOHLWEUoitvkLhe6m8IlcNw8jwEk5SS
         5Hazknj4nBJlcUOhE+csL7job24Xm0eUK8tV+TN8m3BdUBnW5mM7Uo8yWsled4k1Ue
         GCfwCiWupCEJdkRlOfD+wJWDA8eMU9VEOoQQNAK2RxwmEn1Qo7YMBo2bTgclsLPjbs
         eFx1R7TaHGbRy99/D7vl/RZIEQ6ZZvw0O5X686y33SRZEcYcmwWRP7AKFJYZHex/Ia
         /ZTv1GyJV8uJw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C335B4805CC; Fri, 14 Jul 2023 19:53:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
Date:   Fri, 14 Jul 2023 19:53:31 +0200
Message-Id: <20230714175331.112923-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714175331.112923-1-sebastian.reichel@collabora.com>
References: <20230714175331.112923-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add both PCIe3 controllers together with the shared PHY.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi | 128 +++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 4d66ca6c2e4c..af6f52afbaff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -7,6 +7,11 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	pcie30_phy_grf: syscon@fd5b8000 {
+		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
+		reg = <0x0 0xfd5b8000 0x0 0x10000>;
+	};
+
 	pipe_phy1_grf: syscon@fd5c0000 {
 		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfd5c0000 0x0 0x100>;
@@ -80,6 +85,116 @@ i2s10_8ch: i2s@fde00000 {
 		status = "disabled";
 	};
 
+	pcie3x4: pcie@fe150000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0x0f>;
+		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x4_intc 0>,
+				<0 0 0 2 &pcie3x4_intc 1>,
+				<0 0 0 3 &pcie3x4_intc 2>,
+				<0 0 0 4 &pcie3x4_intc 3>;
+		linux,pci-domain = <0>;
+		num-ib-windows = <16>;
+		num-ob-windows = <16>;
+		num-viewport = <8>;
+		max-link-speed = <3>;
+		msi-map = <0x0000 &its1 0x0000 0x1000>;
+		num-lanes = <4>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x40000000 0x0 0x00400000>,
+		      <0x0 0xfe150000 0x0 0x00010000>,
+		      <0x0 0xf0000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+		reset-names = "pwr", "pipe";
+		rockchip,pipe-grf = <&php_grf>;
+		status = "disabled";
+
+		pcie3x4_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie3x2: pcie@fe160000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x10 0x1f>;
+		clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
+			 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
+			 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x2_intc 0>,
+				<0 0 0 2 &pcie3x2_intc 1>,
+				<0 0 0 3 &pcie3x2_intc 2>,
+				<0 0 0 4 &pcie3x2_intc 3>;
+		linux,pci-domain = <1>;
+		num-ib-windows = <16>;
+		num-ob-windows = <16>;
+		num-viewport = <8>;
+		max-link-speed = <3>;
+		msi-map = <0x1000 &its1 0x1000 0x1000>;
+		num-lanes = <2>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf1100000 0x0 0xf1100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf1200000 0x0 0xf1200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x40000000 0x0 0x40000000>;
+		reg = <0xa 0x40400000 0x0 0x00400000>,
+		      <0x0 0xfe160000 0x0 0x00010000>,
+		      <0x0 0xf1000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
+		reset-names = "pwr", "pipe";
+		rockchip,pipe-grf = <&php_grf>;
+		status = "disabled";
+
+		pcie3x2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	pcie2x1l0: pcie@fe170000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;
@@ -221,4 +336,17 @@ combphy1_ps: phy@fee10000 {
 		rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
 		status = "disabled";
 	};
+
+	pcie30phy: phy@fee80000 {
+		compatible = "rockchip,rk3588-pcie3-phy";
+		reg = <0x0 0xfee80000 0x0 0x20000>;
+		#phy-cells = <0>;
+		clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>;
+		clock-names = "pclk";
+		resets = <&cru SRST_PCIE30_PHY>;
+		reset-names = "phy";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,phy-grf = <&pcie30_phy_grf>;
+		status = "disabled";
+	};
 };
-- 
2.40.1


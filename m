Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D484C6B380F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCJIFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCJIFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3111B1B38;
        Fri, 10 Mar 2023 00:05:46 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3A0166030DE;
        Fri, 10 Mar 2023 08:05:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435545;
        bh=MCl+JS4GYShkMG1kJrLBfxKIMkW5axgopzJ3+UFInTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlJoeCfaLeQ5K0EfrokN/aIYO4G5hpSxm4BIz3TP33eSay1Cn/x/QIwTiT8dxUhOz
         zDCngdYFFxczyTS+17tmjlFndUmISr0m3pMs/k9vXXHx9hT3aBxQtNnL+xwW6W3FKz
         GVUu3henJBgLw4F978mqt2RIp7phtozVWX2hQGYdstjpUzyqRBMjn99v7236dnAFnA
         HAg4iIzP2AoSAm+tKzLbTkPhK+Nva15UmX2rN1wUw6oEFJ3rP43/VU13exOryyVJa0
         bOYX2ggSSR0UQogIgB7m1W5vLAOsBBuJDnIKRZMlvxtUXhqTBwuaNU6HoJJg/+swwy
         NMOzlvO0kIfeg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 6/7] arm64: dts: rockchip: Add PCIE2.0x1 lane @fe190000 for RK3588s
Date:   Fri, 10 Mar 2023 08:05:17 +0000
Message-Id: <20230310080518.78054-7-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIE2.0x1 lane @fe190000 phy node for RK3588s.
This lane is used for network controller RTL8125 in ROCK 5B.

This is based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 78 +++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 695aed05eba2..bb66a8252d1b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/power/rk3588-power.h>
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -878,6 +879,83 @@ cru: clock-controller@fd7c0000 {
 		rockchip,grf = <&php_grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+
+	};
+
+	pipe_phy0_grf: syscon@fd5bc000 {
+		compatible = "rockchip,pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5bc000 0x0 0x100>;
+	};
+
+	combphy0_ps: phy@fee00000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee00000 0x0 0x100>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_REF_PIPE_PHY0>, <&cru PCLK_PCIE_COMBO_PIPE_PHY0>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "refclk", "apbclk", "phpclk";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY0>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_P_PCIE2_PHY0>, <&cru SRST_REF_PIPE_PHY0>;
+		reset-names = "combphy-apb", "combphy";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
+		status = "disabled";
+	};
+
+	pcie2x1l2: pcie@fe190000 {
+		compatible = "rockchip,rk3588-pcie", "snps,dw-pcie";
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
+			 <0x03000000 0xa 0x00000000 0xa 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x41000000 0x0 0x00400000>,
+		      <0x0 0xfe190000 0x0 0x00010000>,
+		      <0x0 0xf4000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
+		reset-names = "pcie", "periph";
+		rockchip,pipe-grf = <&php_grf>;
+		status = "disabled";
+
+		pcie2x1l2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
+		};
 	};
 
 	i2c0: i2c@fd880000 {
-- 
2.39.2


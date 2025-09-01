Return-Path: <linux-pci+bounces-35230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A2B3D945
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847A07AD1DE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A715E261393;
	Mon,  1 Sep 2025 05:59:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C434246773;
	Mon,  1 Sep 2025 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706377; cv=none; b=I2+DD39G+EeWf2zu+7QqZtltVcJOysUgN3osPWl/n7yuIltzYeiA9zQ3rNwuO64VuLws4m9l4yZBeWzN0YYhhjIPPArIpp9TxOPjxNHyKh7g/BiKBYGsIHXuBSzStFIczaYHNiZCjsMfSgeopSQiZ9HTuMu/HvJ20ye7UeJumI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706377; c=relaxed/simple;
	bh=f26YcZsrvg9PNdU20bipBTgyviLuewbALEvtIuOCxmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXG8MhVob5Diz2MOjuRL30wX/un5Aij1E8EVrGXHgCPE32Bt70ykGO+cZFCbn2pJObe+AqWOy5CTML7miaMMdX6HjDjiaDZDKNsn2DIkaOxTiO/JhyU0iqbLy9OgPmN4CYA+p9Ly9Ka/eowZgXpvW7GUfVc2e5kun14LS99wR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:23 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:23 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 06/10] ARM: dts: aspeed-g6: Add PCIe RC and PCIe PHY node
Date: Mon, 1 Sep 2025 13:59:18 +0800
Message-ID: <20250901055922.1553550-7-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2600 has one PCIe RC and add the PCIe PHY for RC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..a1ccc141647f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -379,6 +379,62 @@ rng: hwrng@1e6e2524 {
 				quality = <100>;
 			};
 
+			pcie_phy1: phy@1e6ed200 {
+				compatible = "aspeed,ast2600-pcie-phy";
+				reg = <0x1e6ed200 0x100>;
+				#phy-cells = <0>;
+			};
+
+			pcie0: pcie@1e770000 {
+				compatible = "aspeed,ast2600-pcie";
+				device_type = "pci";
+				reg = <0x1e770000 0x100>;
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+				bus-range = <0x80 0xff>;
+
+				ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
+					  0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
+
+				status = "disabled";
+
+				resets = <&syscon ASPEED_RESET_H2X>;
+				reset-names = "h2x";
+
+				#interrupt-cells = <1>;
+				msi-parent = <&pcie0>;
+				msi-controller;
+
+				aspeed,ahbc = <&ahbc>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+						<0 0 0 2 &pcie_intc0 1>,
+						<0 0 0 3 &pcie_intc0 2>,
+						<0 0 0 4 &pcie_intc0 3>;
+				pcie_intc0: interrupt-controller {
+					interrupt-controller;
+					#address-cells = <0>;
+					#interrupt-cells = <1>;
+				};
+
+				pcie@8,0 {
+					reg = <0x804000 0 0 0 0>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					device_type = "pci";
+					resets = <&syscon ASPEED_RESET_PCIE_RC_O>;
+					reset-names = "perst";
+					clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_pcierc1_default>;
+					phys = <&pcie_phy1>;
+					ranges;
+				};
+			};
+
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-- 
2.43.0



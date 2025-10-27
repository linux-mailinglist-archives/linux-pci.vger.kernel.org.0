Return-Path: <linux-pci+bounces-39406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B54C0CD4A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D382F34C570
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD030F53C;
	Mon, 27 Oct 2025 09:58:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6512FBE02;
	Mon, 27 Oct 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559119; cv=none; b=N8yGGo7iUQm6lXmNaeBFlKrRGFADHN9+nV7lpzueNQlZwzmOVPFWu0wn3u8kx9hzx1db0vflk9ohcGSqd9VhyjqrcrcW+aw6NiQv8tFnDi3wEUfdNVD6ILbEjlGWJq1Ps5Rmuz02NzzRAYxYcXfEq9idJQvsz7k7OnawkwiV/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559119; c=relaxed/simple;
	bh=tY8GL6oM3yw1bTGzJEg2pr3YYxYT6bMQfdiZSASnPqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Og2bBsrG/iE5LD7GvvNM7ELG/j+KXCLmvDFrRY6YMeobAHBB7ui/taX9V+ceVGYVC9hrxvAygBHFFd2MRCfCW1dYpIUR/3+hQGDEl0Ws4uccDNxeb2pmWVS1htCztxL5rbC+r8PagzdDA1Pf1+8aQxwSMLeFSCJxEMMCFZAj4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 27 Oct
 2025 17:58:26 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 27 Oct 2025 17:58:26 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v4 5/9] ARM: dts: aspeed-g6: Add PCIe RC and PCIe PHY node
Date: Mon, 27 Oct 2025 17:58:21 +0800
Message-ID: <20251027095825.181161-6-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
References: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
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
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index f8662c8ac089..916e68fedc5a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -379,6 +379,60 @@ rng: hwrng@1e6e2524 {
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
+				#address-cells = <3>;
+				#size-cells = <2>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+				bus-range = <0x00 0xff>;
+
+				ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
+					  0x02000000 0x0 0x60000000 0x60000000 0x0 0x20000000>;
+
+				status = "disabled";
+
+				resets = <&syscon ASPEED_RESET_H2X>;
+				reset-names = "h2x";
+				pinctrl-0 = <&pinctrl_pcierc1_default>;
+				pinctrl-names = "default";
+
+				#interrupt-cells = <1>;
+				msi-controller;
+
+				aspeed,ahbc = <&ahbc>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+						<0 0 0 2 &pcie_intc0 1>,
+						<0 0 0 3 &pcie_intc0 2>,
+						<0 0 0 4 &pcie_intc0 3>;
+				pcie_intc0: legacy-interrupt-controller {
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
+					phys = <&pcie_phy1>;
+					ranges;
+				};
+			};
+
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-- 
2.34.1



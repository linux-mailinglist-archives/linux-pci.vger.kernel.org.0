Return-Path: <linux-pci+bounces-29634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB0AD81B3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4E3B9429
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7272580D2;
	Fri, 13 Jun 2025 03:30:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41B2571BA;
	Fri, 13 Jun 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749785417; cv=none; b=GwZH0DA4xK0pChQBCm+nORZJm0adjiYUHHeuLhevsmtURFilMsj9LvYgt9AgrGKxlUzSJZkQbV+yNL1nbpX31JM7jat4R3NySeVfbeSVhWjZ+7fb55qkfCav9vmdl8FOmfMUr1mq5deqnOaDhoTbyuDRQXmyiTxw3rjEKZifuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749785417; c=relaxed/simple;
	bh=hY26OLd+ttBIhv3LwxsuAVeB6IQrJnV8zG6jeGobekI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om2vv2J9hN0EdHGirHEZ+rxh6ls2b9oCf14h5+fumFqYcjqPFS5FIdJyRUIIjzRSLX/hxhgaJmzwT9DO+z4H7tuwJmqnywtBwNyAMSZjw5d1GWz8eQ/rfwkqb04bJbE/lnc0bm/vuyba4UXi7nPgqmfAHuX4wORfmw4FBlKII0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Jun
 2025 11:30:02 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Jun 2025 11:30:02 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <elbadrym@google.com>, <romlem@google.com>, <anhphan@google.com>,
	<wak@google.com>, <yuxiaozhang@google.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 5/7] ARM: dts: aspeed-g6: Add PCIe RC node
Date: Fri, 13 Jun 2025 11:29:59 +0800
Message-ID: <20250613033001.3153637-6-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2600 has one PCIe RC, and add the relative configure regmap.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..d46a151e3c99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -379,6 +379,59 @@ rng: hwrng@1e6e2524 {
 				quality = <100>;
 			};
 
+			pcie_phy1: pcie-phy@1e6ed200 {
+				compatible = "aspeed,ast2600-pcie-phy", "syscon";
+				reg = <0x1e6ed200 0x100>;
+			};
+
+			pcie_cfg: pcie-cfg@1e770000 {
+				compatible = "aspeed,ast2600-pcie-cfg", "syscon";
+				reg = <0x1e770000 0x80>;
+			};
+
+			pcie0: pcie@1e7700c0 {
+				compatible = "aspeed,ast2600-pcie";
+				device_type = "pci";
+				reg = <0x1e7700c0 0x40>;
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
+				resets = <&syscon ASPEED_RESET_H2X>,
+					 <&syscon ASPEED_RESET_PCIE_RC_O>;
+				reset-names = "h2x", "perst";
+				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pcierc1_default>;
+
+				#interrupt-cells = <1>;
+				msi-parent = <&pcie0>;
+				msi-controller;
+				msi_address = <0x1e77005c>;
+
+				aspeed,ahbc = <&ahbc>;
+				aspeed,pciecfg = <&pcie_cfg>;
+				aspeed,pciephy = <&pcie_phy1>;
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
+			};
+
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-- 
2.43.0



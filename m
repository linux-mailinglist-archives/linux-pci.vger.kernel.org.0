Return-Path: <linux-pci+bounces-6643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB38B0DDA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC18928901B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EDB15F3F4;
	Wed, 24 Apr 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnsDlWZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22015F321;
	Wed, 24 Apr 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971845; cv=none; b=T6IhzyaT9ZgiaAQ8849MX/BUvUpsqCWIlswsHRiz/lDQxK/TSHtXznFuD7mW9x7GqWC8eFc3tJJ7kgaHgNetOw515OxcC3HtOxXjSP2X5eqS2aG9U7ICPDqqmR3DSJN9wy3eD8ZCpp+/w3ssngmWwKdBB6oNu6O2bsKhzLcYRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971845; c=relaxed/simple;
	bh=zV5QDNN0Jd7t4ZstveDXwSQbOhLYZJYhoixvLN8ii44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cznhIQEsgd4zlgjm1vFz1f9CrLqNA3eTsBOlQxFjNp7nC6tTASTFbFCkxtmJVmXCMnKfxP3vPNG04BTN101gWk2cgEaKEAw2+OZn6zCXm9keaQKiEUO+WCGEuQNhw1d5btyj6MmCF9bi0lzbVC211PmCw1l4Qjj4LFlfasIrp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnsDlWZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E2C2BD10;
	Wed, 24 Apr 2024 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971845;
	bh=zV5QDNN0Jd7t4ZstveDXwSQbOhLYZJYhoixvLN8ii44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OnsDlWZcC9DizC+dOmyJVV8+GT0YoHuydH2pzQS6r9zNF+YaXzxLOpHWqpDt6acDu
	 ywb+BfirVQJ5AWkbIpnC35obu8SzJkdHRH3XGCpgD4tfn1MhsZQTWcSgevysD5Pc04
	 wCb6+WHZRzi1N4qoU4xH+/2Sh6xjrW1Ey5DMTshIItJHdDkK1o9FINz+tLaKh9HQDx
	 JGfjRC76s+GHUYMarDLHOvi4LBInDG3NkJ5o3Nl02izIIYCo75T/H23PA9oniO05kL
	 Nb5kyUWYmzjzeo2euqdLMcreb47aBjuOrjfK1o4gY6tiAJH6tkn47A8nID9wpcgM7g
	 QKm7pEVVA3uTw==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:29 +0200
Subject: [PATCH 11/12] arm64: dts: rockchip: Add PCIe endpoint mode support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-11-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=cassel@kernel.org;
 h=from:subject:message-id; bh=zV5QDNN0Jd7t4ZstveDXwSQbOhLYZJYhoixvLN8ii44=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJ2vzOVftD9ZJJ0isXNkldTMw7Lc/+vTGzX+P7v+
 LYFWfW7O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCReeUMf/hi5NfM91qS0rWw
 4qPvO5anzlb5VrfEGUpbDi2667JB9S7D/5q5DucyHlku5mOeZ1cW8tN6cazwelvnXTfzDgWmO7v
 qMAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add a device tree node representing PCIe endpoint mode.

The controller can either be configured to run in Root Complex or Endpoint
node.

If a user wants to run the controller in endpoint mode, the user has to
disable the pcie3x4 node and enable the pcie3x4_ep node.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 5519c1430cb7..09a06e8c43b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -136,6 +136,41 @@ pcie3x4_intc: legacy-interrupt-controller {
 		};
 	};
 
+	pcie3x4_ep: pcie-ep@fe150000 {
+		compatible = "rockchip,rk3588-pcie-ep";
+		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err",
+				  "dma0", "dma1", "dma2", "dma3";
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		reg = <0xa 0x40000000 0x0 0x00100000>,
+		      <0xa 0x40100000 0x0 0x00100000>,
+		      <0x0 0xfe150000 0x0 0x00010000>,
+		      <0x9 0x00000000 0x0 0x40000000>,
+		      <0xa 0x40300000 0x0 0x00100000>;
+		reg-names = "dbi", "dbi2", "apb", "addr_space", "atu";
+		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+	};
+
 	pcie3x2: pcie@fe160000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		#address-cells = <3>;

-- 
2.44.0



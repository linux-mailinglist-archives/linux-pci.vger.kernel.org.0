Return-Path: <linux-pci+bounces-40012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8859C27F8E
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF37188F434
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82391E51EF;
	Sat,  1 Nov 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fS5BHcvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6481531E8;
	Sat,  1 Nov 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003982; cv=none; b=fKcH/td4X/+e9FjNzJOo3XNRn6CPNQ+Auj2NjuL/+RDPaUAU7O5I5UkL+VpYI71ctS2fs9otoiFIeHtbCHEeNn3C5TSsfl/KkHQ3CY/8CDRbqngHJV+zT4nyb27evkGdTBdDXVMaavyc8b6ZVZ84eTJqj2UfJQKNm7CW/rJtYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003982; c=relaxed/simple;
	bh=TML+7NIpD9ku6fMMNJ4M3sDNuPNu+rMvX1U1RKvDE/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pi1rJssmeiBzrB73DNUIoUiwOY6fXvsl0cY5i3vbC/nl8SHjAjZypyABMRLYO32W1cb1fzO5kJl5obyMSGgJQ0vvZTHBbeh9YaFQnIGEQpyGmCX1hCFZgfWe1w+p9RzbWZVwwhg+a/9DdAOIhZpEHH/jbYsAILi9irjk5rovT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fS5BHcvi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=TML+7NIpD9ku6fMMNJ4M3sDNuPNu+rMvX1U1RKvDE/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fS5BHcvi5NKG+PayXkzDIFxY7Y8m/3TPgiARnEqyD6D3CrOj9z3utuHzrvbZXwhnJ
	 kXnsg0GSmRMe3nTgq3T9YmN4Xo1hAHjEe5UUAFdsFnFP4MX6HY+ZRw5ZkiXuTQaprE
	 9Bb69eiqABYmuEpO5zHfwAqhHlNAETVAF04/CkeTT3xLukM7J9Zlp/7JNMOJMMnhq6
	 aXj72/6mY5Di7+KnE9vfg7LfwnRti9EmJ9gI6ZGWSM9rqTmLx1H6Ov7xDOccXMJJ6y
	 zIfefG8sDXNUVjw1mA1tkGOWgfvTqpZ+ht4/Xia735EskZ6IjWT6Mo0ay6wqEJq5uy
	 K1v6mSQQwOrsQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA4E317E1091;
	Sat,  1 Nov 2025 14:32:58 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 88F2410E9D02A; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:46 +0100
Subject: [PATCH v2 01/15] arm64: dts: mediatek: mt7981b: Configure UART0
 pinmux
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-1-2a162b9eea91@collabora.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

Add explicit pinctrl configuration for UART0

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Move pinctrl to the soc dtsi as it's the only available
          pinmux for the uart. And very rare for the pins to be used for
          anything else.
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 58c99f2a25218..4fa35bbf0a9cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -102,6 +102,8 @@ uart0: serial@11002000 {
 			clocks = <&infracfg CLK_INFRA_UART0_SEL>,
 				 <&infracfg CLK_INFRA_UART0_CK>;
 			clock-names = "baud", "bus";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 			status = "disabled";
 		};
 
@@ -229,6 +231,13 @@ pio: pinctrl@11d00000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			#interrupt-cells = <2>;
+
+			uart0_pins: uart0-pins {
+				mux {
+					function = "uart";
+					groups = "uart0";
+				};
+			};
 		};
 
 		efuse@11f20000 {

-- 
2.51.0



Return-Path: <linux-pci+bounces-36427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8BB85AC5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C73626E84
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D730EF94;
	Thu, 18 Sep 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IeA521fU"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED68221D9E;
	Thu, 18 Sep 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209556; cv=none; b=RKf0NOMsb2W8OV1Nu8RdGO2QIrF/SXYsEK1rsGWRbQrgoadbHUy9rsUr4ANHLqga51IEq1kw7CsFe59FIZyi4vOvaC+yynpSHVNsYoSfrpyAChaulOpFa/qxjrEWUWz3OXkqbC2oK/lmjNhdB0NM6PXOfz8ob/y9LGGm8uKyhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209556; c=relaxed/simple;
	bh=sHDVtuH4++8ryiRLH7XMcszZN3f5qzA2Cv1Z4Rnzrrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpQqmGf/jShXIef3doETYcanjfEMWmcm5tCCEj/p9pRMkNTu2NCyQWOC+7S61XCyw93Z/bdcTolt5bQ+Ms2nYqQi5IgOxwYMJ0W9tDyCavVAGYkhfyjocNy9+dZMuptbJOe9+/55Z7ykGGS2J6ClrJPHVG+Jrqrhd48otSNTkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IeA521fU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4C39B261A3;
	Thu, 18 Sep 2025 17:32:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OFj74AdZKf4; Thu, 18 Sep 2025 17:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758209552; bh=sHDVtuH4++8ryiRLH7XMcszZN3f5qzA2Cv1Z4Rnzrrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IeA521fUUF+ISMT4xLkvU4EKmMZVqsgvseTkPxd3TEwWFIvTd9gBLEgHW0aoEPWUT
	 UTBwCrKeCNXg3vtnbUPz1y8ydJlk6FVtiPTfV8EAiixvbPE8kFX4Sxm4sBjdPKR2To
	 e/lzfP9LbgiLH8rpxZ//EmeEl2bN/jxpwI8vZGSwh+QzmYEtN+1lZ9MbcpDMuQyojG
	 xWEfrRh213XE2x6D5gaDeHTiaUS+l5eh1W3kg7axcQQbvS8efkxb716pyMrQfyUUKa
	 ZMVTpu8lOZ41k1g84G5sgE+Da6wGiU96Du4HmlF/fgm04KqW0nVoSeGQqrq/sLIyTE
	 vHzxhZWnkkHMg==
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Enable PCIe controller on Radxa E20C
Date: Thu, 18 Sep 2025 15:30:57 +0000
Message-ID: <20250918153057.56023-4-ziyao@disroot.org>
In-Reply-To: <20250918153057.56023-1-ziyao@disroot.org>
References: <20250918153057.56023-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radxa E20C provides one of its GbE ports through RTL8111H connected to
SoC's PCIe controller. Let's enable the controller and the PHY used by
it to allow usage of the port.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index 12eec2c1db22..b32452756155 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -171,6 +171,10 @@ vdd_logic: regulator-vdd-logic {
 	};
 };
 
+&combphy {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -229,6 +233,14 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pciem1_pins>;
+	reset-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &pinctrl {
 	ethernet {
 		gmac1_rstn_l: gmac1-rstn-l {
-- 
2.50.1



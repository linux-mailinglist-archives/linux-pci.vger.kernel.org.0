Return-Path: <linux-pci+bounces-41542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4FC6BBDF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 36E9C2BCD6
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9B308F1F;
	Tue, 18 Nov 2025 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwnjNsze"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29F231A41;
	Tue, 18 Nov 2025 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502208; cv=none; b=k1MtAX9lBG6zXYlJmFawxdWeSPtU2IqY4c3ktLyuszpuEZSWpDvC/IV6V2VRrtUvC6NN3a18/pBmbY7WZY3kmgDMkpz7Cka32LM+fckQME4chJn9bGH3fqHzAtEE46VOCIwT0bE/9qC1OsuFVmWSJEZhkXmBfys587qfHYC08qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502208; c=relaxed/simple;
	bh=piP/RwbPgLfG2R/w3aecdxfRCWSEvz8vScqdpVTga7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYuYAFnMnOXDA7hBoc6MfP5kFrZ6Fbj55pKBudsgRNnNmM1bkO/SMKEQdXZ319Ix+Npx6EXdkjw3yF/mrmOc3d/KP52urlzp+LVRQdRMzEBi//b0gLiNA3wdYWCmscChNJYruPV9vBCKKHRo4n4AeNPr6wxVFcBVccPUG6RX9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwnjNsze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E9C4AF12;
	Tue, 18 Nov 2025 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502207;
	bh=piP/RwbPgLfG2R/w3aecdxfRCWSEvz8vScqdpVTga7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwnjNszeyn9daUwzPkwXHXbm3uS3LnvI7TRirjy1MtUO1KAzBjZ2f+fiyRiDPUjHg
	 6tw0Hjvho6hSMPZpzK5yqNIjgUysVyYyMKsCm9OgEZx/CuACD9r8r42Tkwu+wxw0SB
	 SqjqkmQdH0JDdG+trYr4wstR57e/cuNEIJbTaGZpGn18iGD6c9tdLtU/umKIA93JCq
	 llhW8re++DyBRIh6cyThEpOspsojrmGk5y4TduwuWAkpLccTxZ20N8nlvehUGItOTG
	 vwzCo7H45khum/cEyDtv276WoHPaS4pVd2g6OceLL6WKLerfYoBI1vXlJqeTqZdnfl
	 dkFv9EGB6xubQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1
Date: Tue, 18 Nov 2025 15:42:18 -0600
Message-ID: <20251118214312.2598220-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118214312.2598220-1-helgaas@kernel.org>
References: <20251118214312.2598220-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

Add supports-clkreq and pinmux for PCIe ASPM L1 substates.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/1761187883-150120-2-git-send-email-shawn.lin@rock-chips.com
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index ff1ba5ed56ef..c9d284cb738b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -522,6 +522,7 @@ &pcie2x1l0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_0_rst>, <&pcie2_0_wake>, <&pcie2_0_clkreq>, <&wifi_host_wake_irq>;
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	supports-clkreq;
 	vpcie3v3-supply = <&vcc3v3_wlan>;
 	status = "okay";
 
@@ -545,7 +546,8 @@ wifi: wifi@0,0 {
 &pcie2x1l1 {
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
+	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>, <&pcie30x1m1_1_clkreqn>;
+	supports-clkreq;
 	status = "okay";
 };
 
@@ -555,7 +557,8 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_reset>;
+	pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
+	supports-clkreq;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
-- 
2.43.0



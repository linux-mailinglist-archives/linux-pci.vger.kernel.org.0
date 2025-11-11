Return-Path: <linux-pci+bounces-40939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B070DC4FF59
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525B24E90C5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7C2F12C4;
	Tue, 11 Nov 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ6ZSNET"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70035CBCB;
	Tue, 11 Nov 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899399; cv=none; b=jefv4Opdzog5ArQ1+0U+2lVSXTYxg6vfWcU5uveyyWgpVzTuNW/ElyjKR8SMbwmtgxi+OyJXSZAxei734xjrnFNUrynrWwTwloiB6JM3GCHegrjv7zvmgJVsGEjEq/4tajJOINHs8fc79BpYiHl4fBUxg1UM/FGaudN8VMz1tOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899399; c=relaxed/simple;
	bh=piP/RwbPgLfG2R/w3aecdxfRCWSEvz8vScqdpVTga7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zuk+L6bm2f4lBzl4Ue9ZkgShrbo007oIYueAhM8hdUEhDo25byIC/4h0KJ8M2TszUI128EhIgMSYOHYjdHG8jeUBtQsZcIthkTET21gwMabRIVnhAPxfCnxccxiTiAgtAV0yv+VZXz5Hh8rcmT1s8V5VNVzvWcBrz/a/9G4meeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ6ZSNET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FDCC4CEF5;
	Tue, 11 Nov 2025 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762899398;
	bh=piP/RwbPgLfG2R/w3aecdxfRCWSEvz8vScqdpVTga7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ6ZSNETJMT92b3zYiGiIx7Ydvvs0kleK7C5qXbMjuOSuCW+VZK3Ls8jgstesTrWS
	 yMADIldoLS/F5KrHgBeUm0uRcWt1rEuchfK9XmapNz2TF/Kz9a20CdqUr7FI8QNRAK
	 88Nd8SbgCjY86c5xj4Dt8I8Mx1w9Nkg9tyOTl0MBxbYxbahx4qTMMb65q6xQz3HOt3
	 zZtDJDqD5GYpsKvdB3/pssXrn9lYmP3eTYOq9k80N00IQFq/66K4CWAZ6V/ItqVBpC
	 0DHFhiQD28+i1OvetrcVrXaylERxY3DNUFQq87ZSy3Zz8fApA+UZEB2WLG542UPJGE
	 6nakGzrXOfMmw==
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
Subject: [PATCH 4/4] arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1
Date: Tue, 11 Nov 2025 16:16:11 -0600
Message-ID: <20251111221621.2208606-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111221621.2208606-1-helgaas@kernel.org>
References: <20251111221621.2208606-1-helgaas@kernel.org>
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



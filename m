Return-Path: <linux-pci+bounces-6644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C608B0DDB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A211F24207
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F815F336;
	Wed, 24 Apr 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkz80Otu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FE15F321;
	Wed, 24 Apr 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971849; cv=none; b=bMxuDMsmmQQIAv6KVL6uaddVMy1mfmdHmw0fYQF0Wi/1aPhfA1a3cPx3+49BS83yKi+cpQGyYdSzRHErjAcZwj0oYAzsmLxosb/oK6KwfrVEtWbcPcfasEVWcrjdkIDqxW30cFHscxMnCBZKk5qt6DdzGhZghpZpFXu4AAVt1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971849; c=relaxed/simple;
	bh=4qN66Ir2UFp9Lf/FY4N/yTmNKplsIfb7tfx/17jEJAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3enLnjMTnlv7XDzi8xHyDIPxF4rfSFzblXK8bdHoQx3wkGK5KuHRA4kcT7Och7w0/SuP6jdqAU3msa75xUJjUpDeCPMrP9Gvky05ap8xdHcEQzMxI4gJpCTs/3XjQ3k3wejcd7iqK0jYLaTunCbede0HUkfZNjBhAo3vuFjLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkz80Otu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49E0C2BBFC;
	Wed, 24 Apr 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971849;
	bh=4qN66Ir2UFp9Lf/FY4N/yTmNKplsIfb7tfx/17jEJAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tkz80Otu/qsk4gxkTDRhPCfxhw63mmqY7A580MlClCocRlvpjXlve5uCabx3CR1z3
	 5swKXcHN4NxE7zIWEo0Xd/gzZfUB5imjV4H2vDdj8dPXJRqdt8FQrtWNJCyTge5fXF
	 FXoqbFUX2/tCvp8GYJ6UOgrcoY8Pn101HuaCJRaIBvU46ItaubJtKGZDbaIYH7UEfn
	 7tx94lEFiYU032Ef9SrVhSmltc2VPJYiAVPABEGBtRtFI7rECk14oY2Ms+EawxHhMg
	 bbf4md1oxdjIf7+ccKvwXNLvkBJNDV9eRVHx85nTuuNWmvDpYGs2HjOv89hA9MRpEW
	 iTja8a21M1TMQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:30 +0200
Subject: [PATCH 12/12] arm64: dts: rockchip: Add rock5b overlays for PCIe
 endpoint mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-12-b1a02ddad650@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=cassel@kernel.org;
 h=from:subject:message-id; bh=4qN66Ir2UFp9Lf/FY4N/yTmNKplsIfb7tfx/17jEJAs=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYKcGwu8Yk92bqh/ENrLmLc5T12mcNMbk+OqR3ars
 3OaL5jYUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlURTP8L6vd/9XqcKvK4++3
 F5yclFv6aNn75wKvw1e6TZ7cPtkpaBEjQ0vT7OAbM6QLoibuk5q3TcIuYZ1cmkONuPV1ppms2zQ
 +cAIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Add rock5b overlays for PCIe endpoint mode support.

If using the rock5b as an endpoint against a normal PC, only the
rk3588-rock-5b-pcie-ep.dtbo needs to be applied.

If using two rock5b:s, with one board as EP and the other board as RC,
rk3588-rock-5b-pcie-ep.dtbo and rk3588-rock-5b-pcie-srns.dtbo has to
be applied to the respective boards.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 arch/arm64/boot/dts/rockchip/Makefile              |  5 +++++
 .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  | 25 ++++++++++++++++++++++
 .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     | 16 ++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index f906a868b71a..d827432d5111 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -117,6 +117,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
@@ -127,3 +129,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
+
+# Enable support for device-tree overlays
+DTC_FLAGS_rk3588-rock-5b += -@
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
new file mode 100644
index 000000000000..672d748fcc67
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * DT-overlay to run the PCIe3_4L Dual Mode controller in Endpoint mode
+ * in the SRNS (Separate Reference Clock No Spread) configuration.
+ *
+ * NOTE: If using a setup with two ROCK 5B:s, with one board running in
+ * RC mode and the other board running in EP mode, see also the device
+ * tree overlay: rk3588-rock-5b-pcie-srns.dtso.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&pcie30phy {
+	rockchip,rx-common-refclk-mode = <0 0 0 0>;
+};
+
+&pcie3x4 {
+	status = "disabled";
+};
+
+&pcie3x4_ep {
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
new file mode 100644
index 000000000000..1a0f1af65c43
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srns.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * DT-overlay to run the PCIe3_4L Dual Mode controller in Root Complex
+ * mode in the SRNS (Separate Reference Clock No Spread) configuration.
+ *
+ * This device tree overlay is only needed (on the RC side) when running
+ * a setup with two ROCK 5B:s, with one board running in RC mode and the
+ * other board running in EP mode.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&pcie30phy {
+	rockchip,rx-common-refclk-mode = <0 0 0 0>;
+};

-- 
2.44.0



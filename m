Return-Path: <linux-pci+bounces-8459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50FC9001D1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F9E1F234FE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BD187323;
	Fri,  7 Jun 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akD/4Jcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391108287F;
	Fri,  7 Jun 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758927; cv=none; b=tJXhaXml8tnB9o6+JQjNSAMrRqAYQtWRqNBmiiIuBF9ph/eTqGXoKCOWvYP4bTVhGiX5EK10rUA/kBW89xNetFWmYF+kO+OPRpPvuRu9wR2FnyD0ruonu8ueJCsUU75PgpR3HXV6H7M/FRg4tXKn/SzRDBK7opLNhTyCH5BdHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758927; c=relaxed/simple;
	bh=gjIWr0kYi+PfpWyhN4RYvATqiMNJcldLk2bvRG5ASpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGuRmqUBr/0ws8V8ARN6LC+WO6/L/dYSf4DZdU9wltSVYqHOre7ahGveYi6xbLPzbA85LGrn6e6j8EAidcT5oPbrx2M0sj4ZO3Ydi3An9798nhKXqXBTQidAy1a91WCHA8Ea/sih0vRHi7i+Nycn6F2BUx1u7oneu1zo2UNHwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akD/4Jcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E7C4AF0C;
	Fri,  7 Jun 2024 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758926;
	bh=gjIWr0kYi+PfpWyhN4RYvATqiMNJcldLk2bvRG5ASpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=akD/4Jcc/h0/l39agKkAAO8wOZ9Azdm/0qG6la/bjOR3Kaq6w2ceBfnF6hjAGvHgo
	 OC7XfqsInV4Jb40/qKy3JKc3dpQn0XaX2ZFeA1x6G5XvTes3VasgCeJIw/WuWMc5gz
	 RhCFiQS/yXLgqaoqB6D+Y9PcI8cCiRPyagoNP8gAni7WGepzOKW98YsapiBHox+hVd
	 lWzssYwS/OA+ucWNN7m9HDABkyntWdNgMpMDeyNieZBwY8uaorycDuPNdK49aMQzf/
	 XLZOkeWSGw6kNMcGHtiInotTf2fZzpNxV00DE1zJxvByvI5znF7Jp+z3dzqquwOiOr
	 lHP7ww67XfoVQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Fri, 07 Jun 2024 13:14:33 +0200
Subject: [PATCH v5 13/13] arm64: dts: rockchip: Add rock5b overlays for
 PCIe endpoint mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-rockchip-pcie-ep-v1-v5-13-0a042d6b0049@kernel.org>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3452; i=cassel@kernel.org;
 h=from:subject:message-id; bh=gjIWr0kYi+PfpWyhN4RYvATqiMNJcldLk2bvRG5ASpw=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKSXk/iPqy19cWx4BL5ben1Sf1LJpyf73BYfnv2hDdvH
 kyUjS+411HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJqE5j+J/MG8X+cXbSylnt
 nD3PvPb2Pbm3/NO9KfzMQr4mF3N1SoMY/uelPPfZUebw/PO6LOPI9rVd5lpmuwOmBS1U+3RC9v+
 /j7wA
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
index f42fa62b4064..df7f5103b018 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -124,6 +124,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-ok3588-c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
@@ -134,3 +136,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
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
2.45.2



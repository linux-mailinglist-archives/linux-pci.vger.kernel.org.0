Return-Path: <linux-pci+bounces-7239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCBE8BFE4F
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0111285125
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B630684DE8;
	Wed,  8 May 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3vDS/ZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87585C5D;
	Wed,  8 May 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174075; cv=none; b=V/lysNIdZ1+niWzxmNDyvxYgFTSGF6yq8vp0wUlsKbS5HWs8kmzsze4xyyXe0ekh3foM49gr+yORcUwEkJVfc/PpuUrx7IHh/tEK6CyFFDBnA2ZU4uAK/fUVt0M3LMDBtB5JdMO43Oy0OdBdZy6KW1zUulAaljUS9GKkuZKakkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174075; c=relaxed/simple;
	bh=4qN66Ir2UFp9Lf/FY4N/yTmNKplsIfb7tfx/17jEJAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0pyTDBXuUQ1MUrqhRgMCj2PqK/zF26vTBx0bH186Z18/tmddoytpW/IlQr6dnkHDjwloxgLZU+RuAiki88ZXqk+alIi2hNLwf9TankElggs5saF5WqaaBVRIKjtLfesdHILdmh0yIMN1q4lyuvZnTyKvttS9dOaZSbsu2ZxP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3vDS/ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0A4C4AF17;
	Wed,  8 May 2024 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174075;
	bh=4qN66Ir2UFp9Lf/FY4N/yTmNKplsIfb7tfx/17jEJAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H3vDS/ZMSu2jc/jka1+zMAJzWeo1JXgkRQQskyMCMxX62PRtYTOIOhHu8i9X81GAm
	 +Z5zN3lTn2Qph8nyMUcuQIeDOdnvsUhxp4eE3VGA6cgYAEN3uS4kSBWff686u+u+f+
	 Zerrus9eC4o6EwKFHsTKCMtwGupLE1wl+G2TezU4rwJ+w3hvnbGFtUgBZYVDHrwJuT
	 Tm03m0GYeON5ewFn3k/Jco3d6+bUQ2GrHFwL+bXbd3VK8Ead/a8wX6imIl79hdi0U2
	 09z1rpAp4/ffp8Oou0axIxtDb2RjKy7KkvSXhec+GQpNbKdktGoRo1wMb4wco7/wY5
	 pAp3XxYloP1xQ==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 08 May 2024 15:13:44 +0200
Subject: [PATCH v3 13/13] arm64: dts: rockchip: Add rock5b overlays for
 PCIe endpoint mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-rockchip-pcie-ep-v1-v3-13-1748e202b084@kernel.org>
References: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
In-Reply-To: <20240508-rockchip-pcie-ep-v1-v3-0-1748e202b084@kernel.org>
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
 b=kA0DAAoWyWQxo5nGTXIByyZiAGY7en+iU336wmdzkB6v5qlNz4tNEY6beo6f2OZq/+SyqI20f
 Ih1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmY7en8ACgkQyWQxo5nGTXK7XQD+PmFy
 Ydn/rF0xGmAkuXJHReuOBaNrXhf01lI4aa6pweUA/iVGALA3enh08RohJX+udFsce2YzMIbCO4t
 VB3hVI8kK
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



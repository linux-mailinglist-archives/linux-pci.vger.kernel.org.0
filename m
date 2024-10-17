Return-Path: <linux-pci+bounces-14718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8A9A184B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF61C212F8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D7381B1;
	Thu, 17 Oct 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuGE6ufX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D41224F6;
	Thu, 17 Oct 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130360; cv=none; b=tL4TAHOCmb+U0eLy9n+6Tya3vxbXmiUONboMk0IU7RvwGcMzSR1l2+1Yeek+W+L/lLxl67+Tb+z6HyKTc6sa8YS/OLNxNwgiK9dfIAU4oyOi6P/5GFrSRIlmjECIf+AYAhMMa7Uj3GzwnpAYWAg2Yp16YLI305l/RmguUPkuZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130360; c=relaxed/simple;
	bh=9A4ebH99NqbJvu4o7NsI8CnYt8jbJv19+dSmlm3CaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeGfQ36rGobDlz0TBVievpWk2eZYUNzzr7Z/jKZyFoA1Lq83uMDWGEQUl291i/MNvAcnWCAwbPdJ0jySzD2dqc4vcYT49vBDbYkFKiddoMZpfninv+Cw+34qd+pxKj7aBzNY2nVaOYdYbuW4jdd/41cV2pg2hc6SiRbyYSpxYKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuGE6ufX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6F5C4CECF;
	Thu, 17 Oct 2024 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130360;
	bh=9A4ebH99NqbJvu4o7NsI8CnYt8jbJv19+dSmlm3CaL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuGE6ufXFUE0NeStZ4HdNsa491n1fWoJuoK951HoIXZRUIWBGzO2Ny3fRjElgcEds
	 vzJGuaXNQIw/ReQ2rR/sYMpueQhjTM3jEZP4NA7vSWV5aXSEW9CLccXYqkJTre4f9r
	 alB4kDTNFwpgRIM0y20cW9fF3DXah7KZvois+zQUTqaTdxoSm0RPxwzGsRcQ9R09TZ
	 jMqPrPULOO4WUTWMnvPGaUVd1hiOrhYw1hgC1ZMiSWQz0cV5Us/iPq/heQKRt9DOl8
	 V/+WzkpNHSGJuRp2O5ApzAZnHFSDD2r8N4Vz1y8DKDk4oPpFxp5ilI0H9+2KBmLS+u
	 zdm8sRIgXJnrg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 14/14] arm64: dts: rockchip: Add rockpro64 overlay for PCIe endpoint mode
Date: Thu, 17 Oct 2024 10:58:49 +0900
Message-ID: <20241017015849.190271-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DTS overlay file for the rk3399-rockpro64 DT for enabling PCIe
endpoint mode support.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../rockchip/rk3399-rockpro64-pcie-ep.dtso    | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09423070c992..184131a58704 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso
new file mode 100644
index 000000000000..cebfb71bebfc
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * DT-overlay to run the PCIe Dual Mode controller in Endpoint mode
+ * with the #PERST signal handled with gpio2.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/dts-v1/;
+/plugin/;
+
+&pcie0 {
+	status = "disabled";
+};
+
+&pcie0_ep {
+	reset-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
-- 
2.47.0



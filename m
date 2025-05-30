Return-Path: <linux-pci+bounces-28740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93274AC97E4
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA94A79A5
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6628C852;
	Fri, 30 May 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TwvznlkF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Aed9Plpe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C528C01B;
	Fri, 30 May 2025 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645754; cv=none; b=GQzqVhMAQ2ndjrnwfSGWJfj6WJZO3sjTVd0EJkZtivs7UTYRyjRvYjOF28uVVX8+ZnIstAOXcNOsj97LxTVDKpPyZ7Mmsrlr96Rcq0Fn2ZK/zZOY5pXs+LoF+i7wzkIRkcFRpdPy/sq6mQqnCgLLqgfhaqDWC1tP31iM8TDbG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645754; c=relaxed/simple;
	bh=H5SikR67l8KY+4PR/WJ85swjtaEmQKdaUD0wH2mh5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfEk+vHBInMdIoilNDazKN6lLac/Fc5auQCa0QnqfrRpEUmUGBs3o7KymruuRxlgEjDoRGNo+mpP47FJ3RX5WK+Q6eZzMh08sHbtNcRW72CHNBWS1NZAvd3m1pUJfqy0Bd5gDzUp/P5MM4LXMUH3NBwpoMGAdAUJiX3gGs8aWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TwvznlkF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Aed9Plpe; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b8JVv30KNz9tMd;
	Sat, 31 May 2025 00:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwTU6GhBxDayHGkAjxVeGm8gG2E5qURVHEFtQeVt+aE=;
	b=TwvznlkFIV/iJ9t+O3JFNk667q+zhu3fL7VTHvsjfLGbKKgtxmFEZzrTB4PtkqRL6520bJ
	riRfBDmExyvmfLdWZhAqmcPu7BoPjSPgoVCoJCWRarglHKxLo3PZxIj9Dcrw7lI9J68otH
	nf1YI2nwm5LMD6fim0LU9zK1uL0wCmKXtdBzhrO+UJANiyIHwboLwpjMAQMLQvFfGCRTLR
	i2jtH4u2bSy8ZhfgKQwrYQYYy4PDCkclnvUDV41eukrtUaPNFRIDokjFv62kUzXQj2c/qG
	moJhZxnM3eHbaLbc8XXdXfxotlpI4QeSWQFmvhoeFd5HHRiOWnnqgqlER8Stog==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwTU6GhBxDayHGkAjxVeGm8gG2E5qURVHEFtQeVt+aE=;
	b=Aed9PlpeJtSAlbkYFZuaU9SGpx3qZfDZCffkoc1pfhKmtL+4e4/CpMsTlL20VAV9zXlS85
	z/DP/fIrCHRpyBJIJscDLs/9PQcLsPu0zYWSjbBcAfumAQoV2AseG15QD1beGYO8MJWa+J
	ydr9x/B1fzO2ASoMm+QukEph+qmjoIQK4ChO9hkXs4Zc+21+qV/x4k35itm1KOKg0i7sIC
	PNMduj/9a7eNeIhrX5GSjX4mNIhaKG8sQ1htCdEJD+GNmUe/fYjYuUeEPLQgOnyhrdv+pR
	sJUYRs0K3xkM8AQG5wAjJ9Il2/j0Z9bw4vshPLK1X1CHqYKQ0489H/8+EfRAqw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: renesas: r8a779g3: Describe split PCIe clock on V4H Sparrow Hawk
Date: Sat, 31 May 2025 00:53:21 +0200
Message-ID: <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f6af4dcb4036654d702
X-MBO-RS-META: a1ys445yh6wx88t7n869r1r6bbyga88r

The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
Describe this split bus configuration in the board DT. The topology looks
as follows:

 ____________                    _____________
| R-Car PCIe |                  | PCIe device |
|            |                  |             |
|    PCIe RX<|==================|>PCIe TX     |
|    PCIe TX<|==================|>PCIe RX     |
|            |                  |             |
|   PCIe CLK<|======..  ..======|>PCIe CLK    |
'------------'      ||  ||      '-------------'
                    ||  ||
 ____________       ||  ||
|  9FGV0441  |      ||  ||
|            |      ||  ||
|   CLK DIF0<|======''  ||
|   CLK DIF1<|==========''
|   CLK DIF2<|
|   CLK DIF3<|
'------------'

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Use pciec0_rp/pciec1_rp phandles to refer to root port moved to core r8a779g0.dtsi
---
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index b8698e07add56..9ba23129e65ec 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -130,6 +130,13 @@ mini_dp_con_in: endpoint {
 		};
 	};
 
+	/* Page 26 / PCIe.0/1 CLK */
+	pcie_refclk: clk-x8 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
 	reg_1p2v: regulator-1p2v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.2V";
@@ -404,6 +411,14 @@ i2c0_mux2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			/* Page 26 / PCIe.0/1 CLK */
+			pcie_clk: clk@68 {
+				compatible = "renesas,9fgv0441";
+				reg = <0x68>;
+				clocks = <&pcie_refclk>;
+				#clock-cells = <1>;
+			};
 		};
 
 		i2c0_mux3: i2c@3 {
@@ -487,26 +502,38 @@ msiof1_snd_endpoint: endpoint {
 
 /* Page 26 / 2230 Key M M.2 */
 &pcie0_clkref {
-	clock-frequency = <100000000>;
+	status = "disabled";
 };
 
 &pciec0 {
+	clocks = <&cpg CPG_MOD 624>, <&pcie_clk 0>;
 	reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pciec0_rp {
+	clocks = <&pcie_clk 1>;
+	vpcie3v3-supply = <&reg_3p3v>;
+};
+
 /* Page 25 / PCIe to USB */
 &pcie1_clkref {
-	clock-frequency = <100000000>;
+	status = "disabled";
 };
 
 &pciec1 {
+	clocks = <&cpg CPG_MOD 625>, <&pcie_clk 2>;
 	/* uPD720201 is PCIe Gen2 x1 device */
 	num-lanes = <1>;
 	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pciec1_rp {
+	clocks = <&pcie_clk 3>;
+	vpcie3v3-supply = <&reg_3p3v>;
+};
+
 &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
-- 
2.47.2



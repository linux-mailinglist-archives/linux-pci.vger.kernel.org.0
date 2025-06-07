Return-Path: <linux-pci+bounces-29155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C014AD0F2E
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B5D3AB0F9
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D6218EB7;
	Sat,  7 Jun 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hr2YSiec";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D7f5hNVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62D20C01B;
	Sat,  7 Jun 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325589; cv=none; b=iwcxGbP6M/h4izyqTHNIwxiUumx1Z/QhY6DYTWQH93UiKjuVenuFfvZe5FSRpnGb0eZV/nfpmSQPEX8UEqNDkSRj/sS5pMHyRCsOmtKaNH7/CZ1g7GLUC/Vk1Sy0KPGC8t7lzAznwQK5tkVAjwG5xdviSRErPa/P1zbmlz8vW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325589; c=relaxed/simple;
	bh=qJCOQca7UO4qw/AK1JoNTMqmFqp3B4Oizaa3gr7MDSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLEQBVURiBxnAJ2ONQUKVqmFLJ3Y27QyX0EGVUhtm17ZRrxA6lccz04874fhaNcSXTLroFKA6VUU/Iiisugw3zMJqMm8Tb1rQDH6q9dq/24I9z4z7y+xclzS52hI+PewyANR6GUb58oqZYk2YSGv0rQ8sxgb4WBJtNsnH16NSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Hr2YSiec; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D7f5hNVZ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bF7wX0BgRz9shj;
	Sat,  7 Jun 2025 21:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U35d7F4ySvr4ve2pA4Gs/YLbV7hHI8pCrNn0trnfB+Q=;
	b=Hr2YSiechTXxkKfWWpAd7e7N4lYfLay/NPCyTttgwmYi+gila84k62Tqfx3HE3wUa8Ra/5
	SqTTj/Lu39EYeJvxBBxuqTAnGFuMoCc3J+V+v90ofjIttaY6jI8N7QfwKuoX58HIVaCgD5
	4XFrzhPRQZfWKiajQXmD4kNPN6AuIJfqtSPVe/OQM4dewEcQmgolkvS6CG+0p7zHOAeZ+t
	Ouh5KhooQh5ml6BW/fANJmxk/HNnh7vMkf4vi/3v3EjPgFTnim6WttXokPAS2nONaQD9Vl
	QNKbR6NpCjToOktHOvxIc0uqePuboAEWbV27BmE6/ODwcWmJs8HLqGo9McrnGw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749325578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U35d7F4ySvr4ve2pA4Gs/YLbV7hHI8pCrNn0trnfB+Q=;
	b=D7f5hNVZ+HsJi6YOXPb6FtH/DiLkhiK4JVRXjPCGY40GI68En4LEVmvlgSYpkHn06i8fUf
	RfydVIGgYCPZMjy8P4lEcnv2lNMbHiH3QsbmPrMqHDqauc97MQPKej1TD3HN/x01V1rzL6
	xYONb32yPtsjCWr2mvZXqHfOnlR0XrKrOrwFMulF8YU+wbgXUAM4N79/X+pgj4ae71y4If
	/UUit3h/6fZ+zQGDAwmNzCt1C6Q8ZQtV5a1yXa0ePZDhiI7WPMMqxa4pGqfVVGNNL1InKw
	BrUUqFmVANympLwyKwOjnfwvwuIY5Sxl3XeA6DtY/i/Oifz+9Mr8MiXCj05OGw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: renesas: r8a779g3: Describe split PCIe clock on V4H Sparrow Hawk
Date: Sat,  7 Jun 2025 21:44:39 +0200
Message-ID: <20250607194541.79176-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
References: <20250607194541.79176-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 691f0f7b87e2ca7a30c
X-MBO-RS-META: 47nn9dfo4gekfi4mzejnermrkkqnm6mq

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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
V3: - Add AB from Manivannan
    - Add RB from Geert
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



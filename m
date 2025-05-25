Return-Path: <linux-pci+bounces-28392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904AFAC35A8
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0679C1893C6D
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AF1F8BDD;
	Sun, 25 May 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BmXD2/Tl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rjeVGvDp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC01C4A2D;
	Sun, 25 May 2025 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748189141; cv=none; b=BiwG5+gGxywP31Tcrqnw1/MAK3fcAQ5wJsOI8Mjkyfdia6fJcv9RFqz/nkbvZSXz0Fdh6+Rcr8h22N1t5Dr7kzs7/ToTcECYUrIMEXi2Gp+4l1PvHPnMI9XEcKV70p7kBZp50aIrxfW49yV7OyeDsqn5xsUXTjGj3OVoHeLIEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748189141; c=relaxed/simple;
	bh=tTPXovc0ofGn96dZAaf9xNR/yONiQMMv4WtV3T0YvPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5Ow1bnwETeXcBaNE0qg1T+RMeriVzYsowD7cvwIDQKF422WSaasoLkHVnvlAvqeAOWwv8rsv/+JgJMIXtq+qqGPVvSUBVElgH3up7qLADGJV0CyYjjXq83T/NGJdU1JeOKon7wZze4SFgK6/rf030Shc9oZfjrPezEjR+jpCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BmXD2/Tl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rjeVGvDp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b53dl5rMpz9sqW;
	Sun, 25 May 2025 18:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPrdgQOQrocNPqIgoaueLRdVVKBCes/xeIpXjvkXuhc=;
	b=BmXD2/TlTrswtNrSSbEjZSM22TH+Af/Sni5ioUWF9cYBOyuA3DQbMj6heMDZUh/rXT0sX9
	ykBkUuxrPRJ0Vns9k8hkKdu8Vh40Pq8lboxGnxpXM7fBwFItjf4FxOEHT5v911apEXJkXb
	98zgY05lrhfw+7GJ+MSqZn8V9H9yn5Ej+m0aqh9LOhLf8pKPoT6FhYP6wX9TyrUX4xRT/+
	vWMog5Rw8t3hTcUI5I/7YKVhburOdBGz3XrYdt4TY98ZE4nvZPMqrN1D74VY/jYFxweSSx
	EMhbjjbDPaZZFhJPA5KJAjU0niLhnDDBp0VdMnz1hg8jmiljmBrqCdEALoxFrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPrdgQOQrocNPqIgoaueLRdVVKBCes/xeIpXjvkXuhc=;
	b=rjeVGvDpyHT27GD+9uawz1PbV+yxyedwQSN1G1ExQUssRW0nFvDG4sFPt29uM7vF7mFspQ
	1tk++sfJqd/OiwFrvYQ5XGnHfzaUQXw/EsMcW5Y8MmjOZXuljMwM3ZQdWz2YUNbwq/gS6M
	le9W7KviLJIGjMf/vYMxIZGqhkngR1iQvpQTyaFv/jQ4gfonx+/fB30BNVdkJJKVEUy0wn
	1waHbEDSUB8uR9h7KJlkwBgdi6t8XrDpY/yRLQozGrQEN9R4cYQ1skoeLCPgJykhnR18S0
	J197wzyCyoqT7GclWmbSy3+X/6mrCkxrUl4Sr+waWeW8IjnfAa1ItUQ1rDJERg==
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
Subject: [PATCH 2/2] arm64: dts: renesas: r8a779g3: Describe split PCIe clock on V4H Sparrow Hawk
Date: Sun, 25 May 2025 18:04:04 +0200
Message-ID: <20250525160513.83029-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
References: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b44ts3qhxxkcs5eeid4n9o3pp136tqx4
X-MBO-RS-ID: b718b974327949ec1da
X-Rspamd-Queue-Id: 4b53dl5rMpz9sqW

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
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index b8698e07add56..7c050a56290fd 100644
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
@@ -487,24 +502,50 @@ msiof1_snd_endpoint: endpoint {
 
 /* Page 26 / 2230 Key M M.2 */
 &pcie0_clkref {
-	clock-frequency = <100000000>;
+	status = "disabled";
 };
 
 &pciec0 {
+	clocks = <&cpg CPG_MOD 624>, <&pcie_clk 0>;
 	reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	/* PCIe bridge, Root Port */
+	pci@0,0 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		compatible = "pciclass,0604";
+		device_type = "pci";
+		clocks = <&pcie_clk 1>;
+		vpcie3v3-supply = <&reg_3p3v>;
+		ranges;
+	};
 };
 
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
+
+	/* PCIe bridge, Root Port */
+	pci@0,0 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		compatible = "pciclass,0604";
+		device_type = "pci";
+		clocks = <&pcie_clk 3>;
+		vpcie3v3-supply = <&reg_3p3v>;
+		ranges;
+	};
 };
 
 &pfc {
-- 
2.47.2



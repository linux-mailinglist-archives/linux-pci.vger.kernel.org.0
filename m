Return-Path: <linux-pci+bounces-26802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC74A9D979
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 10:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDEA7A8F17
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAA2512E6;
	Sat, 26 Apr 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTABcfo6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80251D8DE4;
	Sat, 26 Apr 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745657271; cv=none; b=FX81+WmumiKz7UKHqk+ntX9N+rwr5uQ2694NSZX9vv8Pkj3EDleC5yKQUBowlDRAzSlSqZ5K3Td6Le06LRL2/a8fLngk7sxn/56/32vuzL8GLk97gEPvFkaB+HTln3tCX1FO0xK77oLi4GDaD+Nbo19HZP02QXF05pCJM9bg+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745657271; c=relaxed/simple;
	bh=EePur+oXQTN/Q0Mfo8DIsWZ0cPCciOMp+Cc7Bx6MPW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cU0FTtx12aQX7TldzqajyRKwDd3wPXvvcYd3QP0lY7VIBtAyPFKf+LUrTHXnjM7ZIft6mF33PVvIjsOXyNJjCo73lRN38yY2UZvLeCd9nw/q42vCoZUjDNZmSCm42bq1B1tQ/E2WBAD0FzSrC/oKKJjLrTgJwBwm6f/KFI4eh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTABcfo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0654BC4CEE8;
	Sat, 26 Apr 2025 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745657271;
	bh=EePur+oXQTN/Q0Mfo8DIsWZ0cPCciOMp+Cc7Bx6MPW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UTABcfo6244t1yLjNqtebadpBMWpLStD0HXuIpSgcszl9lrLf0yf71UgCkR3EoHP+
	 vbnui9fBd76v723pI0iRja0z4mSXYJSvkFyP4/tISLzEFiFKa7m2JSQhtH243g6f80
	 cz5sykVT/PZrr6eEcRGJGnkVWU1QOlUTgy3wLRzsvrFQOvU4JHxfmtZWHKvjRrfRUS
	 fsUvar5fBwlOsayFk4DkaXGWu4iQ7mbGEaK1pdP513sXnAJ6sFphzVto6SwS4JLlyG
	 fgPjLCyv5at66q35UapwuYSsnDg7xwZ30yGlZcPH6WFpSauffZp78IS2aeKKyc+XDo
	 Nr122Qbw+3dAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F4C369D9;
	Sat, 26 Apr 2025 08:47:50 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Sat, 26 Apr 2025 12:47:21 +0400
Subject: [PATCH v9 2/2] arm64: dts: qcom: ipq5018: Enable PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250426-ipq5018-pcie-v9-2-1f0dca6c205b@outlook.com>
References: <20250426-ipq5018-pcie-v9-0-1f0dca6c205b@outlook.com>
In-Reply-To: <20250426-ipq5018-pcie-v9-0-1f0dca6c205b@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745657268; l=2062;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=OKmTrcmt0ksiQwz9dz8aVIs/K+GfvvlMVFo78Mfk/ZA=;
 b=rV0etEqqpSlZRcytneg10NcKG8RAOvyDsfbwXwAY97bz9Nj6HGPetzIPY8+RBPQsDtlKI8Q/t
 cKs3ntwbB2ADl5MmOQ2qSpeide1bVr2mNbwcpwcCVt5+flGX6QTrxrx
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Enable the PCIe controller and PHY nodes for RDP 432-c2.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a3e2d6b971bd9637309809e0c0f0c..43def95e9275258041e7522ba4098a3767be3df1 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -9,6 +9,8 @@
 
 #include "ipq5018.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C2";
 	compatible = "qcom,ipq5018-rdp432-c2", "qcom,ipq5018";
@@ -28,6 +30,20 @@ &blsp1_uart1 {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pcie0_default>;
+	pinctrl-names = "default";
+
+	perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 16 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+};
+
 &sdhc_1 {
 	pinctrl-0 = <&sdc_default_state>;
 	pinctrl-names = "default";
@@ -43,6 +59,30 @@ &sleep_clk {
 };
 
 &tlmm {
+	pcie0_default: pcie0-default-state {
+		clkreq-n-pins {
+			pins = "gpio14";
+			function = "pcie0_clk";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio15";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+			output-low;
+		};
+
+		wake-n-pins {
+			pins = "gpio16";
+			function = "pcie0_wake";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
 	sdc_default_state: sdc-default-state {
 		clk-pins {
 			pins = "gpio9";

-- 
2.49.0




Return-Path: <linux-pci+bounces-27673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B0AB6291
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10FA178835
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44381F78E0;
	Wed, 14 May 2025 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjbXlIr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71C1F4C8D;
	Wed, 14 May 2025 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201954; cv=none; b=XzytgD4TiqYuWoChtg0/v3lZ+68rbXXRGsTY4ACC4jaUuHJ9tIiSVz8kTWCI4P8W1h+mQ/7ew10INnM1zsFxtifzUrDOWqAp6j3E8DvZhalE2ubxE81yWRTJTFYKgemk4L2joBiZjIzdgo1DGgSThB4DBMRDFxfFaQZCVjNKOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201954; c=relaxed/simple;
	bh=EePur+oXQTN/Q0Mfo8DIsWZ0cPCciOMp+Cc7Bx6MPW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOumkmNwqT5cXj/TiAIyAZFXgJLj3eocSq0C1ntaxi3kRZkbx/roXoMHxWPPjen8U2cXbZHTFHryTxAiSzhIH+5zWy6qN83GprsZzyJ+dgtyUFXmi7+x27tebbSCKPnMwNRbLicgoRVACNv8jiI1my1RyT+7HlyuH1VWgaLjPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjbXlIr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7087C4CEF1;
	Wed, 14 May 2025 05:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747201954;
	bh=EePur+oXQTN/Q0Mfo8DIsWZ0cPCciOMp+Cc7Bx6MPW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TjbXlIr8tSBr86YWv+eDCsx+UjpMXz7ldV62sd+knYTTatma5LVSElbFrD2yjsvlG
	 yQPqEW4FX10dFFdu1Js79LubPodXy20IfxboVCQW2Vsv0X5AXOVsARki6cRxgMCnWO
	 2GL/rE4uH4VvM7C2sDQsuyJNaFk+FilfoSVUpi+Z82II+173liBupp7pU/fNcIWgSs
	 nWAe8TNKZdyAmznPc1XsyS+np0msVEqahOePAf7r/Sx8xdA/Mx+co824R8z7jSavNO
	 1rhlIVsVWDIW3Qo5bIAeG4DxbivlQAQqApLdbyu/jU7FWnM/qJklT7kC5b3Y90bRu9
	 UkKRSZy8km/fw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD3C3ABCB;
	Wed, 14 May 2025 05:52:33 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 14 May 2025 09:52:14 +0400
Subject: [PATCH v10 2/2] arm64: dts: qcom: ipq5018: Enable PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-ipq5018-pcie-v10-2-5b42a8eff7ea@outlook.com>
References: <20250514-ipq5018-pcie-v10-0-5b42a8eff7ea@outlook.com>
In-Reply-To: <20250514-ipq5018-pcie-v10-0-5b42a8eff7ea@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747201951; l=2062;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=OKmTrcmt0ksiQwz9dz8aVIs/K+GfvvlMVFo78Mfk/ZA=;
 b=Kdpp0nNjPVPIkhZUEbwUlCo6UHMoANmtgHx2Kel29NApsyxP4Vf0gWcib6DlzyYlQZMG5enJQ
 HaFqTRaMVQXDjtGTc5p3c1nCZm75Lu0AqLuz26tXIig+5Ob1Wnd5E23
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




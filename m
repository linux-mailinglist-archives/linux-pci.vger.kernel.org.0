Return-Path: <linux-pci+bounces-24314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF57A6B6C0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6581899539
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909C1F3B9E;
	Fri, 21 Mar 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4HHKraj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F51F130C;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548196; cv=none; b=OntEsC/QrpJJZuXTc0fzL31xIQTtEZo3X6yoLKilmNNQqNKUPOpZEUr4KgAMWrJvvYK8j88Cvo8+ScBc9/BFkmtdUy0kbrSCtqQH811aC/ncNDbrF1IosZqw1CMkZOz7zA3B5+2bIyJA11ixeWbSxJxbwDIyXc5gBSJU8LnzlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548196; c=relaxed/simple;
	bh=nnuDNLDyUo2HnSwQbCKlDNn2ZEgXZ5vT6V3g5jpmKio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWGgx0f5CmMLcIjkczKXrUncCMQKSxtBuLcIW74ZJZzpf0tRYTjo+FwQMsqg51aqH8ibDc/KhJoUZjNIGZ1sr5wB8DCu5NW4qQX05j16Silr1NuGSF80/P5dfe7zDoORNp+uEkdZ8lC7/dW9pvMtC0FK7Q11mwTEkpjggB68/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4HHKraj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B515C4CEEF;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742548196;
	bh=nnuDNLDyUo2HnSwQbCKlDNn2ZEgXZ5vT6V3g5jpmKio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V4HHKraj7Ev00pmS0imX3guvFj9BEJCp29jBv/MSP3/GZkBBBlzL2f5lW4Qmeocox
	 oQFQx81A6eHF1jyTiPWMKZxzCv1gODS98CxhHgAbnk2ErUZVDqxM9jwSDGJrWmaXuN
	 XAVy+EGdv9l+WQdteqykfbkpIIe37dhfk6XaoedSFCJuRuP5PH0JLN5xAYD2d4Ug24
	 7y30U18p7iUfCmOckJ69vnInr9A2L4JY6qH9d3tq2W7CzULq6RtP+zSghFsFsILyET
	 Cb5U/t9Sgog4qz8164hnsOuBn4B/6N+/6cYFLUEdTrrVk9nWlKKw96SZErdURhEl7t
	 no3aKQmuVDuwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49692C35FFF;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 21 Mar 2025 13:09:55 +0400
Subject: [PATCH v5 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-ipq5018-pcie-v5-6-aae2caa1f418@outlook.com>
References: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
In-Reply-To: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742548192; l=1810;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=aDrKqvqd+UP39quMJDnTOhOkR2gW/8ZVcG8WbwkiLrs=;
 b=+/C63OCaTxSXx57X9ialxZRl/EOVwCSZZ6FWSgdjswc+DRhaFG9dHp5UsRYfiOfDipFHb64wq
 ueHUo5P9YjGD9UD1vI31LvzCMvNToSZqkk/PSm7XrVEpmk9Z+bk1y/i
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
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a..43def95e9275 100644
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
2.48.1




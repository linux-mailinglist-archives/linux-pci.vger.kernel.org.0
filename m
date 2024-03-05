Return-Path: <linux-pci+bounces-4500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BAB8717EA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65F72820CB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DA8175E;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyQZLLjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0380632;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=iLVRmP7hdRz8RRMHpmS3gTGCK6zM7aOJsnWAql/ShdB7UXcIIdfobWRxYde1NB4zGNTizWuG8zoQb/EpRMRP0Nt9WdE5GfJodJpD1GS2d6fEC7LSec7V4amTPimekEov5ZnbM5bx1jG5pzb2RMRY0sMnC53oSS1CM4G685vy+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=RdyY/PZRclHf+VgiPUlJt+u4TDL/TN39E8sr3KrgD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSgEVd1ykyf4ko2ub8roJs6I6JlvlGg/roA3U3JyoKAjZ7geClE6uYiygLu6pSJ7MKKpjA8QJ9ODITG1WQOWPWrC1o8iToDXrY9bGEdGzAjXH0oqFtQ5oVo/85CsHlCMmFRlHeqtQ49KCP9OXBQG7m4jp9Ywj7caovyUwVLw8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyQZLLjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B685FC43609;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=RdyY/PZRclHf+VgiPUlJt+u4TDL/TN39E8sr3KrgD8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyQZLLjjGDWkuWqqPTGU7l495gMLekYH1xscFLOVr0WKxjzYsoqFiPcGP9aKz+XV5
	 4McKIU22Ydf46mfz5Utqkvia1zXNdm6F1kgVTLbo7iSMWdCQa3fv81GTjH7Ui9flTw
	 JahQBBuCv2tlTia9qimt8P5U2f02JOIN2AEbT6VWeo1cvG9pZLHgO5j0DYfWJ8uqXU
	 +01Y4eoSgh0glwMxKov4jJwEiNsadCn0WqNTw3QiouE1onxmGv7USyRBrjqFg+rvdy
	 v/DRpY7kM0LR2VoNflmS8aDnLzM1F0h2yD1Ph6ggmudmEwJdnufZIfKdAgNayVf7Be
	 jNqm9BlqerczA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwq-00000000387-2Rx6;
	Tue, 05 Mar 2024 09:14:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 10/10] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
Date: Tue,  5 Mar 2024 09:11:05 +0100
Message-ID: <20240305081105.11912-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305081105.11912-1-johan+linaro@kernel.org>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWC PCIe controller can be used with its internal MSI controller or
with an external one such as the GICv3 Interrupt Translation Service
(ITS).

Add the msi-map properties needed to use the GIC ITS. This will also
make Linux switch to the ITS implementation, which allows for assigning
affinity to individual MSIs.

Note that using the GIC ITS on SC8280XP will cause Advanced Error
Reporting (AER) interrupts to be received on errors unlike when using
the internal MSI controller. This will specifically lead to
notifications about Correctable Errors being logged for the Wi-Fi
controller on the Lenovo ThinkPad X13s when ASPM L0s is enabled.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 424d143ee26a..4708ba28c4d5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1737,6 +1737,8 @@ pcie4: pcie@1c00000 {
 			linux,pci-domain = <6>;
 			num-lanes = <1>;
 
+			msi-map = <0x0 &its 0xe0000 0x10000>;
+
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
@@ -1838,6 +1840,8 @@ pcie3b: pcie@1c08000 {
 			linux,pci-domain = <5>;
 			num-lanes = <2>;
 
+			msi-map = <0x0 &its 0xd0000 0x10000>;
+
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
@@ -1937,6 +1941,8 @@ pcie3a: pcie@1c10000 {
 			linux,pci-domain = <4>;
 			num-lanes = <4>;
 
+			msi-map = <0x0 &its 0xc0000 0x10000>;
+
 			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
@@ -2039,6 +2045,8 @@ pcie2b: pcie@1c18000 {
 			linux,pci-domain = <3>;
 			num-lanes = <2>;
 
+			msi-map = <0x0 &its 0xb0000 0x10000>;
+
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
@@ -2138,6 +2146,8 @@ pcie2a: pcie@1c20000 {
 			linux,pci-domain = <2>;
 			num-lanes = <4>;
 
+			msi-map = <0x0 &its 0xa0000 0x10000>;
+
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
@@ -4342,7 +4352,7 @@ intc: interrupt-controller@17a00000 {
 			#size-cells = <2>;
 			ranges;
 
-			msi-controller@17a40000 {
+			its: msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				reg = <0 0x17a40000 0 0x20000>;
 				msi-controller;
-- 
2.43.0



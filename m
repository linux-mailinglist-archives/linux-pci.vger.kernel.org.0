Return-Path: <linux-pci+bounces-22553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971FA47FB8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166C217A876
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828052343B5;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRor9hrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDC231CB0;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=qNHjAZoxWAglkAZEOXW2Jffe8vU2PgZKkYR1OpGAp8e96iUD4OIsaftvv2nDr6YGn9rQo7nF0PTLejBa1RfWPooAg3zJju29AgpuWBTHm26djcar9AI/DV5SaqBk9hwGWJ6nCbGNFNh0qlSjjvLOEQDMOHdJQ/IDTuBBI6mliJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=0kiBRUWPZHefxeRA2xk0YYjWCe6qg627BlGUmqIm34M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFG8EGj8duLRYlZ5RaT+YlLYvejRM/inZwAGi2DdBmIOqQ02syNoPBeq8va/4riygFgGQi8p68ttDg++z9HqcpgvJJNn1rhPvVoKzY2A8EVxg7TGl9cjm/nOBSup1tErMc7MMK310vhsCZSsU+0ut8m21oALHUOT3VsryBsabLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRor9hrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B99B2C4CEE6;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=0kiBRUWPZHefxeRA2xk0YYjWCe6qg627BlGUmqIm34M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LRor9hrkpFJsXxlqRGiFtu+OIoytkDKvan531X/bYiH001+dwNI3+LOQ15vFKR3Pl
	 2VtU5xqbRVX5LRnAQ1a1HcO9xYdkQlVBIQxjeTjjy6DyCcAVXH4NiQI7pS+GslMTHX
	 uv0WbWmxJt3SITBWPJjYTjFYNWvfLhOlnW1fswkaltVrV1u7gVl2tKjvMYEO7Pm0XD
	 Ka1YzY3LPqlgCNG3DVeYijgTfx1Ue820pMSAfzEwZg9UV9XpF/e06i1wxELTi6ZB5y
	 +nxOMcutlUgkN/e5Kfq8HhvuQsG1lz4LZYcdn1+WC5A+55CHomsq98eGIPDR52c1zP
	 YWqH3iSM5c3gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8D8C19F2E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:54 +0530
Subject: [PATCH 12/23] arm64: dts: qcom: sdm845: Add missing MSI and
 'global' IRQs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-12-2b70a7819d1e@linaro.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=CdX57Y8jrByjwdxSSgs2vvVE4xikqP07+qm09Bemsh0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtgIXZoPxHLJGzqXGBSNNkFVuR2eJVlcr6pN
 9Dch5GusumJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYAAKCRBVnxHm/pHO
 9ZP2B/4+SpYKx+494wgDfi6vwFxHJV+mkmPS0fOlqsXD8gXZRks0rp+ibGPEVATvP0MGoT51oEf
 mlDhtN2d8Vzk9NnpTmDG5GU2Xmgm1XgOO6rlFt7/MO/CaoCjRS4PDwpaA88HJe1mmDgXT+hTb3D
 X26LLrD+lE9UD5a7sSYPZmVkqyPtU586BBxMiMPOI5uzTl3w9wZtpnOssXdRHnWLV7J7iiRyV6R
 uXEe9HTJkW7htwXcrhuKW4JoH5lIGg1W4lf/2yzXjCA9Vsjm7jXiDhdvORtTCucAo2fGETv6iOS
 c+wxbbE97WHk9R7cw2dRpnZLxREssJxLtzEt9hFMtJvzVir2
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

SDM845 has 8 MSI SPI interrupts and one 'global' interrupt per controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 40 ++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e0ce804bb1a3..ed0751db564a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2326,8 +2326,24 @@ pcie0: pcie@1c00000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2435,8 +2451,24 @@ pcie1: pcie@1c08000 {
 			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




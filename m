Return-Path: <linux-pci+bounces-22556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F7A47F88
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE17A25F9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B50235C00;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8NE+eFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFE2356CA;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=hUbndwA7K0bvSic4UcPYbp0bjZAYSmpctKykZdFb0bdkfr7mx8pMk9MaKnwWkz1i7VPL6eJWdpCXOZXBMy4KDOrqjnk/ak8a0bGN3vXGDjmxG9izc5M6FheKOxhFBlpGcijbXK0qc7M0p86gVCvI3dNt9iaoPQIytBCjJ/6vUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=ooa5Tz53MbHAh/xNWFYIsASM9g5qeEl22t4taoIHMW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHgDNitOmz0sAEFttaEFjfg4jRSXzpX0Q/Op67FkWMY2pUDToScWcMRpswY4jW0BQUcYjzYtLiDjgo27lwHZx/hNC7mJiStVIcOrt6uMD53PeP/6huLk1iEXKwGRNlqVSYOn94X7JShNsN768hRLl/kSUJ+kaBQ443kIk32+nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8NE+eFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3B1AC4DDE4;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=ooa5Tz53MbHAh/xNWFYIsASM9g5qeEl22t4taoIHMW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r8NE+eFWAT573EGZkKkt+ri7gmENFHRjHLspPBxlPDrwqhhh7HQ/dZ3OIuALTb6BQ
	 nEVImn3tv92x8vubb7OGIXF9TwJFtNLQ+ZXlzL8uS/i0pivSRuTbFaosuhVr+dmb4j
	 Ehu2BjquvtUBZ2mH4MsilA9C68WQkakv/u+0lF++Qebjr3hxGvBQcX9Vix4wK7HbkD
	 dzCVa9LvIysb1gcMpuE2yjgS6CScJdS6x8TCqffl4SuaFz1jtZOFqEpee4/7kWxotP
	 +ADQRQD276d6ctWUlSyrKQJGQVl707yRqccP2LS/QsPAu87IVe0To2B9oN5/0J4DfE
	 DO7SjrQz/AAPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB1C021BE;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:57 +0530
Subject: [PATCH 15/23] arm64: dts: qcom: msm8998: Add missing MSI and
 'global' IRQs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-15-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=tuxfQ/qLaeL1Z/VoxRrRg/3WlsnVe+b+pyGU9A4SJKY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtgfSwFhnoCqGtydye9BXdEW7ClIAs2n9osj
 +JDhLFLnfmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYAAKCRBVnxHm/pHO
 9fyNB/9mxvdmorLy+FACaOQiboLBiU2AvuB5ihy0znAUcVOCdfzbUeRRji7b4AWl9uesF0sAvxQ
 9xd9hN5AmW97pYc4m+EE+rh1M7r2dvsfOfTZsaCUGi5s21EwHL0KMmPjPOYT71TTXqhxSVNpRs9
 jUndY41lVHZfNv5RlhxEwsPyYSn+NyIyj4gYPbyO+gt4xJWaSvn9/DNmA5BLUpQX5Z0K5nBiYd6
 2leklQP+68EeV/f181zZiRYnfz0T1SXSG1W+X3j20r6Cc3Jza4S6m7mYTgoxlIUBdEfoql7GhPr
 Ba2limYezoRxUsgSCxlwgj+j2yHH3OVLKVhNAV0U0nl6TeBf
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

MSM8998 has 8 MSI SPI interrupts and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index c2caad85c668..65bb03406a59 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -935,8 +935,24 @@ pcie0: pcie@1c00000 {
 				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
 
 			#interrupt-cells = <1>;
-			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 135 IRQ_TYPE_LEVEL_HIGH>,
 					<0 0 0 2 &intc 0 0 136 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1




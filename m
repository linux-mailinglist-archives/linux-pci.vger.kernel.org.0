Return-Path: <linux-pci+bounces-22560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC2A47F8E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B37A5C17
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8528237160;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtTq1OKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16C236447;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663656; cv=none; b=k3bj/si7MuUnRRuM/smjHpw85vCZTlx/af3QCMV4Xn+rm6WMyxbMBkgb1hKHWl3kBEwaDl/0xJ6ovcr+8SbZWSrqu8EE3fPJIIJcUyCY4ytYnqVRvAqAAI7ycbzDNQou/k1ogCd05BDxvY7k1XY+pnd+L6E+REoaL0oulBlo010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663656; c=relaxed/simple;
	bh=q1pCCwRzKbO70plJllrQh+i7L48Ef8B/i1nDnDOLcUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4kq8ezE+HpTXRg0bHx0HmODzHWJpMi3jUtJYz6as1a5hHSaIr1/Rqel0qZ5fSdUDFGYRIo7dE+4ECnmubBZmhV6F5kKYD31gIX+v7X48Jn9HD4yZzPYRDVqSZQNODEhELPBR3dnWnImxJVcSx2qaGZw50HCNHTs+3zBdntuZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtTq1OKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A47AC4DDF6;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=q1pCCwRzKbO70plJllrQh+i7L48Ef8B/i1nDnDOLcUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UtTq1OKKOEg+Xu9XsJsCX901bDeQXjUD4M1xVtsK+NEPYYnT9DkQyKe55/RQycNv2
	 PwLixtXVUmNgElWgUzUNLSU9Cigur1PP6/5QnkSdRBHCtMew1fTDuEy86PbEVuFWTp
	 H1tbTzPJIsZT64lp9SEWH+llqS0J+OpSbi1vvmtukUH1qcY2YD9PwtEEG7XMB/gS5y
	 0v4eBdTAHIAXVwgLM8biaWYNleP4IvdiIDry6b6+cxiHT0TS006KY17FPa6PyEPInm
	 DL091iNAqy0tl7e7t9/q94d7mOFXxxLKHhF85qmsRoEVAlUQBCpl1nqFJNkQbeQKWe
	 5Wbjuh/5QOepg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D74C021BE;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:01 +0530
Subject: [PATCH 19/23] arm64: dts: qcom: ipq6018: Add missing MSI and
 'global' IRQs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-19-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=RowCCsa7UmB5mPOEsSXdyNQWv59aOMUHKBxIbtgXr/U=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtho03MSKCOi1OZSeZzOcyA6tRYzXGdRBo8t
 BThJZlrT2GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYQAKCRBVnxHm/pHO
 9W5JB/4qgyIIi+x3cyWS0XyxVtV8zWuzaPhuu7NYJTxAIbABr3v/9Xe38jPeT+mALauJ53rFTzW
 xSG5FDITYkf4psiMCnwioco+rldyJr6PcvF57/wCeaCE1+wQsbOjq2DYyGbnDPvKuWYAQJXg5Do
 +RoyM9UkLuGiAqnvuTG0+PWHfRYhfV/VgKU8MDfjSNiJa9iajzA7AXZ2Owc08uY5+46fP7Ocp9x
 2O0Ez1hYxSOpPrN6RpKNHeCBWzIsSUV2AHWjc92G6rCY+nMTNZag5baLV4JdcipMj+C4g4JaAvf
 7MGPe5Ims/2MmLK+RG8YBSSSXiISILLX9uUWLL57Q2hksEEJ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

IPQ6018 has 8 MSI SPI interrupts and one 'global' interrupt.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index dbf6716bcb59..d1b1dc048262 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -888,8 +888,24 @@ pcie0: pcie@20000000 {
 			ranges = <0x81000000 0x0 0x00000000 0x0 0x20200000 0x0 0x10000>,
 				 <0x82000000 0x0 0x20220000 0x0 0x20220000 0x0 0xfde0000>;
 
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
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

-- 
2.25.1




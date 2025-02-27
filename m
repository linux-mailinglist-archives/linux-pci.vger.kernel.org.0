Return-Path: <linux-pci+bounces-22554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD049A47FBB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD43B174367
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F623535E;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ/mn7pz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1023236F;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=l9JK2y3xnDuI2jukETmAMNFYISud07GyELDsCfOkpM6U+Wl6rImqdYgU7dZPYLnnqHZZJWkjEGDDAk0K5KeMaojhSrhSSBp8FVUDJkapQ2QREOy5+7rDUjvVm4vrkf09t9ogd0Hp56HGjrE4clvyM0by0YffA3cfcdY6//DMdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=edK7Spmf56AWp44DTUyVw63zBcgwdKXHgx+FqPsIBqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxccTuAfBoNYU1AYfDdOU1skVfBAW1EtCqWqFkBQ1D7O3t096f8vM+AQqMRYLQlfAN/jxSK70hmtSYzOpnWzDjlzp35cMd5/vMToOtlke+xWt3HjQnoz82vB4wExRQjW2Zl59Rsp9gmBfZFvKVdcdagK9f5Liz5QaD8ja4dksxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ/mn7pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C75C6C2BCB2;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=edK7Spmf56AWp44DTUyVw63zBcgwdKXHgx+FqPsIBqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LJ/mn7pzshmVJCDHNxBQNrxnGrm0F+Ff5eMlNxu5kYZ9gxRftqliJpnGSBgO2ZScU
	 emk25fqqmdbVaQVotxUbnkYF14pDhNGIYW+65p9VoVVwAORFdAQh/Rm+CZ/TJJGaxA
	 YgYqDpVZHtw8bHeMXgWxOOcatTiYVzkFmtJc8AVcY1d77Bdo3gVShn6xWFLihPQDkJ
	 aZ3Xpbf29aNqpPuxFLgIHeKsgtPvOazDrFGD40Dd1olG7JePUSa6+CkBGcJXJMZU6H
	 14XeQ+zoI2/JSVmESuRs5U7ZuVvkjVMjJYr/SRcp1JIA1yPjf4OgLeaLQUfsCke68P
	 nOhl+Ud0kfCmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB16BC1B0FF;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:55 +0530
Subject: [PATCH 13/23] arm64: dts: qcom: msm8996: Add missing MSI SPI
 interrupts
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-13-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3064;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=FpIpzsPiznSX9qJ/hFF/18H43JcNjeBgD8xcW752Tcg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtgUobujnlZrKuDYllEeCj1oe2ExBz3nb8Tg
 ryssQ1b4uyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYAAKCRBVnxHm/pHO
 9SZxCACDsKolqSytylF4Xn5Tvhbvf+R9EbGmyUjho7XRci/roNmKKJpcTImP0HIiG2n3uRJp3mt
 14VymAVYruvDycVI575VrhTsI3VfUdMqSP52czjfbfaYOgAtvqoBNUVwUGWRs3Nxbh/6L2tTMAH
 U65sle2x9xBdCyoWw6RzKV3H0abum/FbYNbY+PfR+BgCL3FFfq9FOj/Hp6baXmBcUa4r835eLdb
 FT1b7r8za6WGFVnQgHFOYCO9FU7BoDL5ApcS1VOE69XvY082kUZ8OV6Zt4JCucOFe2B4Kbf1M/e
 yRTI7168LnmY4dyNifnSlURh6FhTQ6zzcAqmcvfnSLCEsPll
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

MSM8996 has 8 MSI SPI interrupts per controller instance.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 54 +++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4719e1fc70d2..38df095e9336 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1905,8 +1905,22 @@ pcie0: pcie@600000 {
 
 				device_type = "pci";
 
-				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
+				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi0",
+						  "msi1",
+						  "msi2",
+						  "msi3",
+						  "msi4",
+						  "msi5",
+						  "msi6",
+						  "msi7";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0x7>;
 				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1968,8 +1982,22 @@ pcie1: pcie@608000 {
 
 				device_type = "pci";
 
-				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
+				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi0",
+						  "msi1",
+						  "msi2",
+						  "msi3",
+						  "msi4",
+						  "msi5",
+						  "msi6",
+						  "msi7";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0x7>;
 				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2029,8 +2057,22 @@ pcie2: pcie@610000 {
 
 				device_type = "pci";
 
-				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "msi";
+				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi0",
+						  "msi1",
+						  "msi2",
+						  "msi3",
+						  "msi4",
+						  "msi5",
+						  "msi6",
+						  "msi7";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0x7>;
 				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




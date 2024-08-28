Return-Path: <linux-pci+bounces-12364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF52962CE0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A97A2818D4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2801A704A;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/1uHZfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D671A4F10;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859985; cv=none; b=ed4o0fvq0wjC+gPzrDaOS2FU/Ua8VLfmw03rMhtlWnH4iOWyK8a44D+p7/64vJ0cemJiH5V/8lYUtICYsHftVZaykGt2QDQZJnqng6Sbg/LMSVOY/P82ZcfWy0oJ/EFyIYzhO+FTufubIpK4YYhfqmY3KfkSeNM9EGQ4tfNSbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859985; c=relaxed/simple;
	bh=T5skMR86m0ZxvSsBUDQmSGDmm4tUdFlQy/vZxL51ZmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Se2F96X6viCOhOcvvB9aH1pX9IlKVbttdzofnxdDNjORG/Yp0YcVVMWZCzRy0r0DSmyeypZdgjFnghPXgqlWnrKUwce3l2fvMnJpzIMIMrOsMcG42pe31V+UbMidH3EUlz2lo4PBJ8cKaT9nKg7vsrB+HxkMIforHqyNQPeTZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/1uHZfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D54C4CEFB;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859985;
	bh=T5skMR86m0ZxvSsBUDQmSGDmm4tUdFlQy/vZxL51ZmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D/1uHZfS1ZkrOgs7DCEJmhqv93Q9f10wMU+OrkI+g+sTKd2VlPfhTHzARlk1F6r6p
	 FQWkEOK1ClFB07cXJxm92Gogj87r1EZ67gjWyC5thEVbdh2NN3knkptJQzeVgj1Dnu
	 Ls6Wpfz/l/+sNKDfHPLKZYWIfD8s97xsnWC6aulAFpgNE32a43cR6bRCRNUJsRxUSJ
	 gadsRe0IPE0de3s6lQl0/XBNil1APMT2AGb/+XlTP0a2Chao/itfEOh+ZuHCwqY474
	 GvYReEkEAOxenkRJHcryvpMIWMRacYONg4RjlVGK8yGc3L/t65VVDAJdCUMWDIAqjM
	 N8hU3riGt/lHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214FC636DB;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:22 +0530
Subject: [PATCH v4 12/12] arm64: dts: qcom: sm8450: Add 'global' interrupt
 to the PCIe RC node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-12-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=VT44obotCPUBbxvMUSiK7oaxSibx2Iio+dz6SHI7KhE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZNBNEoQ6DDVkJpBpWEeTqtGnAT1t6acgVxO
 fhtJqbI0YSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTQAKCRBVnxHm/pHO
 9ctxCACdpEZvp66AumYcDrmPBiFVKFQOJonvGKpRxJYoNv7ls/TRuhgqFUep1DT3szRCzS0gubk
 uXfm/jYLELujibLiWaQeu59MZiGPSe57TDrS5pODkUjd9g3/C5gMCvodV6+178X6JB5XDTeNHlt
 sQIPRitYy/G75mlZ47EF5P55eqsdPVBGeIHa64xxg2bjuKIGHQM3xY2fCsGgpQCfeUIpnPqLcP3
 GJrUDvQlV1VED8gF52EeSBZ+2lp0bd3WWrOD+jURXLBZj8NGsMw5sYfIVMDs13F7qz4qAcY4NAx
 xIWDYCzYmBFKcbhDsVqkyjv2+qHH5kM0xCDkrqqnfzIvTTbv
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPUs. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, add it to the PCIe RC node along with the existing MSI interrupts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9bafb3b350ff..564b071eb77c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1787,7 +1787,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1795,7 +1796,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1949,7 +1951,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1957,7 +1960,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




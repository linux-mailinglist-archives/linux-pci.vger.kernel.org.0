Return-Path: <linux-pci+bounces-22545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FFA47F70
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AE73B1016
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC7231A3B;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZINoWLth"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900122FF2B;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=i0W3koznFoj3dn/jvdf7kcfgL9vxGqlL3rai8G+VKyWp9YEWgsSECYJmXz9O9BS2fSocs0BCXYH5peaAVvorW/4P+UOZhWhcToj7dDX6BjekdShr2KxPZmk4tDT8auX/vFpUe9CnNL4voIABXU3ENM5/oGk0SWbJoZtfqO8P/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=1sqW2Z2OJk3xPiy/Cyu3UK2zX34YqNDyEV/khp1vNeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCZaCmmtQpUnytxxvjWszxY2kG75ahCoXBrwsxJRPIkJ1kgKQwtqDOryC4SvRW/tOY7sobPD39vCXC+/2SAPBaQFoYVNk4y+vhk3Ey5sX6RdGv+S4UWw3ouKD2sMuNCvWb9nDFjfTK5OZ/cHKiLXl9m1OvhlJeJlqhaJSzrMilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZINoWLth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F18DC4AF10;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=1sqW2Z2OJk3xPiy/Cyu3UK2zX34YqNDyEV/khp1vNeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZINoWLth6D60EJ1cLvjE/Scwhar/uzB7YpgvmHvZ0L/h1YJgdoTgEnOTr4O/4AORf
	 +atR50mWTXYmZUrFzhCm+i9Xreh7o+s+l+jkxFlTeEAIrdmrmrTX800KTeFEDucUyX
	 Y9IgRD5HImgO13Nr8DkmtYmjm0EYDyM4iQDMLYF73q/zIzFeTEa3UVv302oB1fmgRV
	 QKbWzU+vm/all+zEOtnC8JSJIZZ2+oBtc/POrOP1NolzaLCLWBdw0moC7k9Bmeqoko
	 FPi3m87xQlQ9pEo/FUFPVOkH8lXXwxbtyHSLJ91V4HYSQ936P9e1xWgqWshLVS0ckI
	 0O31qb6zXs8gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB7C021BE;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:46 +0530
Subject: [PATCH 04/23] arm64: dts: qcom: sm8250: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-4-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=fs6UUE9w9Pz9rmlU2HblvB6mRAo33j+wSEDVuL8zClk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGteJZGSWsChJbGPVJA8zxDuUXm3iKiJ2MrZu
 1aMxyHF4pSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXgAKCRBVnxHm/pHO
 9ajZB/wIYKPKR9oGqzuCqIvhw04vFJalIv7jNUPZZG7trbykW5mFHFluxcJN2L7N1IuOtCppQAl
 CfbbSov1IS/IwmjDbP6/DSToEFpcu8gt4biaPKtuUTxg7qcZq34SItVun3gcu1hDNoZwfgqZmUT
 83fGw+7z2l+t7TPZUmdXtiXYgsLn1enRNf4W63E2Q8pwJBGm3qhLd1VBCr2XdUI72vLkRmiEgGQ
 OvgTuSm0iTVmNwE0vViSBb3cDtuiZzYJdnr/IagD6EHYe6fNI6ZS3tVXKKIy/Zks4O8c0SazEgv
 u+0ilGUb+479niZClKNL956arpg5yJRC4IDsL0FbrOnGyyMo
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'global' interrupt is used to receive PCIe controller and link specific
events.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c2937b4d9f18..920f3b2d3368 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2149,7 +2149,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2157,7 +2158,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2269,7 +2271,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2277,7 +2280,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2394,7 +2398,8 @@ pcie2: pcie@1c10000 {
 				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2402,7 +2407,8 @@ pcie2: pcie@1c10000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 290 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




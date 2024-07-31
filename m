Return-Path: <linux-pci+bounces-11046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E4A942C89
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C4284109
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC41B010A;
	Wed, 31 Jul 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAjXf2G4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA51AE85B;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=AXb0U5e7zkUFsv+p5IThoP7FOeXsRw6F0PWv8K3R8ka+9uZP0wnBzIjesEcbqWkqA0QN+jkghL4PTQedTfGKQBdExfUqUogQ86XVF4ujDyQQB5dYdbcLoGZKGLtC9+lHCq4wiaunwFERcCQF7pynjPadrEkF3nhw5OK/ZwblJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=T5skMR86m0ZxvSsBUDQmSGDmm4tUdFlQy/vZxL51ZmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgMtZXQ4zynyhlQKlpbnrLnQQjkBZ5aCrTUVGw4bBTsypdiCvImojlrkO7SJXycyi//XNjEt+X5argdReVjArlCAMhLnktUr6jlIT2/LEh+tI2seeXmK7P9t9J72SlHhKBh2GHvA7T7W0FIIzUrq5H7UEvYDbRwe75IehPXVF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAjXf2G4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71E9C4DE1D;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423019;
	bh=T5skMR86m0ZxvSsBUDQmSGDmm4tUdFlQy/vZxL51ZmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OAjXf2G4LCOEymiGO7ORtgF+gakvZV8CJv1ilww9RybwroRbNcQIaAP9TngOs6Ns7
	 I1Q455f1Ij6NFwTa2tYeS6MV5qpzLbgro3BbnbH8quMteDHyZsjHqn+SXwvKBxnZ5Q
	 D/Lm7L4xEuVzTx3jJr2xt/hzLPHzjqT3aDuyehvx3kpHr5F+5ZEsIuoWCfCP12/I/c
	 e1/DVUBLWro2Gw9BgNyblG1T9lDKWqpUQLvegUAJDbGyV2HMkTLl4zy43OnG/dQfNy
	 mIH9s32EOD8BPkmHK25Bq7tMpBv6JDTllqs91Hzi1KlHjacjwyosQEI2Fmk9q2hBKE
	 4lDH9ldsGfxaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB020C3DA64;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:16 +0530
Subject: [PATCH v3 13/13] arm64: dts: qcom: sm8450: Add 'global' interrupt
 to the PCIe RC node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-13-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=VT44obotCPUBbxvMUSiK7oaxSibx2Iio+dz6SHI7KhE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhblNzaaeYw8B23DDeqkEmh17nbj4nLf1+plB
 bbD5W/MaxCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW5QAKCRBVnxHm/pHO
 9edLB/wJfinRqT1ZaIEqmwdeCglsOvXrZYFwynjzpwkrwDnq/VJXpKxc1EYNUYndw2kJsnQnkjz
 MJy1k9utlvQI1HfHcGl3AjAL+iS0uVExZabdGUpQaKEFJCf1hr/UiiHh486UCOfE0wCJhni1TvP
 EuXNGESFIBsIcAf4XzYP3OfIIafC6g5fLA5r/6A322EVxMdCy+/kLv2gczMfVf/5ZyZQOGBiW9F
 nir8hA84oZdJsCf8xy50ulrMxrgwXDT3phbIQ2cbduZ1s3ltdLNosD2JIUuU4H/xwRcLh5ZxG3/
 WrTAx9Z1hH/oQQ2lIK73Bi73atywSQtqCQvEs0hvAS+0TUtk
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




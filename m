Return-Path: <linux-pci+bounces-22562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE386A47F98
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA87B188F0A0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CF23770C;
	Thu, 27 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiQAwcGj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA623718D;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663657; cv=none; b=mCqZkMTqpljixTeIaSnMQs23aG5hXLp8Feh0lVV7RNrx8ahM+BORy8DlWcPTeHJKB8UY6n321Ko+/8QYTOhDTQMU/ZOZiFKLMNCNwzca1Qm0ZOxk9UaWou1Rh/KTxGV5+tHYWwJv8E6LbOd/5+fQTstktZvafuw7tAK+VqjsiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663657; c=relaxed/simple;
	bh=cgloku63G1wQeCcfNkOeaAFkTndyWuB2is19zPZnGCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbYkYVF+zIaX5i/3IlzRtHatQZaFR1eStikOIIRiFRzwclk37QUsV5MWLjFlVQUkRFKnpJiG7D7uC9NjvmdkxVs3AW1ajtqjZ9pTwqK9U6IjOJXOnW6uM/WjF/2unIFnB9gtgPpdIh6bd9hGNSjWxZoI4kiXRBmsnpy3HI89q4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiQAwcGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D103C4CEF3;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=cgloku63G1wQeCcfNkOeaAFkTndyWuB2is19zPZnGCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JiQAwcGjKXTe3hY5RVKhdaEmikLmFF9b3oy8+Bb03QLtf1M2SP3n7qBZDCmL8t+BF
	 8ScPiDdWyh5i5hVnQryPOPuGYYqp5WSOZ/Kua04VLB7xkgmIjpWPnngZXYHP3eKVth
	 3Uw5uc+LvX17QmOBVEPYrcDyC9+Ir7VHuJxktb/t4vwERq+iJcfKviSobw572VJNM0
	 rIbWJna3fBDWWIxalwOIQZWiKKaDEbno1wpBtxIriNB4hcILzhti2HCnp9iPkIHHuc
	 0jYsQa4YqH0Te3ExBIIj60N8gEe128jvsknQuXqWdG5thqhdzGwawfc4N7YDNwEviB
	 LzM4nJHBj8sXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C454C282C1;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:03 +0530
Subject: [PATCH 21/23] arm64: dts: qcom: sc8180x: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-21-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=RVfrJS0e95Y78lJzi7GpvyagUeZjC2eKUrTcOd7OnV0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtisRiUJcz54bh59ksZgn6tSDQ+V3vqJYTA6
 BKDbMyt0tOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYgAKCRBVnxHm/pHO
 9cT5B/sHSQvAlwOhjzKudu/UbGknGhOWHsHI6j7UP19+mT2lXFHuh/oQYM5I1+Zr+UDo6nc7ktr
 0nIo+/pUd5ngweTyyoSGWFSwqUAWDWMo10Wd8dlWF0lmkMWOfkT7KTNMEC3YPWPl2oAF89Vm7Tm
 Zqmz7TwhG5oeu2MPHDAOs1NP+vwRjChC7OfvV44YDjNJoyHn09HnMnnYmYHyiYhBeIYtqJ/9TKI
 KYo+iOa1tp8VM0oTYCKoPqpGawwwKFKwCl02bkzOwqCsIDWdb0qCiyyZWEH9AEWoJcieKl36TNT
 jGgEXlOOAO6mmQpR9mE9UKaAfHDjRUa2gGszQXHMiT8bFEIb
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
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 28693a3bfc7f..b4563389ad3b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -1725,7 +1725,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1733,7 +1734,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1846,7 +1848,8 @@ pcie3: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1854,7 +1857,8 @@ pcie3: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1968,7 +1972,8 @@ pcie1: pcie@1c10000 {
 				     <GIC_SPI 752 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 751 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 750 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 749 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 749 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -1976,7 +1981,8 @@ pcie1: pcie@1c10000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 747 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -2090,7 +2096,8 @@ pcie2: pcie@1c18000 {
 				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 744 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2098,7 +2105,8 @@ pcie2: pcie@1c18000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 663 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




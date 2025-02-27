Return-Path: <linux-pci+bounces-22549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD6A47F77
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE0F188A2D2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDE23372B;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLiggeZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12D2309A0;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=UMs6hZHDK36ZAV/86NTbO8Gm70UpYFMNotSa2SQ39vWrP0v9oy/yrKlwcWd+0uZvB7c1jQiamOmvs+m2HOEmolhB9EdofmiBzSOyIdG87ED9AX+VQGHnKKiOXt65dfQkOXK7BxHPiJ2RHkJ3FbELieelZGLkOH2caJQlyLhS22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=L+7fmafUbVjlxmLkt84Q2/XpMG/TAgYrJR1b7K3eDQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhQEbKPJaM+OUGL2GOGthhX8l+ShfsbnVlGZAz1UdULJzVqME1u9/uLHrpgOchdjtxmPMGtDbw1jsxxHM6dzARw088RZRL/xasYijo0O9Eep0mLefXffvFC+YaarlXVJr1y/yvcS93LnIArZx5fTb6CueTEnqp+x22maQ+9hfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLiggeZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70F5EC113CF;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=L+7fmafUbVjlxmLkt84Q2/XpMG/TAgYrJR1b7K3eDQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tLiggeZphVtz4OgzAkSui71GmCuHYoCnEOAPPTf6MuGA4kaqgzYZ/CIPJAlAD3LHM
	 cNJqkf43uAAsC3ocykLWpZ8uybIGZKuI4V7//gZeoK6iBYMnWrxVLCemEh7YqKiwgU
	 BJUxmCsLrFHIg5PhZpXJJvUQ3MXkUDmR+qUtYTns88GCxwyBgZ0rZCuKiVH4qlJpeu
	 hIsg139qB1BkyDt94r2JdhEC98epAGMPoTpBdWKkua1uifvadsB7rDS2dYY0rygGtP
	 Z0sbMjvU1LuR0GjI1Q6dTZMj6LB83QMzgS1LFtznK+NsvgUAM7mrdSpFeni3cl9s1a
	 mN/427QXkPceA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7BC1B0D9;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:50 +0530
Subject: [PATCH 08/23] arm64: dts: qcom: sa8775p: Add 'global' PCIe
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-8-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Os2oTXz3lM7O8tEiJo6RhT8WTo7QJJeaiTGq7TdERl4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtf3mFRsxhFB5i2bT0PnqnD5DqV6CyNoa0dY
 gRb4So9q/eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXwAKCRBVnxHm/pHO
 9Y5yB/9SjMKRBDc281gpmD7dg7RV/rSvsHE3S6duGtZdwzaujXh5DfIOrVaI6/NMjvmTmw3uo+G
 7TpU5hJs4SeIq3jJ4o2iupox5rEq+xKpE37hFfJFfjEozYNifxFrfgGhW2Uhx3iGWi8Sh2QwogD
 YZq+MFEmcJR5J2YAO/PsAWq9/W94JHFaM2k6GvI5RJKhwC6swAX7TamagXST6j4jC5RJfLrd6qO
 IXZzv8fj92VsWpUkqITfxonMximOezz/bz3mXF6cRNsSrh18vJoUcfo9VCbCEASmJMcYCNxUbDR
 OP7zUa+Lsw2pnBS+fD1hI+5iXLGtioFEWTDUad5224hOengC
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
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 3394ae2d1300..05a3eb06d182 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -6421,9 +6421,17 @@ pcie0: pcie@1c00000 {
 			     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi0", "msi1", "msi2", "msi3",
-				  "msi4", "msi5", "msi6", "msi7";
+			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi0",
+				  "msi1",
+				  "msi2",
+				  "msi3",
+				  "msi4",
+				  "msi5",
+				  "msi6",
+				  "msi7",
+				  "global";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
@@ -6579,9 +6587,17 @@ pcie1: pcie@1c10000 {
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi0", "msi1", "msi2", "msi3",
-				  "msi4", "msi5", "msi6", "msi7";
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi0",
+				  "msi1",
+				  "msi2",
+				  "msi3",
+				  "msi4",
+				  "msi5",
+				  "msi6",
+				  "msi7",
+				  "global";
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1




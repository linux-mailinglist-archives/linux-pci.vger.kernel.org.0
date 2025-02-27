Return-Path: <linux-pci+bounces-22552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B307A47FB7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9916A46F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF22343AB;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcYLGN6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2074230D2B;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=I57GkQY/FhGUwBnS0IS6c+UKe2rponeoHFHOImYjUk1ffyL8wljWxwOxdZL4MS4k0LSJUxudGs6YSWGTIhV+JHxWy9PJSEW5URdDkLc9u6og6mS84tjp4TK1lh7IMdF/9FkH1qO/3IhAPrtjNAqJjtkfKY63FqX1U44J9WQFnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=H3WDSAOTWUvP+jjTPc6glTpBe5Z+uodGVhuG6L/ZhME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mb6KNxAExO8sM5pmGNx+ttOtjAj5MuoUp0oU6CPEEqfwKiKMiZHlVWFnWluIWqftUQgQBVvbOFoN+MD2dea6vUGDXLp1cTyFMZD8g+JrOds66l1bvUc2vkXO1VxI8mVPP+ZZntPDFYC/U5tiAq01tEfzJHL399spKdSqoS+r+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcYLGN6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0302C2BC87;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=H3WDSAOTWUvP+jjTPc6glTpBe5Z+uodGVhuG6L/ZhME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LcYLGN6aY/ku/pFtGH+DOW6ZE+wTwCQgWF+lsofqDz1WOET36YkazjnZpes4XIz90
	 Zv2GUQkaGdqR919GMynrhQCN3vpoYzXr6gshYLKcDcDdBJQtSIBcP0cV+2Hc0zKf6f
	 V/4q5reQ7ahXYeycW1H8ziJrE9FXS/oD7Ctq0sDly5vlgTZCqQg4U9Nu81nt0GEytt
	 ZvT/2ucNSJE21wj0xtfvwNl3n2ggWNXSC/TMhTib/PEcFKOSVuADpj3v4bu4I/iPGf
	 l4AsqOxRmK7rCYqlJQ8xOvOdZeBG8owtAcrmfRYXnJbkXgd5/MMtA76sId3V7LRTIy
	 VjoDlpwYiMXCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD3C021BE;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:53 +0530
Subject: [PATCH 11/23] dt-bindings: PCI: qcom: Add 'global' interrupt for
 SDM845 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-11-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=PoEhXCfBs5e3V4TSUedTjigqATIQI/CO3FwH77CyhdM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtfXka7p4vJZjRxG0Y5keFxL2MDwu7B5DYZk
 O7JFjyojGCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXwAKCRBVnxHm/pHO
 9SqgB/oDAyCV/42b1JlqEcf8jUzXqLM20XbWPP6469FBUP3Ao4ypq2C8E/7/Eqv2ljupORkyqot
 x0HsnORxutnE3ymL8gBRPB5xNQxAwna0nF7qlGQOfDrL269zDWEGusWEwUGUBimAgY+DNthWbla
 1Nt2EClFi+HeEh7eMie0Gzd3d+fMybXG6yCpIpe5ep2OF3BTGQgzWKBV+T8F9ZwuOqFp1Cb1cS6
 MQk5ttcnZ2yqRWjuN3rex9z9tYVEIpnfRlhjclUsCiNxDiT0VsW1/PlTTJ5d2wT5Zx9ub7CY+Qc
 bN5H35exx2KNYFc1iwFPn6b2HkyNc7+Te4VPA1ol9tnuWBSs
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
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 7235d6554cfb..3776dfcd2dca 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -49,11 +49,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 9
 
   iommu-map:
     minItems: 1
@@ -599,7 +599,9 @@ allOf:
         - properties:
             interrupts:
               minItems: 8
+              maxItems: 9
             interrupt-names:
+              minItems: 8
               items:
                 - const: msi0
                 - const: msi1
@@ -609,6 +611,7 @@ allOf:
                 - const: msi5
                 - const: msi6
                 - const: msi7
+                - const: global
 
   - if:
       properties:

-- 
2.25.1




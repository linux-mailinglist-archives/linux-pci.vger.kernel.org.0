Return-Path: <linux-pci+bounces-22547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FFA47F7C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D083B27B1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C66233158;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZIxOcsx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0423099C;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=Ylzj36cERXFDH4bgoa91SBC1ipJ89TKSxExJ6pRYt2MtMZVI4GzmIefbSt+4x6yb/0gfDo1phYmil31WRVx62rRg1G7v+6QeqHSi3ShWvjK+4Yuz6zkFYS+lvPmMKH+3IUuZdW/wFOQ6SLVp1YrnqQRdP1+dsi8qrBP6dKN7kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=1UJD0HzeyfJKdfVhOH7NW4MgXDee1TzWg6k+2rpGIY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNVnr5hYCosjQ/3BbH9+0IJi+qod5UNV32++8liBElULILmo8Vm2XTp4tBNIedAArp1X162M/7QELqtkTqrNFhAcPDpoYycagy3pD+C5aRUMULm8Ra+ypTJuKX4zqhIRIP4N6zZ7BNewXT1VgETcmOgupZ5eUcDNga2T5eB1PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZIxOcsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AFAAC4CEF3;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=1UJD0HzeyfJKdfVhOH7NW4MgXDee1TzWg6k+2rpGIY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aZIxOcsxwXP/YWf3aLUtHelby/uW539/CJrKLAwOqWvtLaZ8YoP3bp+yw46tYbe+A
	 Sr5px4jWqGQkvuijFLY0XREZXVYeX7K6+xtwdjhfSxklVDAjASGF4Cp82ztXTh6RbL
	 DMFFMYcp14+JS6TdfY87SXteiUqWwuwfZ0FWCzuODToGui6zD5IaOSRpsxo8SRku3n
	 Z+b31Y3Kf6uaEmC3oTy3xwS7hArtXivKr2ZuZWLTEb48LwwQwMud/2rDkPmmOSre77
	 ZwhvvBSRZne8bn9kyt4nC8aVYy1nDBsspFLdzLT3m60fsW7qLB1ozwBfIkxm8h6eAb
	 ex7RMqxex/fNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362E7C282C1;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:47 +0530
Subject: [PATCH 05/23] dt-bindings: PCI: qcom,pcie-sm8350: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-5-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+PdcbEuWmMgic5yiYO2o2+HdPlBtqTvPDHlQRYt9B3I=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGteki537wloib2MKOtEhYLNPOHuDBgJMSPTA
 2FfbIGKqIiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXgAKCRBVnxHm/pHO
 9SqmB/4vL2rfFHh5Vvwvae95ggG1kGJVTjBjr7j+52lNW18nXTmU1B4hjtnkTT1BR8oqW4f6LIb
 lBKSuzJ0afYmaKPObhIO/SppqIL110s+nL3vF61pK2mkkkyfZTHw9QfB7U0A4wne3ZoeH+koF7A
 4rKUZjJYPry/EOC+VntYG/UaUtLa60hK/uiBXDxRlGeTwQuhSN0MdIxBBtTtsybOZf0WLanvFOq
 K85lh7o+GjQRBmKjKCqUkmdn1efkxZQ9P736+9xVEO8kbSgBHGQHEN7BG4Dl/66utEhQcko1YQS
 77gLTPJfudzeaMxp/6+slXZkpqxehBuPD/qptg4af1FeaZk7
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
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index 2a4cc41fc710..dde3079adbb3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -51,9 +51,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -63,6 +64,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     maxItems: 1
@@ -132,9 +134,10 @@ examples:
                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                              "msi4", "msi5", "msi6", "msi7";
+                              "msi4", "msi5", "msi6", "msi7", "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




Return-Path: <linux-pci+bounces-12366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CA962CE8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852541F236E6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8655B1A38C1;
	Wed, 28 Aug 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G02gvhg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570961AAE1C;
	Wed, 28 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859987; cv=none; b=RTMAWYp2pmqjzsSFFpMUjIA1A7blfy8nT8Invn7NQbLIBeldAGSmflUETkRNhkd4qMV/D8L556NQ8x2aQu+lz/h5o0aqSGGsSbV5J4wbnrKMmXTWb80lFccgNIjOJD5gO3qEsPxrYjSRv0Ft9qtJnb5AiQ5gOX5A53a46UjDmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859987; c=relaxed/simple;
	bh=F3tlcZYkq7aH9cd8XiPnDgHNXtfM6IsBl+yJgxAu458=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjtwDeJ7aXOFJtvFVXAyLUHkr+hYiYqflqZpRivOzzUHMXCYPZIqHcuCV7QnaTPtr7A+K9GWdKjDQV39hIHsGAhG0KOx46cYY0Qfd6BJ+BXySlaRbO5vsZ/aqUkeHqO91HwSwrhN/hmJ+j4JImc9oj6XKm6lnswVagNCC6iIIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G02gvhg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D97A0C4CEF3;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=F3tlcZYkq7aH9cd8XiPnDgHNXtfM6IsBl+yJgxAu458=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G02gvhg3wzK4EFaGx02Cv+sihP8gBSxncT4a7lDK1nyXyf3mPBczATbikiTvaXqYf
	 UD+3kkygagizZqcR00HNNpQEeRiLMOyV3rmeMTmJKeAoAsfahCr5J4LA28nVxfbLi/
	 mxAZhj/yquUOcuXJxt5Eb+qYy6HK3oAmVTOVwccTVxYYBCiuwvUFTXWLpiI62tPt5H
	 Lm1dDwrj1Yvnf8Q7kjDqctnD2zFXB+vzpQ6xpWNIqFn55rnt3PXysJ4Z6HE5SDIBFD
	 rKpS2RcE7/DfLAhRanTyYiqtNZs2CLEDg7odnyxgUSZYfFfo6Hn/pOikrz50SWcNla
	 Bv9PT5tLY+8rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0822C61DB8;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:20 +0530
Subject: [PATCH v4 10/12] dt-bindings: PCI: qcom,pcie-sm8450: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-10-263a385fbbcb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=DyBVQRLO1Cvv6lhUcJR+pkpUwb9nrOEo4mxqLaOumRw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZN73vihZy1iEXaEcTGQKkDZREqQZS/aQCIQ
 Tp/HiXFbxiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GTQAKCRBVnxHm/pHO
 9f0+B/wK7H1XmDJUhCBbN/HOdnPxMEI0TodYU5qwzRf3wBq/v5DsKb0wHx7u5Rb4FogLmE+qbjI
 nU77ZbDUQezrMrbsl4V3lbw6d/rG0n9cbTCvUOnD+8IGa2XsCe0YcfO7jGIl8kh1qZiDGOnF2l5
 YJuOVQCwPabpmmjZNiQkiNxz9ZqRjquNgxOWb7uziTlelaMEyAf2HPvVJ7HpsklfoHB9UKAIIc7
 PGZajtULee1PLbSn3M6FdsGnWLtYiPRQFR6r1dGnj0afaDRjCKf9AjZK45Se79yVqCnEN9MxOkx
 EtB/ypOK7rC3vrpDjrb1Z0lDviYTaFxx73w5P0LVuqjrMKPL
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPU. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, document it in the binding along with the existing MSI interrupts.
Though adding a new interrupt will break the ABI, it is required to
accurately describe the hardware.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml |  4 ++--
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0a39bbfcb28b..704c0f58eea5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -21,11 +21,11 @@ properties:
 
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
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index d8c0afaa4b19..46bd59eefadb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -55,8 +55,8 @@ properties:
       - const: aggre1 # Aggre NoC PCIe1 AXI clock
 
   interrupts:
-    minItems: 8
-    maxItems: 8
+    minItems: 9
+    maxItems: 9
 
   interrupt-names:
     items:
@@ -68,6 +68,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   operating-points-v2: true
   opp-table:
@@ -149,9 +150,10 @@ examples:
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
             interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




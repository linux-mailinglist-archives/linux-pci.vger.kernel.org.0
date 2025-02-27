Return-Path: <linux-pci+bounces-22551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDCA47F84
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AFE3B14EA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F85233D91;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BguzPaAM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE691230D1E;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663655; cv=none; b=sai3fhWJQNxfyWkVrAMGF/BtRAXQxA60TP5yATkyT8XhmRnMemv7UU/zye3iD0NBGAuuYDZ3YY8G1scx+Fqwc0XruJnDm910wrc8BxaKHIY4GzvDvQcQOlMttzY5IHB64dE8UJ8SGK8y3iriVEgAPj6O8hrd4zQdBbLilawGvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663655; c=relaxed/simple;
	bh=erC6YNsOQoeLC7Vqn3Td063kUN7pBcT4JKctWJbosWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBtGG8WBnRMYwlhwqF+8E++oly9uxdqfygQKJX8VHV16g8uSrh3tjhbEEEVxA/ufG/5DGomcyd+FHf0xVyzFFC14x92xvuTFEzLqVEah3T5Ryfc422SbD6p+xc3XwreJ+GaYotVOfYM++wHYKp9jAZ2ccH6DG3FSfBmECqhp8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BguzPaAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CD9EC4CEE7;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=erC6YNsOQoeLC7Vqn3Td063kUN7pBcT4JKctWJbosWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BguzPaAM+2RYC6I9twFhRCBF7a3pBJR5/Zd0X/e92QawLnd00IHv5bSbUClB4OfSY
	 tSFD8m03I991uFy6FwtW6//YOvpNAJBak06FfmlWaXYk5N3tr2gRnUn0rnCgTJ0HFB
	 viAltKmQazRTIqAhqPvkfppNYrcBcydVLurFlTjTo9En6tjyO3YCnzmOsA5XldAPvx
	 VFXI0ZaWHC4/c89GfZTXkJiXykhSyPa0Q0vgJ4PmKGVcoAZF4wmLaqK1do4Yw5G6Lh
	 nXBMn7Km7xpiPf44KQhSU942GgPv6Nts2Uy0fUM3EGL2YMB8t49jQBkZh2yf/rkRb1
	 54374TLLCWJng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489FC021BE;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:51 +0530
Subject: [PATCH 09/23] dt-bindings: PCI: qcom,pcie-sc7280: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-9-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Ypfuedp5Iva71ub+3I/TErUi7/T1H5RxWeczTJusiAc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtft6BtrM1tZFvua316Ng6Gc9IK8GbDisgWv
 z7AYhsGqx+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXwAKCRBVnxHm/pHO
 9VbzB/9Ig+5sg5vOcKeWP1vv+i09AEn/enAbcsxRlnSer+8tiPwmmybKoQlitBsnYR23DRrgp5a
 SCCbxeHq/4Ygci1rw3vd2/AzKrAQX2BVCavFwjafDpy5ltQjEiY+NAbkgTwtK9Q7JobPj1Q3x/h
 vkofVspBS8MudSfqBkvQigmmPupQb+s38Ts5UDkpfJk4PF2kreTDaFpsI6LRaRg3+KHQsSHX/zd
 EV7JDhipM3ZKsyY/46p2j2uRq3Hehd1O1gsVW6536RNelaGrJLGbpcCnjkoVGR9xWlB4XAR996P
 BkgpbIxTqTENDBp2izD2gppD0ni2F4z5/VYwbGpLoCJwBH+k
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
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 76cb9fbfd476..ff508f592a1a 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -54,9 +54,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -66,6 +67,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     maxItems: 1
@@ -149,9 +151,10 @@ examples:
                          <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                              "msi4", "msi5", "msi6", "msi7";
+                              "msi4", "msi5", "msi6", "msi7", "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1




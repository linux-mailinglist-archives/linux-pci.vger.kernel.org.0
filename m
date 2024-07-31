Return-Path: <linux-pci+bounces-11043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB517942C7D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCA81C21A12
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EE1AE87C;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFW3TRwL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005371AD3FE;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=g4NSsM8PxkbzWN8fIcKJDx/IkdfxTuKrqR68aTpIzfaBxqQ3JcE54s6L1t8TaMjjq0nDcKWiI/d9/5IzQ5MFHGYpImV6tTPqcV/Gq1UJBRKoKSQGbMqICiUmTXlgVFZVeF+Z7PaPRb8Ji3/q+LEIsJxPlVYqD4zS6EaSsrfVAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=FDAyuVhiZfadF2+raswbfNBa/0aOcWVYQKsBdgtWLgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfFS4Udd+9+iFeHj4waPUYpiPFqrBgjWkuPVIF5MST0pEzufudDxgvscENq57rZQ4Y1pHkFrQyKe7Py+SMsxV3Np/LclFOsKeKx/8MvKKslGaL271YjFqzRiHK1qKeKThJv5xG1B37JHr8GmJJcSzKl3GlbtKjlnLqGuxY6E1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFW3TRwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5A46C4DE03;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=FDAyuVhiZfadF2+raswbfNBa/0aOcWVYQKsBdgtWLgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gFW3TRwLRi6dvDK10BKiOU9WO6I3foMmtFaUvMylpGyhbBdU8XHCG5sLfuDxVXxRL
	 GXPXojC9e0xvu2xyUIE83Of/VXU4Aa5mjD9upw9ON4gHGNvstKdWJPAzaQB4sqGyTd
	 6SHqn/WSCvF6tufSYzDojmW8ymloB+lUPkHjFFzRAgzZC1thP4SKfU7dmC0E3F0aHz
	 ZSNIQRFIxRvxiJwArMmbb+1pkXM/mKPwdVdB56GxuEkVK8nWHaD20w3fnz+Vc/OveE
	 RBq8QX/ckrky5R562BHXgDD3XFbWhNWF1JyTFS/JoZXVQ/R6KkhNbkwsY4qWrraiFU
	 GRSo2YJrsvzAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD052C52D54;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:14 +0530
Subject: [PATCH v3 11/13] dt-bindings: PCI: qcom,pcie-sm8450: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-11-a1426afdee3b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=w4cY5FEuD1vubOFd7Zhbt7y5H9yLj0yvZBQOIyWPebc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbkakmaRXQMThiXty5wzJtqGzDoKQJJtmLBw
 VRycaPEeJeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW5AAKCRBVnxHm/pHO
 9dngB/kBPbwnipqgE9LYCyvM7tsqZnqrzPBVSl+ShZO4DBdntLhupwJWwoBGIOLNCS4UPNmNkI5
 aEu/3uV3MI7G6IiUxXbDsnbH9bTKYNrmM9hLySVzr+rvvTbZJV2YeHCya65WOQCpWIfDwt9cVaC
 RZgwv3x9vnXEc2lF+YIRgzogwadwbn+iYCYh4Ykrze5gut+mjGsxdNiJa2euaF+d7r4g22h8HJG
 lA2aPMhzwKrDj5zjG8dMTpiyGlAWVnq9gBRRVvFQaHLjj+oKAK53jWHuPaM/NzlmkQveKEYVxY0
 hD4RHBZxKOQjKG2lASxkAkCTX9Ec8SPNSiw9H7LApYxU9gM1
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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




Return-Path: <linux-pci+bounces-22543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B229BA47F6A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB211889142
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9F23026D;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7P0oEFk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5E22FDF2;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=F5onjzqABW0TZRoDeqlVCCwsRAZcxp9SFsjS6y9QJMsM9aB0RziBOynSwZ39AgR3mW2+Xad86sKulGHm+sWr+gkTZd4cENltsrs5cIQ7QaCcFMS8B2CSEYgKe2+TsEwsgHmg8QBatryrfL1kbtBa8r6WEq3Kr6grH9flagxCHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=bWWTG1PyfIMJzF76NSy+EeTbgLJvzK2k4Qb5cBe0Hbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKqyzs6y8Q+e1L4UsSGCRC1zoRGJsiAzY9Szkyy18Sn5MevUuZVsSOe2+VSHXv7AFmEUAkW3P/uv2U/dDfh+0Q8nuIlgpPsGJQKdEYfPq70E+l1oB25oHI4Ts6hyMIB8QfB9C/bKBiMcQgjfeXu/wfFiFSLkgPSuqhqVeeDG0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7P0oEFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 106B9C4CEDD;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=bWWTG1PyfIMJzF76NSy+EeTbgLJvzK2k4Qb5cBe0Hbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X7P0oEFkqR7Rf7qH5uvtWIjxDmcc4cV7Vojhbif7fhkbbza3ngQ/1CmmHk2g0qIOh
	 DUChIRTYVHNCkYglPgWN00Wm5n5aEYNFLPQhI1pFvH2JQdzA4527xVMVdLoPH8Yb1m
	 220NyjZ/I+6SefCibrHQkdFxPNGWg4+tR5QL12HtHHXcIqyOGd/FRu/nV127c1+oew
	 fJusNc8/k/Ljwn+8CnndvfmXSyCDvcJPX5XM89qTwrLgL0ZgFaVmHofW0HXqyHlCOL
	 FVR96eGCYQwdA8P2VBuGqDpStU94PPfuP5UZZW0m7gr/KMG9gyfqp+zCIc6SoVA9jI
	 nZBqED5Lfr/8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D3C19F32;
	Thu, 27 Feb 2025 13:40:53 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:43 +0530
Subject: [PATCH 01/23] dt-bindings: PCI: qcom,pcie-sm8150: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-1-2b70a7819d1e@linaro.org>
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
 bh=55z0isesPRsoBW3LenxOlNppI2+qm4UnlpCp+bQlx+o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtd9RJU6/KQfNEbU+phDnWfHBYIQttEQ3oYd
 ZcxmyTt0VWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXQAKCRBVnxHm/pHO
 9UFjB/9v69ly4JdQX9NEiGFfnEeG3NoKG7tJrWhB+YNiek51SgDupekl4cBrA6yTwblfsar5RpQ
 DeHzJbmdXYo2aufqn6rmCqzftyw9ZDtBOhnHb4ACmn+lmkl6ZxVMlyiwhv05Dmc0hIwedEO/g2S
 nb118sm5KOicWusf7jU+rIwL8y6dCNrcx1fLc9UTYfZT1hmilD3wtIW3YY1JM0PR8MXVvE9xr1w
 r451drJfphqR6nPXCnW3KMM2B4oGcyOSDmtrJRMJScIbO/M00O6juO4Y2AKAUx4yXdh6/Gvumun
 R0Dj5GVziTccc6UWs+nplgB3UcVYJpKi1LB/y/d15KixOdph
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
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 9d569644fda9..a604f2a79de3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -49,9 +49,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -61,6 +62,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     maxItems: 1
@@ -128,9 +130,10 @@ examples:
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




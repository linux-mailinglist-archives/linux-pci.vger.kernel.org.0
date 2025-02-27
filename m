Return-Path: <linux-pci+bounces-22561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D05A47F94
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D49D188EAF2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC12376FA;
	Thu, 27 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEPna3Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C42236A9F;
	Thu, 27 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663657; cv=none; b=nAyhEKxuLw5CI9Zt//j6PySZr2eK6MHgbzGz8TdHVrGyHJk/eaEBJWAYK6MOwBpoa0jRIbGGgicJtyBSanotWAxCzMatP6XVd0PrfoPEWYdfLqmOv04vH2YaBCUdzWs7VGxA5Stpdb0fd5ZIzM0Wz9VT6OSlpygeze/caW36nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663657; c=relaxed/simple;
	bh=qi3l6NG6Rg1ySOcIFulm+m8YXf4IIYIKmrf1bvFWF0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFQ7bn2KSgedf0XuBe+NjKhmLb3vFIotBbip+lVK5nYg9sK7ZLIAF/ZaRdZjgH9LG9nFaB3QpgUSU9wxrR09gDNdsG0vufkuOFUOj6lrOzpDncx49y3ss/DxuTMNMEdyGfjKHsYH4QxV270+cVmI3rRIwCVxAfog7HWbqpoxleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEPna3Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65460C4DE06;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663655;
	bh=qi3l6NG6Rg1ySOcIFulm+m8YXf4IIYIKmrf1bvFWF0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cEPna3YlFrPn2adFEOGR+t2GoCXMHPTl44kKY28idYi7quTQUZNYiFnvBeigrmj+0
	 3m7Hq3PthNHG27J/XZVglSdimVukz+uF8Fjz5yG6alFkqiI9kzb22j8zUQ8KRpFu3n
	 r04sknwAqn35kYcJjv6Kzmw1WvyvkC7on5GrHZhZHoirXBOTGXDM9zgSBB0D0R5/uy
	 ouyMsT1IkECsSHASWuxtaC4ySQ3gHP8+1ARIcoup7BMJg5RImySqhCk5MjKhD7lCFW
	 AEKEra88NkoxpDOdpXxXQllfkHaUbqtxXo+RZhJ6bRAP08B6uqrhmt58limAEtaucN
	 ku7fiSo+iQDkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49389C19F2E;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:11:02 +0530
Subject: [PATCH 20/23] dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-20-2b70a7819d1e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Na12fmGJbdooTFijRdHfDd5PBT36knP9iLScIFZtl68=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtiZFdkTxnv7NuCHp2GN9Rm/aTBWYJZQn+e9
 PwYElIAjVGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrYgAKCRBVnxHm/pHO
 9ZWrB/wPz8+bq4a82ucw3T/2CPxOQRWrnjrMU+l1T2nEBfqqz2FKqT8nGL82LGPMYA09hmxSQZ4
 dQ43eZrJgM+l5cK+GMt9iXjEq2/iVhuisdaeqRPJXnbFcjqb3LgY3oNenU+1TYovSoS7LuwmhzS
 YljJhwXsNA7Af4e+AVxlqn9h4XwwUX9Gy2h2v0fkxtjG+0h3aliUZKk5BU2ESVg/sRtW6tlPKVv
 a5e7AIozRvYZhHxnhqOgjdm1G7712zF8KLg6u9aa8xJh1tlgZJShv6eMpGaGtwP0AHAqYE6IHUx
 ZoFX4FEO/DmJVlH62U98LO9KzKFiUjMMDJq+6iHh5Kq1SvD6
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
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
index baf1813ec0ac..331fc25d7a17 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
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
@@ -136,7 +138,8 @@ examples:
                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0",
                           "msi1",
                           "msi2",
@@ -144,7 +147,8 @@ examples:
                           "msi4",
                           "msi5",
                           "msi6",
-                          "msi7";
+                          "msi7",
+                          "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.25.1




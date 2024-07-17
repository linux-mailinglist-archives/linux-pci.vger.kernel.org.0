Return-Path: <linux-pci+bounces-10450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F379A934108
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9F92849B6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE41849EE;
	Wed, 17 Jul 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCVHsgWT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7924183087;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=EzZIuTeWXh9FE2bwcweI0+5m1Rs3ZK8NXIyGioHfpub6M0R8nDWsasLLtFwh6U7+FS4OAIPdB6feImBGj0g7W9R+FU6eshKijtPu5fRwt1dhf6B64gBWb12XXc9vBFA6ALLOGX/bYCzNimi+TmFM1CWXLZLUjllui5a3Ze64mlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=xVSjQT1rCMYJ7JMW46sFrx5R4uNe8KS69JtmKEfBafc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ddxojmz3Z0vhbIDQUOipJn7kTGuvh9NniJ8s3kwWr8OBpDcy2yhAfMF47FZppMk/hQxzoFl4BLqXxTw+wjLPN82W2OI6Z6/CJ8Ud5pzYzEkWQWWwkFuD8gGnelsnuH6nJ5CtoaFOlCymB/C8/OhagkaKpyaPNRinOOwN8Do1UA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCVHsgWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FD31C4AF49;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=xVSjQT1rCMYJ7JMW46sFrx5R4uNe8KS69JtmKEfBafc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gCVHsgWT6P9ao5uav9wCTkWQiPtqqamO3t1STbDu0/FI9DJPpjzen01ciWN81MO4W
	 uIZyFbw3F7Wv9nSSCdf4rqoHDEcbZcL379UYCs15xGomRRkDfL6IRefI6sBsvkZzi4
	 KK8o+nRPUmfKjX2c1DLp0/O5TQBB3JakUZw0eBkqLYDbqnHNCwoK5i/DuuioxYK1/z
	 Ux5zlGhrScqL4DlUwjBxwQJGXztDIYKiZys91V03k01LiMyxIdmu23b1Vt4ck1PLP1
	 ELPITcePESJhQ74qWCJMya7mc2zqJ9qN3ayLQSBDnjiHUgh0fxl0LhJHi17qn0pXmQ
	 5KHu575PsKUEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72173C3DA62;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:16 +0530
Subject: [PATCH v2 11/13] dt-bindings: PCI: qcom,pcie-sm8450: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-11-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WTYqEiAQrNsXkDUR6nKibzqYEnKaNCwK2nnJZ4g+zho=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBml/lP9ULqIWFizsPL1F7exFT3gCiltHrrGeD+r
 VHyeE2BUfKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpf5TwAKCRBVnxHm/pHO
 9TrlB/9x3P5MCFvYHOJZ0ypEcPgHw43VN7IF/KoZBvA1IoFKnKPUoZzLGrdWSPEdc6UWFL0tQhl
 mmbcdHHyJqAi+jX7WepExANqKvvb3i0SUIIYF9WqvfWSqgorAmOMzpXg1LKSp+Qk2qJwxrXEooC
 rDEUuiw20CW6fCdrPFEhEkHfh2vMmHtRqaKU2FRQC7suZDvyFgGJ48h69B1INLSVSboUuroaTC8
 Lu1L92pHpTGcYY6wNctfRnrymsWoeBrbftVbgXohF+Nou0cRaS2ZVM7OkyARysWj8gPfa8z9zkc
 txNu6TZ2UhQb1Ne0aJRLxkF7053SBtAu5oVp5eFcnICg9XX0
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index d8c0afaa4b19..0d68ce073383 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -55,11 +55,12 @@ properties:
       - const: aggre1 # Aggre NoC PCIe1 AXI clock
 
   interrupts:
-    minItems: 8
-    maxItems: 8
+    minItems: 9
+    maxItems: 9
 
   interrupt-names:
     items:
+      - const: global
       - const: msi0
       - const: msi1
       - const: msi2
@@ -142,7 +143,8 @@ examples:
                           "aggre0",
                           "aggre1";
 
-            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
@@ -150,7 +152,7 @@ examples:
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+            interrupt-names = "global", "msi0", "msi1", "msi2", "msi3",
                               "msi4", "msi5", "msi6", "msi7";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;

-- 
2.25.1




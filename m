Return-Path: <linux-pci+bounces-24745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67111A7122E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C41898AB9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC151A3BC0;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlmEHLpc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CF1A255C;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976664; cv=none; b=dVAx2vqO4bgxPCzOXWa+oo1qxajpxshaF7GaSRcEV/4AwemrDkoNl7fKzC1QRVNbT0GIHxQ4pmc8iv/uQDfME//Y12Ks7Zg81qMpeCIOvE1f8UH1Z/3v+JpsXIikgRBNwSN465dt/LZPy3c3gpYvJMlubkkomC3Ee9JJ3TzPdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976664; c=relaxed/simple;
	bh=PSqTZDfWpErRZS7ytcdgOCY+2TXXDzwOjm90nT1xmRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvWbHEoLwYQW1k1DwqQyaczVakOUItpeJ0S/yneMR/UCDxuuvLekRhXf21FnE6t6PQfvjaiZQqsd4Ykqfpo9lF4BBQNDxS+nnKT3Ob19V3usm6JSupGYxIVJHD8xcyH8s3+NrUCsQKChYN5+A/nbe1oUJusKIqKGFv6PibflWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlmEHLpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D42F2C4CEF5;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976663;
	bh=PSqTZDfWpErRZS7ytcdgOCY+2TXXDzwOjm90nT1xmRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rlmEHLpcwDZPxByVDwfnFex5N0t2gMYvMuKMMn4iBhoNrYl17FXMUYwxT1jw79Dlo
	 ThGjrOoo9aGE7Jyn3i/uA+ST7RIgF3tI/k5402vRsQGcSNNQrP2nTNuWnul/j+wc5I
	 qMzOVoTF4P6F0xFDPuBlh7b6NQWoV3AOziowewJBD5gmcq58uqn7/VZLldLJE20t8d
	 h+lsF/jp3rMrlF4h2ObSdBmgNGhQrDY8ir9Pse+7l1Z/vPqurLu8rTUignpcfttTtP
	 Aabb/2YyI8rVntvMcR6BfXLK2b0iDcQ4ieDBDmeBx9+Wvw77WdJwNa71P9LVBpQRk5
	 PYwIlyqNVDu4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316EC36008;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 26 Mar 2025 12:10:57 +0400
Subject: [PATCH v7 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ipq5018-pcie-v7-3-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
In-Reply-To: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742976660; l=3263;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=VoA3ruM0vchkEenHoQyA6ZuiI4oyx5AjPzowyFkxIeE=;
 b=A1NUJN6OMCqUCB8lS3i6aCykpd+imHDlmSJ/f2ns1/6IsryF1cW5+YwVaaaLXcwrO90jh9mLn
 c2cAlXJR9hrBMiieuTm61xlxh3rKqjfVUzfpxqUlvn++2d9Bu+mxEs9
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add support for the PCIe controller on the Qualcomm
IPQ5108 SoC to the bindings.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8f628939209e9ca63ba229c089520cd5538bbe6b..b1643c07942956bff9fca7aa0524749a5004a642 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
           - qcom,pcie-ipq4019
+          - qcom,pcie-ipq5018
           - qcom,pcie-ipq6018
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
@@ -168,6 +169,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-ipq5018
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-ipq9574
@@ -322,6 +324,53 @@ allOf:
             - const: ahb # AHB reset
             - const: phy_ahb # PHY AHB reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq5018
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: iface # PCIe to SysNOC BIU clock
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: ahb # AHB clock
+            - const: aux # Auxiliary clock
+            - const: axi_bridge # AXI bridge clock
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core sticky reset
+            - const: axi_m # AXI master reset
+            - const: axi_s # AXI slave reset
+            - const: ahb # AHB reset
+            - const: axi_m_sticky # AXI master sticky reset
+            - const: axi_s_sticky # AXI slave sticky reset
+        interrupts:
+          minItems: 9
+          maxItems: 9
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+            - const: msi4
+            - const: msi5
+            - const: msi6
+            - const: msi7
+            - const: global
+
   - if:
       properties:
         compatible:
@@ -562,6 +611,7 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
+                - qcom,pcie-ipq5018
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074

-- 
2.49.0




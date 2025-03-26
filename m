Return-Path: <linux-pci+bounces-24741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C6A7121E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F01697D6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825281A23BC;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTxD9f33"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EC1A0B08;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976664; cv=none; b=HvzoKA65rQL3XFWR34RTRovbFp+SxIeKnkcHRgKSDEdLExSCC4mKwPG2BZJ8XEwWwIkEg/KmTkgiC310lxHPgLq3f3iVmsq/d5t9vYwa5BYMaM7zJcWZTFBMK5o53yvH5An4dSQrModbnPnNt/iD6ynXgwM0OIHFpZiB2XRs/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976664; c=relaxed/simple;
	bh=/Vpaz4x9fwZAnHLG6IUAAxI34tMKek2Ai8IRZhy83/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWVZ2QOWd8Rt+rS+Xg2tchLoCtfXgd8CHBiHHAC4h1qdRCIf2cZpBwaqjYxwg6jBqhTG3cj1uXoza/Zd/tOeaaOx2it+zAlRtCCURIUEFBC2sZfKfB49rNqqhCoFKt9kNub7aMeMkTfmeiHTt1aPJDg/jbLClaupEZAmQb9raG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTxD9f33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4659C4CEEE;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976663;
	bh=/Vpaz4x9fwZAnHLG6IUAAxI34tMKek2Ai8IRZhy83/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KTxD9f33jCY0ifiaGstq1XH3RQug2uFPDjuOzo9cVNfO2585VVDbXF+wcuAgfu8XB
	 qTSLqw0NZrlxaRiKpuNnf/H/ugCtZPFilkR3ZneZPNeXQ46ml3LjH649YNIWCuuaJG
	 gHDDukl0RF2lDSDg5qVuh3XNyPCOOBdWB8W8cS1SByKjkzHlM4i65p5K8Hv6J0iib9
	 a3TDO86xeOIaLquSzU+/c5tv51ZYmN7O7Cj3pGxWRV5E2Fmacig8J+ebEpi0Dzj9kX
	 uLeGA5oEyam7OY0/jnX+S6yNBrbpDIFdsHN0eHF8vClyTljwaBwsJzZD9b43Q7qJRG
	 hY8R+albo0XHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9658FC36010;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 26 Mar 2025 12:10:55 +0400
Subject: [PATCH v7 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ipq5018-pcie-v7-1-e1828fef06c9@outlook.com>
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
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742976660; l=2649;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=RzhX10TqIYEMB/NTuvqI/PKN5F5WXtFaWjatLWvgFzo=;
 b=We7QB78QZlBFHrnitOO1crJOewYZbnsm+wFqF8GMYO4mDAoi39LqgTDfWSRsKwbk5JS6DOMns
 4m2j+S/p4SeCATSyFaa2NTvp1ioS0J+sMT4G+JUb1pF1U4mGWJXikdF
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
same as the one found in IPQ5332. As such, add IPQ5018 compatible.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 49 ++++++++++++++++++----
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
index e39168d55d23c6d361b6f89f00a897e121479714..6e9df81441e94d82d78761aa4a25ea4ece65d36a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
@@ -11,26 +11,24 @@ maintainers:
   - Varadarajan Narayanan <quic_varada@quicinc.com>
 
 description:
-  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
+  PCIe and USB combo PHY found in Qualcomm IPQ5018 & IPQ5332 SoCs
 
 properties:
   compatible:
     enum:
+      - qcom,ipq5018-uniphy-pcie-phy
       - qcom,ipq5332-uniphy-pcie-phy
 
   reg:
     maxItems: 1
 
   clocks:
-    items:
-      - description: pcie pipe clock
-      - description: pcie ahb clock
+    minItems: 1
+    maxItems: 2
 
   resets:
-    items:
-      - description: phy reset
-      - description: ahb reset
-      - description: cfg reset
+    minItems: 2
+    maxItems: 3
 
   "#phy-cells":
     const: 0
@@ -53,6 +51,41 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5018-uniphy-pcie-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pcie pipe clock
+        resets:
+          items:
+            - description: phy reset
+            - description: cfg reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-uniphy-pcie-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pcie pipe clock
+            - description: pcie ahb clock
+        resets:
+          items:
+            - description: phy reset
+            - description: ahb reset
+            - description: cfg reset
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,ipq5332-gcc.h>

-- 
2.49.0




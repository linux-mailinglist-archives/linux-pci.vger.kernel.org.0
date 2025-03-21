Return-Path: <linux-pci+bounces-24333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D2A6BA74
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4E3BCDCD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1645226CE4;
	Fri, 21 Mar 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNsg33Eo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69B22370A;
	Fri, 21 Mar 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559286; cv=none; b=m6FO7ltV/kllL0C8tVhbFGrB4XtuuALBWC3WIOjLlc/eDw57PEJJQ+4TiUTAIZFG5L/2NqiFti+Gv/ULTNudA6yTwqvGfMavC77GX4jHfRUBJwonZrul+HfEGvLGZjt1X5NBu1cD0UqndSeIM4xfae7NzvNan3j1c9Q0PW8yhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559286; c=relaxed/simple;
	bh=tOdxxoSzUazpcccklQoLqiP7/7aKFLypGPrykuxFBYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAirj7wbaokLTiwNJTxE/XT2Rlge0vc/dagC8DN0VuFmDogqOKIw5m49SJb1CzPnM+jIhPnkybvrwa+8txzJ/OdbV6vl9FXcrW3cdAZLSUzGPt0eB5h4Vjad+Q7BJRYMmYHIirhZd/OAz1768tjvZHbN1dvLMAJO0sZ0eUbKLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNsg33Eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBE9BC4CEEA;
	Fri, 21 Mar 2025 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559285;
	bh=tOdxxoSzUazpcccklQoLqiP7/7aKFLypGPrykuxFBYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tNsg33EoA2o7BsYb95TxdRdJmBD1a5N0Ex7xc5JMlm7KF5BAKEN67/W7YCCrdrY1F
	 5eOjm64gqDUqA7M/LKZa+Horw1tK47irYSPHJlRZoB8peRtOahpDYfoFOAEeGKWTJQ
	 mD2In32+vRWX4c4oukf/Z4ko9dSVKkgpNl/yX/xQEdGNyiQ1R7pKsLc5BUQ6ufkraT
	 WJzOlDv44cgeT/aFSP1UeoQhj9pyRFmpkC6Wyf9HHWmzMfUaRT+sT290Wx5/rwTpzp
	 igTLmyG5ln/oHhU6LuYQJ9tOVUpxbkw4rJlymU3yOUcW01k1rBiSEYkTtyZF/0wlCy
	 +PAgeOiPyo3Rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFFC36002;
	Fri, 21 Mar 2025 12:14:45 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 21 Mar 2025 16:14:39 +0400
Subject: [PATCH v6 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-ipq5018-pcie-v6-1-b7d659a76205@outlook.com>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
In-Reply-To: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
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
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742559282; l=2543;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=pXPdeIxQ7UFpyUFii0fIXy8w9NXPjKIIvZnafwJ+4VU=;
 b=oNXc9owwJDOnsPhm3V/cYg59hNXB1vZmyULocJXqdkbAQrey9H7Yq+OR74DiDEd07OXzaJ5lJ
 4IWNkqnplycDqFwN+N9+oC7/33i2pInh216jFMTnX3AvHIIxANdZN4l
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
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 49 ++++++++++++++++++----
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
index e39168d55d23..6e9df81441e9 100644
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
2.48.1




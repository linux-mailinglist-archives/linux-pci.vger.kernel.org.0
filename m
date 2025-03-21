Return-Path: <linux-pci+bounces-24309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACCA6B6AB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F23B6EA6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E51F0E2D;
	Fri, 21 Mar 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAxmlf5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E01EBA19;
	Fri, 21 Mar 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548196; cv=none; b=HH8hL4ycaeE9yEXN8cskiTemDnsIg0S7RAe/nagoy9ir4Td+4apQz4hS8vhZmikMkZAbi+pDP7Tsvak6jOGDj7Dj6ltVCYO5vwaDPw5e0rrIEOVLVFDWD5Npjf/ZU9tvCVtppru8eVh/d5QZBaL5cPp22yNTnwsw6x+nJY7lE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548196; c=relaxed/simple;
	bh=AEpVOJojY5LncFCAY2kbkMkameRzofqryfeEZSY750U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz1cuz9wsgyVo4M4PmR4XCfPaHCbgDawCJPsIHEbsdQKjzBvxC9b6aOu/H5hSSUQ7q9zGWntQf5hOoyn1MfSDYneBXOeX5jnI/yZdgh00hktQJcccb4dWHLUT+kBywHv4BNQN+AxFMUjIiTt8DedUbgdyh0RMxEuFwWe22R0lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAxmlf5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1A53C4CEED;
	Fri, 21 Mar 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742548195;
	bh=AEpVOJojY5LncFCAY2kbkMkameRzofqryfeEZSY750U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CAxmlf5Xa/qA7XQ7NMiaqUlpR4pgwlT8RLoasDkn0wFfMEU5taRStXNCd1Ux6azl5
	 rfx+i7od/apmQh954paJ3W9m57w8yck94UpnvCRltsWykTH/ktIi5ar1JrvX2gn8AL
	 6rNRfQekHVNvUAyme14/nu2DMvsQowKh5BA7gUWLw47tl50EGbX4ksMUxZ4PCaATZA
	 ozUq1uo+m7qNMjQ0WNUCfZj20JL8QjmWyrMvJYRx24uf+e4AoY2f2WSH+SLkmYShqw
	 uz3xIxnRhO9H2L1xrYUry7Lro8o2aWDPZfDVBeMHaDfNFwadl4e8yd6OgDPBFUcFJK
	 8YaeNVGm5NPVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40EC36000;
	Fri, 21 Mar 2025 09:09:55 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 21 Mar 2025 13:09:50 +0400
Subject: [PATCH v5 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com>
References: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
In-Reply-To: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742548192; l=2799;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=YO1GatpnBlBF8JPXKfKBWyGdUDfdpI2iVibaLGfHwaM=;
 b=G3ZMTZMovwOmJ7mZJScYzhYZC9yCXFTseqlRVRwFCeheCUNU6QbHC2PW4Cvjf9KPhT96gDouX
 7VWIvwdHuOmCZvZ/YBiZAoP7g+ZwzunvqDtklP/lgmyKKqHmmTo8Noz
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
same as the one found in IPQ5332. As such, add IPQ5018 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 57 +++++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
index e39168d55d23..580651eba864 100644
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
@@ -53,6 +51,49 @@ required:
 
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
+          minItems: 1
+          maxItems: 1
+          items:
+            - description: pcie pipe clock
+        resets:
+          minItems: 2
+          maxItems: 2
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
+          minItems: 2
+          maxItems: 2
+          items:
+            - description: pcie pipe clock
+            - description: pcie ahb clock
+        resets:
+          minItems: 3
+          maxItems: 3
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




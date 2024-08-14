Return-Path: <linux-pci+bounces-11663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AAA951631
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 10:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A871C211F3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77413D51E;
	Wed, 14 Aug 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSJao8xk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77680631;
	Wed, 14 Aug 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622968; cv=none; b=CPICRFGJblRFeR1f7FfBWAsHrgVmje97jq5p6HNnxQu32Uk4ZBOT3TaxKxEL1ljbzf8BaPJpajlfHj5rtbPCWObGUWBOqfln5pFZ0PvLcEWFFyQJ8F8hANDSx/HNxupYiypO3PvG1wr7RLaqkiOSPAexhikPHgNSbPZDiHYbZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622968; c=relaxed/simple;
	bh=xUgTT4UZQWZno0q4oA9LXLY4axIXca9/bjeBODZgaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqHN/2NzpuP6MZMm2y2/Oxm/4E7TmBGx+kHEWB35X7OBo5wIT+orBUHhdeuDVhJrjd6UPLoUfnOSP4bT9pfEA4ZWCrBfEFyDwTnFLdEA3/K7wFs9pM07/NsTB/46aFgjOMEdEjnA+cpbryDUFHCfhN8NlTDVu/G1Ubl1m+drmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSJao8xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3246FC32786;
	Wed, 14 Aug 2024 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723622967;
	bh=xUgTT4UZQWZno0q4oA9LXLY4axIXca9/bjeBODZgaLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSJao8xkJPBsnJNoz9yAArnUASYrqoVeA8Qsdnc4aOMYlWPP7rlL3h7FYn/yy1Q/N
	 4SDYIHfpfvc4cowDFWRLX+mggVM8lyil4fNOt9UMUFxMjka7pTzQFAmYnjbVRbDLMf
	 y1/UuMGZsbsW3dVdoFUbv5KLX1hKlYetJ4yB4ApDOddFnGxLekGY+sqttBnxwh6DAl
	 7VU6wbsY4nSr85yTREi+Dhl89NHQCdgSUBhITioY/cDzz4q1EK3J3TqYk17HDKv5oj
	 cmeYvVtTfZbRq5W82aWDeQuDL4xSF5E41GTDynlLi0+i0pOv/xovDLINZfuPWsxDpr
	 kyqHVd4YZFdpA==
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: PCI: microchip,pcie-host: fix reg properties
Date: Wed, 14 Aug 2024 09:08:41 +0100
Message-ID: <20240814-confront-race-a72c0c91db56@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814-setback-rumbling-c6393c8f1a91@spud>
References: <20240814-setback-rumbling-c6393c8f1a91@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3754; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=36Qs8DsS42oBryO2V1EoOkd8WWqDLIunp3TI9Trqzac=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl70jg4A+NkD5wJDH3s1u6qyP2G60pfj0LCz18sCeXP7 Wb1i6p3lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCJ3vjIyNAjN4jXU2dGq9nGp jOcG9tmcf9vXMC7gNOCuyHN6/PeQKiPDB4XjxeJWS/1ZJlnpuLtuL0raVt68VCPPslhc3j/IXIU TAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The PCI host controller on PolarFire SoC has multiple "instances", each
with their own bridge and ctrl address spaces. The original binding has
an "apb" register region, and it is expected to be set to the base
address of the host controllers register space. Some defines in the
Linux driver were used to compute the addresses of the bridge and ctrl
address ranges corresponding to instance1. Some customers want to use
instance2 however and that requires changing the defines in the driver,
which is clearly not a portable solution.

Remove this "apb" register region from the binding and add "bridge" &
"ctrl" regions instead, that will directly communicate the address of
these regions

Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/pci/microchip,pcie-host.yaml          | 11 +++++++++--
 .../bindings/pci/plda,xpressrich3-axi-common.yaml  | 14 ++++++++++----
 .../bindings/pci/starfive,jh7110-pcie.yaml         |  7 +++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 612633ba59e2..2e1547569702 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -17,6 +17,12 @@ properties:
   compatible:
     const: microchip,pcie-host-1.0 # PolarFire
 
+  reg:
+    minItems: 3
+
+  reg-names:
+    minItems: 3
+
   clocks:
     description:
       Fabric Interface Controllers, FICs, are the interface between the FPGA
@@ -62,8 +68,9 @@ examples:
             pcie0: pcie@2030000000 {
                     compatible = "microchip,pcie-host-1.0";
                     reg = <0x0 0x70000000 0x0 0x08000000>,
-                          <0x0 0x43000000 0x0 0x00010000>;
-                    reg-names = "cfg", "apb";
+                          <0x0 0x43008000 0x0 0x00002000>,
+                          <0x0 0x4300a000 0x0 0x00002000>;
+                    reg-names = "cfg", "bridge", "ctrl";
                     device_type = "pci";
                     #address-cells = <3>;
                     #size-cells = <2>;
diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
index 7a57a80052a0..039eecdbd6aa 100644
--- a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
+++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
@@ -18,12 +18,18 @@ allOf:
 
 properties:
   reg:
-    maxItems: 2
+    maxItems: 3
+    minItems: 2
 
   reg-names:
-    items:
-      - const: cfg
-      - const: apb
+    oneOf:
+      - items:
+          - const: cfg
+          - const: apb
+      - items:
+          - const: cfg
+          - const: bridge
+          - const: ctrl
 
   interrupts:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
index 67151aaa3948..5f432452c815 100644
--- a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
@@ -16,6 +16,13 @@ properties:
   compatible:
     const: starfive,jh7110-pcie
 
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
+
   clocks:
     items:
       - description: NOC bus clock
-- 
2.43.0



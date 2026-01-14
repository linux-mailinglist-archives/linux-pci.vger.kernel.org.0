Return-Path: <linux-pci+bounces-44752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256CD1FE00
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00BBC30C6847
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26E39E16C;
	Wed, 14 Jan 2026 15:36:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9030EF6F;
	Wed, 14 Jan 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404972; cv=none; b=JrvBfuYtVfly5Avo+E3TgxGxfsZij9Rt8k3Otkh8wwibEe/VR8bW4UexIcvj84ak4jhgeWd6fnuXWdsWVsWKEgzcQKaBLmM7Q7CL65z1I+xL+xnA1e/BcLXA7EmBvrd9j5XxusYi4r+Foj/c8R99WnmxlPbokmr4GAoHZNCksOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404972; c=relaxed/simple;
	bh=vvui3AZFKc3NTruMpsk2C5aluN2CrRaZCRDjVkJfpjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osmly2fnq6lJaa0E5vQ9sfCbiCAzBXrMwIWva9BHYg2SnSXjlNBJklqHLdsprhjIHMU8y2Zw9CP4n7+roUiKFLMaAJ/T/mZ9c+CRYBPM7maMGcPtWB/4pcqedQDFCmWUczclZyAafaDbSEcY+rDorPOCNPDQOTlF7Xeg4rt49vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 5J2bL7qFS/+sBGryXnDSNw==
X-CSE-MsgGUID: kXX2nxevRt+qM7zH5XFmuw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:09 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8C04B4022B3E;
	Thu, 15 Jan 2026 00:36:03 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 05/16] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
Date: Wed, 14 Jan 2026 16:33:26 +0100
Message-ID: <20260114153337.46765-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the existing device tree bindings for Renesas RZ/G3S PCIe
controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie) PCIe
controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has some key
differences:

 - Uses a different device ID
 - Supports PCIe Gen3 (8.0 GT/s) link speeds
 - Uses a different clock naming (clkpmu vs clkl1pm)
 - Has a different set of interrupts, interrupt ordering, and reset signals

Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 243 +++++++++++++-----
 1 file changed, 172 insertions(+), 71 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index d668782546a2..c68bc76af35d 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -10,85 +10,34 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 
 description:
-  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
-  4.0 and supports up to 5 GT/s (Gen2).
+  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
+  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
+  up to 8 GT/s (Gen3) for RZ/G3E.
 
 properties:
   compatible:
-    const: renesas,r9a08g045-pcie # RZ/G3S
+    enum:
+      - renesas,r9a08g045-pcie # RZ/G3S
+      - renesas,r9a09g047-pcie # RZ/G3E
 
   reg:
     maxItems: 1
 
-  interrupts:
-    items:
-      - description: System error interrupt
-      - description: System error on correctable error interrupt
-      - description: System error on non-fatal error interrupt
-      - description: System error on fatal error interrupt
-      - description: AXI error interrupt
-      - description: INTA interrupt
-      - description: INTB interrupt
-      - description: INTC interrupt
-      - description: INTD interrupt
-      - description: MSI interrupt
-      - description: Link bandwidth interrupt
-      - description: PME interrupt
-      - description: DMA interrupt
-      - description: PCIe event interrupt
-      - description: Message interrupt
-      - description: All interrupts
-
-  interrupt-names:
-    items:
-      - description: serr
-      - description: ser_cor
-      - description: serr_nonfatal
-      - description: serr_fatal
-      - description: axi_err
-      - description: inta
-      - description: intb
-      - description: intc
-      - description: intd
-      - description: msi
-      - description: link_bandwidth
-      - description: pm_pme
-      - description: dma
-      - description: pcie_evt
-      - description: msg
-      - description: all
+  interrupts: true
+
+  interrupt-names: true
 
   interrupt-controller: true
 
   clocks:
-    items:
-      - description: System clock
-      - description: PM control clock
+    maxItems: 2
 
   clock-names:
-    items:
-      - description: aclk
-      - description: pm
-
-  resets:
-    items:
-      - description: AXI2PCIe Bridge reset
-      - description: Data link layer/transaction layer reset
-      - description: Transaction layer (ACLK domain) reset
-      - description: Transaction layer (PCLK domain) reset
-      - description: Physical layer reset
-      - description: Configuration register reset
-      - description: Configuration register reset
-
-  reset-names:
-    items:
-      - description: aresetn
-      - description: rst_b
-      - description: rst_gp_b
-      - description: rst_ps_b
-      - description: rst_rsm_b
-      - description: rst_cfg_b
-      - description: rst_load_b
+    maxItems: 2
+
+  resets: true
+
+  reset-names: true
 
   power-domains:
     maxItems: 1
@@ -128,11 +77,12 @@ patternProperties:
         const: 0x1912
 
       device-id:
-        const: 0x0033
+        enum:
+          - 0x0033
+          - 0x0039
 
       clocks:
-        items:
-          - description: Reference clock
+        maxItems: 1
 
       clock-names:
         items:
@@ -142,8 +92,6 @@ patternProperties:
       - device_type
       - vendor-id
       - device-id
-      - clocks
-      - clock-names
 
     unevaluatedProperties: false
 
@@ -167,6 +115,159 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-pcie
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: System error interrupt
+            - description: System error on correctable error interrupt
+            - description: System error on non-fatal error interrupt
+            - description: System error on fatal error interrupt
+            - description: AXI error interrupt
+            - description: INTA interrupt
+            - description: INTB interrupt
+            - description: INTC interrupt
+            - description: INTD interrupt
+            - description: MSI interrupt
+            - description: Link bandwidth interrupt
+            - description: PME interrupt
+            - description: DMA interrupt
+            - description: PCIe event interrupt
+            - description: Message interrupt
+            - description: All interrupts
+        interrupt-names:
+          items:
+            - const: serr
+            - const: serr_cor
+            - const: serr_nonfatal
+            - const: serr_fatal
+            - const: axi_err
+            - const: inta
+            - const: intb
+            - const: intc
+            - const: intd
+            - const: msi
+            - const: link_bandwidth
+            - const: pm_pme
+            - const: dma
+            - const: pcie_evt
+            - const: msg
+            - const: all
+        clocks:
+          items:
+            - description: System clock
+            - description: PM control clock
+        clock-names:
+          items:
+            - const: aclk
+            - const: pm
+        resets:
+          items:
+            - description: AXI2PCIe Bridge reset
+            - description: Data link layer/transaction layer reset
+            - description: Transaction layer (ACLK domain) reset
+            - description: Transaction layer (PCLK domain) reset
+            - description: Physical layer reset
+            - description: Configuration register reset
+            - description: Configuration register reset
+        reset-names:
+          items:
+            - const: aresetn
+            - const: rst_b
+            - const: rst_gp_b
+            - const: rst_ps_b
+            - const: rst_rsm_b
+            - const: rst_cfg_b
+            - const: rst_load_b
+      patternProperties:
+        "^pcie@0,[0-0]$":
+          properties:
+            device-id:
+              const: 0x0033
+          required:
+            - clocks
+            - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-pcie
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: All interrupts
+            - description: INTA interrupt
+            - description: INTB interrupt
+            - description: INTC interrupt
+            - description: INTD interrupt
+            - description: MSI interrupt
+            - description: Link bandwidth interrupt
+            - description: Link equalization request interrupt
+            - description: PME interrupt
+            - description: System error interrupt
+            - description: System error on correctable error interrupt
+            - description: System error on non-fatal error interrupt
+            - description: System error on fatal error interrupt
+            - description: DMA interrupt
+            - description: PCIe event interrupt
+            - description: AXI error interrupt
+            - description: Message interrupt
+            - description: Turn off event interrupt
+            - description: PMU power off interrupt
+            - description: D3 event function 0 interrupt
+            - description: D3 event function 1 interrupt
+            - description: Configuration PMCSR write clear function 0 interrupt
+            - description: Configuration PMCSR write clear function 1 interrupt
+        interrupt-names:
+          items:
+            - const: all
+            - const: inta
+            - const: intb
+            - const: intc
+            - const: intd
+            - const: msi
+            - const: link_bandwidth
+            - const: link_equalization_request
+            - const: pm_pme
+            - const: serr
+            - const: serr_cor
+            - const: serr_nonfatal
+            - const: serr_fatal
+            - const: dma
+            - const: pcie_evt
+            - const: axi_err
+            - const: msg
+            - const: turn_off_event
+            - const: pmu_poweroff
+            - const: d3_event_f0
+            - const: d3_event_f1
+            - const: cfg_pmcsr_writeclear_f0
+            - const: cfg_pmcsr_writeclear_f1
+        clocks:
+          items:
+            - description: System clock
+            - description: PMU clock
+        clock-names:
+          items:
+            - const: aclk
+            - const: pmu
+        resets:
+          items:
+            - description: AXI2PCIe Bridge reset
+        reset-names:
+          items:
+            - const: aresetn
+      patternProperties:
+        "^pcie@0,[0-0]$":
+          properties:
+            device-id:
+              const: 0x0039
 
 unevaluatedProperties: false
 
-- 
2.25.1



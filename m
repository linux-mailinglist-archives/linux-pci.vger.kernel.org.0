Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14FC5460D4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiFJJFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiFJJE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:04:56 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9683A1116FE;
        Fri, 10 Jun 2022 02:04:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id EB6C516C7;
        Fri, 10 Jun 2022 11:58:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com EB6C516C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851489;
        bh=KQRGL/XPxlRYl4cYVwRo4mgR2jl0BfcuH+fJxdVq07g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=M30PS9MQvN9kCwN/1+Mc3uH+xi3qKWwjvrzNRyhvvBVWaSkrRZJRcWcB2KyE+0/Rq
         kyR3I6AJ94MBXfyC0p5onO6zuQSFXnUJ6qulsdexyRRkol6yrQtksjFuVUuneK4sfU
         AFzK6gN4Z4LePCbmZqNuYnQNBjR7Nb8HHnpsPnfo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:16 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH v3 09/17] dt-bindings: PCI: dwc: Add clocks/resets common properties
Date:   Fri, 10 Jun 2022 11:56:57 +0300
Message-ID: <20220610085706.15741-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DW PCIe RP/EP reference manuals explicit define all the clocks and reset
requirements in [1] and [2]. Seeing the DW PCIe vendor-specific
DT-bindings have already started assigning random names to the same set of
the clocks and resets lines, let's define a generic names sets and add
them to the DW PCIe definitions in the common DT-schema. These definitions
will be used in the generic DW PCIe DT-schema and can be referenced in the
particular DW PCIe DT-bindings if they are compatible with them, otherwise
the platforms can be left with already defined clocks/resets properties.

[1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Root Port, Version 5.40a, March 2019, p.55 - 78.
[2] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Endpoint, Version 5.40a, March 2019, p.58 - 81.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
- Drop synonymous from the names list since the device schemas create
  their own enumerations anyway.
---
 .../bindings/pci/samsung,exynos-pcie.yaml     |   3 +-
 .../bindings/pci/snps,dw-pcie-common.yaml     | 100 ++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  26 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  20 +++-
 .../pci/socionext,uniphier-pcie-ep.yaml       |   3 +-
 5 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
index 445eed94b53f..fedb774938f4 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -16,7 +16,8 @@ description: |+
   snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index c6a55f90ddd5..f22fb01c9bd0 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -58,6 +58,36 @@ properties:
     minItems: 1
     maxItems: 26
 
+  clocks:
+    description:
+      DWC PCIe reference manual explicitly defines a set of the clocks required
+      to get the controller working correctly. In general all of them can
+      be divided into two groups':' application and core clocks. Note the
+      platforms may have some of the clock sources unspecified in case if the
+      corresponding domains are fed up from a common clock source.
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+
+  resets:
+    description:
+      DWC PCIe reference manual explicitly defines a set of the reset
+      signals required to be de-asserted to properly activate the controller
+      sub-parts. All of these signals can be divided into two sub-groups':'
+      application and core resets with respect to the main sub-domains they
+      are supposed to reset. Note the platforms may have some of these signals
+      unspecified in case if they are automatically handled or aggregated into
+      a comprehensive control module.
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+
   phys:
     description:
       There can be up to the number of possible lanes PHYs specified.
@@ -218,4 +248,74 @@ definitions:
           uncorrectable error.
         const: sft_ue
 
+  clock-names:
+    description:
+      Reference clock names common for the DWC PCIe Root Port and Endpoint
+      controllers.
+    anyOf:
+      - description:
+          Data Bus Interface (DBI) clock. Clock signal for the AXI-bus
+          interface of the Configuration-Dependent Module, which is
+          basically the set of the controller CSRs.
+        const: dbi
+      - description:
+          Application AXI-bus Master interface clock. Basically this is
+          a clock for the controller DMA interface (PCI-to-CPU).
+        const: mstr
+      - description:
+          Application AXI-bus Slave interface clock. This is a clock for
+          the CPU-to-PCI memory IO interface.
+        const: slv
+      - description:
+          Controller Core-PCS PIPE interface clock. It's normally
+          supplied by an external PCS-PHY.
+        const: pipe
+      - description:
+          Controller Primary clock. It's assumed that all controller input
+          signals (except resets) are synchronous to this clock.
+        const: core
+      - description:
+          Auxiliary clock for the controller PMC domain. The controller
+          partitioning implies having some parts to operate with this
+          clock in some power management states.
+        const: aux
+      - description:
+          Generic reference clock. In case if there are several
+          interfaces fed up with a common clock source it's advisable to
+          define it with this name (for instance pipe, core and aux can
+          be connected to a single source of the periodic signal).
+        const: ref
+      - description:
+          Clock for the PHY registers interface. Originally this is
+          a PHY-viewport-based interface, but some platform may have
+          specifically designed one.
+        const: phy_reg
+
+  reset-names:
+    description:
+      Reset signal names common for the DWC PCIe Root Port and Endpoint
+      controllers.
+    anyOf:
+      - description: Data Bus Interface (DBI) domain reset
+        const: dbi
+      - description: AXI-bus Master interface reset
+        const: mstr
+      - description: AXI-bus Slave interface reset
+        const: slv
+      - description: Controller Non-sticky CSR flags reset
+        const: non-sticky
+      - description: Controller sticky CSR flags reset
+        const: sticky
+      - description: PIPE-interface (Core-PCS) logic reset
+        const: pipe
+      - description:
+          Controller primary reset (resets everything except PMC module)
+        const: core
+      - description: PCS/PHY block reset
+        const: phy
+      - description: PMC hot reset signal
+        const: hot
+      - description: Cold reset signal
+        const: pwr
+
 ...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index bfff723b529d..bb7e4381d392 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -74,6 +74,26 @@ properties:
     items:
       $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
 
+  clocks:
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+    items:
+      $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/clock-names
+
+  resets:
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reset-names
+
   max-functions:
     maximum: 32
 
@@ -109,6 +129,12 @@ examples:
       interrupts = <23>, <24>;
       interrupt-names = "dma0", "dma1";
 
+      clocks = <&sys_clk 12>, <&sys_clk 24>;
+      clock-names = "dbi", "ref";
+
+      resets = <&sys_rst 12>, <&sys_rst 24>;
+      reset-names = "dbi", "phy";
+
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 9e96c6d0ef48..518fa5626c11 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -78,7 +78,25 @@ properties:
       - contains:
           const: msi
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 7
+
+  clock-names:
+    minItems: 1
+    maxItems: 7
+    items:
+      $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/clock-names
+
+  resets:
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reset-names
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 1719a36952c0..8c2a8e8f96f9 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -16,7 +16,8 @@ maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 allOf:
-  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+  - $ref: /schemas/pci/pci-ep.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
-- 
2.35.1


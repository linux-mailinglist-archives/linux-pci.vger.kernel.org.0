Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0459C70D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiHVSst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiHVSsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:09 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 009C8BF48;
        Mon, 22 Aug 2022 11:47:44 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B851DDAE;
        Mon, 22 Aug 2022 21:50:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B851DDAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194248;
        bh=gdmZ897S3WcwRIKZy2b9JSuwJqubLSkOmymSDRv/5JA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=j5ZWmW2n9AKTyMTUaYM9Y5tevLaNmXRE/Lw1ag7OH2pd0WkCCEZuUFzp5bMExAOpF
         NxK2kJlU8Cn4WPtMoh5YI8wXKCj7vU5HMPc0DcnSUBliq2eRxG+M1NVLCYcHM1Mbnn
         2h/MV2zbFC4xvn0T/mIWFgwlVQCwGD7vdE/fyaQw=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 11/20] dt-bindings: PCI: dwc: Add clocks/resets common properties
Date:   Mon, 22 Aug 2022 21:46:52 +0300
Message-ID: <20220822184701.25246-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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

Note since there are DW PCI-based vendor-specific DT-bindings with the
custom names assigned to the same clocks and resets resources we have no
much choice but to add them to the generic DT-schemas in order to have the
schemas being applicable for such devices. Let's mark these names as
deprecated so not to encourage the new DT-bindings to use them.

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

Changelog v5:
- Add platform-specific clock/reset names, but mark them as deprecated.
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 100 ++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  40 +++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  42 +++++++-
 3 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index e48028bc98c8..4fa027e6fd99 100644
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
       There can be up to the number of possible lanes PHYs specified placed in
@@ -222,4 +252,74 @@ definitions:
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
index 68bf8de057d6..867eaf91a297 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -68,6 +68,40 @@ properties:
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
+      oneOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/clock-names
+        - deprecated: true
+          oneOf:
+            - description: See native 'ref' clock for details.
+              enum: [ gio ]
+            - description: See native 'pipe' clock for details
+              enum: [ link ]
+
+  resets:
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      oneOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reset-names
+        - deprecated: true
+          oneOf:
+            - description: See native 'core' reset for details
+              enum: [ gio ]
+            - description: See native 'phy' reset for details
+              enum: [ link ]
+
   max-functions:
     maximum: 32
 
@@ -103,6 +137,12 @@ examples:
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
index 83a838c6f8b5..d0e09c3001ef 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -78,7 +78,47 @@ properties:
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
+      oneOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/clock-names
+        - deprecated: true
+          oneOf:
+            - description: See native 'dbi' clock for details
+              enum: [ pcie, pcie_apb_sys, aclk_dbi ]
+            - description: See native 'mstr/slv' clock for details
+              enum: [ pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
+            - description: See native 'pipe' clock for details
+              enum: [ pcie_phy, pcie_phy_ref ]
+            - description: See native 'aux' clock for details
+              enum: [ pcie_aux ]
+            - description: See nativs 'phy_reg' clock for details
+              enum: [ pcie_apb_phy, pclk ]
+
+  resets:
+    minItems: 1
+    maxItems: 10
+
+  reset-names:
+    minItems: 1
+    maxItems: 10
+    items:
+      oneOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reset-names
+        - deprecated: true
+          oneOf:
+            - description: See native 'core' reset for details
+              enum: [ apps ]
+            - description: See native 'phy' reset for details
+              enum: [ pciephy ]
+            - description: See native 'pwr' reset for details
+              enum: [ turnoff ]
 
 additionalProperties: true
 
-- 
2.35.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7C627211
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiKMTPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiKMTPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:15:04 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F9ADFD8;
        Sun, 13 Nov 2022 11:14:57 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 59640E0EA0;
        Sun, 13 Nov 2022 22:14:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Jaqf1p3XjP87cfYtMu+/D5VUwXDYEXyFY9bF6X/lGp8=; b=VI7+wh/Vh7eR
        JNsPm7Wf5wnC4T1UQryVv1L3i9bnDWqPGpvLOnMtypkO7depWXO8INnA/BVpZ9uo
        P3E3jhPazDi9N3/AyNF/8h9o/d70pYaYyOnm3Vc1oeqAkmSZJl08UduwNAdhZLp/
        xB9MjkW6W9olRlTn6lQDGRR4dusmY/I=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4A48DE0E6A;
        Sun, 13 Nov 2022 22:14:56 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 11/20] dt-bindings: PCI: dwc: Add clocks/resets common properties
Date:   Sun, 13 Nov 2022 22:12:52 +0300
Message-ID: <20221113191301.5526-12-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DW PCIe RP/EP reference manuals explicit define all the clocks and reset
requirements in [1] and [2]. Seeing the DW PCIe vendor-specific
DT-bindings have already started assigning random names to the same set of
the clocks and resets lines, let's define a generic names sets and add
them to the DW PCIe common DT-schema.

Note since there are DW PCI-based vendor-specific DT-bindings with the
custom names assigned to the same clocks and resets resources we have no
much choice but to add them to the generic DT-schemas in order to have the
schemas being applicable for such devices. These names are marked as
vendor-specific and should be avoided being used in new bindings in favor
of the generic names.

[1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Root Port, Version 5.40a, March 2019, p.55 - 78.
[2] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
Endpoint, Version 5.40a, March 2019, p.58 - 81.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
- Drop synonymous from the names list since the device schemas create
  their own enumerations anyway.

Changelog v5:
- Add platform-specific clock/reset names, but mark them as deprecated.

Changelog v6:
- Move the common *-names definitions to the RP/EP schemas. Thus drop
  the 'definitions' property. (@Rob)
- Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 120 ++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |   6 +
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 -
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 13c41cd50e54..4d9efcea3859 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -58,6 +58,126 @@ properties:
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
+    items:
+      oneOf:
+        - description:
+            Data Bus Interface (DBI) clock. Clock signal for the AXI-bus
+            interface of the Configuration-Dependent Module, which is
+            basically the set of the controller CSRs.
+          const: dbi
+        - description:
+            Application AXI-bus Master interface clock. Basically this is
+            a clock for the controller DMA interface (PCI-to-CPU).
+          const: mstr
+        - description:
+            Application AXI-bus Slave interface clock. This is a clock for
+            the CPU-to-PCI memory IO interface.
+          const: slv
+        - description:
+            Controller Core-PCS PIPE interface clock. It's normally
+            supplied by an external PCS-PHY.
+          const: pipe
+        - description:
+            Controller Primary clock. It's assumed that all controller input
+            signals (except resets) are synchronous to this clock.
+          const: core
+        - description:
+            Auxiliary clock for the controller PMC domain. The controller
+            partitioning implies having some parts to operate with this
+            clock in some power management states.
+          const: aux
+        - description:
+            Generic reference clock. In case if there are several
+            interfaces fed up with a common clock source it's advisable to
+            define it with this name (for instance pipe, core and aux can
+            be connected to a single source of the periodic signal).
+          const: ref
+        - description:
+            Clock for the PHY registers interface. Originally this is
+            a PHY-viewport-based interface, but some platform may have
+            specifically designed one.
+          const: phy_reg
+        - description:
+            Vendor-specific clock names. Consider using the generic names
+            above for new bindings.
+          oneOf:
+            - description: See native 'dbi' clock for details
+              enum: [ pcie, pcie_apb_sys, aclk_dbi ]
+            - description: See native 'mstr/slv' clock for details
+              enum: [ pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
+            - description: See native 'pipe' clock for details
+              enum: [ pcie_phy, pcie_phy_ref, link ]
+            - description: See native 'aux' clock for details
+              enum: [ pcie_aux ]
+            - description: See native 'ref' clock for details.
+              enum: [ gio ]
+            - description: See nativs 'phy_reg' clock for details
+              enum: [ pcie_apb_phy, pclk ]
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
+    items:
+      oneOf:
+        - description: Data Bus Interface (DBI) domain reset
+          const: dbi
+        - description: AXI-bus Master interface reset
+          const: mstr
+        - description: AXI-bus Slave interface reset
+          const: slv
+        - description: Application-dependent interface reset
+          const: app
+        - description: Controller Non-sticky CSR flags reset
+          const: non-sticky
+        - description: Controller sticky CSR flags reset
+          const: sticky
+        - description: PIPE-interface (Core-PCS) logic reset
+          const: pipe
+        - description:
+            Controller primary reset (resets everything except PMC module)
+          const: core
+        - description: PCS/PHY block reset
+          const: phy
+        - description: PMC hot reset signal
+          const: hot
+        - description: Cold reset signal
+          const: pwr
+        - description:
+            Vendor-specific reset names. Consider using the generic names
+            above for new bindings.
+          oneOf:
+            - description: See native 'app' reset for details
+              enum: [ apps, gio, apb ]
+            - description: See native 'phy' reset for details
+              enum: [ pciephy, link ]
+            - description: See native 'pwr' reset for details
+              enum: [ turnoff ]
+
   phys:
     description:
       There can be up to the number of possible lanes PHYs specified placed in
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index f4d7eb2dec4d..8fc2151691a4 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -180,6 +180,12 @@ examples:
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
index 59d3bbb5883a..c62c8fe517ae 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -195,8 +195,6 @@ properties:
       - contains:
           const: msi
 
-  clocks: true
-
 additionalProperties: true
 
 required:
-- 
2.38.1



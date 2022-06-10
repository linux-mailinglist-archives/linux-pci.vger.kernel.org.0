Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5265460F6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348546AbiFJJGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiFJJF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:05:59 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C4CE939C0;
        Fri, 10 Jun 2022 02:04:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B77A716B0;
        Fri, 10 Jun 2022 11:58:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B77A716B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851487;
        bh=veDlcRl7jIs2ROxKcxQDckuVHRbp1wddq59lNB/vP+U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=PWsV6xH81nTJZxyFcq3QsEg7Xe/OAdjIlNgWNSDW/xVU7Yx3blbvW9MUBlIyxfCqt
         xOjhWgOP1AY09AGXZrOjl3emNCoxBBlAUF3BMHIGkg3EjF5vnwqmfUhQn87pjSlWDB
         jDz5FV3LiEDfv29nrbJS7WFgmNT+lT88kQnsuZAY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/17] dt-bindings: PCI: dwc: Add reg/reg-names common properties
Date:   Fri, 10 Jun 2022 11:56:56 +0300
Message-ID: <20220610085706.15741-9-Sergey.Semin@baikalelectronics.ru>
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

Even though there is a more-or-less limited set of the CSR spaces can be
defined for each DW PCIe controller the generic DT schema currently
doesn't specify much limitations on the reg-space names used for one or
another range. In order to prevent the vendor-specific controller schemas
further deviation from the generic interface let's fix that by introducing
the reg-names definition in the common DW PCIe DT-schema and preserving a
generic "reg" and "reg-names" properties in there. New DW PCIe device
DT-bindings are encouraged to use the generic set of the CSR spaces
defined in the generic DW PCie DT-bindings, while the already available
vendor-specific DT-bindings can refer to the common schema and define
their own reg-spaces.

Note the number of reg/reg-names items need to be changed in the DW PCIe
EP DT-schema since aside with the "dbi" CSRs space these arrays can
have "dbi2", "addr_space", "atu", etc ranges.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
- Split up reg-names in the same way as the interrupt-names: common,
  Root Port and Endpoint specific names. (@Rob)
- Drop synonymous from the names list since the device schemas create
  their own enumerations anyway.
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 76 +++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 34 +++++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 27 +++++--
 3 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 0a524e916a9f..c6a55f90ddd5 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -17,6 +17,28 @@ description:
 select: false
 
 properties:
+  reg:
+    description:
+      DWC PCIe CSR space is normally accessed over the dedicated Data Bus
+      Interface - DBI. In accordance with the reference manual the register
+      configuration space belongs to the Configuration-Dependent Module (CDM)
+      and is split up into several sub-parts Standard PCIe configuration
+      space, Port Logic Registers (PL), Shadow Config-space Registers,
+      iATU/eDMA registers. The particular sub-space is selected by the
+      CDM/ELBI (dbi_cs) and CS2 (dbi_cs2) signals (selector bits). Such
+      configuration provides a flexible interface for the system engineers to
+      either map the particular space at a desired MMIO address or just leave
+      them in a contiguous memory space if pure Native or AXI Bridge DBI access
+      is selected. Note the PCIe CFG-space, PL and Shadow registers are
+      specific for each activated function, while the rest of the sub-spaces
+      are common for all of them (if there are more than one).
+    minItems: 2
+    maxItems: 6
+
+  reg-names:
+    minItems: 2
+    maxItems: 6
+
   interrupts:
     description:
       There are two main sub-blocks which are normally capable of
@@ -111,6 +133,60 @@ properties:
 additionalProperties: true
 
 definitions:
+  reg-names:
+    description:
+      CSR space names common for the DWC PCIe Root Port and Endpoint
+      controllers.
+    oneOf:
+      - description:
+          Basic DWC PCIe controller configuration-space accessible over
+          the DBI interface. This memory space is either activated with
+          CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region
+          with all spaces. Note iATU/eDMA CSRs are indirectly accessible
+          via the PL viewports on the DWC PCIe controllers older than
+          v4.80a.
+        const: dbi
+      - description:
+          Shadow DWC PCIe config-space registers. This space is selected
+          by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of
+          the PCI-SIG PCIe CFG-space with the shadow registers for some
+          PCI Header space, PCI Standard and Extended Structures. It's
+          mainly relevant for the end-point controller configuration,
+          but still there are some shadow registers available for the
+          Root Port mode too.
+        const: dbi2
+      - description:
+          External Local Bus registers. It's an application-dependent
+          registers normally defined by the platform engineers. The space
+          can be selected by setting CDM/ELBI = 1 and CS2 = 0 wires or can
+          be accessed over some platform-specific means (for instance
+          as a part of a system controller).
+        enum: [ elbi, app ]
+      - description:
+          iATU/eDMA registers common for all device functions. It's an
+          unrolled memory space with the internal Address Translation
+          Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1
+          and CS2 = 1. For IP-core releases prior v4.80a, these registers
+          have been programmed via an indirect addressing scheme using a
+          set of viewport CSRs mapped into the PL space. Note iATU is
+          normally mapped to the 0x0 address of this region, while eDMA
+          is available at 0x80000 base address.
+        const: atu
+      - description:
+          Platform-specific eDMA registers. Some platforms may have eDMA
+          CSRs mapped in a non-standard base address. The registers offset
+          can be changed or the MS/LS-bits of the address can be attached
+          in an additional RTL block before the MEM-IO transactions reach
+          the DW PCIe slave interface.
+        const: dma
+      - description:
+          PHY/PCS configuration registers. Some platforms can have the
+          PCS and PHY CSRs accessible over a dedicated memory mapped
+          region, but mainly these registers are indirectly accessible
+          either by means of the embedded PHY viewport schema or by some
+          platform-specific method.
+        const: phy
+
   interrupt-names:
     description:
       IRQ signal names common for the DWC PCIe Root Port and Endpoint
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 5f12a6ac08d8..bfff723b529d 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -40,18 +40,25 @@ properties:
           const: snps,dw-pcie-ep
 
   reg:
-    description: |
-      It should contain Data Bus Interface (dbi) and config registers for all
-      versions.
-      For designware core version >= 4.80, it may contain ATU address space.
+    description:
+      DBI, DBI2 reg-spaces and outbound memory window are required for the
+      normal controller functioning. iATU memory IO region is also required
+      if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
-    maxItems: 4
+    maxItems: 5
 
   reg-names:
     minItems: 2
-    maxItems: 4
+    maxItems: 5
     items:
-      enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
+      anyOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reg-names
+        - $ref: '#/definitions/reg-names'
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: addr_space
 
   interrupts:
     description:
@@ -77,6 +84,19 @@ required:
 
 additionalProperties: true
 
+definitions:
+  reg-names:
+    description:
+      DWC PCIe Endpoint specific CSR space names.
+    oneOf:
+      - description:
+          Outbound iATU-capable memory-region which will be used to
+          generate various application-specific traffic on the PCIe bus
+          hierarchy. It's usage scenario depends on the endpoint
+          functionality, for instance it can be used to create MSI(X)
+          messages.
+        const: addr_space
+
 examples:
   - |
     pcie-ep@dfd00000 {
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index e0020b72288a..9e96c6d0ef48 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -40,10 +40,10 @@ properties:
           const: snps,dw-pcie
 
   reg:
-    description: |
-      It should contain Data Bus Interface (dbi) and config registers for all
-      versions.
-      For designware core version >= 4.80, it may contain ATU address space.
+    description:
+      At least DBI reg-space and peripheral devices CFG-space outbound window
+      are required for the normal controller work. iATU memory IO region is
+      also required if the space is unrolled (IP-core version >= 4.80a).
     minItems: 2
     maxItems: 5
 
@@ -51,8 +51,14 @@ properties:
     minItems: 2
     maxItems: 5
     items:
-      enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu, apb, phy ]
+      anyOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/reg-names
+        - $ref: '#/definitions/reg-names'
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: config
 
   interrupts:
     description:
@@ -82,6 +88,15 @@ required:
   - reg-names
 
 definitions:
+  reg-names:
+    description:
+      DWC PCIe Root Port/Complex specific CSR space names.
+    oneOf:
+      - description:
+          Outbound iATU-capable memory-region which will be used to access
+          the peripheral PCIe devices configuration space.
+        const: config
+
   interrupt-names:
     description:
       DWC PCIe Root Port/Complex specific IRQ signal names.
-- 
2.35.1


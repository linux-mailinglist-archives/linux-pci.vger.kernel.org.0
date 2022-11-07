Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED9C620075
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiKGVKk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiKGVKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:23 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77F042E9FE;
        Mon,  7 Nov 2022 13:07:21 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BBD89E0EBE;
        Mon,  7 Nov 2022 23:50:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=mo5sTg4ej3YEE6ZtonzVJt/tH0+N7EC/Uv1zxfzBxXM=; b=NgIwwUMuYlZr
        BnVbeoVt7EudEeVFT5oGCzAzLEW+cKT9MgkuLz8AUy91GzJBM+sIPyhRUgL5qXbR
        TViJX3bx5Ck1WUYwRvKUxQolJ23pz1UqnSI7M5fUFPienen9Frz5/BNUFwL+ChOD
        nQm6pk5NqO9mqlLnOOQ/HcajM+cDVWI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AB032E0E1D;
        Mon,  7 Nov 2022 23:50:16 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:16 +0300
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
Subject: [PATCH v6 10/20] dt-bindings: PCI: dwc: Add reg/reg-names common properties
Date:   Mon, 7 Nov 2022 23:49:24 +0300
Message-ID: <20221107204934.32655-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
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

Even though there is a more-or-less limited set of the CSR spaces can be
defined for each DW PCIe controller the generic DT-schema currently
doesn't specify much limitations on the reg-space names used for one or
another range. In order to prevent the vendor-specific controller schemas
further deviation from the generic interface let's fix that by introducing
the reg-names definition in the common DW PCIe DT-schemas and preserving
the generic "reg" and "reg-names" properties in there. New DW PCIe device
DT-bindings are encouraged to use the generic set of the CSR spaces
defined in the generic DW PCIe RP/EP DT-bindings, while the already
available vendor-specific DT-bindings can still apple the common
DT-schemas.

Note the number of reg/reg-names items need to be changed in the DW PCIe
EP DT-schema since aside with the "dbi" CSRs space these arrays can have
"dbi2", "addr_space", "atu", etc ranges.

Also note since there are DW PCIe-based vendor-specific DT-bindings with
the custom names assigned to the same CSR resources we have no much choice
but to add them to the generic DT-schemas in order to have the schemas
being applicable for such devices. These names are marked as
vendor-specific and should be avoided being used in new bindings in favor
of the generic names.

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

Changelog v5:
- Add platform-specific reg names, but mark them as deprecated.

Changelog v6:
- Move the common reg-names definitions to the RP/EP schemas. Thus drop
  the 'definitions' property. (@Rob)
- Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 22 +++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 82 +++++++++++++++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 78 ++++++++++++++++--
 3 files changed, 169 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 4646fb14e817..13c41cd50e54 100644
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
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 7d3f8fc8b7b4..f4d7eb2dec4d 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -28,18 +28,86 @@ allOf:
 
 properties:
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
+      oneOf:
+        - description:
+            Basic DWC PCIe controller configuration-space accessible over
+            the DBI interface. This memory space is either activated with
+            CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region
+            with all spaces. Note iATU/eDMA CSRs are indirectly accessible
+            via the PL viewports on the DWC PCIe controllers older than
+            v4.80a.
+          const: dbi
+        - description:
+            Shadow DWC PCIe config-space registers. This space is selected
+            by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of
+            the PCI-SIG PCIe CFG-space with the shadow registers for some
+            PCI Header space, PCI Standard and Extended Structures. It's
+            mainly relevant for the end-point controller configuration,
+            but still there are some shadow registers available for the
+            Root Port mode too.
+          const: dbi2
+        - description:
+            External Local Bus registers. It's an application-dependent
+            registers normally defined by the platform engineers. The space
+            can be selected by setting CDM/ELBI = 1 and CS2 = 0 wires or can
+            be accessed over some platform-specific means (for instance
+            as a part of a system controller).
+          enum: [ elbi, app ]
+        - description:
+            iATU/eDMA registers common for all device functions. It's an
+            unrolled memory space with the internal Address Translation
+            Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1
+            and CS2 = 1. For IP-core releases prior v4.80a, these registers
+            have been programmed via an indirect addressing scheme using a
+            set of viewport CSRs mapped into the PL space. Note iATU is
+            normally mapped to the 0x0 address of this region, while eDMA
+            is available at 0x80000 base address.
+          const: atu
+        - description:
+            Platform-specific eDMA registers. Some platforms may have eDMA
+            CSRs mapped in a non-standard base address. The registers offset
+            can be changed or the MS/LS-bits of the address can be attached
+            in an additional RTL block before the MEM-IO transactions reach
+            the DW PCIe slave interface.
+          const: dma
+        - description:
+            PHY/PCS configuration registers. Some platforms can have the
+            PCS and PHY CSRs accessible over a dedicated memory mapped
+            region, but mainly these registers are indirectly accessible
+            either by means of the embedded PHY viewport schema or by some
+            platform-specific method.
+          const: phy
+        - description:
+            Outbound iATU-capable memory-region which will be used to
+            generate various application-specific traffic on the PCIe bus
+            hierarchy. It's usage scenario depends on the endpoint
+            functionality, for instance it can be used to create MSI(X)
+            messages.
+          const: addr_space
+        - description:
+            Vendor-specific CSR names. Consider using the generic names above
+            for new bindings.
+          oneOf:
+            - description: See native 'elbi/app' CSR region for details.
+              enum: [ link, appl ]
+            - description: See native 'atu' CSR region for details.
+              enum: [ atu_dma ]
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: addr_space
 
   interrupts:
     description:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index fa1db57b2b97..59d3bbb5883a 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -28,10 +28,10 @@ allOf:
 
 properties:
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
 
@@ -39,8 +39,74 @@ properties:
     minItems: 2
     maxItems: 5
     items:
-      enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
-              parf, cfg, link, ulreg, smu, mpu, apb, phy ]
+      oneOf:
+        - description:
+            Basic DWC PCIe controller configuration-space accessible over
+            the DBI interface. This memory space is either activated with
+            CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region
+            with all spaces. Note iATU/eDMA CSRs are indirectly accessible
+            via the PL viewports on the DWC PCIe controllers older than
+            v4.80a.
+          const: dbi
+        - description:
+            Shadow DWC PCIe config-space registers. This space is selected
+            by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of
+            the PCI-SIG PCIe CFG-space with the shadow registers for some
+            PCI Header space, PCI Standard and Extended Structures. It's
+            mainly relevant for the end-point controller configuration,
+            but still there are some shadow registers available for the
+            Root Port mode too.
+          const: dbi2
+        - description:
+            External Local Bus registers. It's an application-dependent
+            registers normally defined by the platform engineers. The space
+            can be selected by setting CDM/ELBI = 1 and CS2 = 0 wires or can
+            be accessed over some platform-specific means (for instance
+            as a part of a system controller).
+          enum: [ elbi, app ]
+        - description:
+            iATU/eDMA registers common for all device functions. It's an
+            unrolled memory space with the internal Address Translation
+            Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1
+            and CS2 = 1. For IP-core releases prior v4.80a, these registers
+            have been programmed via an indirect addressing scheme using a
+            set of viewport CSRs mapped into the PL space. Note iATU is
+            normally mapped to the 0x0 address of this region, while eDMA
+            is available at 0x80000 base address.
+          const: atu
+        - description:
+            Platform-specific eDMA registers. Some platforms may have eDMA
+            CSRs mapped in a non-standard base address. The registers offset
+            can be changed or the MS/LS-bits of the address can be attached
+            in an additional RTL block before the MEM-IO transactions reach
+            the DW PCIe slave interface.
+          const: dma
+        - description:
+            PHY/PCS configuration registers. Some platforms can have the
+            PCS and PHY CSRs accessible over a dedicated memory mapped
+            region, but mainly these registers are indirectly accessible
+            either by means of the embedded PHY viewport schema or by some
+            platform-specific method.
+          const: phy
+        - description:
+            Outbound iATU-capable memory-region which will be used to access
+            the peripheral PCIe devices configuration space.
+          const: config
+        - description:
+            Vendor-specific CSR names. Consider using the generic names above
+            for new bindings.
+          oneOf:
+            - description: See native 'elbi/app' CSR region for details.
+              enum: [ apb, mgmt, link, ulreg, appl ]
+            - description: See native 'atu' CSR region for details.
+              enum: [ atu_dma ]
+            - description: Syscon-related CSR regions.
+              enum: [ smu, mpu ]
+    allOf:
+      - contains:
+          const: dbi
+      - contains:
+          const: config
 
   interrupts:
     description:
-- 
2.38.0



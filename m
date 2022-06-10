Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED45460FC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiFJJGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348275AbiFJJGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:06:00 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C7D2274D77;
        Fri, 10 Jun 2022 02:04:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C33BC16AE;
        Fri, 10 Jun 2022 11:58:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C33BC16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851486;
        bh=bndcRK7whtsfmiDP8jRu1JWxK0C4AOmoZ70ofFSjgmM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=plOlDjWj9i8Wnn59DzcrmXXUtIr/HIWUmtGdwQIZy8SgaAiA6NdmlETIDkXb/SnS5
         A8l2cvX3TNYgUlcOPjLggUaH1cVlLppr7EbyiC1pnGu0L2guVR+9Y/ixCMR2DG+Li9
         H0qChErltLPpuq2oPo5r7FRIs4VHWcdzQ094F2fo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:14 +0300
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
Subject: [PATCH v3 07/17] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
Date:   Fri, 10 Jun 2022 11:56:55 +0300
Message-ID: <20220610085706.15741-8-Sergey.Semin@baikalelectronics.ru>
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

Currently the 'interrupts' and 'interrupt-names' are defined being too
generic to really describe any actual IRQ interface. Moreover the DW PCIe
End-point devices are left with no IRQ signals. All of that can be fixed
by adding the IRQ-related properties to the common DW PCIe DT-schema and
defining a common and device-specific set of the IRQ names in accordance
with the hardware reference manual. Seeing there are common and dedicated
IRQ signals for DW PCIe Root Port and End-point controllers we suggest to
split the IRQ names up into two sets: common definitions available in the
snps,dw-pcie-common.yaml schema and Root Port specific names defined in
the snps,dw-pcie.yaml schema. The former one will be applied to both DW
PCIe RP and EP controllers, while the later one - for the RP only.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 51 +++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 63 ++++++++++++++++++-
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index b2fbe886981b..0a524e916a9f 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -17,6 +17,25 @@ description:
 select: false
 
 properties:
+  interrupts:
+    description:
+      There are two main sub-blocks which are normally capable of
+      generating interrupts. It's System Information Interface and MSI
+      interface. While the former one has some common for the Host and
+      Endpoint controllers IRQ-signals, the later interface is obviously
+      Root Complex specific since it's responsible for the incoming MSI
+      messages signalling. The System Information IRQ signals are mainly
+      responsible for reporting the generic PCIe hierarchy and Root
+      Complex events like VPD IO request, general AER, PME, Hot-plug, link
+      bandwidth change, link equalization request, INTx asserted/deasserted
+      Message detection, embedded DMA Tx/Rx/Error.
+    minItems: 1
+    maxItems: 26
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 26
+
   phys:
     description:
       There can be up to the number of possible lanes PHYs specified.
@@ -91,4 +110,36 @@ properties:
 
 additionalProperties: true
 
+definitions:
+  interrupt-names:
+    description:
+      IRQ signal names common for the DWC PCIe Root Port and Endpoint
+      controllers.
+    oneOf:
+      - description:
+          Controller request to read or write virtual product data
+          from/to the VPD capability registers.
+        const: vpd
+      - description:
+          Link Equalization Request flag is set in the Link Status 2
+          register (applicable if the corresponding IRQ is enabled in
+          the Link Control 3 register).
+        const: l_eq
+      - description:
+          Indicates that the eDMA Tx/Rx transfer is complete or that an
+          error has occurred on the corresponding channel. eDMA can have
+          eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
+          to 16 IRQ signals all together. Write eDMA channels shall go
+          first in the ordered row as per default edma_int[*] bus setup.
+        pattern: '^dma([0-9]|1[0-5])?$'
+      - description:
+          PCIe protocol correctable error or a Data Path protection
+          correctable error is detected by the automotive/safety
+          feature.
+        const: sft_ce
+      - description:
+          Indicates that the internal safety mechanism detected and
+          uncorrectable error.
+        const: sft_ue
+
 ...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 9411366d6ca7..5f12a6ac08d8 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -53,6 +53,20 @@ properties:
     items:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
+  interrupts:
+    description:
+      There is no mandatory IRQ signals for the normal controller functioning,
+      but in addition to the native set the platforms may have a link- or
+      PM-related IRQs specified.
+    minItems: 1
+    maxItems: 20
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 20
+    items:
+      $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
+
   max-functions:
     maximum: 32
 
@@ -72,6 +86,9 @@ examples:
             <0xd0000000 0x2000000>; /* Configuration space */
       reg-names = "dbi", "dbi2", "addr_space";
 
+      interrupts = <23>, <24>;
+      interrupt-names = "dma0", "dma1";
+
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 8b2e3210e3e2..e0020b72288a 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -54,9 +54,23 @@ properties:
       enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
               ulreg, smu, mpu, apb, phy ]
 
-  interrupts: true
-
-  interrupt-names: true
+  interrupts:
+    description:
+      At least MSI interrupt signal is supposed to be specified for
+      the DWC PCIe host controller.
+    minItems: 1
+    maxItems: 26
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 26
+    items:
+      anyOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
+        - $ref: '#/definitions/interrupt-names'
+    allOf:
+      - contains:
+          const: msi
 
   clocks: true
 
@@ -67,6 +81,48 @@ required:
   - reg
   - reg-names
 
+definitions:
+  interrupt-names:
+    description:
+      DWC PCIe Root Port/Complex specific IRQ signal names.
+    oneOf:
+      - description:
+          DSP AXI MSI Interrupt detected. It gets de-asserted when there is
+          no more MSI interrupt pending. The interrupt is relevant to the
+          iMSI-RX - Integrated MSI Receiver (AXI bridge).
+        const: msi
+      - description:
+          Legacy A/B/C/D interrupt signal. Basically it's triggered by
+          receiving a Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message
+          from the downstream device.
+        pattern: "^int(a|b|c|d)$"
+      - description:
+          Error condition detected and a bit is set in the Root Error Status
+          register of the AER capability. It's asserted when the RC
+          internally generated an error or an error message is received by
+          the RC.
+        const: aer
+      - description:
+          PME message is received by the port. That means having the PME
+          status bit set in the Root Status register (the event is
+          supposed to be unmasked in the Root Control register).
+        const: pme
+      - description:
+          Hot-plug event is detected. That is a bit has been set in the
+          Slot Status register and the corresponding event is enabled in
+          the Slot Control register.
+        const: hp
+      - description:
+          Link Autonomous Bandwidth Status flag has been set in the Link
+          Status register (the event is supposed to be unmasked in the
+          Link Control register).
+        const: bw_au
+      - description:
+          Bandwidth Management Status flag has been set in the Link
+          Status register (the event is supposed to be unmasked in the
+          Link Control register).
+        const: bw_mg
+
 examples:
   - |
     pcie@dfc00000 {
@@ -82,6 +138,7 @@ examples:
       bus-range = <0x0 0xff>;
 
       interrupts = <25>, <24>;
+      interrupt-names = "msi", "hp";
       #interrupt-cells = <1>;
 
       reset-gpios = <&port0 0 1>;
-- 
2.35.1


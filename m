Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C766659C743
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiHVStU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiHVSsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:23 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA0534A832;
        Mon, 22 Aug 2022 11:47:43 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id D54A1DAC;
        Mon, 22 Aug 2022 21:50:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com D54A1DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194246;
        bh=1ZRqd/btC6EWjWyWRzbEbMh2qTwX0mhDhchvD7FViJI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WUNGqeP9Dv0JF4LVybtYnMbEz5Ip0yP4ODrNB3klvu0jU/0k8GE9AXNfpisKjOm/g
         eCOPy66nkVabgDEkcuYOyXsVKQc0AA8LQTJmUbuvVNx4VuHEgYweGllnnQ5ZsjbK2x
         ujpvKkF/FKtwm9K5WAbR1FnMBA4IHd+XFlfK8c08=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:32 +0300
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
Subject: [PATCH v5 09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
Date:   Mon, 22 Aug 2022 21:46:50 +0300
Message-ID: <20220822184701.25246-10-Sergey.Semin@baikalelectronics.ru>
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

Note since there are DW PCI-based vendor-specific DT-bindings with the
custom names assigned to the same IRQ resources we have no much choice but
to add them to the generic DT-schemas in order to have the schemas being
applicable for such devices. Let's mark these names as deprecated so not
to encourage the new DT-bindings to use them.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)

Changelog v5:
- Add platform-specific interrupt names, but mark them as deprecated.
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 51 ++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 67 ++++++++++++++++++-
 3 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 5fc704138677..1b0ed8f4db6c 100644
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
       There can be up to the number of possible lanes PHYs specified placed in
@@ -95,4 +114,36 @@ properties:
 
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
index 71dd19ae1060..a9e77339c3ff 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -41,6 +41,20 @@ properties:
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
 
@@ -60,6 +74,9 @@ examples:
             <0xd0000000 0x2000000>; /* Configuration space */
       reg-names = "dbi", "dbi2", "addr_space";
 
+      interrupts = <23>, <24>;
+      interrupt-names = "dma0", "dma1";
+
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 85861b71d9ff..3e46f74a591a 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -42,9 +42,27 @@ properties:
       enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
               parf, cfg, link, ulreg, smu, mpu, apb, phy ]
 
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
+      oneOf:
+        - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
+        - $ref: '#/definitions/interrupt-names'
+        - deprecated: true
+          oneOf:
+            - description: See native "msi" IRQ for details
+              enum: [ intr ]
+    allOf:
+      - contains:
+          const: msi
 
   clocks: true
 
@@ -55,6 +73,48 @@ required:
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
@@ -70,6 +130,7 @@ examples:
       bus-range = <0x0 0xff>;
 
       interrupts = <25>, <24>;
+      interrupt-names = "msi", "hp";
       #interrupt-cells = <1>;
 
       reset-gpios = <&port0 0 1>;
-- 
2.35.1


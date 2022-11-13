Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C3627214
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiKMTPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiKMTO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:14:56 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75F62BE1;
        Sun, 13 Nov 2022 11:14:54 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EFB35E0EB9;
        Sun, 13 Nov 2022 22:14:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=gplzP3K8WfYz/8RwoGoHSBrv5CgJjWPVt9HNBNS4KRE=; b=sAlwt95deqw4
        mqrh5r2D12SM8An4YfiSDVbEzwjqpWG6ezrWwyVBj9bFA5QT94Z2K3N3p2QczcWX
        +Nr825pp/Nq1Xe48/3gag8hHiRlo+EboTrZqWP1Kpgp1W/qM0di2tkEBCgAyWJHt
        FOyBSt4xDmQBeBRWEgMjTrBZqmzz9Lo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DF203E0E6A;
        Sun, 13 Nov 2022 22:14:53 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:53 +0300
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
Subject: [PATCH v7 09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
Date:   Sun, 13 Nov 2022 22:12:50 +0300
Message-ID: <20221113191301.5526-10-Sergey.Semin@baikalelectronics.ru>
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

Currently the 'interrupts' and 'interrupt-names' properties are defined
being too generic to really describe any actual IRQ interface. Moreover
the DW PCIe End-point devices are left with no IRQ signals. All of that
can be fixed by adding the IRQ-related properties to the common DW PCIe
DT-schemas in accordance with the hardware reference manual. The DW PCIe
common DT-schema will contain the generic properties definitions with just
a number of entries per property, while the DW PCIe RP/EP-specific schemas
will have the particular number of items and the generic resource names
listed.

Note since there are DW PCI-based vendor-specific DT-bindings with the
custom names assigned to the same IRQ resources we have no much choice but
to add them to the generic DT-schemas in order to have the schemas being
applicable for such devices. These names are marked as vendor-specific and
should be avoided being used in new bindings in favor of the generic
names.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)

Changelog v5:
- Add platform-specific interrupt names, but mark them as deprecated.

Changelog v6:
- Move the common interrupt-names definitions to the RP/EP schemas.
  Thus drop the 'definitions' property. (@Rob)
- Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)

Changelog v7:
- Drop the dtschema tool 'lib.py' fix chunk from under the '---' pattern.
  (@Yoshihiro)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 19 ++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 52 +++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 90 ++++++++++++++++++-
 3 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index e63c21783fc1..4646fb14e817 100644
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
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 71dd19ae1060..7d3f8fc8b7b4 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -41,6 +41,55 @@ properties:
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
+      oneOf:
+        - description:
+            Controller request to read or write virtual product data
+            from/to the VPD capability registers.
+          const: vpd
+        - description:
+            Link Equalization Request flag is set in the Link Status 2
+            register (applicable if the corresponding IRQ is enabled in
+            the Link Control 3 register).
+          const: l_eq
+        - description:
+            Indicates that the eDMA Tx/Rx transfer is complete or that an
+            error has occurred on the corresponding channel. eDMA can have
+            eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
+            to 16 IRQ signals all together. Write eDMA channels shall go
+            first in the ordered row as per default edma_int[*] bus setup.
+          pattern: '^dma([0-9]|1[0-5])?$'
+        - description:
+            PCIe protocol correctable error or a Data Path protection
+            correctable error is detected by the automotive/safety
+            feature.
+          const: sft_ce
+        - description:
+            Indicates that the internal safety mechanism has detected an
+            uncorrectable error.
+          const: sft_ue
+        - description:
+            Application-specific IRQ raised depending on the vendor-specific
+            events basis.
+          const: app
+        - description:
+            Vendor-specific IRQ names. Consider using the generic names above
+            for new bindings.
+          oneOf:
+            - description: See native "app" IRQ for details
+              enum: [ intr ]
+
   max-functions:
     maximum: 32
 
@@ -60,6 +109,9 @@ examples:
             <0xd0000000 0x2000000>; /* Configuration space */
       reg-names = "dbi", "dbi2", "addr_space";
 
+      interrupts = <23>, <24>;
+      interrupt-names = "dma0", "dma1";
+
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
 
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 85861b71d9ff..fa1db57b2b97 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -42,9 +42,92 @@ properties:
       enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
               parf, cfg, link, ulreg, smu, mpu, apb, phy ]
 
-  interrupts: true
-
-  interrupt-names: true
+  interrupts:
+    description:
+      DWC PCIe Root Port/Complex specific IRQ signals. At least MSI interrupt
+      signal is supposed to be specified for the host controller.
+    minItems: 1
+    maxItems: 26
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 26
+    items:
+      oneOf:
+        - description:
+            Controller request to read or write virtual product data
+            from/to the VPD capability registers.
+          const: vpd
+        - description:
+            Link Equalization Request flag is set in the Link Status 2
+            register (applicable if the corresponding IRQ is enabled in
+            the Link Control 3 register).
+          const: l_eq
+        - description:
+            Indicates that the eDMA Tx/Rx transfer is complete or that an
+            error has occurred on the corresponding channel. eDMA can have
+            eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
+            to 16 IRQ signals all together. Write eDMA channels shall go
+            first in the ordered row as per default edma_int[*] bus setup.
+          pattern: '^dma([0-9]|1[0-5])?$'
+        - description:
+            PCIe protocol correctable error or a Data Path protection
+            correctable error is detected by the automotive/safety
+            feature.
+          const: sft_ce
+        - description:
+            Indicates that the internal safety mechanism has detected an
+            uncorrectable error.
+          const: sft_ue
+        - description:
+            Application-specific IRQ raised depending on the vendor-specific
+            events basis.
+          const: app
+        - description:
+            DSP AXI MSI Interrupt detected. It gets de-asserted when there is
+            no more MSI interrupt pending. The interrupt is relevant to the
+            iMSI-RX - Integrated MSI Receiver (AXI bridge).
+          const: msi
+        - description:
+            Legacy A/B/C/D interrupt signal. Basically it's triggered by
+            receiving a Assert_INT{A,B,C,D}/Desassert_INT{A,B,C,D} message
+            from the downstream device.
+          pattern: "^int(a|b|c|d)$"
+        - description:
+            Error condition detected and a flag is set in the Root Error Status
+            register of the AER capability. It's asserted when the RC
+            internally generated an error or an error message is received by
+            the RC.
+          const: aer
+        - description:
+            PME message is received by the port. That means having the PME
+            status bit set in the Root Status register (the event is
+            supposed to be unmasked in the Root Control register).
+          const: pme
+        - description:
+            Hot-plug event is detected. That is a bit has been set in the
+            Slot Status register and the corresponding event is enabled in
+            the Slot Control register.
+          const: hp
+        - description:
+            Link Autonomous Bandwidth Status flag has been set in the Link
+            Status register (the event is supposed to be unmasked in the
+            Link Control register).
+          const: bw_au
+        - description:
+            Bandwidth Management Status flag has been set in the Link
+            Status register (the event is supposed to be unmasked in the
+            Link Control register).
+          const: bw_mg
+        - description:
+            Vendor-specific IRQ names. Consider using the generic names above
+            for new bindings.
+          oneOf:
+            - description: See native "app" IRQ for details
+              enum: [ intr ]
+    allOf:
+      - contains:
+          const: msi
 
   clocks: true
 
@@ -70,6 +153,7 @@ examples:
       bus-range = <0x0 0xff>;
 
       interrupts = <25>, <24>;
+      interrupt-names = "msi", "hp";
       #interrupt-cells = <1>;
 
       reset-gpios = <&port0 0 1>;
-- 
2.38.1



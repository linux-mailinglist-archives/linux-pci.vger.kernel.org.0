Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216462007C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKGVKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiKGVKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:25 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E83D32B96;
        Mon,  7 Nov 2022 13:07:20 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7C2E7E0EB7;
        Mon,  7 Nov 2022 23:50:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=6pbUU/1rVgs0qP/kl3zLIRVXxzAt8V9XoD9Kk+EME20=; b=d75OzDW4Ah7P
        4ZbSNL9Babe4z+UxdZAGKgA9OL2xglcCyCVkeTeme2c5BR7i0pD6Jno37j5CMHdN
        UBYtAu0FTKeBL5kBGgma/CGSOOi7erTgsbyf1oCXB+RjSeEG/zmkzM/wsfxnNfxE
        oWRkzyfEIa1Dk1hvoIRN5ZJrbq5mR7w=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 64E23E0E1D;
        Mon,  7 Nov 2022 23:50:15 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:14 +0300
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
Subject: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
Date:   Mon, 7 Nov 2022 23:49:23 +0300
Message-ID: <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
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

---

Note without the next dtschema tool fix

--- a/lib.py 2022-09-29 15:17:13.100033810 +0300
+++ b/lib.py     2022-09-29 15:19:54.886172794 +0300
@@ -1307,7 +1307,7 @@
 def format_error(filename, error, prefix="", nodename=None, verbose=False):
     src = prefix + os.path.abspath(filename) + ':'

-    if error.linecol[0] >= 0:
+    if hasattr(error, 'linecol') and error.linecol[0] >= 0:
         src = src + '%i:%i: ' % (error.linecol[0]+1, error.linecol[1]+1)
     else:
         src += ' '
@@ -1342,10 +1342,10 @@
     else:
         msg = error.message

-    if error.note:
+    if hasattr(error, 'note') and error.note:
         msg += '\n\t' + prefix + 'hint: ' + error.note

-    if error.schema_file:
+    if hasattr(error, 'schema_file') and error.schema_file:
         msg += '\n\t' + prefix + 'from schema $id: ' + error.schema_file

     return src + msg

any DT-bindings error will cause the dt-schema script crash:

Traceback (most recent call last):
  File "/home/fancer/.local/bin/dt-validate", line 175, in <module>
    sg.check_trees(filename, testtree)
  File "/home/fancer/.local/bin/dt-validate", line 122, in check_trees
    self.check_subtree(dt, subtree, False, "/", "/", filename)
  File "/home/fancer/.local/bin/dt-validate", line 111, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/home/fancer/.local/bin/dt-validate", line 111, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/home/fancer/.local/bin/dt-validate", line 106, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
  File "/home/fancer/.local/bin/dt-validate", line 84, in check_node
    print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
  File "/home/fancer/.local/lib/python3.8/site-packages/dtschema/lib.py", line 1332, in format_error
    msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
  File "/home/fancer/.local/lib/python3.8/site-packages/dtschema/lib.py", line 1310, in format_error
    if error.linecol[0] >= 0:
AttributeError: 'ValidationError' object has no attribute 'linecol'

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
2.38.0



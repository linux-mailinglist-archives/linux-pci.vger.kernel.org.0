Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69601E2D0D
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391988AbgEZTTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:19:03 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45882 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404253AbgEZTNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:23 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 1D46730D751;
        Tue, 26 May 2020 12:13:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 1D46730D751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520402;
        bh=8TtwqVFOeNWHeLC4ioTyyfNs+GuSFwf6XTiy9LM2XsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6N4btUBsdsEPE1z//oDdAcGWUTnI7hxnU+F4DJpJOgsUit90NIcr5MGo+fdQDm0K
         m9CTYqvgc8s88B6CI5EkeMI762vnCFuWlHbZ25vzGmtej2P66zQ/Pre9qJwH5Aw8d5
         rw2oHR2Z/XQ+pCK1Jb5vHmW8YLQLbap5jf5q/L9o=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 93BE6140069;
        Tue, 26 May 2020 12:13:20 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb chips
Date:   Tue, 26 May 2020 15:12:42 -0400
Message-Id: <20200526191303.1492-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

- Add compatible strings for three more Broadcom STB chips: 7278, 7216,
  7211 (STB version of RPi4).
- add new property 'brcm,scb-sizes'
- add new property 'resets'
- add new property 'reset-names'
- allow 'ranges' and 'dma-ranges' to have more than one item and update
  the example to show this.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 8680a0f86c5a..66a7df45983d 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -14,7 +14,13 @@ allOf:
 
 properties:
   compatible:
-    const: brcm,bcm2711-pcie # The Raspberry Pi 4
+    items:
+      - enum:
+          - brcm,bcm2711-pcie # The Raspberry Pi 4
+          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
+          - brcm,bcm7278-pcie # Broadcom 7278 Arm
+          - brcm,bcm7216-pcie # Broadcom 7216 Arm
+          - brcm,bcm7445-pcie # Broadcom 7445 Arm
 
   reg:
     maxItems: 1
@@ -34,10 +40,12 @@ properties:
       - const: msi
 
   ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   dma-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 6
 
   clocks:
     maxItems: 1
@@ -58,8 +66,30 @@ properties:
 
   aspm-no-l0s: true
 
+  resets:
+    description: for "brcm,bcm7216-pcie", must be a valid reset
+      phandle pointing to the RESCAL reset controller provider node.
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  reset-names:
+    items:
+      - const: rescal
+
+  brcm,scb-sizes:
+    description: (u32, u32) tuple giving the 64bit PCIe memory
+      viewport size of a memory controller.  There may be up to
+      three controllers, and each size must be a power of two
+      with a size greater or equal to the amount of memory the
+      controller supports.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - items:
+          minItems: 2
+          maxItems: 6
+
 required:
   - reg
+  - ranges
   - dma-ranges
   - "#interrupt-cells"
   - interrupts
@@ -93,7 +123,9 @@ examples:
                     msi-parent = <&pcie0>;
                     msi-controller;
                     ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
-                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
+                    dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
+                                 <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
+                    brcm,scb-sizes = <0x0 0x80000000 0x0 0x80000000>;
             };
     };
-- 
2.17.1


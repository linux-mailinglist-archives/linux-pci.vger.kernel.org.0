Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD91ED6B6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFCTVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 15:21:46 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43046 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgFCTVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 15:21:22 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 342A530DEA0;
        Wed,  3 Jun 2020 12:21:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 342A530DEA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1591212080;
        bh=xHVmdwrtES336ZD/pMaNwdQn2MdfztoEcmaxMbZqWYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEL2a2At3qdIZTMd5Ux7vUowzVMWvEK7LCA0Gi0k04b6EZ4O2vf0g5XSULVKnRjMU
         BVfkjc/XJYaFkWch64c/Icmwp2jlY9PCL28O1GJPwglhL3h+1jlsIT3rzy3P8HF5dg
         9yhj2PdFtBseQN6ibumQ+Z+p2kmUoBeN/FmjQUmw=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 917CC14008C;
        Wed,  3 Jun 2020 12:21:18 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/13] dt-bindings: PCI: Add bindings for more Brcmstb chips
Date:   Wed,  3 Jun 2020 15:20:35 -0400
Message-Id: <20200603192058.35296-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603192058.35296-1-james.quinlan@broadcom.com>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

- Add compatible strings for three more Broadcom STB chips: 7278, 7216,
  7211 (STB version of RPi4).
- add new property 'brcm,scb-sizes'
- add new property 'resets'
- add new property 'reset-names' for 7216 only
- allow 'ranges' and 'dma-ranges' to have more than one item and update
  the example to show this.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 58 ++++++++++++++++---
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 8680a0f86c5a..4a012d77513f 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -9,12 +9,15 @@ title: Brcmstb PCIe Host Controller Device Tree Bindings
 maintainers:
   - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
 
-allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
-
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
@@ -34,10 +37,12 @@ properties:
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
@@ -58,8 +63,33 @@ properties:
 
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
+    description: u64 giving the 64bit PCIe memory
+      viewport size of a memory controller.  There may be up to
+      three controllers, and each size must be a power of two
+      with a size greater or equal to the amount of memory the
+      controller supports.  Note that each memory controller
+      may have two component regions -- base and extended -- so
+      this information cannot be deduced from the dma-ranges.
+
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint64-array
+      - items:
+          minItems: 1
+          maxItems: 3
+
 required:
   - reg
+  - ranges
   - dma-ranges
   - "#interrupt-cells"
   - interrupts
@@ -68,6 +98,18 @@ required:
   - interrupt-map
   - msi-controller
 
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7216-pcie
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
@@ -93,7 +135,9 @@ examples:
                     msi-parent = <&pcie0>;
                     msi-controller;
                     ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
-                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
+                    dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
+                                 <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
+                    brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
             };
     };
-- 
2.17.1


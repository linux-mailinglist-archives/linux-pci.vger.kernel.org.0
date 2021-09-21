Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E8413A2D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhIUSn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:43:29 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51397 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233372AbhIUSn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:43:29 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 14:43:14 EDT
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Skb8mlMr9pQdWSkbKmYt3s; Tue, 21 Sep 2021 20:34:42 +0200
From:   Mark Kettenis <kettenis@openbsd.org>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 1/4] dt-bindings: interrupt-controller: Convert MSI controller to json-schema
Date:   Tue, 21 Sep 2021 20:34:12 +0200
Message-Id: <20210921183420.436-2-kettenis@openbsd.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921183420.436-1-kettenis@openbsd.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIlpYFiGaSAXpAnocbCedhdc9w5ORcy16MbexeqrUt9heusGvQR0ct6u4W6KKa6LUSEWt+uhsEfl8afqN2dav/AIj6sBKWxbG9ZqBF2tlE9E5Cx5r8+k
 naUalhJp0zKsE4TOQhfQMFHq55Lrz/RM2X8AB6F8/si00+vAWZub9nXSB5WcskFXqtUc8+gzveqVg3FS/tOkXh3SJXBCSEGDaJ19KIYnKKvTosrJgAYNMQTC
 WtwbSAt3CAxnXztaa8/bOKIRxw/bU/8KYv+dhpEm4Dpv8nMqZW35oMSVOA7SzFJ/ms3uMI6ky/d6UB+aF7Hl0Zz/pqckuNfp7CPAT4E1k3EfhZ6E1/J1vioc
 01RqHspf3sNw/DUSrTFNRhaWFi68u59GYc/BMiRuFDIUoznpmRo0/Kym8TegGcJPVtKwFnYu6HyVhOby9rXmGBTkYpUMUU4RFKwXfJslLRU1wUoYzSG67QcR
 +/e62w6eVOFfzYtaYOfXe1QkN3rAtfP2WplmzBd/vjcR6rSvjBwOCpDdVmfgEWzYuP+LghAvuLVz6cC/X2xhKL0P2ZVjvDqTRh4CdlDJW6VuHCMNkGoYjebQ
 ZLH8olt0tsweARdGIdcocruZubPsiQywSMPOn7cixe6mhQV1aT3d+lq2wks00hHAdPcaRDH5TbHNjjiAuYj34bzWCUXHQ2TgZXzz1rq13pzEZqQ4gNyFQihq
 7PO/Cyy5m7EvFdT1qLmgvwaweeAQTmxp19tR6quO9gCIAunQ3LmrdrJkjQ91aTRxv2JffkD+JtDaK7IHhQdcRfHiyVxLNuB9MVL3wVJ0RS+j35CTGqTLTW61
 wR3ISaGZteDGDJoOLDg6e1yEoV3z8A79nV7i9BuG+j2XiOzd7JtJrx5QLi5abA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the MSI controller bindings from the MSI binding document
into DT schema format using json-schema.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 .../interrupt-controller/msi-controller.yaml  | 38 +++++++++++++++++++
 .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
 .../bindings/pci/microchip,pcie-host.yaml     |  1 +
 3 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
new file mode 100644
index 000000000000..58d898d5b943
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/msi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MSI controller
+
+maintainers:
+  - Marc Zyngier <maz@kernel.org>
+
+description: |
+  An MSI controller signals interrupts to a CPU when a write is made
+  to an MMIO address by some master. An MSI controller may feature a
+  number of doorbells.
+
+properties:
+  "#msi-cells":
+    description: |
+      The number of cells in an msi-specifier, required if not zero.
+
+      Typically this will encode information related to sideband data,
+      and will not encode doorbells or payloads as these can be
+      configured dynamically.
+
+      The meaning of the msi-specifier is defined by the device tree
+      binding of the specific MSI controller.
+    enum: [0, 1]
+
+  msi-controller:
+    description:
+      Identifies the node as an MSI controller.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+dependencies:
+  "#msi-cells": [ msi-controller ]
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index b9589a0daa5c..1fe102743f82 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -88,6 +88,7 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index fb95c276a986..7b0776457178 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
 
 properties:
   compatible:
-- 
2.33.0


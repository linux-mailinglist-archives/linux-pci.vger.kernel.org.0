Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19CFE9F1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 01:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKPAwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 19:52:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35743 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKPAwn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 19:52:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so10279990oig.2;
        Fri, 15 Nov 2019 16:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AetbleCxh59RFQA50mSfhwx5Tr8S+w1DkHRLL89kPsY=;
        b=ehs0di2T/yogUUmAhIUwAe3pZliPyYkl/X14ykSaWulBIZ9XkqCKN1te6ulnBO3G4e
         FGAeH06Fgn841gh1af+Cisgh0rvPaLNMfycTHEnvyQb3MbR+sgZl32mpIAa3LOkdNawX
         cMGAyxobVVkzPT25mY/kcq035JcSxjnIAjnFqEulqojrK+XCg0u+nl9sm47mUc0djpnx
         K24Pfu6qCpBjZam/PMY15IEJlJyFK0cdd8qNJK2Y28FKaHaoPZi4Aj0yKDChe2p4POoz
         HSTtutgoV2g9h9nF97THZih8EZGm6vC4cvjdLNhEP7rQaNpeHsi2MunsmpxHGH2719Rp
         z5JQ==
X-Gm-Message-State: APjAAAXdgO2yoXfzP49PH7z1HJ/VBqBS5Tu2oXBmeY3oJkm5vxiIuDlA
        oibGVYqEVRYZ1aajCRGvEeSiNfA=
X-Google-Smtp-Source: APXvYqwg/VgS3/evD7c7sKv17gVvXIxXTLVIjdz9nGUVlGfrbDpv5PJX/I/IXrd7tvhjMBRZoNi6Ug==
X-Received: by 2002:aca:d8c5:: with SMTP id p188mr9914595oig.140.1573865562371;
        Fri, 15 Nov 2019 16:52:42 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g18sm3525680otg.50.2019.11.15.16.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:52:41 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alan Douglas <adouglas@cadence.com>,
        Scott Telford <stelford@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 2/3] dt-bindings: PCI: Convert Cadence host to DT schema
Date:   Fri, 15 Nov 2019 18:52:39 -0600
Message-Id: <20191116005240.15722-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116005240.15722-1-robh@kernel.org>
References: <20191116005240.15722-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Cadence PCIe host binding to DT schema.

The 'phy-names' definition is incomplete.

'vendor-id' and 'device-id' aren't listed as those are standard PCI
properties. They were incorrectly defined as 16-bit when they should be
32-bits (even though only 16-bits are used).

'cdns,max-outbound-regions' should really be removed. It serves no
purpose other than bounds checking 'ranges'. If 'ranges' is wrong for
the h/w, what's going to ensure 'cdns,max-outbound-regions' is correct.

'cdns,no-bar-match-nbits' is also suspect. This probably could be
determined from 'dma-ranges' using the sizes.

Cc: Alan Douglas <adouglas@cadence.com>
Cc: Scott Telford <stelford@cadence.com>
Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/cdns,cdns-pcie-host.txt      |  66 -----------
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 106 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 107 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
deleted file mode 100644
index 91de69c713a9..000000000000
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* Cadence PCIe host controller
-
-This PCIe controller inherits the base properties defined in
-host-generic-pci.txt.
-
-Required properties:
-- compatible: Should contain "cdns,cdns-pcie-host" to identify the IP used.
-- reg: Should contain the controller register base address, PCIe configuration
-  window base address, and AXI interface region base address respectively.
-- reg-names: Must be "reg", "cfg" and "mem" respectively.
-- #address-cells: Set to <3>
-- #size-cells: Set to <2>
-- device_type: Set to "pci"
-- ranges: Ranges for the PCI memory and I/O regions
-- #interrupt-cells: Set to <1>
-- interrupt-map-mask and interrupt-map: Standard PCI properties to define the
-  mapping of the PCIe interface to interrupt numbers.
-
-Optional properties:
-- cdns,max-outbound-regions: Set to maximum number of outbound regions
-  (default 32)
-- cdns,no-bar-match-nbits: Set into the no BAR match register to configure the
-  number of least significant bits kept during inbound (PCIe -> AXI) address
-  translations (default 32)
-- vendor-id: The PCI vendor ID (16 bits, default is design dependent)
-- device-id: The PCI device ID (16 bits, default is design dependent)
-- phys: From PHY bindings: List of Generic PHY phandles. One per lane if more
-  than one in the list.  If only one PHY listed it must manage all lanes. 
-- phy-names:  List of names to identify the PHY.
-
-Example:
-
-pcie@fb000000 {
-	compatible = "cdns,cdns-pcie-host";
-	device_type = "pci";
-	#address-cells = <3>;
-	#size-cells = <2>;
-	bus-range = <0x0 0xff>;
-	linux,pci-domain = <0>;
-	cdns,max-outbound-regions = <16>;
-	cdns,no-bar-match-nbits = <32>;
-	vendor-id = /bits/ 16 <0x17cd>;
-	device-id = /bits/ 16 <0x0200>;
-
-	reg = <0x0 0xfb000000  0x0 0x01000000>,
-	      <0x0 0x41000000  0x0 0x00001000>,
-	      <0x0 0x40000000  0x0 0x04000000>;
-	reg-names = "reg", "cfg", "mem";
-
-	ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
-		 <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
-
-	#interrupt-cells = <0x1>;
-
-	interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1
-			 0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1
-			 0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1
-			 0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
-
-	interrupt-map-mask = <0x0 0x0 0x0  0x7>;
-
-	msi-parent = <&its_pci>;
-
-	phys = <&pcie_phy0>;
-	phy-names = "pcie-phy";
-};
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
new file mode 100644
index 000000000000..ada77e267b68
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cdns,cdns-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence PCIe host controller
+
+maintainers:
+  - Alan Douglas <adouglas@cadence.com>
+  - Scott Telford <stelford@cadence.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: cdns,cdns-pcie-host
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+      - const: mem
+
+  cdns,max-outbound-regions:
+    description: maximum number of outbound regions
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    default: 32
+
+  cdns,no-bar-match-nbits:
+    description:
+      Set into the no BAR match register to configure the number of least
+      significant bits kept during inbound (PCIe -> AXI) address translations
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 32
+    default: 32
+
+  msi-parent: true
+
+  phys:
+    description:
+      One per lane if more than one in the list. If only one PHY listed it must
+      manage all lanes.
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    items:
+      - const: pcie-phy
+    # FIXME: names when more than 1
+
+required:
+  - reg
+  - reg-names
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@fb000000 {
+            compatible = "cdns,cdns-pcie-host";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x0 0xff>;
+            linux,pci-domain = <0>;
+            cdns,max-outbound-regions = <16>;
+            cdns,no-bar-match-nbits = <32>;
+            vendor-id = /bits/ 16 <0x17cd>;
+            device-id = /bits/ 16 <0x0200>;
+
+            reg = <0x0 0xfb000000  0x0 0x01000000>,
+                  <0x0 0x41000000  0x0 0x00001000>,
+                  <0x0 0x40000000  0x0 0x04000000>;
+            reg-names = "reg", "cfg", "mem";
+
+            ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
+                     <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
+
+            #interrupt-cells = <0x1>;
+
+            interrupt-map = <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1>,
+                 <0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1>,
+                 <0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1>,
+                 <0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
+
+            interrupt-map-mask = <0x0 0x0 0x0  0x7>;
+
+            msi-parent = <&its_pci>;
+
+            phys = <&pcie_phy0>;
+            phy-names = "pcie-phy";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 48a90f0833b8..21f3393c36e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12416,7 +12416,7 @@ PCI DRIVER FOR CADENCE PCIE IP
 M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/cdns,*.txt
+F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/pcie-cadence*
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
-- 
2.20.1


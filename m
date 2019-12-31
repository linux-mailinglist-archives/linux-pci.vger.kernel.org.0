Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73FD12DB31
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLaTjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 14:39:08 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36874 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaTjI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 14:39:08 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so30844715iln.4;
        Tue, 31 Dec 2019 11:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqacRFuypSbp63ZFpYBf+4/J26LILeoQM9atqZZnMj4=;
        b=Dm3z8wXCSAK62yE8DJNLSyBOSFnFuZobkbzxp+NxPbEFswOcF3FOk7RcqES+VSLAfO
         ncFG26Xnf6pl6kGoS9YKSRhjoIJwIH2+NfHfc598lc1aDjSQtrvKDYUVfEYYeoDxeSJV
         9IN+XlSmLby02zeVYoLwr76q2IBMggZon7Qz2M0gWCTO29jweQS893x3WfQLph9Q3G2l
         ZpVhGf7eMiDAewEs2o6qsGC6EHyGVSesqgCF5Pa+haVk1jkxImD6m/P/CUbKhcCALPgE
         P7hp4PVNCV0MlU2I04VuRAZ85VHmSbmaZpbhfEAf975GGDNgSezS3QRM3hQZrAI7750p
         x9eQ==
X-Gm-Message-State: APjAAAUbcJyYijGTSkJZngpbuQ481xIgRRJp1kJukCH1nCkCHiKwhz1C
        TQ4jP3fe13u7VgL41OTTHECsQkc=
X-Google-Smtp-Source: APXvYqy8tUsVbgRAfMkqZD+nQanshPlfDdft40dpazdp5aOy8X5W7JlTTiNR+OXixAxiRgiFUuOrAA==
X-Received: by 2002:a92:3cd4:: with SMTP id j81mr66368596ilf.77.1577821146884;
        Tue, 31 Dec 2019 11:39:06 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id e1sm17860074ill.47.2019.12.31.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 11:39:06 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alan Douglas <adouglas@cadence.com>,
        Scott Telford <stelford@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 2/3] dt-bindings: PCI: Convert Cadence host to DT schema
Date:   Tue, 31 Dec 2019 12:39:02 -0700
Message-Id: <20191231193903.15929-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191231193903.15929-1-robh@kernel.org>
References: <20191231193903.15929-1-robh@kernel.org>
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
v2: no change

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
index 1072745a8fda..b55f9dd7c47a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12595,7 +12595,7 @@ PCI DRIVER FOR CADENCE PCIE IP
 M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/cdns,*.txt
+F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/pcie-cadence*
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
-- 
2.20.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE01D33F1
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgENPAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 11:00:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42036 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENPAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:00:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EExqYf028904;
        Thu, 14 May 2020 09:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468392;
        bh=Z+gfjunEdb+MDsFcXFEi3ESnDkoKrmf88fLI5DaHYFs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X/Wl4VbpWfLMxOmffnMC5XzbbmI1jXt6otRkFudTKOj+MoTVRJczt1q1ijiz8PbYm
         LG0FXCXwcldlYOUogAFwDHXMwaVShOt8dfV//CH1ShO9R8K11L48jN6+fktEyKe7zR
         11aOUUpMZGthBMF3SdVClabcjJccvC3xgf857vgs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EExqUd117212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 09:59:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 09:59:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 09:59:51 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAj019279;
        Thu, 14 May 2020 09:59:47 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/19] dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF NTB Device
Date:   Thu, 14 May 2020 20:29:09 +0530
Message-ID: <20200514145927.17555-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree schema for PCI endpoint function bus to which
endpoint function devices should be attached. Then add device tree
schema for PCI endpoint function device to include bindings thats
generic to all endpoint functions. Finally add device tree schema
for PCI endpoint NTB function device by including the generic
device tree schema for PCIe endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/endpoint/pci-epf-bus.yaml    | 42 +++++++++++
 .../bindings/pci/endpoint/pci-epf-device.yaml | 69 +++++++++++++++++++
 .../bindings/pci/endpoint/pci-epf-ntb.yaml    | 68 ++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml

diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
new file mode 100644
index 000000000000..1c504f2e85e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCI Endpoint Function Bus
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  compatible:
+    const: pci-epf-bus
+
+patternProperties:
+  "^func@[0-9a-f]+$":
+    type: object
+    description: |
+      PCI Endpoint Function Bus node should have subnodes for each of
+      the implemented endpoint function. It should follow the bindings
+      specified for endpoint function in
+      Documentation/devicetree/bindings/pci/endpoint/
+
+examples:
+  - |
+    epf_bus {
+      compatible = "pci-epf-bus";
+
+      func@0 {
+        compatible = "pci-epf-ntb";
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";
+        reg = <0>;
+        epf,vendor-id = /bits/ 16 <0x104c>;
+        epf,device-id = /bits/ 16 <0xb00d>;
+        num-mws = <4>;
+        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
new file mode 100644
index 000000000000..cee72864c8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCI Endpoint Function Device
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+properties:
+  compatible:
+    const: pci-epf-bus
+
+properties:
+  $nodename:
+    pattern: "^func@"
+
+  epcs:
+    description:
+      Phandle to the endpoint controller device. Should have "2" entries for
+      NTB endpoint function and "1" entry for others.
+    minItems: 1
+    maxItems: 2
+
+  epc-names:
+    description:
+      Must contain an entry for each entry in "epcs" when "epcs" have more than
+      one entry.
+
+  reg:
+    maxItems: 0
+    description: Must contain the index number of the function.
+
+  epf,vendor-id:
+    description:
+      The PCI vendor ID
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint16
+
+  epf,device-id:
+    description:
+      The PCI device ID
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint16
+
+  epf,baseclass-code:
+    description: Code to classify the type of operation the function performs
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+
+  epf,subclass-code:
+    description:
+      Specifies a base class sub-class, which identifies more specifically the
+      operation of the Function
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+
+  epf,subsys-vendor-id:
+    description: Code to identify vendor of the add-in card or subsystem
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint16
+
+  epf,subsys-id:
+    description: Code to specify an id that is specific to a vendor
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint16
diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
new file mode 100644
index 000000000000..92c2e522b9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/endpoint/pci-epf-ntb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCI Endpoint NTB Function Device
+
+maintainers:
+  - Kishon Vijay Abraham I <kishon@ti.com>
+
+allOf:
+  - $ref: "pci-epf-device.yaml#"
+
+properties:
+  compatible:
+    const: pci-epf-ntb
+
+  epcs:
+    minItems: 2
+    maxItems: 2
+
+  epc-names:
+    items:
+      - const: primary
+      - const: secondary
+
+  num-mws:
+    description:
+      Specify the number of memory windows
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 4
+
+  mws-size:
+    description:
+      List of 'num-mws' entries containing size of each memory window.
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+  - epcs
+  - epc-names
+  - epf,vendor-id
+  - epf,device-id
+  - num-mws
+  - mws-size
+
+examples:
+  - |
+    epf_bus {
+      compatible = "pci-epf-bus";
+
+      func@0 {
+        compatible = "pci-epf-ntb";
+        reg = <0>;
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";
+        epf,vendor-id = /bits/ 16 <0x104c>;
+        epf,device-id = /bits/ 16 <0xb00d>;
+        num-mws = <4>;
+        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
+      };
+    };
+...
-- 
2.17.1


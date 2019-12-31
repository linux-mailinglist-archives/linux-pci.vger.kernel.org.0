Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A830612DB33
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 20:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLaTjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 14:39:09 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40911 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaTjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 14:39:09 -0500
Received: by mail-il1-f195.google.com with SMTP id c4so30832301ilo.7;
        Tue, 31 Dec 2019 11:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yzg1o+NejcreYIWjvsiNbCW/clv43Gm/h+fsjIitq30=;
        b=OeiZ6mPG+DV5XAGSwbp9ZZiRPuwwEdKHy6MaLR4+QESdlWiBWhsT4AIe9SWrZRJpXF
         KOizdgxLYQmXkTMHfblRiqFoFHVFQfkUFJeER0RaLwlGNDSYrsSqet7p7PAxSdjccXqA
         3rU4OVY+uIg1mwHQGwA1KRysW8E17dEgMwKcvLkbb2YiI3VQ+GPjWl3eAS5otZDNxgPi
         AwDHnYsHmdfe3rc5twwJDGFrAHYyq7OxBZuujbmt1UPQPXtLGP2mdyzmBaEGcT+TrV0l
         NArfUWvnervEME7Jj1KN6Tx1G6tCelvkN/RCxriQJ1gActBqRkfTzTSdn9kjgzA3OdBx
         I/vA==
X-Gm-Message-State: APjAAAU9QHX3Kb4F/g8wdCWBuQ7Y0zwFEswBRaeVmnt5Zz8K6kKUWJtm
        O+YVgqD8UO+nZ+D8Y65vfD4MSXM=
X-Google-Smtp-Source: APXvYqwKoRLvMY1JgUwVkI/f4SvRX7hdkXtRWKN9M258Nq2sCg9V8AV/C6stRJgoMs0kGNprBrJ7TA==
X-Received: by 2002:a92:914a:: with SMTP id t71mr65534894ild.293.1577821148339;
        Tue, 31 Dec 2019 11:39:08 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id e1sm17860074ill.47.2019.12.31.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 11:39:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
Date:   Tue, 31 Dec 2019 12:39:03 -0700
Message-Id: <20191231193903.15929-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191231193903.15929-1-robh@kernel.org>
References: <20191231193903.15929-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the generic PCI host binding to DT schema. The derivative Juno,
PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
their compatible strings. The simplest way to convert those to
schema is just add them into the common generic PCI host schema.

The HiSilicon ECAM and Cavium ThunderX PEM bindings have an additional
'reg' entry, but are otherwise the same binding as well.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Add in Cavium PEM and HiSilicon ECAM bindings
- Drop dma-coherent description
- Drop leftover interrupt mapping text
- Add description for generic compatibles and drop 'contains'

 .../bindings/pci/arm,juno-r1-pcie.txt         |  10 -
 .../bindings/pci/designware-pcie-ecam.txt     |  42 -----
 .../bindings/pci/hisilicon-pcie.txt           |  42 -----
 .../bindings/pci/host-generic-pci.txt         | 101 ----------
 .../bindings/pci/host-generic-pci.yaml        | 172 ++++++++++++++++++
 .../bindings/pci/pci-thunder-ecam.txt         |  30 ---
 .../bindings/pci/pci-thunder-pem.txt          |  43 -----
 .../bindings/pci/plda,xpressrich3-axi.txt     |  12 --
 MAINTAINERS                                   |   2 +-
 9 files changed, 173 insertions(+), 281 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

diff --git a/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt b/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
deleted file mode 100644
index f7514c170a32..000000000000
--- a/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-* ARM Juno R1 PCIe interface
-
-This PCIe host controller is based on PLDA XpressRICH3-AXI IP
-and thus inherits all the common properties defined in plda,xpressrich3-axi.txt
-as well as the base properties defined in host-generic-pci.txt.
-
-Required properties:
- - compatible: "arm,juno-r1-pcie"
- - dma-coherent: The host controller bridges the AXI transactions into PCIe bus
-   in a manner that makes the DMA operations to appear coherent to the CPUs.
diff --git a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt b/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
deleted file mode 100644
index 515b2f9542e5..000000000000
--- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* Synopsys DesignWare PCIe root complex in ECAM shift mode
-
-In some cases, firmware may already have configured the Synopsys DesignWare
-PCIe controller in RC mode with static ATU window mappings that cover all
-config, MMIO and I/O spaces in a [mostly] ECAM compatible fashion.
-In this case, there is no need for the OS to perform any low level setup
-of clocks, PHYs or device registers, nor is there any reason for the driver
-to reconfigure ATU windows for config and/or IO space accesses at runtime.
-
-In cases where the IP was synthesized with a minimum ATU window size of
-64 KB, it cannot be supported by the generic ECAM driver, because it
-requires special config space accessors that filter accesses to device #1
-and beyond on the first bus.
-
-Required properties:
-- compatible: "marvell,armada8k-pcie-ecam" or
-              "socionext,synquacer-pcie-ecam" or
-              "snps,dw-pcie-ecam" (must be preceded by a more specific match)
-
-Please refer to the binding document of "pci-host-ecam-generic" in the
-file host-generic-pci.txt for a description of the remaining required
-and optional properties.
-
-Example:
-
-    pcie1: pcie@7f000000 {
-        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
-        device_type = "pci";
-        reg = <0x0 0x7f000000 0x0 0xf00000>;
-        bus-range = <0x0 0xe>;
-        #address-cells = <3>;
-        #size-cells = <2>;
-        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
-                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
-                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
-
-        #interrupt-cells = <0x1>;
-        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
-        interrupt-map = <0x0 0x0 0x0 0x0 &gic 0x0 0x0 0x0 182 0x4>;
-        msi-map = <0x0 &its 0x0 0x10000>;
-        dma-coherent;
-    };
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 0dcb87d6554f..d6796ef54ea1 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -41,45 +41,3 @@ Hip05 Example (note that Hip06 is the same except compatible):
 				 0x0 0 0 3 &mbigen_pcie 3 12
 				 0x0 0 0 4 &mbigen_pcie 4 13>;
 	};
-
-HiSilicon Hip06/Hip07 PCIe host bridge DT (almost-ECAM) description.
-
-Some BIOSes place the host controller in a mode where it is ECAM
-compliant for all devices other than the root complex. In such cases,
-the host controller should be described as below.
-
-The properties and their meanings are identical to those described in
-host-generic-pci.txt except as listed below.
-
-Properties of the host controller node that differ from
-host-generic-pci.txt:
-
-- compatible     : Must be "hisilicon,hip06-pcie-ecam", or
-		   "hisilicon,hip07-pcie-ecam"
-
-- reg            : Two entries: First the ECAM configuration space for any
-		   other bus underneath the root bus. Second, the base
-		   and size of the HiSilicon host bridge registers include
-		   the RC's own config space.
-
-Example:
-	pcie0: pcie@a0090000 {
-		compatible = "hisilicon,hip06-pcie-ecam";
-		reg = <0 0xb0000000 0 0x2000000>,  /*  ECAM configuration space */
-		      <0 0xa0090000 0 0x10000>; /* host bridge registers */
-		bus-range = <0  31>;
-		msi-map = <0x0000 &its_dsa 0x0000 0x2000>;
-		msi-map-mask = <0xffff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		dma-coherent;
-		ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0 0x5ff0000
-			  0x01000000 0 0 0 0xb7ff0000 0 0x10000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
-				 0x0 0 0 2 &mbigen_pcie0 650 4
-				 0x0 0 0 3 &mbigen_pcie0 650 4
-				 0x0 0 0 4 &mbigen_pcie0 650 4>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
deleted file mode 100644
index 614b594f4e72..000000000000
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
+++ /dev/null
@@ -1,101 +0,0 @@
-* Generic PCI host controller
-
-Firmware-initialised PCI host controllers and PCI emulations, such as the
-virtio-pci implementations found in kvmtool and other para-virtualised
-systems, do not require driver support for complexities such as regulator
-and clock management. In fact, the controller may not even require the
-configuration of a control interface by the operating system, instead
-presenting a set of fixed windows describing a subset of IO, Memory and
-Configuration Spaces.
-
-Such a controller can be described purely in terms of the standardized device
-tree bindings communicated in pci.txt:
-
-
-Properties of the host controller node:
-
-- compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
-                   depending on the layout of configuration space (CAM vs
-                   ECAM respectively).
-
-- device_type    : Must be "pci".
-
-- ranges         : As described in IEEE Std 1275-1994, but must provide
-                   at least a definition of non-prefetchable memory. One
-                   or both of prefetchable Memory and IO Space may also
-                   be provided.
-
-- bus-range      : Optional property (also described in IEEE Std 1275-1994)
-                   to indicate the range of bus numbers for this controller.
-                   If absent, defaults to <0 255> (i.e. all buses).
-
-- #address-cells : Must be 3.
-
-- #size-cells    : Must be 2.
-
-- reg            : The Configuration Space base address and size, as accessed
-                   from the parent bus.  The base address corresponds to
-                   the first bus in the "bus-range" property.  If no
-                   "bus-range" is specified, this will be bus 0 (the default).
-
-Properties of the /chosen node:
-
-- linux,pci-probe-only
-                 : Optional property which takes a single-cell argument.
-                   If '0', then Linux will assign devices in its usual manner,
-                   otherwise it will not try to assign devices and instead use
-                   them as they are configured already.
-
-Configuration Space is assumed to be memory-mapped (as opposed to being
-accessed via an ioport) and laid out with a direct correspondence to the
-geography of a PCI bus address by concatenating the various components to
-form an offset.
-
-For CAM, this 24-bit offset is:
-
-        cfg_offset(bus, device, function, register) =
-                   bus << 16 | device << 11 | function << 8 | register
-
-While ECAM extends this by 4 bits to accommodate 4k of function space:
-
-        cfg_offset(bus, device, function, register) =
-                   bus << 20 | device << 15 | function << 12 | register
-
-Interrupt mapping is exactly as described in `Open Firmware Recommended
-Practice: Interrupt Mapping' and requires the following properties:
-
-- #interrupt-cells   : Must be 1
-
-- interrupt-map      : <see aforementioned specification>
-
-- interrupt-map-mask : <see aforementioned specification>
-
-
-Example:
-
-pci {
-    compatible = "pci-host-cam-generic"
-    device_type = "pci";
-    #address-cells = <3>;
-    #size-cells = <2>;
-    bus-range = <0x0 0x1>;
-
-    // CPU_PHYSICAL(2)  SIZE(2)
-    reg = <0x0 0x40000000  0x0 0x1000000>;
-
-    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
-    ranges = <0x01000000 0x0 0x01000000  0x0 0x01000000  0x0 0x00010000>,
-             <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
-
-
-    #interrupt-cells = <0x1>;
-
-    // PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
-    interrupt-map = <  0x0 0x0 0x0  0x1  &gic  0x0 0x4 0x1
-                     0x800 0x0 0x0  0x1  &gic  0x0 0x5 0x1
-                    0x1000 0x0 0x0  0x1  &gic  0x0 0x6 0x1
-                    0x1800 0x0 0x0  0x1  &gic  0x0 0x7 0x1>;
-
-    // PCI_DEVICE(3)  INT#(1)
-    interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
-}
diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
new file mode 100644
index 000000000000..47353d0cd394
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic PCI host controller
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+
+description: |
+  Firmware-initialised PCI host controllers and PCI emulations, such as the
+  virtio-pci implementations found in kvmtool and other para-virtualised
+  systems, do not require driver support for complexities such as regulator
+  and clock management. In fact, the controller may not even require the
+  configuration of a control interface by the operating system, instead
+  presenting a set of fixed windows describing a subset of IO, Memory and
+  Configuration Spaces.
+
+  Configuration Space is assumed to be memory-mapped (as opposed to being
+  accessed via an ioport) and laid out with a direct correspondence to the
+  geography of a PCI bus address by concatenating the various components to
+  form an offset.
+
+  For CAM, this 24-bit offset is:
+
+          cfg_offset(bus, device, function, register) =
+                     bus << 16 | device << 11 | function << 8 | register
+
+  While ECAM extends this by 4 bits to accommodate 4k of function space:
+
+          cfg_offset(bus, device, function, register) =
+                     bus << 20 | device << 15 | function << 12 | register
+
+properties:
+  compatible:
+    description: Depends on the layout of configuration space (CAM vs ECAM
+      respectively). May also have more specific compatibles.
+    oneOf:
+      - description:
+          PCIe host controller in Arm Juno based on PLDA XpressRICH3-AXI IP
+        items:
+          - const: arm,juno-r1-pcie
+          - const: plda,xpressrich3-axi
+          - const: pci-host-ecam-generic
+      - description: |
+          ThunderX PCI host controller for pass-1.x silicon
+
+          Firmware-initialized PCI host controller to on-chip devices found on
+          some Cavium ThunderX processors.  These devices have ECAM-based config
+          access, but the BARs are all at fixed addresses.  We handle the fixed
+          addresses by synthesizing Enhanced Allocation (EA) capabilities for
+          these devices.
+        const: cavium,pci-host-thunder-ecam
+      - description:
+          Cavium ThunderX PEM firmware-initialized PCIe host controller
+        const: cavium,pci-host-thunder-pem
+      - description:
+          HiSilicon Hip06/Hip07 PCIe host bridge in almost-ECAM mode. Some
+          firmware places the host controller in a mode where it is ECAM
+          compliant for all devices other than the root complex.
+        enum:
+          - hisilicon,hip06-pcie-ecam
+          - hisilicon,hip07-pcie-ecam
+      - description: |
+          In some cases, firmware may already have configured the Synopsys
+          DesignWare PCIe controller in RC mode with static ATU window mappings
+          that cover all config, MMIO and I/O spaces in a [mostly] ECAM
+          compatible fashion. In this case, there is no need for the OS to
+          perform any low level setup of clocks, PHYs or device registers, nor
+          is there any reason for the driver to reconfigure ATU windows for
+          config and/or IO space accesses at runtime.
+
+          In cases where the IP was synthesized with a minimum ATU window size
+          of 64 KB, it cannot be supported by the generic ECAM driver, because
+          it requires special config space accessors that filter accesses to
+          device #1 and beyond on the first bus.
+        items:
+          - enum:
+              - marvell,armada8k-pcie-ecam
+              - socionext,synquacer-pcie-ecam
+          - const: snps,dw-pcie-ecam
+      - description:
+          CAM or ECAM compliant PCI host controllers without any quirks
+        enum:
+          - pci-host-cam-generic
+          - pci-host-ecam-generic
+
+  reg:
+    description:
+      The Configuration Space base address and size, as accessed from the parent
+      bus. The base address corresponds to the first bus in the "bus-range"
+      property. If no "bus-range" is specified, this will be bus 0 (the
+      default). Some host controllers have a 2nd non-compliant address range,
+      so 2 entries are allowed.
+    minItems: 1
+    maxItems: 2
+
+  ranges:
+    description:
+      As described in IEEE Std 1275-1994, but must provide at least a
+      definition of non-prefetchable memory. One or both of prefetchable Memory
+      and IO Space may also be provided.
+    minItems: 1
+    maxItems: 3
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,juno-r1-pcie
+    then:
+      required:
+        - dma-coherent
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - cavium,pci-host-thunder-pem
+                - hisilicon,hip06-pcie-ecam
+                - hisilicon,hip07-pcie-ecam
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+examples:
+  - |
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@40000000 {
+            compatible = "pci-host-cam-generic";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x0 0x1>;
+
+            // CPU_PHYSICAL(2)  SIZE(2)
+            reg = <0x0 0x40000000  0x0 0x1000000>;
+
+            // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
+            ranges = <0x01000000 0x0 0x01000000  0x0 0x01000000  0x0 0x00010000>,
+                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
+
+            #interrupt-cells = <0x1>;
+
+            // PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
+            interrupt-map = <   0x0 0x0 0x0  0x1  &gic  0x0 0x4 0x1>,
+                            < 0x800 0x0 0x0  0x1  &gic  0x0 0x5 0x1>,
+                            <0x1000 0x0 0x0  0x1  &gic  0x0 0x6 0x1>,
+                            <0x1800 0x0 0x0  0x1  &gic  0x0 0x7 0x1>;
+
+            // PCI_DEVICE(3)  INT#(1)
+            interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt b/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
deleted file mode 100644
index f478874b79ce..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* ThunderX PCI host controller for pass-1.x silicon
-
-Firmware-initialized PCI host controller to on-chip devices found on
-some Cavium ThunderX processors.  These devices have ECAM-based config
-access, but the BARs are all at fixed addresses.  We handle the fixed
-addresses by synthesizing Enhanced Allocation (EA) capabilities for
-these devices.
-
-The properties and their meanings are identical to those described in
-host-generic-pci.txt except as listed below.
-
-Properties of the host controller node that differ from
-host-generic-pci.txt:
-
-- compatible     : Must be "cavium,pci-host-thunder-ecam"
-
-Example:
-
-	pcie@84b000000000 {
-		compatible = "cavium,pci-host-thunder-ecam";
-		device_type = "pci";
-		msi-parent = <&its>;
-		msi-map = <0 &its 0x30000 0x10000>;
-		bus-range = <0 31>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		#stream-id-cells = <1>;
-		reg = <0x84b0 0x00000000 0 0x02000000>;  /* Configuration space */
-		ranges = <0x03000000 0x8180 0x00000000 0x8180 0x00000000 0x80 0x00000000>; /* mem ranges */
-	};
diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
deleted file mode 100644
index f131faea3b7c..000000000000
--- a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* ThunderX PEM PCIe host controller
-
-Firmware-initialized PCI host controller found on some Cavium
-ThunderX processors.
-
-The properties and their meanings are identical to those described in
-host-generic-pci.txt except as listed below.
-
-Properties of the host controller node that differ from
-host-generic-pci.txt:
-
-- compatible     : Must be "cavium,pci-host-thunder-pem"
-
-- reg            : Two entries: First the configuration space for down
-                   stream devices base address and size, as accessed
-                   from the parent bus. Second, the register bank of
-                   the PEM device PCIe bridge.
-
-Example:
-
-    pci@87e0,c2000000 {
-	compatible = "cavium,pci-host-thunder-pem";
-	device_type = "pci";
-	msi-parent = <&its>;
-	msi-map = <0 &its 0x10000 0x10000>;
-	bus-range = <0x8f 0xc7>;
-	#size-cells = <2>;
-	#address-cells = <3>;
-
-	reg = <0x8880 0x8f000000 0x0 0x39000000>,  /* Configuration space */
-	      <0x87e0 0xc2000000 0x0 0x00010000>; /* PEM space */
-	ranges = <0x01000000 0x00 0x00020000 0x88b0 0x00020000 0x00 0x00010000>, /* I/O */
-		 <0x03000000 0x00 0x10000000 0x8890 0x10000000 0x0f 0xf0000000>, /* mem64 */
-		 <0x43000000 0x10 0x00000000 0x88a0 0x00000000 0x10 0x00000000>, /* mem64-pref */
-		 <0x03000000 0x87e0 0xc2f00000 0x87e0 0xc2000000 0x00 0x00100000>; /* mem64 PEM BAR4 */
-
-	#interrupt-cells = <1>;
-	interrupt-map-mask = <0 0 0 7>;
-	interrupt-map = <0 0 0 1 &gic0 0 0 0 24 4>, /* INTA */
-			<0 0 0 2 &gic0 0 0 0 25 4>, /* INTB */
-			<0 0 0 3 &gic0 0 0 0 26 4>, /* INTC */
-			<0 0 0 4 &gic0 0 0 0 27 4>; /* INTD */
-    };
diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
deleted file mode 100644
index f3f75bfb42bc..000000000000
--- a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* PLDA XpressRICH3-AXI host controller
-
-The PLDA XpressRICH3-AXI host controller can be configured in a manner that
-makes it compliant with the SBSA[1] standard published by ARM Ltd. For those
-scenarios, the host-generic-pci.txt bindings apply with the following additions
-to the compatible property:
-
-Required properties:
- - compatible: should contain "plda,xpressrich3-axi" to identify the IP used.
-
-
-[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
diff --git a/MAINTAINERS b/MAINTAINERS
index b55f9dd7c47a..d13924690259 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12613,7 +12613,7 @@ M:	Will Deacon <will@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
+F:	Documentation/devicetree/bindings/pci/host-generic-pci.yaml
 F:	drivers/pci/controller/pci-host-common.c
 F:	drivers/pci/controller/pci-host-generic.c
 
-- 
2.20.1


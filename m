Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198B3FE9F3
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 01:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKPAwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 19:52:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38395 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfKPAwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 19:52:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so9601200oti.5;
        Fri, 15 Nov 2019 16:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QiZWV9+TKcIvaa+QbP2SeO8UjexKrCZpIntBA+lfA0E=;
        b=sDLhbsa55udlhY656H66v1ZJy07DkbwIk/PgIWi490+IRiUfR0PC4qcUT5TO+TQy4F
         5S0RjPV/O0WKwFwllkEpwbzfJ3akvt49YIlnE4JNyxSMRiRjkqLogSo+nCq8DmxiGgmy
         kPmcI3nwZAbnf/MJnJq481yMHqOdHb2B6DQ/1F/oZxENmDqM7jkaX4tiJSNhE6A4pEmt
         YCdGHPVIFQfK/dEVaRY8pK6REg2zxvDrhd27EWrfbCnJKhbYO8orgo0NCkEfQKm30JH5
         /ocVvXuwgCH/pLhex7uL8uQpVUTKKh/kVBm7OllCJmDTTR8OI0PfOgOhxLb497s8h7Og
         A75w==
X-Gm-Message-State: APjAAAX5WVjPR9CL4dKXPIFibTs+Iz8ji9hWrcx07O/a+1Y97hZpQYsI
        Rvc4/OChxo7kLNGCH2URAVm2h48=
X-Google-Smtp-Source: APXvYqxw5BsBMu3h7fAuw5plahHWVntkiS+sPpbeUOhyxemqnl9wrXQmNx7BNWol13upwftpoBICvw==
X-Received: by 2002:a9d:1b01:: with SMTP id l1mr2862145otl.141.1573865563474;
        Fri, 15 Nov 2019 16:52:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g18sm3525680otg.50.2019.11.15.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:52:42 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
Date:   Fri, 15 Nov 2019 18:52:40 -0600
Message-Id: <20191116005240.15722-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116005240.15722-1-robh@kernel.org>
References: <20191116005240.15722-1-robh@kernel.org>
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

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/arm,juno-r1-pcie.txt         |  10 --
 .../bindings/pci/designware-pcie-ecam.txt     |  42 -----
 .../bindings/pci/hisilicon-pcie.txt           |   4 +-
 .../bindings/pci/host-generic-pci.txt         | 101 ------------
 .../bindings/pci/host-generic-pci.yaml        | 150 ++++++++++++++++++
 .../bindings/pci/pci-thunder-ecam.txt         |  30 ----
 .../bindings/pci/pci-thunder-pem.txt          |   7 +-
 .../bindings/pci/plda,xpressrich3-axi.txt     |  12 --
 MAINTAINERS                                   |   2 +-
 9 files changed, 155 insertions(+), 203 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
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
index 0dcb87d6554f..adf66a26b70b 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -49,10 +49,10 @@ compliant for all devices other than the root complex. In such cases,
 the host controller should be described as below.
 
 The properties and their meanings are identical to those described in
-host-generic-pci.txt except as listed below.
+host-generic-pci.yaml except as listed below.
 
 Properties of the host controller node that differ from
-host-generic-pci.txt:
+host-generic-pci.yaml:
 
 - compatible     : Must be "hisilicon,hip06-pcie-ecam", or
 		   "hisilicon,hip07-pcie-ecam"
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
index 000000000000..7c3f3b2bdd57
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -0,0 +1,150 @@
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
+  Interrupt mapping is exactly as described in `Open Firmware Recommended
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    description: Depends on the layout of configuration space (CAM vs ECAM
+      respectively). May also have more specific compatibles.
+    anyOf:
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
+      - contains:
+          enum:
+            - pci-host-cam-generic
+            - pci-host-ecam-generic
+
+  reg:
+    description:
+      The Configuration Space base address and size, as accessed from the parent
+      bus. The base address corresponds to the first bus in the "bus-range"
+      property. If no "bus-range" is specified, this will be bus 0 (the
+      default).
+    maxItems: 1
+
+  ranges:
+    description:
+      As described in IEEE Std 1275-1994, but must provide at least a
+      definition of non-prefetchable memory. One or both of prefetchable Memory
+      and IO Space may also be provided.
+    minItems: 1
+    maxItems: 3
+
+  dma-coherent:
+    description: The host controller bridges the AXI transactions into PCIe bus
+      in a manner that makes the DMA operations to appear coherent to the CPUs.
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: arm,juno-r1-pcie
+then:
+  required:
+    - dma-coherent
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
index f131faea3b7c..f3c87d55753b 100644
--- a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
+++ b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
@@ -3,11 +3,8 @@
 Firmware-initialized PCI host controller found on some Cavium
 ThunderX processors.
 
-The properties and their meanings are identical to those described in
-host-generic-pci.txt except as listed below.
-
-Properties of the host controller node that differ from
-host-generic-pci.txt:
+In addition to standard PCI host bridge properties, the following properties
+are required:
 
 - compatible     : Must be "cavium,pci-host-thunder-pem"
 
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
index 21f3393c36e3..3a5ddc0d530c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12434,7 +12434,7 @@ M:	Will Deacon <will@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
+F:	Documentation/devicetree/bindings/pci/host-generic-pci.yaml
 F:	drivers/pci/controller/pci-host-common.c
 F:	drivers/pci/controller/pci-host-generic.c
 
-- 
2.20.1


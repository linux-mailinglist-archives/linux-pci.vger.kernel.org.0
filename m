Return-Path: <linux-pci+bounces-25878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58DA88DF2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D8B3A8318
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C801F4179;
	Mon, 14 Apr 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDoa57BL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D41F4169;
	Mon, 14 Apr 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666925; cv=none; b=DcGr2hqTt4zVx2H0eHjSdEvMMQBvsOaYrBdZu9SsoVQ8jqHSgJ6J1h6Va9oktu17THN1fctWcisiqf294cPKrsj5Z8KAiVeQMJycNJ8K6PmmdawXlyxdN1FkYZLTMG1UlnapGPb9m8b5IBwmCaK/f/WzpCSQ+kHiEZPlVeOEZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666925; c=relaxed/simple;
	bh=l1odAD402a8ckeaggKO5pvRP5ybvt4pRjN4BtTV72H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLDXJdMjajSTy4DcV4JmKzPAWuOX+ZHfE8L1URkUYSMSi47ioWqJozWoFOpl36SFXW4HFNfDwyh8OECYePH+z4XDrK1fnuFdLo0W2iedKMOO+qmuPuBRUhq/TULbmbAHWgzvwgfZK9MaKY67/GNDhv00g+l2m1A8OHYwJBEd4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDoa57BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB87CC4CEE2;
	Mon, 14 Apr 2025 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744666925;
	bh=l1odAD402a8ckeaggKO5pvRP5ybvt4pRjN4BtTV72H4=;
	h=From:To:Cc:Subject:Date:From;
	b=FDoa57BLLB7NvBIaGJg7RFd603E4dU479X2JasOHG4iflItuQZ8oZY5ca9e28vy3L
	 rns4ur6QXz6xp3HaZhTZdbwPIh7qL/m2whU8fbYWJsKyPAnx9kpywaS8CPIOSMaYqH
	 /mD6pr3G8IRKIt25RTg6Yho89Vl2JvURRrD9AKSNfH57rHgWHnopjgZkXCSsqiLx04
	 s7oIto3Z7woem4qXRp/mqE04ooCk6sDGcSF0hWojJgcc/nQOFe9Mhzs49Xbct5WsKL
	 RQkgJ9HWd2cjXWtoPRxZ+sf7DwDcPpTwSnSf6+y9ELCOnqS6/0hpUCKz/zfYrhnR0q
	 KGXg2RvFu7qXQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert Marvell EBU to schema
Date: Mon, 14 Apr 2025 16:41:48 -0500
Message-ID: <20250414214157.1680484-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Marvell EBU (Kirkwood, Dove, Armada XP/370) to DT schema
format. Add "error" to interrupt-names which is in use, but missing.

Shorten the example from 10 child nodes to 6 as the additional ones
don't add much value to the example.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/marvell,kirkwood-pcie.yaml   | 277 ++++++++++++++++
 .../devicetree/bindings/pci/mvebu-pci.txt     | 310 ------------------
 2 files changed, 277 insertions(+), 310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
new file mode 100644
index 000000000000..7be695320ddf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
@@ -0,0 +1,277 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/marvell,kirkwood-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell EBU PCIe interfaces
+
+maintainers:
+  - Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+  - Pali Rohár <pali@kernel.org>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-370-pcie
+      - marvell,armada-xp-pcie
+      - marvell,dove-pcie
+      - marvell,kirkwood-pcie
+
+  ranges:
+    description: >
+      The ranges describing the MMIO registers have the following layout:
+
+        0x82000000 0 r MBUS_ID(0xf0, 0x01) r 0 s
+
+      where:
+
+        * r is a 32-bits value that gives the offset of the MMIO registers of
+        this PCIe interface, from the base of the internal registers.
+
+        * s is a 32-bits value that give the size of this MMIO registers area.
+        This range entry translates the '0x82000000 0 r' PCI address into the
+        'MBUS_ID(0xf0, 0x01) r' CPU address, which is part of the internal
+        register window (as identified by MBUS_ID(0xf0, 0x01)).
+
+      The ranges describing the MBus windows have the following layout:
+
+          0x8t000000 s 0     MBUS_ID(w, a) 0 1 0
+
+      where:
+
+        * t is the type of the MBus window (as defined by the standard PCI DT
+        bindings), 1 for I/O and 2 for memory.
+
+        * s is the PCI slot that corresponds to this PCIe interface
+
+        * w is the 'target ID' value for the MBus window
+
+        * a the 'attribute' value for the MBus window.
+
+      Since the location and size of the different MBus windows is not fixed in
+      hardware, and only determined in runtime, those ranges cover the full first
+      4 GB of the physical address space, and do not translate into a valid CPU
+      address.
+
+  msi-parent:
+    maxItems: 1
+
+patternProperties:
+  '^pcie@':
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-bus-common.yaml#
+      - $ref: /schemas/pci/pci-device.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      clocks:
+        maxItems: 1
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      interrupt-names:
+        minItems: 1
+        items:
+          - const: intx
+          - const: error
+
+      reset-delay-us:
+        default: 100000
+        description: todo
+
+      marvell,pcie-port:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 3
+        description: todo
+
+      marvell,pcie-lane:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 3
+        description: todo
+
+      interrupt-controller:
+        type: object
+        additionalProperties: false
+
+        properties:
+          interrupt-controller: true
+
+          '#interrupt-cells':
+            const: 1
+
+    required:
+      - assigned-addresses
+      - clocks
+      - interrupt-map
+      - marvell,pcie-port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@f001000000000000 {
+            compatible = "marvell,armada-xp-pcie";
+            device_type = "pci";
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            bus-range = <0x00 0xff>;
+            msi-parent = <&mpic>;
+
+            ranges =
+                  <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000  /* Port 0.0 registers */
+                    0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000  /* Port 2.0 registers */
+                    0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000  /* Port 0.1 registers */
+                    0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000  /* Port 0.2 registers */
+                    0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000  /* Port 0.3 registers */
+                    0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000  /* Port 1.0 registers */
+                    0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000  /* Port 3.0 registers */
+                    0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000  /* Port 1.1 registers */
+                    0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000  /* Port 1.2 registers */
+                    0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000  /* Port 1.3 registers */
+                    0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
+                    0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
+                    0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
+                    0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
+                    0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
+                    0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
+                    0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
+                    0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
+
+                    0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
+                    0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
+                    0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
+                    0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
+                    0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
+                    0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
+                    0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
+                    0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
+
+                    0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
+                    0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
+
+                    0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
+                    0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
+
+            pcie@1,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+                reg = <0x0800 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+                    0x81000000 0 0 0x81000000 0x1 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 58>;
+                marvell,pcie-port = <0>;
+                marvell,pcie-lane = <0>;
+                num-lanes = <1>;
+                /* low-active PERST# reset on GPIO 25 */
+                reset-gpios = <&gpio0 25 1>;
+                /* wait 20ms for device settle after reset deassertion */
+                reset-delay-us = <20000>;
+                clocks = <&gateclk 5>;
+            };
+
+            pcie@2,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
+                reg = <0x1000 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
+                    0x81000000 0 0 0x81000000 0x2 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 59>;
+                marvell,pcie-port = <0>;
+                marvell,pcie-lane = <1>;
+                num-lanes = <1>;
+                clocks = <&gateclk 6>;
+            };
+
+            pcie@3,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
+                reg = <0x1800 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
+                    0x81000000 0 0 0x81000000 0x3 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 60>;
+                marvell,pcie-port = <0>;
+                marvell,pcie-lane = <2>;
+                num-lanes = <1>;
+                clocks = <&gateclk 7>;
+            };
+
+            pcie@4,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
+                reg = <0x2000 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
+                    0x81000000 0 0 0x81000000 0x4 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 61>;
+                marvell,pcie-port = <0>;
+                marvell,pcie-lane = <3>;
+                num-lanes = <1>;
+                clocks = <&gateclk 8>;
+            };
+
+            pcie@5,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
+                reg = <0x2800 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
+                    0x81000000 0 0 0x81000000 0x5 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 62>;
+                marvell,pcie-port = <1>;
+                marvell,pcie-lane = <0>;
+                num-lanes = <1>;
+                clocks = <&gateclk 9>;
+            };
+
+            pcie@6,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
+                reg = <0x3000 0 0 0 0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+                ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
+                    0x81000000 0 0 0x81000000 0x6 0 1 0>;
+                interrupt-map-mask = <0 0 0 0>;
+                interrupt-map = <0 0 0 0 &mpic 63>;
+                marvell,pcie-port = <1>;
+                marvell,pcie-lane = <1>;
+                num-lanes = <1>;
+                clocks = <&gateclk 10>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
deleted file mode 100644
index 6d022a9d36ee..000000000000
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ /dev/null
@@ -1,310 +0,0 @@
-* Marvell EBU PCIe interfaces
-
-Mandatory properties:
-
-- compatible: one of the following values:
-    marvell,armada-370-pcie
-    marvell,armada-xp-pcie
-    marvell,dove-pcie
-    marvell,kirkwood-pcie
-- #address-cells, set to <3>
-- #size-cells, set to <2>
-- #interrupt-cells, set to <1>
-- bus-range: PCI bus numbers covered
-- device_type, set to "pci"
-- ranges: ranges describing the MMIO registers to control the PCIe
-  interfaces, and ranges describing the MBus windows needed to access
-  the memory and I/O regions of each PCIe interface.
-- msi-parent: Link to the hardware entity that serves as the Message
-  Signaled Interrupt controller for this PCI controller.
-
-The ranges describing the MMIO registers have the following layout:
-
-    0x82000000 0 r MBUS_ID(0xf0, 0x01) r 0 s
-
-where:
-
-  * r is a 32-bits value that gives the offset of the MMIO
-  registers of this PCIe interface, from the base of the internal
-  registers.
-
-  * s is a 32-bits value that give the size of this MMIO
-  registers area. This range entry translates the '0x82000000 0 r' PCI
-  address into the 'MBUS_ID(0xf0, 0x01) r' CPU address, which is part
-  of the internal register window (as identified by MBUS_ID(0xf0,
-  0x01)).
-
-The ranges describing the MBus windows have the following layout:
-
-    0x8t000000 s 0     MBUS_ID(w, a) 0 1 0
-
-where:
-
-   * t is the type of the MBus window (as defined by the standard PCI DT
-   bindings), 1 for I/O and 2 for memory.
-
-   * s is the PCI slot that corresponds to this PCIe interface
-
-   * w is the 'target ID' value for the MBus window
-
-   * a the 'attribute' value for the MBus window.
-
-Since the location and size of the different MBus windows is not fixed in
-hardware, and only determined in runtime, those ranges cover the full first
-4 GB of the physical address space, and do not translate into a valid CPU
-address.
-
-In addition, the device tree node must have sub-nodes describing each
-PCIe interface, having the following mandatory properties:
-
-- reg: used only for interrupt mapping, so only the first four bytes
-  are used to refer to the correct bus number and device number.
-- assigned-addresses: reference to the MMIO registers used to control
-  this PCIe interface.
-- clocks: the clock associated to this PCIe interface
-- marvell,pcie-port: the physical PCIe port number
-- status: either "disabled" or "okay"
-- device_type, set to "pci"
-- #address-cells, set to <3>
-- #size-cells, set to <2>
-- #interrupt-cells, set to <1>
-- ranges, translating the MBus windows ranges of the parent node into
-  standard PCI addresses.
-- interrupt-map-mask and interrupt-map, standard PCI properties to
-  define the mapping of the PCIe interface to interrupt numbers.
-
-and the following optional properties:
-- marvell,pcie-lane: the physical PCIe lane number, for ports having
-  multiple lanes. If this property is not found, we assume that the
-  value is 0.
-- num-lanes: number of SerDes PCIe lanes for this link (1 or 4)
-- reset-gpios: optional GPIO to PERST#
-- reset-delay-us: delay in us to wait after reset de-assertion, if not
-  specified will default to 100ms, as required by the PCIe specification.
-- interrupt-names: list of interrupt names, supported are:
-   - "intx" - interrupt line triggered by one of the legacy interrupt
-- interrupts or interrupts-extended: List of the interrupt sources which
-  corresponding to the "interrupt-names". If non-empty then also additional
-  'interrupt-controller' subnode must be defined.
-
-Example:
-
-pcie-controller {
-	compatible = "marvell,armada-xp-pcie";
-	device_type = "pci";
-
-	#address-cells = <3>;
-	#size-cells = <2>;
-
-	bus-range = <0x00 0xff>;
-	msi-parent = <&mpic>;
-
-	ranges =
-	       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000	/* Port 0.0 registers */
-		0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000	/* Port 2.0 registers */
-		0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000	/* Port 0.1 registers */
-		0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000	/* Port 0.2 registers */
-		0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000	/* Port 0.3 registers */
-		0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000	/* Port 1.0 registers */
-		0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000	/* Port 3.0 registers */
-		0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000	/* Port 1.1 registers */
-		0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000	/* Port 1.2 registers */
-		0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000	/* Port 1.3 registers */
-		0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
-		0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
-		0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
-		0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
-		0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
-		0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
-		0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
-		0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
-
-		0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
-		0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
-		0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
-		0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
-		0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
-		0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
-		0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
-		0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
-
-		0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
-		0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
-
-		0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
-		0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
-
-	pcie@1,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
-		reg = <0x0800 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
-			  0x81000000 0 0 0x81000000 0x1 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 58>;
-		marvell,pcie-port = <0>;
-		marvell,pcie-lane = <0>;
-		num-lanes = <1>;
-		/* low-active PERST# reset on GPIO 25 */
-		reset-gpios = <&gpio0 25 1>;
-		/* wait 20ms for device settle after reset deassertion */
-		reset-delay-us = <20000>;
-		clocks = <&gateclk 5>;
-	};
-
-	pcie@2,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
-		reg = <0x1000 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
-			  0x81000000 0 0 0x81000000 0x2 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 59>;
-		marvell,pcie-port = <0>;
-		marvell,pcie-lane = <1>;
-		num-lanes = <1>;
-		clocks = <&gateclk 6>;
-	};
-
-	pcie@3,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
-		reg = <0x1800 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
-			  0x81000000 0 0 0x81000000 0x3 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 60>;
-		marvell,pcie-port = <0>;
-		marvell,pcie-lane = <2>;
-		num-lanes = <1>;
-		clocks = <&gateclk 7>;
-	};
-
-	pcie@4,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
-		reg = <0x2000 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
-			  0x81000000 0 0 0x81000000 0x4 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 61>;
-		marvell,pcie-port = <0>;
-		marvell,pcie-lane = <3>;
-		num-lanes = <1>;
-		clocks = <&gateclk 8>;
-	};
-
-	pcie@5,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
-		reg = <0x2800 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
-			  0x81000000 0 0 0x81000000 0x5 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 62>;
-		marvell,pcie-port = <1>;
-		marvell,pcie-lane = <0>;
-		num-lanes = <1>;
-		clocks = <&gateclk 9>;
-	};
-
-	pcie@6,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
-		reg = <0x3000 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x6 0 1 0
-			  0x81000000 0 0 0x81000000 0x6 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 63>;
-		marvell,pcie-port = <1>;
-		marvell,pcie-lane = <1>;
-		num-lanes = <1>;
-		clocks = <&gateclk 10>;
-	};
-
-	pcie@7,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
-		reg = <0x3800 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x7 0 1 0
-			  0x81000000 0 0 0x81000000 0x7 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 64>;
-		marvell,pcie-port = <1>;
-		marvell,pcie-lane = <2>;
-		num-lanes = <1>;
-		clocks = <&gateclk 11>;
-	};
-
-	pcie@8,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
-		reg = <0x4000 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x8 0 1 0
-			  0x81000000 0 0 0x81000000 0x8 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 65>;
-		marvell,pcie-port = <1>;
-		marvell,pcie-lane = <3>;
-		num-lanes = <1>;
-		clocks = <&gateclk 12>;
-	};
-
-	pcie@9,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
-		reg = <0x4800 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
-			  0x81000000 0 0 0x81000000 0x9 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 99>;
-		marvell,pcie-port = <2>;
-		marvell,pcie-lane = <0>;
-		num-lanes = <1>;
-		clocks = <&gateclk 26>;
-	};
-
-	pcie@a,0 {
-		device_type = "pci";
-		assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
-		reg = <0x5000 0 0 0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x82000000 0 0 0x82000000 0xa 0 1 0
-			  0x81000000 0 0 0x81000000 0xa 0 1 0>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &mpic 103>;
-		marvell,pcie-port = <3>;
-		marvell,pcie-lane = <0>;
-		num-lanes = <1>;
-		clocks = <&gateclk 27>;
-	};
-};
-- 
2.47.2



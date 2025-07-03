Return-Path: <linux-pci+bounces-31352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D0AF6FF7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390BD3AA2B1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66F2E2EFD;
	Thu,  3 Jul 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtUwGCtK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F072E2EE0;
	Thu,  3 Jul 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538320; cv=none; b=EYgM6To5X4VFCcU42WFL3RQd0zvsaPYfKk9ts+KhWEZaiTtHTJWTIE3x/zJ2/GtWNe/qoohiFDY6oht3ryZufKRwosnsq8YzVi72BsQIyWuDcfRR2kvVqjgG5yAexAvRrfKt8704421DfuhZlwP2ZZdO0xR2TMmucWrZLon3Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538320; c=relaxed/simple;
	bh=72YVYlZpx1c2GB+9yCrTowRw630f+mznM7Sb9bqRu6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1G6hfNCzLG9QThtbODJEy3f88ywVrbdmDA3Ijt+ESOvRE4e1OjAACBDy1RIFugCiU3NBgVDedO4zeP2hGGPBTIq5JsW7+W6k+KHpas+wgy5maIdyqdPyOxzQuGqTw0xqqWkKadazqFjEdx0qRLLl78Bh2gI0A2lTo5bDoSTeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtUwGCtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF534C4CEF4;
	Thu,  3 Jul 2025 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538318;
	bh=72YVYlZpx1c2GB+9yCrTowRw630f+mznM7Sb9bqRu6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jtUwGCtK2hm3bveJkKS2FeIF8HldLt+UKMfrSqvM7zMRymIqYmBub7Q/WyfDCoQHE
	 V1mmPOwh4/W4oU3S8Ed85zzSAGByhWCSYPq42TS9sK0UpoeDRjfBO3/Mz7WY5B2tpL
	 xpUiL/ailyzWpGwW7lBMeOX3cx6nKijQUL2wC1QukmVRsf2t/k4yDUssrqwwPiLPnK
	 knDdTxV8/UCF0Y2/IYKvRIsS/pL6Blmi1i2QQAinfvqU2IKXHDiZ6eK9SXk5uAJk2u
	 jq4Y3uc8K9lN5NP1In0xgr4dLmjmc7NsLgOM2rrKI7E8Qwi7UJOJK4U6mfgKpM4B7Y
	 7W1sK6a4I4aaA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:24:51 +0200
Subject: [PATCH v7 01/31] dt-bindings: interrupt-controller: Add Arm GICv5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-1-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

The GICv5 interrupt controller architecture is composed of:

- one or more Interrupt Routing Service (IRS)
- zero or more Interrupt Translation Service (ITS)
- zero or more Interrupt Wire Bridge (IWB)

Describe a GICv5 implementation by specifying a top level node
corresponding to the GICv5 system component.

IRS nodes are added as GICv5 system component children.

An ITS is associated with an IRS so ITS nodes are described
as IRS children - use the hierarchy explicitly in the device
tree to define the association.

IWB nodes are described as a separate schema.

An IWB is connected to a single ITS, the connection is made explicit
through the msi-parent property and therefore is not required to be
explicit through a parent-child relationship in the device tree.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 .../interrupt-controller/arm,gic-v5-iwb.yaml       |  78 ++++++
 .../bindings/interrupt-controller/arm,gic-v5.yaml  | 267 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 3 files changed, 352 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml
new file mode 100644
index 000000000000..99a266a62385
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v5-iwb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller, version 5 Interrupt Wire Bridge (IWB)
+
+maintainers:
+  - Lorenzo Pieralisi <lpieralisi@kernel.org>
+  - Marc Zyngier <maz@kernel.org>
+
+description: |
+  The GICv5 architecture defines the guidelines to implement GICv5
+  compliant interrupt controllers for AArch64 systems.
+
+  The GICv5 specification can be found at
+  https://developer.arm.com/documentation/aes0070
+
+  GICv5 has zero or more Interrupt Wire Bridges (IWB) that are responsible
+  for translating wire signals into interrupt messages to the GICv5 ITS.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: arm,gic-v5-iwb
+
+  reg:
+    items:
+      - description: IWB control frame
+
+  "#address-cells":
+    const: 0
+
+  "#interrupt-cells":
+    description: |
+      The 1st cell corresponds to the IWB wire.
+
+      The 2nd cell is the flags, encoded as follows:
+      bits[3:0] trigger type and level flags.
+
+      1 = low-to-high edge triggered
+      2 = high-to-low edge triggered
+      4 = active high level-sensitive
+      8 = active low level-sensitive
+
+    const: 2
+
+  interrupt-controller: true
+
+  msi-parent:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@2f000000 {
+      compatible = "arm,gic-v5-iwb";
+      reg = <0x2f000000 0x10000>;
+
+      #address-cells = <0>;
+
+      #interrupt-cells = <2>;
+      interrupt-controller;
+
+      msi-parent = <&its0 64>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
new file mode 100644
index 000000000000..86ca7f3ac281
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
@@ -0,0 +1,267 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller, version 5
+
+maintainers:
+  - Lorenzo Pieralisi <lpieralisi@kernel.org>
+  - Marc Zyngier <maz@kernel.org>
+
+description: |
+  The GICv5 architecture defines the guidelines to implement GICv5
+  compliant interrupt controllers for AArch64 systems.
+
+  The GICv5 specification can be found at
+  https://developer.arm.com/documentation/aes0070
+
+  The GICv5 architecture is composed of multiple components:
+    - one or more IRS (Interrupt Routing Service)
+    - zero or more ITS (Interrupt Translation Service)
+
+  The architecture defines:
+    - PE-Private Peripheral Interrupts (PPI)
+    - Shared Peripheral Interrupts (SPI)
+    - Logical Peripheral Interrupts (LPI)
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: arm,gic-v5
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  "#interrupt-cells":
+    description: |
+      The 1st cell corresponds to the INTID.Type field in the INTID; 1 for PPI,
+      3 for SPI. LPI interrupts must not be described in the bindings since
+      they are allocated dynamically by the software component managing them.
+
+      The 2nd cell contains the interrupt INTID.ID field.
+
+      The 3rd cell is the flags, encoded as follows:
+      bits[3:0] trigger type and level flags.
+
+        1 = low-to-high edge triggered
+        2 = high-to-low edge triggered
+        4 = active high level-sensitive
+        8 = active low level-sensitive
+
+    const: 3
+
+  interrupt-controller: true
+
+  interrupts:
+    description:
+      The VGIC maintenance interrupt.
+    maxItems: 1
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-controller
+
+patternProperties:
+  "^irs@[0-9a-f]+$":
+    type: object
+    description:
+      GICv5 has one or more Interrupt Routing Services (IRS) that are
+      responsible for handling IRQ state and routing.
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: arm,gic-v5-irs
+
+      reg:
+        minItems: 1
+        items:
+          - description: IRS config frames
+          - description: IRS setlpi frames
+
+      reg-names:
+        description:
+          Describe config and setlpi frames that are present.
+          "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+          and "el3-" for EL3.
+        minItems: 1
+        maxItems: 8
+        items:
+          enum: [ ns-config, s-config, realm-config, el3-config, ns-setlpi,
+                  s-setlpi, realm-setlpi, el3-setlpi ]
+
+      "#address-cells":
+        enum: [ 1, 2 ]
+
+      "#size-cells":
+        enum: [ 1, 2 ]
+
+      ranges: true
+
+      dma-noncoherent:
+        description:
+          Present if the GIC IRS permits programming shareability and
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
+      cpus:
+        description:
+          CPUs managed by the IRS.
+
+      arm,iaffids:
+        $ref: /schemas/types.yaml#/definitions/uint16-array
+        description:
+          Interrupt AFFinity ID (IAFFID) associated with the CPU whose
+          CPU node phandle is at the same index in the cpus array.
+
+    patternProperties:
+      "^its@[0-9a-f]+$":
+        type: object
+        description:
+          GICv5 has zero or more Interrupt Translation Services (ITS) that are
+          used to route Message Signalled Interrupts (MSI) to the CPUs. Each
+          ITS is connected to an IRS.
+        additionalProperties: false
+
+        properties:
+          compatible:
+            const: arm,gic-v5-its
+
+          reg:
+            items:
+              - description: ITS config frames
+
+          reg-names:
+            description:
+              Describe config frames that are present.
+              "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+              and "el3-" for EL3.
+            minItems: 1
+            maxItems: 4
+            items:
+              enum: [ ns-config, s-config, realm-config, el3-config ]
+
+          "#address-cells":
+            enum: [ 1, 2 ]
+
+          "#size-cells":
+            enum: [ 1, 2 ]
+
+          ranges: true
+
+          dma-noncoherent:
+            description:
+              Present if the GIC ITS permits programming shareability and
+              cacheability attributes but is connected to a non-coherent
+              downstream interconnect.
+
+        patternProperties:
+          "^msi-controller@[0-9a-f]+$":
+            type: object
+            description:
+              GICv5 ITS has one or more translate register frames.
+            additionalProperties: false
+
+            properties:
+              reg:
+                items:
+                  - description: ITS translate frames
+
+              reg-names:
+                description:
+                  Describe translate frames that are present.
+                  "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+                  and "el3-" for EL3.
+                minItems: 1
+                maxItems: 4
+                items:
+                  enum: [ ns-translate, s-translate, realm-translate, el3-translate ]
+
+              "#msi-cells":
+                description:
+                  The single msi-cell is the DeviceID of the device which will
+                  generate the MSI.
+                const: 1
+
+              msi-controller: true
+
+            required:
+              - reg
+              - reg-names
+              - "#msi-cells"
+              - msi-controller
+
+        required:
+          - compatible
+          - reg
+          - reg-names
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - cpus
+      - arm,iaffids
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+      compatible = "arm,gic-v5";
+
+      #interrupt-cells = <3>;
+      interrupt-controller;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      interrupts = <1 25 4>;
+
+      irs@2f1a0000 {
+        compatible = "arm,gic-v5-irs";
+        reg = <0x2f1a0000 0x10000>;  // IRS_CONFIG_FRAME
+        reg-names = "ns-config";
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>, <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+        arm,iaffids = /bits/ 16 <0 1 2 3 4 5 6 7>;
+
+        its@2f120000 {
+          compatible = "arm,gic-v5-its";
+          reg = <0x2f120000 0x10000>;   // ITS_CONFIG_FRAME
+          reg-names = "ns-config";
+
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          msi-controller@2f130000 {
+            reg = <0x2f130000 0x10000>;   // ITS_TRANSLATE_FRAME
+            reg-names = "ns-translate";
+
+            #msi-cells = <1>;
+            msi-controller;
+          };
+        };
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b8..f02a768adecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1965,6 +1965,13 @@ F:	drivers/irqchip/irq-gic*.[ch]
 F:	include/linux/irqchip/arm-gic*.h
 F:	include/linux/irqchip/arm-vgic-info.h
 
+ARM GENERIC INTERRUPT CONTROLLER V5 DRIVERS
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5*.yaml
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported

-- 
2.48.0



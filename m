Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528104E9AE0
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiC1PZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiC1PZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:25:50 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E091F63E;
        Mon, 28 Mar 2022 08:24:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AC95E1E4920;
        Thu, 24 Mar 2022 04:37:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru AC95E1E4920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085869;
        bh=fFFXY6fc+neLhZ7RKAfQ7NRj0Ug9JDpw+U5GeFCAV2I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bktRlkRxx9ngmRg9Rnb5rox7S15QW1TZ7qu8efJF/OGoERR84KdM8NY5aGkdANAWR
         W9NN1/HsbREdEIkhgHH7hUkvLosyz5tH3NVnBeaNJZYTU4fHLO5cLaaz6TAiksMCWZ
         aYnw4Vit4Mp5xERnfhO0TUjaezq6bf4BCtjxxFVU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/16] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
Date:   Thu, 24 Mar 2022 04:37:20 +0300
Message-ID: <20220324013734.18234-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
controller is supposed to be fed up with four clock sources: DBI
peripheral clock, AXI application Tx/Rx clocks and external PHY/core
reference clock generating the 100MHz signal. In addition to that the
platform provide a way to reset each part of the controller:
sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
Hot/Power reset signal. The Root Port controller is equipped with multiple
IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
equalization request and eDMA ones. The registers space is accessed over
the DBI interface. There can be no more than four inbound or outbound iATU
windows configured.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Rob, this DT-bindings most likely will fail the dt_bindings_check
evaluations with the "'*' is not of type 'array'" errors for the same
reason described in the previous patch. Let's discuss the problem there.
---
 .../bindings/pci/baikal,bt1-pcie.yaml         | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
new file mode 100644
index 000000000000..f34438330a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 PCIe Root Port Controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description: |
+  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
+  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
+  Port function and is capable of establishing the link up to Gen.3 speed
+  on x4 lanes. It doesn't have embedded clock and reset control module, so
+  the proper interface initialization is supposed to be performed by software.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: baikal,bt1-pcie
+
+  reg:
+    description:
+      DBI, DBI2 and at least 4KB outbound iATU-capable region are available.
+    maxItems: 3
+
+  reg-names:
+    minItems: 3
+    maxItems: 3
+    items:
+      enum: [ dbi, dbi2, config ]
+
+  interrupts:
+    description:
+      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
+      request and eight Read/Write eDMA IRQ lines are available.
+    maxItems: 14
+
+  interrupt-names:
+    minItems: 14
+    maxItems: 14
+    items:
+      oneOf:
+        - pattern: '^dma[0-7]$'
+        - enum: [ msi, aer, pme, hp, bw_mg, l_eq ]
+
+  clocks:
+    description:
+      DBI (attached to the APB bus), AXI-bus master and slave interfaces
+      are fed up by the dedicated application clocks. A common reference
+      clock signal is supposed to be attached to the corresponding Ref-pad
+      of the SoC. It will be redistributed amongst the controller core
+      sub-modules (pipe, core, aux, etc).
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    minItems: 4
+    maxItems: 4
+    items:
+      enum: [ dbi, mstr, slv, ref ]
+
+  resets:
+    description:
+      A comprehensive controller reset logic is supposed to be implemented
+      by software, so almost all the possible application and core reset
+      signals are exposed via the system CCU module.
+    minItems: 9
+    maxItems: 9
+
+  reset-names:
+    minItems: 9
+    maxItems: 9
+    items:
+      enum: [ mstr, slv, pwr, hot, phy, core, pipe, sticky, non-sticky ]
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the Baikal-T1 System Controller DT node. It's required to
+      access some additional PM, Reset-related and LTSSM signals.
+
+  num-lanes:
+    maximum: 4
+
+  max-link-speed:
+    maximum: 3
+
+  num-ob-windows:
+    const: 4
+
+  num-ib-windows:
+    const: 4
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie@1f052000 {
+      compatible = "baikal,bt1-pcie", "snps,dw-pcie-4.60a", "snps,dw-pcie";
+      device_type = "pci";
+      reg = <0x1f052000 0x1000>, <0x1f053000 0x1000>, <0x1bdbf000 0x1000>;
+      reg-names = "dbi", "dbi2", "config";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
+               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
+      bus-range = <0x0 0xff>;
+
+      interrupts = <0 80 4>, <0 81 4>, <0 82 4>, <0 83 4>,
+                   <0 84 4>, <0 85 4>, <0 86 4>, <0 87 4>,
+                   <0 88 4>, <0 89 4>, <0 90 4>, <0 91 4>,
+                   <0 92 4>, <0 93 4>;
+      interrupt-names = "dma0", "dma1", "dma2", "dma3", "dma4", "dma5", "dma6",
+                        "dma7", "msi", "aer", "pme", "hp", "bw_mg", "l_eq";
+
+      clocks = <&ccu_sys 1>, <&ccu_axi 6>, <&ccu_axi 7>, <&clk_pcie>;
+      clock-names = "dbi", "mstr", "slv", "ref";
+
+      resets = <&ccu_axi 6>, <&ccu_axi 7>, <&ccu_sys 7>, <&ccu_sys 10>,
+               <&ccu_sys 4>, <&ccu_sys 6>, <&ccu_sys 5>, <&ccu_sys 8>,
+               <&ccu_sys 9>;
+      reset-names = "mstr", "slv", "pwr", "hot", "phy", "core", "pipe",
+                    "sticky", "non-sticky";
+
+      reset-gpios = <&port0 0 1>;
+
+      num-lanes = <4>;
+      max-link-speed = <3>;
+    };
+...
-- 
2.35.1


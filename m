Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45EF5460EE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347639AbiFJJGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344465AbiFJJGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:06:00 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C6A6274B7D;
        Fri, 10 Jun 2022 02:04:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 20B1D16CB;
        Fri, 10 Jun 2022 11:58:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 20B1D16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851491;
        bh=YoncPqpfxB/O+UIQ5udV/r13samFVrXcrXHOyNlvANA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gsm7a/MFyE7RFg5b/a5dWPqv+yapOR66sIuaSfNuaixLoE7XEkTYaY9QKykDtAUwA
         DsTgwa5+erOIjIHNhbdDWtNCCJ1SiE1wIOHpUPdBfofOcy91KK+iFxY+nXkWkFcNW7
         VUKGYC4KgtmhcoDRQAHPGa/a3oyGMSwYR+aapw2U=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:18 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
Date:   Fri, 10 Jun 2022 11:57:00 +0300
Message-ID: <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelog v2:
- Rename 'syscon' property to 'baikal,bt1-syscon'.
- Fix the 'compatible' property definition to being more specific about
  what strings are supposed to be used. Due to that we had to add the
  select property to evaluate the schema against the Baikal-T1 PCIe DT
  nodes only.
---
 .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
new file mode 100644
index 000000000000..23bd1d0aa5c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
@@ -0,0 +1,154 @@
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
+description:
+  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
+  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
+  Port function and is capable of establishing the link up to Gen.3 speed
+  on x4 lanes. It doesn't have embedded clock and reset control module, so
+  the proper interface initialization is supposed to be performed by software.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: baikal,bt1-pcie
+
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: baikal,bt1-pcie
+      - const: snps,dw-pcie-4.60a
+      - const: snps,dw-pcie
+
+  reg:
+    description:
+      DBI, DBI2 and at least 4KB outbound iATU-capable region.
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
+  baikal,bt1-syscon:
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAE59C711
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiHVSsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiHVSsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:10 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 928623CBDB;
        Mon, 22 Aug 2022 11:47:48 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id CB8CCDB1;
        Mon, 22 Aug 2022 21:50:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com CB8CCDB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194250;
        bh=X0wgUC3KDgO+PQ62l6HCreDoweK6a4wAHNh6AcNhl5Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KCTm5MRX7KomjSbWHzpIh9/r/cX9k7MXSX5P7dl0ALQ0DQnNhJwYPzFFz6iGjB2SU
         cRwmoorZT6OS0bRPwqqEDM5/9aqvrW6Afx5yESf4E54gzJr45NBOz83zBeEOEAKmcw
         3jqjk8T/xfHuWTSJ/8496QHvHT1TY9iT/cWNm/+I=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 14/20] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root Port bindings
Date:   Mon, 22 Aug 2022 21:46:55 +0300
Message-ID: <20220822184701.25246-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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

Changelog v5:
- Drop generic fallback names from the compatible property constraints.
  (@Rob)
- Define ordered {reg,interrupt,clock,reset}-names properties. (@Rob)
- Drop minItems from the clocks and reset properties, since it equals
  to the maxItems for them.
- Drop num-ob-windows and num-ib-windows properties constraint. (@Rob)
---
 .../bindings/pci/baikal,bt1-pcie.yaml         | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
new file mode 100644
index 000000000000..b00cb04357d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
@@ -0,0 +1,153 @@
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
+  Embedded into Baikal-T1 SoC Root Complex controller with a single port
+  activated. It's based on the DWC RC PCIe v4.60a IP-core, which is configured
+  to have just a single Root Port function and is capable of establishing the
+  link up to Gen.3 speed on x4 lanes. It doesn't have embedded clock and reset
+  control module, so the proper interface initialization is supposed to be
+  performed by software. There four in- and four outbound iATU regions
+  which can be used to emit all required TLP types on the PCIe bus.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: baikal,bt1-pcie
+
+  reg:
+    description:
+      DBI, DBI2 and at least 4KB outbound iATU-capable region for the
+      peripheral devices CFG-space access.
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: config
+
+  interrupts:
+    description:
+      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
+      request and eight Read/Write eDMA IRQ lines are available.
+    maxItems: 14
+
+  interrupt-names:
+    items:
+      - const: dma0
+      - const: dma1
+      - const: dma2
+      - const: dma3
+      - const: dma4
+      - const: dma5
+      - const: dma6
+      - const: dma7
+      - const: msi
+      - const: aer
+      - const: pme
+      - const: hp
+      - const: bw_mg
+      - const: l_eq
+
+  clocks:
+    description:
+      DBI (attached to the APB bus), AXI-bus master and slave interfaces
+      are fed up by the dedicated application clocks. A common reference
+      clock signal is supposed to be attached to the corresponding Ref-pad
+      of the SoC. It will be redistributed amongst the controller core
+      sub-modules (pipe, core, aux, etc).
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+      - const: ref
+
+  resets:
+    description:
+      A comprehensive controller reset logic is supposed to be implemented
+      by software, so almost all the possible application and core reset
+      signals are exposed via the system CCU module.
+    maxItems: 9
+
+  reset-names:
+    items:
+      - const: mstr
+      - const: slv
+      - const: pwr
+      - const: hot
+      - const: phy
+      - const: core
+      - const: pipe
+      - const: sticky
+      - const: non-sticky
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
+      compatible = "baikal,bt1-pcie";
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


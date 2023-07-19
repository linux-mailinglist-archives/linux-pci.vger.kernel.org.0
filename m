Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70287592AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGSKVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGSKVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:21:07 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45B1BF5;
        Wed, 19 Jul 2023 03:21:05 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A376A24E270;
        Wed, 19 Jul 2023 18:21:04 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:04 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Jul
 2023 18:21:03 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 5/9] dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
Date:   Wed, 19 Jul 2023 18:20:53 +0800
Message-ID: <20230719102057.22329-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PLDA XpressRICH host controller dt-bindings. Both Microchip
PolarFire SoC and StarFive JH7110 SoC are using PLDA XpressRICH
PCIe host controller IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../pci/plda,xpressrich-pcie-host.yaml        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
new file mode 100644
index 000000000000..10a10862a078
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PLDA XpressRICH PCIe host controller
+
+maintainers:
+  - Daire McNamara <daire.mcnamara@microchip.com>
+  - Minda Chen <minda.chen@starfivetech.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: plda,xpressrich-pcie-common.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: plda,xpressrich-pcie-host
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-map-mask
+  - interrupt-map
+  - msi-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            pcie0: pcie@12000000 {
+                    compatible = "plda,xpressrich-pcie-host";
+                    reg = <0x0 0x12000000 0x0 0x00010000>,
+                          <0x0 0x43000000 0x0 0x00010000>;
+                    reg-names = "host", "cfg";
+                    ranges = <0x03000000 0x0 0x88000000 0x0 0x88000000 0x0 0x04000000>;
+                    device_type = "pci";
+                    #address-cells = <3>;
+                    #size-cells = <2>;
+                    #interrupt-cells = <1>;
+                    interrupts = <131>;
+                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+                    interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                                    <0 0 0 2 &pcie_intc0 1>,
+                                    <0 0 0 3 &pcie_intc0 2>,
+                                    <0 0 0 4 &pcie_intc0 3>;
+                    interrupt-parent = <&plic0>;
+                    msi-parent = <&pcie0>;
+                    msi-controller;
+                    bus-range = <0x00 0x7f>;
+
+                    pcie_intc0: interrupt-controller {
+                        #address-cells = <0>;
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                    };
+            };
+    };
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D059C708
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiHVSsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiHVSsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:04 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A98563C149;
        Mon, 22 Aug 2022 11:47:32 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DB221DA5;
        Mon, 22 Aug 2022 21:50:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DB221DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194240;
        bh=AROHqFsRVb9P132PoqU5IjW7FY9cZVcQEdgAHHqrKJk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CBAEs97114wGsZioMLRer3picNAd0BPypO23DN2dwBwGZOVcGMIR8k8RLgczt3zYQ
         ch3TQuZ5woL8kUKr11Pr12ke7/AlouUmZOfHzx43RCAE8P9Y82Jg1FAcbv54k7Z0a6
         7ZF3tKatO0A/mCBcwxOssvrviwCjnInpo0lWo0/4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:26 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 03/20] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
Date:   Mon, 22 Aug 2022 21:46:44 +0300
Message-ID: <20220822184701.25246-4-Sergey.Semin@baikalelectronics.ru>
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

Currently both DW PCIe Root Port and End-point DT bindings are defined as
separate schemas. Carefully looking at them, at the hardware reference
manuals and seeing there is a generic part of the driver used by the both
RP and EP drivers we can greatly simplify the DW PCIe controller bindings
by moving some of the properties into the common DT schema. It concerns
the PERST GPIO control, number of lanes, number of iATU windows and CDM
check properties. They will be defined in the snps,dw-pcie-common.yaml
schema which will be referenced in the DW PCIe Root Port and End-point DT
bindings in order to evaluate the common for both of these controllers
properties. The rest of properties like reg{,-names}, clock{s,-names},
reset{s,-names}, etc will be consolidate there in one of the next commits.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 76 +++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 31 +-------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 33 +-------
 3 files changed, 78 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
new file mode 100644
index 000000000000..554c2804c608
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/snps,dw-pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC PCIe RP/EP controller
+
+maintainers:
+  - Jingoo Han <jingoohan1@gmail.com>
+  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+description:
+  Generic Synopsys DesignWare PCIe Root Port and Endpoint controller
+  properties.
+
+select: false
+
+properties:
+  reset-gpio:
+    deprecated: true
+    description:
+      Reference to the GPIO-controlled PERST# signal. It is used to reset all
+      the peripheral devices available on the PCIe bus.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Reference to the GPIO-controlled PERST# signal. It is used to reset all
+      the peripheral devices available on the PCIe bus.
+    maxItems: 1
+
+  num-lanes:
+    description:
+      Number of PCIe link lanes to use. Can be omitted if the already brought
+      up link is supposed to be preserved.
+    maximum: 16
+
+  num-ob-windows:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of outbound address translation windows. This parameter can be
+      auto-detected based on the iATU memory writability. So there is no
+      point in having a dedicated DT-property for it.
+    maximum: 256
+
+  num-ib-windows:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of inbound address translation windows. In the same way as
+      for the outbound AT windows, this parameter can be auto-detected based
+      on the iATU memory writability. There is no point having a dedicated
+      DT-property for it either.
+    maximum: 256
+
+  num-viewport:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Number of outbound view ports configured in hardware. It's the same as
+      the number of outbound AT windows.
+    maximum: 256
+
+  snps,enable-cdm-check:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable automatic checking of CDM (Configuration Dependent Module)
+      registers for data corruption. CDM registers include standard PCIe
+      configuration space registers, Port Logic registers, DMA and iATU
+      registers. This feature has been available since DWC PCIe v4.80a.
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index b78535040f04..eae60901d60e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
@@ -36,36 +37,6 @@ properties:
     items:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
-  reset-gpio:
-    description: GPIO pin number of PERST# signal
-    maxItems: 1
-    deprecated: true
-
-  reset-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
-  snps,enable-cdm-check:
-    type: boolean
-    description: |
-      This is a boolean property and if present enables
-      automatic checking of CDM (Configuration Dependent Module) registers
-      for data corruption. CDM registers include standard PCIe configuration
-      space registers, Port Logic registers, DMA and iATU (internal Address
-      Translation Unit) registers.
-
-  num-ib-windows:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    maximum: 256
-    description: number of inbound address translation windows
-    deprecated: true
-
-  num-ob-windows:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    maximum: 256
-    description: number of outbound address translation windows
-    deprecated: true
-
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 7287d395e1b6..505b01e0a034 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
   compatible:
@@ -37,44 +38,12 @@ properties:
       enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
               parf, cfg, link, ulreg, smu, mpu, apb, phy ]
 
-  num-lanes:
-    description: |
-      number of lanes to use (this property should be specified unless
-      the link is brought already up in firmware)
-    maximum: 16
-
-  reset-gpio:
-    description: GPIO pin number of PERST# signal
-    maxItems: 1
-    deprecated: true
-
-  reset-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
   interrupts: true
 
   interrupt-names: true
 
   clocks: true
 
-  snps,enable-cdm-check:
-    type: boolean
-    description: |
-      This is a boolean property and if present enables
-      automatic checking of CDM (Configuration Dependent Module) registers
-      for data corruption. CDM registers include standard PCIe configuration
-      space registers, Port Logic registers, DMA and iATU (internal Address
-      Translation Unit) registers.
-
-  num-viewport:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    maximum: 256
-    description: |
-      number of view ports configured in hardware. If a platform
-      does not specify it, the driver autodetects it.
-    deprecated: true
-
 additionalProperties: true
 
 required:
-- 
2.35.1


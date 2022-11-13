Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B1627200
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiKMTPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiKMTOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:14:52 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E81E4DF63;
        Sun, 13 Nov 2022 11:14:47 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0805AE0EAC;
        Sun, 13 Nov 2022 22:14:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Eb62t2mz28WZp2Jm0fCIxJ9bGqCGMkN4xsgKdUl/dgw=; b=jYEWaCSgr6/U
        zCHH8CCPxoBJXKmZ8Vu7ybP63v62uGE0FIHHxKM4ILNRYxfJjrR63sBQekfcvYkJ
        XEJY4RCM54ZBAPfcX1GKUq5T3vF+X4fu6YABVXUNGEGS9Z6M3p8RKKxWxPNTWNm7
        3MhvevgLMZQXEiCOovYPZE4b9THXxmg=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EC186E0E6A;
        Sun, 13 Nov 2022 22:14:46 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 03/20] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
Date:   Sun, 13 Nov 2022 22:12:44 +0300
Message-ID: <20221113191301.5526-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.38.1



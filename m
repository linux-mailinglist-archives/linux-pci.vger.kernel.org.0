Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02779620061
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiKGVJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiKGVIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:08:30 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9308F317C3;
        Mon,  7 Nov 2022 13:06:33 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 29268E0EB5;
        Mon,  7 Nov 2022 23:50:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Z3f+SSDkSLMOP6mHphQ6nhs3Vs00fdpMjwBCMhX3bg8=; b=ir8fS/TS9pm4
        JKVb9gDRb128+Q5/d3KGW1P5kQAmZ2uhUA7CfNYItwE5I+hx0ecDR603cQ65P4Uy
        lwsudjbithWRNgLGnIGNsIHX9+HBzP6DKk0uxpGjNd+dEqwWslqpg6QVDyTxI2dK
        9x28/muxSWrcwNr7lrqPqjIoA+b7MD8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 16A5DE0E1D;
        Mon,  7 Nov 2022 23:50:13 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:12 +0300
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
Subject: [PATCH v6 07/20] dt-bindings: PCI: dwc: Apply generic schema for generic device only
Date:   Mon, 7 Nov 2022 23:49:21 +0300
Message-ID: <20221107204934.32655-8-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
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

Having the generic compatible strings constraints with the 'any'+'generic
string' semantic implicitly encourages either to add new DW PCIe-based
DT-bindings with the generic compatible string attached or just forget
about adding new DT-bindings since the corresponding DT-node will be
evaluated anyway. Moreover having that semantic implemented in the
generic DT-schema causes the DT-validation tool to apply the schema twice:
first by implicit compatible-string-based selection and second by means of
the 'allOf: [ $ref ]' statement. Let's fix all of that by dropping the
compatible property constraints and selecting the generic DT-schema only
for the purely generic DW PCIe DT-nodes. The later is required since there
is a driver for such devices. (Though there are no such DT-nodes currently
defined in the kernel DT sources.)

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
- Fix compatible property schema so one would work as expected: string
  must contain either generic DW PCIe IP-core name or both generic and
  equipped with IP-core version names.

Changelog v5:
- Switch the patch from not-selecting the generic schemas to applying
  them to the generic DW PCIe device nodes only.
- Drop the generic compatible string used as fallback. (@Rob)
---
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 16 ++++++++++------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml    | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index fc3b5d4ac245..d04001248b53 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -13,16 +13,20 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller endpoint
 
+# Please create a separate DT-schema for your DWC PCIe Endpoint controller
+# and make sure it's assigned with the vendor-specific compatible string.
+select:
+  properties:
+    compatible:
+      const: snps,dw-pcie-ep
+  required:
+    - compatible
+
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
-  compatible:
-    anyOf:
-      - {}
-      - const: snps,dw-pcie-ep
-
   reg:
     description: |
       It should contain Data Bus Interface (dbi) and config registers for all
@@ -38,9 +42,9 @@ properties:
       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index e787b9727589..85861b71d9ff 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -13,16 +13,20 @@ maintainers:
 description: |
   Synopsys DesignWare PCIe host controller
 
+# Please create a separate DT-schema for your DWC PCIe Root Port controller
+# and make sure it's assigned with the vendor-specific compatible string.
+select:
+  properties:
+    compatible:
+      const: snps,dw-pcie
+  required:
+    - compatible
+
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 properties:
-  compatible:
-    anyOf:
-      - {}
-      - const: snps,dw-pcie
-
   reg:
     description: |
       It should contain Data Bus Interface (dbi) and config registers for all
@@ -47,9 +51,9 @@ properties:
 additionalProperties: true
 
 required:
+  - compatible
   - reg
   - reg-names
-  - compatible
 
 examples:
   - |
-- 
2.38.0



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C059C71E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiHVStM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiHVSsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:12 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1417749B73;
        Mon, 22 Aug 2022 11:47:39 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 31B01DA9;
        Mon, 22 Aug 2022 21:50:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 31B01DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194245;
        bh=01sgRfAC3h/M1bbjqw+cS58MAG3eTq2dWGnLa4lwWFY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hV5KgS7M01lNIEKnE+MNjhDRgzqM4OykrbLEuBKMJ9HDRzpc481tGuCkDVGl1ChtL
         eTxkmkIbFyMkhZOhvjdg2pF+aUldfILWvmmVCKA0T6nGmSmSJYWu2YWmvAvVWjnZUq
         EIrBVymSNzddNkrYwVyp3nGLkuYtOPRNVBh0nZMQ=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:30 +0300
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
Subject: [PATCH v5 07/20] dt-bindings: PCI: dwc: Apply generic schema for generic device only
Date:   Mon, 22 Aug 2022 21:46:48 +0300
Message-ID: <20220822184701.25246-8-Sergey.Semin@baikalelectronics.ru>
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
2.35.1


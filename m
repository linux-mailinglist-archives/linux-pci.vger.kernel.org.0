Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C186546103
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346992AbiFJJGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiFJJGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:06:09 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D879D27A913;
        Fri, 10 Jun 2022 02:05:13 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 459B316A7;
        Fri, 10 Jun 2022 11:58:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 459B316A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851481;
        bh=9HBWgGedDYOR2uBsYnskWJHTdcEKOS91WeTnOn9NVdw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iFsSuz2tJg+Ysyp/XlSHeJ6h82B1frTZTFqTWjz8lsAtgYURozjckOmmlzLdDbU94
         0zONWhcEphg/WL+pR9LjWePkSU6AdHmGyqI/qgxC8Bs+5hcAFzyN761hI4Lw3tLteY
         su+a4jmOcX4eJvUFUz8Re9GJ4RvGw8MbWt7x/D4o=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:08 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/17] dt-bindings: PCI: dwc: Remove bus node from the examples
Date:   Fri, 10 Jun 2022 11:56:50 +0300
Message-ID: <20220610085706.15741-3-Sergey.Semin@baikalelectronics.ru>
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

It's absolutely redundant seeing by default each node is embedded into its
own example-X node with address and size cells set to 1.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 16 ++++-----
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 35 ++++++++++---------
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index eae60901d60e..7d05dcba419b 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -46,14 +46,10 @@ additionalProperties: true
 
 examples:
   - |
-    bus {
-      #address-cells = <1>;
-      #size-cells = <1>;
-      pcie-ep@dfd00000 {
-        compatible = "snps,dw-pcie-ep";
-        reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
-              <0xdfc01000 0x0001000>, /* IP registers 2 */
-              <0xd0000000 0x2000000>; /* Configuration space */
-        reg-names = "dbi", "dbi2", "addr_space";
-      };
+    pcie-ep@dfd00000 {
+      compatible = "snps,dw-pcie-ep";
+      reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+            <0xdfc01000 0x0001000>, /* IP registers 2 */
+            <0xd0000000 0x2000000>; /* Configuration space */
+      reg-names = "dbi", "dbi2", "addr_space";
     };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 75ff715a0153..2810e9b5cc8d 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -53,21 +53,22 @@ required:
 
 examples:
   - |
-    bus {
-      #address-cells = <1>;
-      #size-cells = <1>;
-      pcie@dfc00000 {
-        device_type = "pci";
-        compatible = "snps,dw-pcie";
-        reg = <0xdfc00000 0x0001000>, /* IP registers */
-              <0xd0000000 0x0002000>; /* Configuration space */
-        reg-names = "dbi", "config";
-        #address-cells = <3>;
-        #size-cells = <2>;
-        ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
-                 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
-        interrupts = <25>, <24>;
-        #interrupt-cells = <1>;
-        num-lanes = <1>;
-      };
+    pcie@dfc00000 {
+      compatible = "snps,dw-pcie";
+      device_type = "pci";
+      reg = <0xdfc00000 0x0001000>, /* IP registers */
+            <0xd0000000 0x0002000>; /* Configuration space */
+      reg-names = "dbi", "config";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
+               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+      bus-range = <0x0 0xff>;
+
+      interrupts = <25>, <24>;
+      #interrupt-cells = <1>;
+
+      reset-gpios = <&port0 0 1>;
+
+      num-lanes = <1>;
     };
-- 
2.35.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66D59C704
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiHVSsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiHVSry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:47:54 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FBB311164;
        Mon, 22 Aug 2022 11:47:34 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DBD8EDA6;
        Mon, 22 Aug 2022 21:50:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DBD8EDA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194241;
        bh=0SbRKXK6uzG4rIK+IfmQSCMmKXV6lPl24R2CGwwB6kE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=H8WVr6cFqEg69kbOM2j4qFfMwXupSpi98jyG/wStBpRFfqzdV8O5UGDcypzdZDQRS
         pB7cpKa4dqZFWXHwn8YDwtWt3n7uCiOeuRKcnvuQSzfI+Y7K9+AKThdRF5Kaq3XahW
         SVRYt0FogTB/KDG28NsNWkZddnbV89/Ri7H7xjpA=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:27 +0300
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
Subject: [PATCH v5 04/20] dt-bindings: PCI: dwc: Remove bus node from the examples
Date:   Mon, 22 Aug 2022 21:46:45 +0300
Message-ID: <20220822184701.25246-5-Sergey.Semin@baikalelectronics.ru>
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

It's absolutely redundant seeing by default each node is embedded into its
own example-X node with address and size cells set to 1.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

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
index 505b01e0a034..3fdc80453a85 100644
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


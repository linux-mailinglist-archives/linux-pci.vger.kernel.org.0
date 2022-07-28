Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF84584192
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiG1OgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiG1OfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 10:35:20 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D45C4F698;
        Thu, 28 Jul 2022 07:34:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6FFD116D9;
        Thu, 28 Jul 2022 17:37:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6FFD116D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659019033;
        bh=4+FspBDrmkpEqQ53XZop0prYjV+tM5O/71NmIcbrgRQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lXW3bCxoehOZWFj1wEJhCvk2LwpoOR48p+n56JQFPSQ/aGAw2sTfwzRzBZUzUXrNw
         fCB88Tl5dqtG7V/ddc2AWVzx3uHNn6KbC8F2Gd93otkcISq0PUJHLjN0iFgKmCjpvt
         ZF6pC+vGuajiH5lqmgAVTyhFaRyqOSaOGw1IUMgw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:34:48 +0300
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
Subject: [PATCH v4 03/17] dt-bindings: PCI: dwc: Add phys/phy-names common properties
Date:   Thu, 28 Jul 2022 17:34:13 +0300
Message-ID: <20220728143427.13617-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
PHY phandle references. There can be up to 16 PHYs attach in accordance
with the maximum number of supported PCIe lanes. Let's extend the common
DW PCIe controller schema with the 'phys' and 'phy-names' properties
definition. The PHY names are defined with the regexp pattern
'^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
"pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
keystone, dra7xx; "pcie": histb, etc). Though the "pcie%d" format would
the most preferable in this case.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml         | 15 +++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml  |  3 +++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml     |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 3e992b653d12..627a5d6625ba 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -17,6 +17,21 @@ description:
 select: false
 
 properties:
+  phys:
+    description:
+      There can be up to the number of possible lanes PHYs specified.
+      Obviously each specified PHY is supposed to be able to work in the
+      PCIe mode with a speed implied by the DWC PCIe controller it is
+      attached to.
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    minItems: 1
+    maxItems: 16
+    items:
+      pattern: '^pcie([0-9]+|-?phy[0-9]*)?$'
+
   reset-gpio:
     deprecated: true
     description:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index 7d05dcba419b..dcd521aed213 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -52,4 +52,7 @@ examples:
             <0xdfc01000 0x0001000>, /* IP registers 2 */
             <0xd0000000 0x2000000>; /* Configuration space */
       reg-names = "dbi", "dbi2", "addr_space";
+
+      phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
+      phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
     };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 2810e9b5cc8d..4a5c8b933b52 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -70,5 +70,8 @@ examples:
 
       reset-gpios = <&port0 0 1>;
 
+      phys = <&pcie_phy>;
+      phy-names = "pcie";
+
       num-lanes = <1>;
     };
-- 
2.35.1


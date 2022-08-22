Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37D59C721
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiHVStM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiHVSsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:14 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426A849B61;
        Mon, 22 Aug 2022 11:47:39 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1DEE6DA7;
        Mon, 22 Aug 2022 21:50:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1DEE6DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194243;
        bh=Ku/rX23PzmZnnuku2OPnDiyNOiKj4HKIQ6OE24yC8dc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pIdmn19Il+WMUhT+7sylOG+pRnCsEYbGWmp3/oPISBZLC278HvmiFlmy2KRlHGDfX
         3R3U/t1piROSWQAhpp3t8GiKoPlgdoSrfzLBzjg84tBndQDX0nHI4teq16U9r87WK7
         06RMBKfzAB/4R6/RTCDDOVJE8f+BX4j1Nfng8hUo=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:28 +0300
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
Subject: [PATCH v5 05/20] dt-bindings: PCI: dwc: Add phys/phy-names common properties
Date:   Mon, 22 Aug 2022 21:46:46 +0300
Message-ID: <20220822184701.25246-6-Sergey.Semin@baikalelectronics.ru>
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

Changelog v5:
- Add a note about having line-based PHY phandles order. (@Rob)
- Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 19 +++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  3 +++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 554c2804c608..e8d610d63ae2 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -17,6 +17,25 @@ description:
 select: false
 
 properties:
+  phys:
+    description:
+      There can be up to the number of possible lanes PHYs specified placed in
+      the phandle array in the line-based order. Obviously each the specified
+      PHYs are supposed to be able to work in the PCIe mode with a speed
+      implied by the DWC PCIe controller they are attached to.
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    minItems: 1
+    maxItems: 16
+    oneOf:
+      - items:
+          pattern: '^pcie[0-9]+$'
+      - deprecated: true
+        items:
+          pattern: '^pcie(-?phy[0-9]*)?$'
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
index 3fdc80453a85..d9512f7f7124 100644
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


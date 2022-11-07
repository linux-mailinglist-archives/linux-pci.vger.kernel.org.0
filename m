Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D862011D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiKGV0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiKGV0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:26:10 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B47F22ED78;
        Mon,  7 Nov 2022 13:26:02 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BC317E0EB3;
        Mon,  7 Nov 2022 23:50:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=ZO2KozCesJXMnFVF7RMoOEcLvdjeR1lQvgddDu9E7xA=; b=pI0Ca+Cu275k
        btMPAjqeWL59JgcwmLtyjrOfMIqxiYHykkNDRWcO608ZuQ/J6hEc5stMI2dcWn+x
        A9oc6PglnIbw+OsHccGoL/o71fHsGbqz8LSo9/gFrteqrgtklrbwLmzHbwNsNyj+
        THu+Araju8bKoYqBXxx5tSDJ5k0eTuU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A6316E0E1D;
        Mon,  7 Nov 2022 23:50:10 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:10 +0300
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
Subject: [PATCH v6 05/20] dt-bindings: PCI: dwc: Add phys/phy-names common properties
Date:   Mon, 7 Nov 2022 23:49:19 +0300
Message-ID: <20221107204934.32655-6-Sergey.Semin@baikalelectronics.ru>
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

It's normal to have the DW PCIe RP/EP DT-nodes equipped with the explicit
PHY phandle references. There can be up to 16 PHYs attach in accordance
with the maximum number of supported PCIe lanes. Let's extend the common
DW PCIe controller schema with the 'phys' and 'phy-names' properties
definition. There two types PHY names are defined: preferred generic names
'^pcie[0-9]+$' and non-preferred vendor-specific names
'^pcie([0-9]+|-?phy[0-9]*)?$' so to match the names currently supported by
the DW PCIe platform drivers ("pcie": meson; "pciephy": qcom, imx6;
"pcie-phy": uniphier, rockchip, spear13xx; "pcie": intel-gw; "pcie-phy%d":
keystone, dra7xx; "pcie": histb, etc).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)

Changelog v5:
- Add a note about having line-based PHY phandles order. (@Rob)
- Prefer 'pcie[0-9]+' PHY-names over the rest of the cases. (@Rob)

Changelog v6:
- Add the Nvidia Tegra194-specific "p2u-[0-7]" phy-names too. (@DT-tbot)
- Drop 'deprecated' keywords from the vendor-specific names. (@Rob)
---
 .../bindings/pci/snps,dw-pcie-common.yaml     | 24 +++++++++++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |  3 +++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 554c2804c608..91d24e400dfc 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -17,6 +17,30 @@ description:
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
+      - description: Generic PHY names
+        items:
+          pattern: '^pcie[0-9]+$'
+      - description:
+          Vendor-specific PHY names. Consider using the generic
+          names above for new bindings.
+        items:
+          oneOf:
+            - pattern: '^pcie(-?phy[0-9]*)?$'
+            - pattern: '^p2u-[0-7]$'
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
2.38.0



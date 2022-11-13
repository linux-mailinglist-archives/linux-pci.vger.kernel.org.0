Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EA62720D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 20:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiKMTO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiKMTOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 14:14:52 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1639EDEC2;
        Sun, 13 Nov 2022 11:14:46 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DC4D2E0EAA;
        Sun, 13 Nov 2022 22:14:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=HAbPpyQXjz8ylsqMTZ03ZjBo19Ye/nkDntALZaYQcTI=; b=MdsG/jrPr/Nh
        jgBXP9IN3550UJm78IBv4xU/Ne4mbJuQqwFTQufpJdA21N13fSKLcdjf1N5p50l9
        cXZtuIAoKo++6UpdJ9RAgkysnOj1bhTMmdmNmFCoQ8VBf8OS+O4o5VhDzv26ZOMU
        cKsEuLvwG/fYvcglxlFeDNktNdcLPPA=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C8416E0E6A;
        Sun, 13 Nov 2022 22:14:44 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 13 Nov 2022 22:14:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 01/20] dt-bindings: imx6q-pcie: Fix clock names for imx6sx and imx8mq
Date:   Sun, 13 Nov 2022 22:12:42 +0300
Message-ID: <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
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

Originally as it was defined the legacy bindings the pcie_inbound_axi and
pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
Let's fix that by conditionally apply the clock-names constraints based on
the compatible string content.

Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

---

Changelog v5:
- This is a new patch added on the v5 release of the patchset.

Changelog v7:
- Move the allOf clause to the bottom of the bindings. (@Krzysztof)
- Get back the names to the clock-names property and make sure the
  platform-specific name constraint is applied in the allOf clause.
  (@Rob)
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 376e739bcad4..49b4f7a32e71 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -14,9 +14,6 @@ description: |+
   This PCIe host controller is based on the Synopsys DesignWare PCIe IP
   and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-
 properties:
   compatible:
     enum:
@@ -61,7 +58,7 @@ properties:
       - const: pcie
       - const: pcie_bus
       - const: pcie_phy
-      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
+      - enum: [ pcie_inbound_axi, pcie_aux ]
 
   num-lanes:
     const: 1
@@ -175,6 +172,47 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx6sx-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - {}
+            - {}
+            - {}
+            - const: pcie_inbound_axi
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - {}
+            - {}
+            - {}
+            - const: pcie_aux
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - fsl,imx6sx-pcie
+                - fsl,imx8mq-pcie
+    then:
+      properties:
+        clock-names:
+          maxItems: 3
+
 unevaluatedProperties: false
 
 examples:
-- 
2.38.1



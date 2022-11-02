Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64361701E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 22:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBV5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 17:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBV5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 17:57:52 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACAF63B4;
        Wed,  2 Nov 2022 14:57:50 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8714B841F5;
        Wed,  2 Nov 2022 22:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667426268;
        bh=6fg3wZ0v2xlX9DYAwWKFSLZnHpC+I+xLcARHRsY2t+U=;
        h=From:To:Cc:Subject:Date:From;
        b=xxjsFXluTaVB4EP+8TIzNLSDpBgXHEyF1s/inhVtozhMW/oghNkbyeYCPednz3zYU
         fq4tWeiqJ2Qv9GLH83ZKaZ/xKvCwIECsWbo/i0EZxWAclPZaHzMBKOEyVxkbmy69z0
         W0Iu8pFU6294B0jWmVUS3pxoRqBTL8j+idQyORiyMMMrQY6QZk2kEdMSTKq+K0sMlD
         5+WMKjeF8Lu4JnHEjwggYE2OZS5gqzV8NoR7gihvX7kmxdgHrXkyGNdHjKz+QfXW3w
         Muy1RX/piPbSpJYwSXIndzjLz7UXctBuCQhK+m7vzfgUy2Rld34pjf9+18Lf9saakr
         ig8O3Ngh3qVIA==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: imx6q-pcie: Handle various clock configurations
Date:   Wed,  2 Nov 2022 22:57:27 +0100
Message-Id: <20221102215729.147335-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX SoCs have various clock configurations routed into the PCIe IP,
the list of clock is below. Document all those configurations in the DT
binding document.

All SoCs: pcie, pcie_bus
6QDL, 7D: + pcie_phy
6SX:      + pcie_phy          pcie_inbound_axi
8MQ:      + pcie_phy pcie_aux
8MM, 8MP: +          pcie_aux

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: NXP Linux Team <linux-imx@nxp.com>
To: devicetree@vger.kernel.org
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 74 +++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 376e739bcad40..1cfea8ca72576 100644
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
@@ -60,8 +57,8 @@ properties:
     items:
       - const: pcie
       - const: pcie_bus
-      - const: pcie_phy
-      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
+      - enum: [pcie_phy, pcie_aux]
+      - enum: [pcie_inbound_axi, pcie_aux]
 
   num-lanes:
     const: 1
@@ -177,6 +174,73 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6sx-pcie
+              - fsl,imx8mq-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx6sx-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+            - const: pcie_phy
+            - const: pcie_inbound_axi
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: fsl,imx8mq-pcie
+      then:
+        properties:
+          clock-names:
+            items:
+              - const: pcie
+              - const: pcie_bus
+              - const: pcie_phy
+              - const: pcie_aux
+      else:
+        if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - fsl,imx8mm-pcie
+                  - fsl,imx8mp-pcie
+        then:
+          properties:
+            clock-names:
+              items:
+                - const: pcie
+                - const: pcie_bus
+                - const: pcie_aux
+        else:
+          properties:
+            clock-names:
+              items:
+                - const: pcie
+                - const: pcie_bus
+                - const: pcie_phy
+
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
-- 
2.35.1


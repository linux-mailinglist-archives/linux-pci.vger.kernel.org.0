Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFB617020
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 22:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKBV5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 17:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKBV5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 17:57:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148B6574;
        Wed,  2 Nov 2022 14:57:51 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E57E98438C;
        Wed,  2 Nov 2022 22:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667426269;
        bh=Lqx6hts9OjI3paHi8t4kB2hUAQZNlsQVsGVhVYLo56Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9zRojoZvoEhRQ315T7LkNxWEJTBnEWQMdF3SfCFpGXd/GYdXJQo4Wrp41lv8FZR8
         9aynLdfyi9uH/lzPRQPel+9TTgCqr+Cnon8FccnC2p7yF2E4Ies8+bMTguqTDqKOYV
         IZ/5XHRok5d1roVXC/ITkNIwXSAUZ9VSKZQdPVRRjRk4GeuiSzUxlYGL835O7QEUad
         TESyt9EWTZpiAyj12KzQ6KioD0xaU/saLIpXYDwv7XiA3fnjaakGHL+0i6Lr8u3MmP
         1ukd8zcMKvNhASp15coYWA3yjq4MvmqogeKEQOC/cxiSo7T7wEJXWcNftuLgCVolBz
         vPnAO9ToJcQ0w==
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
Subject: [PATCH 2/3] dt-bindings: imx6q-pcie: Handle various PD configurations
Date:   Wed,  2 Nov 2022 22:57:28 +0100
Message-Id: <20221102215729.147335-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102215729.147335-1-marex@denx.de>
References: <20221102215729.147335-1-marex@denx.de>
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

The i.MX SoCs have various power domain configurations routed into
the PCIe IP. MX6SX is the only one which contains 2 domains and also
uses power-domain-names. MX6QDL do not use any domains. All the rest
uses one domain and does not use power-domain-names anymore.

Document all those configurations in the DT binding document.

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
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 ++++++++++++++-----
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 1cfea8ca72576..fc8d4d7b80b38 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -68,19 +68,6 @@ properties:
     description: A phandle to an fsl,imx7d-pcie-phy node. Additional
       required properties for imx7d-pcie and imx8mq-pcie.
 
-  power-domains:
-    items:
-      - description: The phandle pointing to the DISPLAY domain for
-          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
-          imx8mq-pcie.
-      - description: The phandle pointing to the PCIE_PHY power domains
-          for imx6sx-pcie.
-
-  power-domain-names:
-    items:
-      - const: pcie
-      - const: pcie_phy
-
   resets:
     maxItems: 3
     description: Phandles to PCIe-related reset lines exposed by SRC
@@ -241,6 +228,40 @@ allOf:
                 - const: pcie_bus
                 - const: pcie_phy
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx6sx-pcie
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: The phandle pointing to the DISPLAY domain for
+                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
+                imx8mq-pcie.
+            - description: The phandle pointing to the PCIE_PHY power domains
+                for imx6sx-pcie.
+        power-domain-names:
+          items:
+            - const: pcie
+            - const: pcie_phy
+    else:
+      if:
+        not:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - fsl,imx6q-pcie
+                  - fsl,imx6qp-pcie
+      then:
+        properties:
+          power-domains:
+            description: |
+               The phandle pointing to the DISPLAY domain for imx6sx-pcie, to
+               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
+
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
-- 
2.35.1


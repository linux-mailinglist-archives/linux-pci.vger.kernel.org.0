Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAC61701C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 22:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKBV5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBV5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 17:57:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F06DF1A;
        Wed,  2 Nov 2022 14:57:51 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4949385087;
        Wed,  2 Nov 2022 22:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667426269;
        bh=pOflOZxdJSm/WBBfigL88V8kiLJCuonMLusq12XCQ5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt4Ot33hrw3uV36AIbR7+ABGridXE+r4OHHmtF8WsmgL5D1zza+91FqIxQv1mqMth
         /UJbOGzVTpgcsyJikSL3MVBvXQ/jm+eVAKJbNGT3UdnpitD/eaJdpQnsDNVPqdkOb2
         8hI9aBjMjbYv7CRotbyOdzgsFIXfsN2n4/Jao6MSKPTAqc/WsKbAJsNvbSkFUhk/Qn
         j1quVhS7wVxBox4gbbvsi8qUPikaLBU5JwGUGOJTRs9EeLwIBn1BlzgtsBD7y2FN9x
         69n/RNGvZz1Sqo8DEghOXOcXC3wYBc0QB2G7LfEnz0d24Nzxbgh3Ao6qVQifCBGCAc
         C2Uww1JEC6QkQ==
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
Subject: [PATCH 3/3] dt-bindings: imx6q-pcie: Handle more resets on legacy platforms
Date:   Wed,  2 Nov 2022 22:57:29 +0100
Message-Id: <20221102215729.147335-3-marex@denx.de>
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

The i.MX6 and i.MX7D does not use block controller to toggle PCIe
reset, hence the PCIe DT description contains three reset entries
on these older SoCs. Add this exception into the binding document.

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
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index fc8d4d7b80b38..12c7baba489aa 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -69,13 +69,12 @@ properties:
       required properties for imx7d-pcie and imx8mq-pcie.
 
   resets:
-    maxItems: 3
+    maxItems: 2
     description: Phandles to PCIe-related reset lines exposed by SRC
       IP block. Additional required by imx7d-pcie and imx8mq-pcie.
 
   reset-names:
     items:
-      - const: pciephy
       - const: apps
       - const: turnoff
 
@@ -262,6 +261,25 @@ allOf:
                The phandle pointing to the DISPLAY domain for imx6sx-pcie, to
                PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-pcie
+              - fsl,imx6sx-pcie
+              - fsl,imx6qp-pcie
+              - fsl,imx7d-pcie
+    then:
+      properties:
+        resets:
+          maxItems: 3
+        reset-names:
+          items:
+            - const: pciephy
+            - const: apps
+            - const: turnoff
+
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
-- 
2.35.1


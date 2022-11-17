Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8D62E1DC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiKQQ3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiKQQ2d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:28:33 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995507CB93;
        Thu, 17 Nov 2022 08:27:43 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 93A2262637;
        Thu, 17 Nov 2022 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668702459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCq6Ar2PkhD4OoGWAuL/w2DeeuE2Tk+RaLJ97BRtlww=;
        b=rMV/lodh61k0GdYu4Z5sNNQ+db50GnZUBHLoDv6d/sgNm7gHIY2U8sw121GFPFeDp9GDWw
        FME9pSpWq4h+Nf5yNyah1xxUvxB4lLpOZYKpVl/J4eOeR7lGDd+oDe2ZuKoTzdTXXe/TBo
        PYAw5qTQ95FY8SC9E4zuUGjHlCjASNg=
Received: from frank-G5.. (fttx-pool-80.245.75.65.bambit.de [80.245.75.65])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 5C6961003D5;
        Thu, 17 Nov 2022 16:27:38 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 05/11] dt-bindings: PCI: mediatek-gen3: add support for mt7986
Date:   Thu, 17 Nov 2022 17:27:22 +0100
Message-Id: <20221117162728.20608-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117162728.20608-1-linux@fw-web.de>
References: <20221117162728.20608-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 540b6034-3930-4f02-97d2-3d5b3601088a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string and clock-definition for mt7986. It needs 4 clocks
for PCIe, define them in binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
v2:
- squashed patch 2+3 (compatible and clock definition)
---
 .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 5d7369debff2..f7a02019daea 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,6 +48,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
@@ -78,9 +79,11 @@ properties:
       - const: mac
 
   clocks:
+    minItems: 4
     maxItems: 6
 
   clock-names:
+    minItems: 4
     maxItems: 6
 
   assigned-clocks:
@@ -160,6 +163,20 @@ allOf:
             - const: tl_32k
             - const: peri_26m
             - const: peri_mem
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7986-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pl_250m
+            - const: tl_26m
+            - const: peri_26m
+            - const: top_133m
 
 unevaluatedProperties: false
 
-- 
2.34.1


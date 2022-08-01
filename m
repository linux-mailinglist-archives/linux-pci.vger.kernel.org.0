Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07637586839
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHALh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiHALhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 07:37:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB21928D;
        Mon,  1 Aug 2022 04:37:19 -0700 (PDT)
X-UUID: d3305503f1e847c0926d62419e815eb8-20220801
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:94ab9d98-5d81-4bdb-b88f-34f614a3c468,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:b8e3e7d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d3305503f1e847c0926d62419e815eb8-20220801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 836323772; Mon, 01 Aug 2022 19:37:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 1 Aug 2022 19:37:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 1 Aug 2022 19:37:12 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <Rex-BC.Chen@mediatek.com>, <TingHan.Shen@mediatek.com>,
        <Liju-clr.Chen@mediatek.com>, <Jian.Yang@mediatek.com>
Subject: [PATCH v3] dt-bindings: PCI: mediatek-gen3: Add support for MT8188 and MT8195
Date:   Mon, 1 Aug 2022 19:37:09 +0800
Message-ID: <20220801113709.12101-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.

Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
"peri_mem" instead of "top_133m".

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
Changes in v3:
Use enum property to add the new clock name.

Changes in v2:
Merge two patches into one.
---
 .../bindings/pci/mediatek-pcie-gen3.yaml           | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0499b94627ae..a0ca9c7f5dfa 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,7 +48,14 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt8192-pcie
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8188-pcie
+              - mediatek,mt8195-pcie
+          - const: mediatek,mt8192-pcie
+      - items:
+          - const: mediatek,mt8192-pcie
 
   reg:
     maxItems: 1
@@ -84,7 +91,9 @@ properties:
       - const: tl_96m
       - const: tl_32k
       - const: peri_26m
-      - const: top_133m
+      - enum:
+          - top_133m        # for MT8192
+          - peri_mem        # for MT8188/MT8195
 
   assigned-clocks:
     maxItems: 1
@@ -126,6 +135,7 @@ required:
   - interrupts
   - ranges
   - clocks
+  - clock-names
   - '#interrupt-cells'
   - interrupt-controller
 
-- 
2.18.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B84EA861
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiC2HRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2HRX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 03:17:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3A36164;
        Tue, 29 Mar 2022 00:15:40 -0700 (PDT)
X-UUID: 0e3ebfebb9ea4d6d9c63dd9952ee0145-20220329
X-UUID: 0e3ebfebb9ea4d6d9c63dd9952ee0145-20220329
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1828438358; Tue, 29 Mar 2022 15:15:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Mar 2022 15:15:32 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 15:15:32 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "allen-kh . cheng" <allen-kh.cheng@mediatek.com>
Subject: [PATCH RFC] dt-bindings: PCI: mediatek-gen3: Remove clock-names
Date:   Tue, 29 Mar 2022 15:15:26 +0800
Message-ID: <20220329071526.10298-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some SoC may have different clocks (e.g. MT8192 uses clock 'top_133m',
but MT8195 use clock 'peri_mem' instead), since these clocks do not have
any timing dependencies and the PCIe controller driver uses
'devm_clk_bulk_get_all' to gets all of them, remove 'clock-names' in
dt-bindings file for compatible with different SoCs.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml   | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0499b94627ae..dc261c3d2570 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -77,15 +77,6 @@ properties:
   clocks:
     maxItems: 6
 
-  clock-names:
-    items:
-      - const: pl_250m
-      - const: tl_26m
-      - const: tl_96m
-      - const: tl_32k
-      - const: peri_26m
-      - const: top_133m
-
   assigned-clocks:
     maxItems: 1
 
@@ -157,8 +148,6 @@ examples:
                      <&infracfg 97>,
                      <&infracfg 99>,
                      <&infracfg 111>;
-            clock-names = "pl_250m", "tl_26m", "tl_96m",
-                          "tl_32k", "peri_26m", "top_133m";
             assigned-clocks = <&topckgen 50>;
             assigned-clock-parents = <&topckgen 91>;
 
-- 
2.18.0


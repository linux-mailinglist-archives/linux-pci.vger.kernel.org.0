Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2D610D35
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ1J2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJ1J2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:28:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDFE192D86;
        Fri, 28 Oct 2022 02:28:45 -0700 (PDT)
X-UUID: ec29c8be4c0e43738277bcb8c69ad0aa-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=z8DFcu4Y0BNFTtsi7qLl27vlNLxGCpxNh+bimbHT58w=;
        b=aeCkxfJsHtc2lThA5bz6piGGF9CRFJrbj4FMhjVtlobVF1Zx7suhL8ymBoFuIA6wWyCv73tjT7jbnIegKfH1XSTCv6UXIoNEM2vh5qUyk3teIOivK6QUqtTMShDiyMPMJLjHn051i3rL2P3rC5jy81BC8qWU2ZKwz2P16YrSmAA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:cbf93b8d-7cfc-4465-a6bb-582110304a3b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:df91ef80-3116-4fbc-b86b-83475c3df513,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ec29c8be4c0e43738277bcb8c69ad0aa-20221028
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 630686710; Fri, 28 Oct 2022 17:28:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 28 Oct 2022 17:28:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 28 Oct 2022 17:28:38 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        TingHan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v3 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Date:   Fri, 28 Oct 2022 17:28:34 +0800
Message-ID: <20221028092836.29006-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221028092836.29006-1-tinghan.shen@mediatek.com>
References: <20221028092836.29006-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jianjun Wang <jianjun.wang@mediatek.com>

In order to support mt8195 pcie node, update the yaml to support new
properties of iommu and power-domain, and update the reset-names
property to allow only one 'mac' name.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml         | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index c00be39af64e..a9013c10131a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -70,14 +70,21 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommu-map:
+    maxItems: 1
+
+  iommu-map-mask:
+    const: 0
+
   resets:
     minItems: 1
     maxItems: 2
 
   reset-names:
-    minItems: 1
-    items:
-      - const: phy
+    oneOf:
+      - items:
+          - const: phy
+          - const: mac
       - const: mac
 
   clocks:
@@ -107,6 +114,9 @@ properties:
     items:
       - const: pcie-phy
 
+  power-domains:
+    maxItems: 1
+
   '#interrupt-cells':
     const: 1
 
-- 
2.18.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F2061749F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 03:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiKCC5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKCC5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 22:57:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462D10B44;
        Wed,  2 Nov 2022 19:57:09 -0700 (PDT)
X-UUID: 6e41587d680042cdb3791e03ed6babbb-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NkXsbhZ1C8Ne8ug6E4tBFfkzINbKPN88lCCIn+4lczs=;
        b=NE//+U/QChOFkWDOxxJk5oZVrFhse6JqXusvzooqSiD+fmoYAFMZrUm/QYCs1bfE9S87R9QvVkhj8YS5KUHmHAOTA9VbFrWYcyW7Vh8mVwa7TyaSLPumNf+fDFvT1uMkHYOO/PYa6E+Ipy1HewM7SqcczaGvRMwccYfpp8p5a3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f45f8761-9871-4fa2-aa2a-2c40b8ed8264,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:9eee7581-3116-4fbc-b86b-83475c3df513,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6e41587d680042cdb3791e03ed6babbb-20221103
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1495823301; Thu, 03 Nov 2022 10:57:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 3 Nov 2022 10:57:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 10:57:04 +0800
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
Subject: [PATCH v5 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Date:   Thu, 3 Nov 2022 10:56:54 +0800
Message-ID: <20221103025656.8714-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221103025656.8714-1-tinghan.shen@mediatek.com>
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
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
 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index c00be39af64e..bc90f0ec7bd9 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -70,15 +70,21 @@ properties:
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
     minItems: 1
+    maxItems: 2
     items:
-      - const: phy
-      - const: mac
+      enum: [ phy, mac ]
 
   clocks:
     maxItems: 6
@@ -107,6 +113,9 @@ properties:
     items:
       - const: pcie-phy
 
+  power-domains:
+    maxItems: 1
+
   '#interrupt-cells':
     const: 1
 
-- 
2.18.0


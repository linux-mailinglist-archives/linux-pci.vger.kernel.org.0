Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5C605EA9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 13:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJTLTq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJTLTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 07:19:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5D17055;
        Thu, 20 Oct 2022 04:19:36 -0700 (PDT)
X-UUID: 1809ec0bc4104ccebfb3e2ab4eee0f08-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5evy1vxNCjxdkl74PuIn+c5ti6HjltIHHQ78bDlgo4o=;
        b=eFUm1n32WywqOYeuz7F6GEnoYyZLWl7H4lXp4U0lxaH7QECN3xvlFbe2e4xr/oMWfMz7Y+LKjQsRe+4urhL7R9MOnraDJKIyoPgyoCyi23a1PwhVHi9Hzu9AFZAcvznFlpZg1JnCoF1V4q6dwDuPIgI8pKpYCLfIYdXXzzz58K8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0f135c70-fa64-4fdc-805f-a351fdd740e6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:12e46ca4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1809ec0bc4104ccebfb3e2ab4eee0f08-20221020
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1606574240; Thu, 20 Oct 2022 19:19:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 20 Oct 2022 19:19:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 20 Oct 2022 19:19:26 +0800
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
Subject: [PATCH v2 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Date:   Thu, 20 Oct 2022 19:19:23 +0800
Message-ID: <20221020111925.30002-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221020111925.30002-1-tinghan.shen@mediatek.com>
References: <20221020111925.30002-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index c00be39af64e..af271018b134 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -70,14 +70,21 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommu-map:
+    maxItems: 1
+
+  iommu-map-mask:
+    maxItems: 1
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


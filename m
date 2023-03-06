Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E856AB673
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCFGlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 01:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCFGlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 01:41:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024281BADC;
        Sun,  5 Mar 2023 22:41:16 -0800 (PST)
X-UUID: e212e46ebbe911ed945fc101203acc17-20230306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Spyaa8M/Z1ToxANJU/RmmQBZihYa+i6zixnOJIJkGbU=;
        b=UzaC8OurkVjTBpJMpv1ru7XKPnv1wT0rVIn3Au0J2XfSfrTpzlH3Ttb4SdV5onriyHB3tGLTkK3Ld3ONjW7gWkY+5nIuunESmo1R0kbYtVj1+i+oaM6s5P9TlJfuH8bZS0hgyriyWqRJUzSX6acQtTMvM6PrkifEOnr+UY0lQ3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:45195280-e846-497e-94b3-95d50dee4da9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:85567027-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: e212e46ebbe911ed945fc101203acc17-20230306
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1356459382; Mon, 06 Mar 2023 14:41:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 6 Mar 2023 14:41:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 6 Mar 2023 14:41:09 +0800
From:   Jian Yang <jian.yang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jian.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <jieyy.yang@mediatek.com>, <qizhong.cheng@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add support for controlling power and reset
Date:   Mon, 6 Mar 2023 14:40:58 +0800
Message-ID: <20230306064059.7239-2-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306064059.7239-1-jian.yang@mediatek.com>
References: <20230306064059.7239-1-jian.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "jian.yang" <jian.yang@mediatek.com>

Add new properties to support control power supplies and reset pin of
a downstream component.

Signed-off-by: jian.yang <jian.yang@mediatek.com>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 7e8c7a2a5f9b..a59f9d0a782e 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -84,6 +84,23 @@ properties:
     items:
       enum: [ phy, mac ]
 
+  pcie1v8-supply:
+    description:
+      The regulator phandle that provides 1.8V power to a downstream component.
+
+  pcie3v3-supply:
+    description:
+      The regulator phandle that provides 3.3V power to a downstream component.
+
+  pcie12v-supply:
+    description:
+      The regulator phandle that provides 12V power to a downstream component.
+
+  dsc-reset-gpios:
+    description:
+      The extra reset pin other than PERST# required by a downstream component.
+    maxItems: 1
+
   clocks:
     minItems: 4
     maxItems: 6
-- 
2.18.0


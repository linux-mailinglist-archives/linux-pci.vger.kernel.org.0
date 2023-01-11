Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338BE66525F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 04:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKD3m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 22:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjAKD3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 22:29:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E3F00B;
        Tue, 10 Jan 2023 19:28:50 -0800 (PST)
X-UUID: 0ce976b2916011eda06fc9ecc4dadd91-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q1367LjRdABOqy7A1vYGcZQlo1pAjOhv0VoFEG4f6qM=;
        b=l4b0lZgM4FrOxeGQtY/4FwyKJjZRG1Gg1vGv2V2dFXfZfn+qm1sZqnux5tnXB0IQf9m4sTzWb1RPYfI2gtHRkXJ2sv8s050/qpvQz8jfbC9t+qr/+MvSCE3X1+Mw+LLL8pOA8FeKJVIcn4AivUql6u1VxcxVxEirSIhokNouS0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:5eee728e-3103-4e0d-8cc1-3fcbafde5b85,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.17,REQID:5eee728e-3103-4e0d-8cc1-3fcbafde5b85,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:543e81c,CLOUDID:0f19e78b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230111112845I660I28Z,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 0ce976b2916011eda06fc9ecc4dadd91-20230111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 339982136; Wed, 11 Jan 2023 11:28:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 11:28:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 11:28:41 +0800
From:   Jian Yang <jian.yang@mediatek.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jian.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <jieyy.yang@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <david-yh.chiu@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for controlling power and reset
Date:   Wed, 11 Jan 2023 11:28:30 +0800
Message-ID: <20230111032830.20447-3-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111032830.20447-1-jian.yang@mediatek.com>
References: <20230111032830.20447-1-jian.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 7e8c7a2a5f9b..46149cc63989 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -84,6 +84,29 @@ properties:
     items:
       enum: [ phy, mac ]
 
+  pcie1v8-supply:
+    description:
+      The regulator phandle that provides 1.8V power to downstream component.
+
+  pcie3v3-supply:
+    description:
+      The regulator phandle that provides 3.3V power to downstream component.
+
+  pcie12v-supply:
+    description:
+      The regulator phandle that provides 12V power to downstream component.
+
+  dsc-reset-gpios:
+    description:
+      The reset GPIO of a downstream component.
+    maxItems: 1
+
+  dsc-reset-msleep:
+    description:
+      The delay time between assertion and de-assertion of a downstream
+      component's reset GPIO.
+    maxItems: 1
+
   clocks:
     minItems: 4
     maxItems: 6
-- 
2.18.0


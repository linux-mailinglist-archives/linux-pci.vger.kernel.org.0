Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A81610D2D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ1J2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ1J2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:28:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB141974D5;
        Fri, 28 Oct 2022 02:28:42 -0700 (PDT)
X-UUID: ad82d4cbef124d88b71db87e5acb9897-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yktn2X3Tu9fQS6qMm81/IkyxFTy0zWn5CAydvKl1vAs=;
        b=p8ngwYhHUUDBnLZXtE6sQq9hznGoAoCTkxTFBUNfriawUWJpvc97qIgNz4AL2TprHA1Uo97/zRvbbNF7EJvnLMqrTNz1PrWTnJc7a4MMlcgxx7YvYU0gBR7zcDwWQaZglGg3HIQa8W9Vu74ecwstt0eAWuMPIc93wfLpie+dXng=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:649568a0-711e-46ae-89b7-9845344ab8ec,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:5174e68f-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ad82d4cbef124d88b71db87e5acb9897-20221028
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1670792734; Fri, 28 Oct 2022 17:28:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v3 0/3] Add driver nodes for MT8195 SoC
Date:   Fri, 28 Oct 2022 17:28:33 +0800
Message-ID: <20221028092836.29006-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Add pcie and venc nodes for MT8195 SoC.

This series is based on linux-next/next-20221028.
Depends on https://lore.kernel.org/all/20221001030752.14486-1-irui.wang@mediatek.com/ 

v2 -> v3:
- update pcie iommu-map-mask

v1 -> v2:
- remove 8195 example from pcie yaml
- update reset-names of pcie yaml
- add resets and reset-names to pcie node 
- rename venc node

---
Jianjun Wang (1):
  dt-bindings: PCI: mediatek-gen3: Support mt8195

Tinghan Shen (2):
  arm64: dts: mt8195: Add pcie and pcie phy nodes
  arm64: dts: mt8195: Add venc node

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  16 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 174 ++++++++++++++++++
 2 files changed, 187 insertions(+), 3 deletions(-)

-- 
2.18.0


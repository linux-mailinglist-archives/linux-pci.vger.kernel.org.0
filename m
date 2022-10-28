Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F3610D80
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ1Jn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1Jn0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:43:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DFD77F9;
        Fri, 28 Oct 2022 02:43:25 -0700 (PDT)
X-UUID: 2e246e3450494a8d8b4baea61e9a1bad-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L7iUhJXsjZSKAeavtsFdah6zQihRiXF6NImTOySL6k0=;
        b=VXNAO348lJmKy6jGVNKfWp1J2fpxhP+NmUWP4e1tdG6yh3nG2RIj48pOJx2Iekby0liPqlj8justPWWB3+e95YJlhvFUuZpOZYnjsMn6HzZ4OuU6d4+ZnuAgQ6dT4SAPxyIsz3O4qnkjWbOxi+AQyqx8GrQUgPFo98Xc7NkyTCE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:cfd45132-5cd0-4295-83be-0c9b619bb233,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:cfd45132-5cd0-4295-83be-0c9b619bb233,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:eea4bfea-84ac-4628-a416-bc50d5503da6,B
        ulkID:221028174323W2U7BPUS,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2e246e3450494a8d8b4baea61e9a1bad-20221028
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 511302477; Fri, 28 Oct 2022 17:43:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 28 Oct 2022 17:43:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 28 Oct 2022 17:43:22 +0800
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
Subject: [PATCH v4 0/3] Add driver nodes for MT8195 SoC
Date:   Fri, 28 Oct 2022 17:43:14 +0800
Message-ID: <20221028094317.29270-1-tinghan.shen@mediatek.com>
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

v3 -> v4:
- update resets of pcie node

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


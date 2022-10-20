Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E50605EAF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJTLTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJTLTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 07:19:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3712089;
        Thu, 20 Oct 2022 04:19:35 -0700 (PDT)
X-UUID: 15102183a74e45cfa73792051820af5c-20221020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=opOjBz4YXQMkku/b+s8cixkeDvpolqYi8tbCP8NecmU=;
        b=YoPKMOB/3izsOGR4+e+ZvfPUfjiUuE4JsU9CbS4Zz0N7FCwtIeUmrs6rkdF5cvAKd2v+J1tidr5uK+JNhcvuC2QwuYAZXg29XknxceeMnmVQkCFgKG9FLkJSycW0QCCU2zoaGneLUwVPKhZQ/8MmeJrNkfSrhT8QFCYzBoXod5Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:151b4e64-6491-4eb2-9d8b-78fe0c197f0c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:fb927233-7d3c-46b3-a6e9-0ba03eeda632,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 15102183a74e45cfa73792051820af5c-20221020
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1793700684; Thu, 20 Oct 2022 19:19:28 +0800
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
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v2 0/3] Add driver nodes for MT8195 SoC
Date:   Thu, 20 Oct 2022 19:19:22 +0800
Message-ID: <20221020111925.30002-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Add pcie and venc nodes for MT8195 SoC.

This series is based on linux-next/next-20221020.
Depends on https://lore.kernel.org/all/20221001030752.14486-1-irui.wang@mediatek.com/ 

v1 -> v2:
- remove 8195 example from pcie yaml
- update reset-names of pcie yaml
- add resets and reset-names to pcie node 
- rename venc node

---
Jianjun Wang (1):
  dt-bindings: PCI: mediatek-gen3: Add iommu and power-domain support

Tinghan Shen (2):
  arm64: dts: mt8195: Add pcie and pcie phy nodes
  arm64: dts: mt8195: Add venc node

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  16 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 174 ++++++++++++++++++
 2 files changed, 187 insertions(+), 3 deletions(-)

-- 
2.18.0


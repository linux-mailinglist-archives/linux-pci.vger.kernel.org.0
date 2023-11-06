Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308C57E1A10
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 07:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjKFGMc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 01:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFGMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 01:12:32 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC7FA;
        Sun,  5 Nov 2023 22:12:28 -0800 (PST)
X-UUID: 743680667c6b11eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=grp1AlMkyekbeDiBRfj+htcx3Y2qk/xgnK8jPrJfTv8=;
        b=a3tmYAYGbxzC1lsN+xzDtWfpfUPBRpzY1PLA+VYSf34M6/rbe5S5fPw/9kRhucpuKDFuMuYaeOxUmgWKt4r1/RJTtao8C42Dfm3/P0aUrssX6p0DcvdJYpG71y1B7WK2djJ7ErcRdwsyxZtLz3Ei+nveJN/2JKv4VNksCoJ1L3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1150d3e3-3d4e-4c1f-856d-4797e928126b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:b8e4b85f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 743680667c6b11eea33bb35ae8d461a2-20231106
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2138774526; Mon, 06 Nov 2023 14:12:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 14:12:23 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 14:12:22 +0800
From:   Jian Yang <jian.yang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <Chuanjia.Liu@mediatek.com>, <Jieyy.Yang@mediatek.com>,
        <Qizhong.Cheng@mediatek.com>, <Jianguo.Zhang@mediatek.com>,
        Jian Yang <jian.yang@mediatek.com>
Subject: [PATCH v4 0/2] PCI: mediatek-gen3: Support controlling power supplies
Date:   Mon, 6 Nov 2023 14:12:18 +0800
Message-ID: <20231106061220.21485-1-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for controlling power supplies and reset GPIO of a downstream
component in Mediatek's PCIe GEN3 controller driver.

Changes in v4:
1. Rename power supplies properties in DT binding and driver.
2. Reorder variables alphabetically.
3. Use 'dev_err_probe' to do some error handling stuff.

Changes in v3:
1. Modify description of power supply properties in DT binding.
2. Remove unused header files.
3. Use 'device_wakeup_path' to determine whether the downstream component
needs to skip the reset process in system suspend scenarios.

Changes in v2:
1. Remove an unnecessary property in dt-bindings file.
2. Use the flag 'GPIOD_OUT_LOW' to set initial state of a downstream
component's reset GPIO.
3. Keep downstream component powered on in suspend state if it is capable
of waking up the system.

jian.yang (2):
  dt-bindings: PCI: mediatek-gen3: Add support for controlling power and
    reset
  PCI: mediatek-gen3: Add power and reset control feature for downstream
    component

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 30 +++++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 89 ++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.18.0


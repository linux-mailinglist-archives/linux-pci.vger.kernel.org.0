Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3B6AB671
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCFGlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 01:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCFGlW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 01:41:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C857D1B54F;
        Sun,  5 Mar 2023 22:41:16 -0800 (PST)
X-UUID: e055aeeabbe911ed945fc101203acc17-20230306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fjPhyM0ETWURr4gOHa0K/Dc6pqcNM8k4+6w2fVMFVvo=;
        b=sL2Q7IsoUuzZojF4WviiUJGgVD8xGHjaWdxOF0A8vQSwE+Mp7A53Nh3RJIsoEomGFAVeKR8vFjj52fdIA7meIZ3f1fiMfS7lnpXWKkHWxXpaXPP87Z9AUpAEaQCqoR3a5u5bVy9qdexRWPsDsIhA2Hva9qFm/Y/JlqCzuAvBagg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:5fba1ba1-be4a-4ea9-a0ac-be2a017b4b6a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:bb9fdef4-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: e055aeeabbe911ed945fc101203acc17-20230306
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1656512053; Mon, 06 Mar 2023 14:41:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 6 Mar 2023 14:41:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 6 Mar 2023 14:41:06 +0800
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
Subject: [PATCH v2 0/2] PCI: mediatek-gen3: Support controlling power and
Date:   Mon, 6 Mar 2023 14:40:57 +0800
Message-ID: <20230306064059.7239-1-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

These series patches add support for controlling power supplies and reset
GPIO of a downstream component in Mediatek's PCIe GEN3 controller driver.

Changes in v2:
1. Remove an unnecessary property in dt-bindings file.
2. Use the flag 'GPIOD_OUT_LOW' to set initial state of a downstream
component's reset GPIO.
3. Keep downstream component powered on in suspend state if it need to
wakeup the system.

jian.yang (2):
  dt-bindings: PCI: mediatek-gen3: Add support for controlling power and
    reset
  PCI: mediatek-gen3: Add power and reset control feature for downstream
    component

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 17 ++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 86 ++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.18.0


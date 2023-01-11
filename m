Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E266524D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 04:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjAKD0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 22:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjAKD0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 22:26:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119C383;
        Tue, 10 Jan 2023 19:25:52 -0800 (PST)
X-UUID: a32e8ece915f11ed945fc101203acc17-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tPBVLufhdIhjett3dh8ZSV7+mAa/jQgjUH4vRx9Y3lE=;
        b=C8tFDmU1S95DzL54D0/ikMhTr+vl+7WI6TQavdRFkN+OE+S/NDg+kOtO+wO0ceOvxjYmwVs0B5fcuRlF26Jv1U4c7LJRChxVr9wBKLnKKGd0UC3EHnU64N2LUsbn4gQb/m5ZQcw6H/9vbb2OuF9SbvnMCmcPND8nTKFfTOxGRQo=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:a5a3a9e3-c2a4-47ab-bd32-f60a378eb500,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.17,REQID:a5a3a9e3-c2a4-47ab-bd32-f60a378eb500,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:543e81c,CLOUDID:6d00e78b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230111112547OCN7N61P,BulkQuantity:0,Recheck:0,SF:38|28|16|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: a32e8ece915f11ed945fc101203acc17-20230111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1768162440; Wed, 11 Jan 2023 11:25:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 11:25:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 11:25:43 +0800
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
Subject: [PATCH 0/2] PCI: mediatek-gen3: Support controlling power supplies
Date:   Wed, 11 Jan 2023 11:25:40 +0800
Message-ID: <20230111032542.20306-1-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "jian.yang" <jian.yang@mediatek.com>

These series patches add support for controlling power supplies and reset
GPIO of a downstream component in MediaTek's PCIe GEN3 controller driver.

jian.yang (2):
  PCI: mediatek-gen3: Add power and reset control feature for downstream
    component
  dt-bindings: PCI: mediatek-gen3: Add support for controlling power and
    reset

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  23 ++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 114 +++++++++++++++++-
 2 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.18.0


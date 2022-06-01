Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A7539C53
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 06:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiFAEru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 00:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiFAEru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 00:47:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD603969C;
        Tue, 31 May 2022 21:47:42 -0700 (PDT)
X-UUID: ef36d7d6d9254b4ab4bd99f1e3c5bb15-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:23316a26-42bd-42f8-85e8-b5bd763b2579,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:32fc158a-32d7-4fc0-b2ef-8776ac194f8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: ef36d7d6d9254b4ab4bd99f1e3c5bb15-20220601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1341377555; Wed, 01 Jun 2022 12:47:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 12:47:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 12:47:36 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <bhelgaas@google.com>, <jianjun.wang@mediatek.com>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <miles.chen@mediatek.com>, <robh@kernel.org>,
        <ryder.lee@mediatek.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Wed, 1 Jun 2022 12:47:36 +0800
Message-ID: <20220601044736.8440-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601041259.56185-1-linmq006@gmail.com>
References: <20220601041259.56185-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miaoqian, 

>of_get_child_by_name() returns a node pointer with refcount
>incremented, we should use of_node_put() on it when not need anymore.
>Add missing of_node_put() to avoid refcount leak.
>
>Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
>Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for scanning the refcont leak and submitting this!

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

>---
>changes in v2:
>- move of_node_put(intc_node) right after irq_domain_add_linear to cover
>normal path and error paths.
>---
>changes in v3:
>- call of_node_put() in error paths with goto, and call of_node_put() before
>  return 0 in normal path. Since this function has a goto part to handle
>  resources, so put them together, as suggested by Miles Chen <miles.chen@mediatek.com>
>
>v1 link: https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
>v2 link: https://lore.kernel.org/all/20220530064807.34534-1-linmq006@gmail.com/

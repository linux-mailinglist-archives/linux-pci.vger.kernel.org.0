Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92768537384
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiE3CTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 May 2022 22:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE3CTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 May 2022 22:19:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC22663C1;
        Sun, 29 May 2022 19:19:33 -0700 (PDT)
X-UUID: 9b1ce6ba15f24f7fb15322853dbd4716-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:33c55451-4baa-461d-bc87-8d188f040082,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:3dabb1b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 9b1ce6ba15f24f7fb15322853dbd4716-20220530
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1326517318; Mon, 30 May 2022 10:19:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 30 May 2022 10:19:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 30 May 2022 10:19:23 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <bhelgaas@google.com>, <jianjun.wang@mediatek.com>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <miles.chen@mediatek.com>, <robh@kernel.org>,
        <ryder.lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Mon, 30 May 2022 10:19:23 +0800
Message-ID: <20220530021923.31601-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <bd03ca71-1875-2e94-8040-533034f76ee5@gmail.com>
References: <bd03ca71-1875-2e94-8040-533034f76ee5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Miaoqian,

>>> 						  &intx_domain_ops, pcie);
>>> 	if (!pcie->intx_domain) {
>>> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>>> +		of_node_put(intc_node);
>>> 		return -ENODEV;
>>> 	}
>> Thanks for doing this.
>>
>> I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
>> err_msi_domain and err_msi_bottom_domain and the normal path which also
>> need of_node_put(intc_node).
>
>Thanks for your reply,
>
>I didn't add of_node_put() in other paths because I am not sure if the reference passed through irq_domain_add_linear(), since intc_node is passed to irq_domain_add_linear().
>
>__irq_domain_add() keeps &node->fwnode in the irq_domain structure.
>
>and use fwnode_handle_get() to get the reference of fwnode, but I still uncertain.
>
>If the reference don't needed anymore after irq_domain_add_linear(),
>
>your suggestion looks fine, and I will submit v2.


Thanks for your reply, I think we can do similar things like
rtl8365mb_irq_setup() in drivers/net/dsa/realtek/rtl8365mb.c

Thanks,
Miles

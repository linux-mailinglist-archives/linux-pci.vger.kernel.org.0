Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044553757B
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiE3HgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 May 2022 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiE3HgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2022 03:36:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA039B99;
        Mon, 30 May 2022 00:36:03 -0700 (PDT)
X-UUID: 33b064ae7da048188e2a565cc58ae238-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:57f8ed2e-6554-4fd0-bd82-9213fe71ea40,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:0e78bfb8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 33b064ae7da048188e2a565cc58ae238-20220530
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1687734413; Mon, 30 May 2022 15:35:57 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 30 May 2022 15:35:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 May 2022 15:35:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 May 2022 15:35:55 +0800
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
Date:   Mon, 30 May 2022 15:35:56 +0800
Message-ID: <20220530073556.1831-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6cf820cf-a2e7-c93e-3c00-08bc366f2eb2@gmail.com>
References: <6cf820cf-a2e7-c93e-3c00-08bc366f2eb2@gmail.com>
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

>Hi, Miles
>
>On 2022/5/30 10:19, Miles Chen wrote:
>> Hi Miaoqian,
>>
>>>>> 						  &intx_domain_ops, pcie);
>>>>> 	if (!pcie->intx_domain) {
>>>>> 		dev_err(dev, "failed to create INTx IRQ domain\n");
>>>>> +		of_node_put(intc_node);
>>>>> 		return -ENODEV;
>>>>> 	}
>>>> Thanks for doing this.
>>>>
>>>> I checked mtk_pcie_init_irq_domains() and there are multiple exit paths like
>>>> err_msi_domain and err_msi_bottom_domain and the normal path which also
>>>> need of_node_put(intc_node).
>>> Thanks for your reply,
>>>
>>> I didn't add of_node_put() in other paths because I am not sure if the reference passed through irq_domain_add_linear(), since intc_node is passed to irq_domain_add_linear().
>>>
>>> __irq_domain_add() keeps &node->fwnode in the irq_domain structure.
>>>
>>> and use fwnode_handle_get() to get the reference of fwnode, but I still uncertain.
>>>
>>> If the reference don't needed anymore after irq_domain_add_linear(),
>>>
>>> your suggestion looks fine, and I will submit v2.
>>
>> Thanks for your reply, I think we can do similar things like
>> rtl8365mb_irq_setup() in drivers/net/dsa/realtek/rtl8365mb.c
>
>I checked rtl8365mb_irq_setup(), it calls of_node_put() by goto statement for error paths.
>
>and calls of_node_put() before return 0 in normal path. I didn't see the same problem.

Sorry for the confusing. I meant that we can do the same thing - 
it calls of_node_put() by goto statement for error paths
and calls of_node_put() before return 0 in normal path. :-)

Thanks,
Miles

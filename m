Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE752B041
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiERBzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiERBzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 21:55:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FF054BDC;
        Tue, 17 May 2022 18:55:35 -0700 (PDT)
X-UUID: 220dc296169e4cf399570465aad54c37-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3324cc5a-4676-45a4-afec-ce54a28106ca,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:7e718ee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 220dc296169e4cf399570465aad54c37-20220518
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1859978881; Wed, 18 May 2022 09:55:30 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 18 May 2022 09:55:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 May 2022 09:55:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 May 2022 09:55:28 +0800
Message-ID: <7a10b1d7fc294093f26555a8b5a8748a3c0e1c9f.camel@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Print LTSSM state when PCIe link
 down
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Wed, 18 May 2022 09:55:28 +0800
In-Reply-To: <32f5308e629cef3692c57c4c55442b0f2f25634f.camel@mediatek.com>
References: <20220329030715.7975-1-jianjun.wang@mediatek.com>
         <32f5308e629cef3692c57c4c55442b0f2f25634f.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Maintainers,

Gentle ping for this patch, if there is anything I can do to get this
patch merged, please let me know.

Thanks.

On Fri, 2022-04-22 at 14:33 +0800, Jianjun Wang wrote:
> Hi Maintainers,
> 
> Just gentle ping for this patch, if there is anything I can do to get
> this patch merged, please let me know.
> 
> Thanks.
> 
> On Tue, 2022-03-29 at 11:07 +0800, Jianjun Wang wrote:
> > Print current LTSSM state when PCIe link down instead of the
> > register
> > value, make it easier to get the link status.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> > Changes in v2:
> > Print both of the register value and the LTSSM state.
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 41
> > ++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 6745076a02b9..c24e03c198b7 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -153,6 +153,37 @@ struct mtk_gen3_pcie {
> >  	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
> >  };
> >  
> > +/* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
> > +static const char *const ltssm_str[] = {
> > +	"detect.quiet",			/* 0x00 */
> > +	"detect.active",		/* 0x01 */
> > +	"polling.active",		/* 0x02 */
> > +	"polling.compliance",		/* 0x03 */
> > +	"polling.configuration",	/* 0x04 */
> > +	"config.linkwidthstart",	/* 0x05 */
> > +	"config.linkwidthaccept",	/* 0x06 */
> > +	"config.lanenumwait",		/* 0x07 */
> > +	"config.lanenumaccept",		/* 0x08 */
> > +	"config.complete",		/* 0x09 */
> > +	"config.idle",			/* 0x0A */
> > +	"recovery.receiverlock",	/* 0x0B */
> > +	"recovery.equalization",	/* 0x0C */
> > +	"recovery.speed",		/* 0x0D */
> > +	"recovery.receiverconfig",	/* 0x0E */
> > +	"recovery.idle",		/* 0x0F */
> > +	"L0",				/* 0x10 */
> > +	"L0s",				/* 0x11 */
> > +	"L1.entry",			/* 0x12 */
> > +	"L1.idle",			/* 0x13 */
> > +	"L2.idle",			/* 0x14 */
> > +	"L2.transmitwake",		/* 0x15 */
> > +	"disable",			/* 0x16 */
> > +	"loopback.entry",		/* 0x17 */
> > +	"loopback.active",		/* 0x18 */
> > +	"loopback.exit",		/* 0x19 */
> > +	"hotreset",			/* 0x1A */
> > +};
> > +
> >  /**
> >   * mtk_pcie_config_tlp_header() - Configure a configuration TLP
> > header
> >   * @bus: PCI bus to query
> > @@ -327,8 +358,16 @@ static int mtk_pcie_startup_port(struct
> > mtk_gen3_pcie *pcie)
> >  				 !!(val & PCIE_PORT_LINKUP), 20,
> >  				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
> >  	if (err) {
> > +		const char *ltssm_state;
> > +		int ltssm_index;
> > +
> >  		val = readl_relaxed(pcie->base +
> > PCIE_LTSSM_STATUS_REG);
> > -		dev_err(pcie->dev, "PCIe link down, ltssm reg val:
> > %#x\n", val);
> > +		ltssm_index = PCIE_LTSSM_STATE(val);
> > +		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
> > +			      "Unknown state" : ltssm_str[ltssm_index];
> > +		dev_err(pcie->dev,
> > +			"PCIe link down, current ltssm state: %s
> > (%#x)\n",
> > +			ltssm_state, val);
> >  		return err;
> >  	}
> >  
> 
> 


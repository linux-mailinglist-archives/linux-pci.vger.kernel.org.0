Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4119B54A675
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 04:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355615AbiFNCg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355966AbiFNCgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 22:36:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E1340C0;
        Mon, 13 Jun 2022 19:15:12 -0700 (PDT)
X-UUID: 0b33db81944c4a7e930f51d58ecd3e44-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f02b50cf-029f-4c0f-bdec-3799a2d958c6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:93287a07-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 0b33db81944c4a7e930f51d58ecd3e44-20220614
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2083284706; Tue, 14 Jun 2022 10:15:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 10:15:04 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 14 Jun 2022 10:15:04 +0800
Message-ID: <758e23499dd440f480d90c4417625a538521917a.camel@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Print LTSSM state when PCIe link
 down
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Tue, 14 Jun 2022 10:15:03 +0800
In-Reply-To: <f95d10d69758014c9b1631718afa7dc72a68aa79.camel@mediatek.com>
References: <20220329030715.7975-1-jianjun.wang@mediatek.com>
         <32f5308e629cef3692c57c4c55442b0f2f25634f.camel@mediatek.com>
         <7a10b1d7fc294093f26555a8b5a8748a3c0e1c9f.camel@mediatek.com>
         <f95d10d69758014c9b1631718afa7dc72a68aa79.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Maintainers,

Just gentle ping for this patch, is there anything I can to do to get
this patch merged?

Thanks.

On Wed, 2022-06-01 at 10:24 +0800, Jianjun Wang wrote:
> Hello Maintainers,
> 
> Is there anything I can do to get this patch merged?
> 
> Thanks.
> 
> On Wed, 2022-05-18 at 09:55 +0800, Jianjun Wang wrote:
> > Hi Maintainers,
> > 
> > Gentle ping for this patch, if there is anything I can do to get
> > this
> > patch merged, please let me know.
> > 
> > Thanks.
> > 
> > On Fri, 2022-04-22 at 14:33 +0800, Jianjun Wang wrote:
> > > Hi Maintainers,
> > > 
> > > Just gentle ping for this patch, if there is anything I can do to
> > > get
> > > this patch merged, please let me know.
> > > 
> > > Thanks.
> > > 
> > > On Tue, 2022-03-29 at 11:07 +0800, Jianjun Wang wrote:
> > > > Print current LTSSM state when PCIe link down instead of the
> > > > register
> > > > value, make it easier to get the link status.
> > > > 
> > > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > ---
> > > > Changes in v2:
> > > > Print both of the register value and the LTSSM state.
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek-gen3.c | 41
> > > > ++++++++++++++++++++-
> > > >  1 file changed, 40 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > index 6745076a02b9..c24e03c198b7 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > > @@ -153,6 +153,37 @@ struct mtk_gen3_pcie {
> > > >  	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
> > > >  };
> > > >  
> > > > +/* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
> > > > +static const char *const ltssm_str[] = {
> > > > +	"detect.quiet",			/* 0x00 */
> > > > +	"detect.active",		/* 0x01 */
> > > > +	"polling.active",		/* 0x02 */
> > > > +	"polling.compliance",		/* 0x03 */
> > > > +	"polling.configuration",	/* 0x04 */
> > > > +	"config.linkwidthstart",	/* 0x05 */
> > > > +	"config.linkwidthaccept",	/* 0x06 */
> > > > +	"config.lanenumwait",		/* 0x07 */
> > > > +	"config.lanenumaccept",		/* 0x08 */
> > > > +	"config.complete",		/* 0x09 */
> > > > +	"config.idle",			/* 0x0A */
> > > > +	"recovery.receiverlock",	/* 0x0B */
> > > > +	"recovery.equalization",	/* 0x0C */
> > > > +	"recovery.speed",		/* 0x0D */
> > > > +	"recovery.receiverconfig",	/* 0x0E */
> > > > +	"recovery.idle",		/* 0x0F */
> > > > +	"L0",				/* 0x10 */
> > > > +	"L0s",				/* 0x11 */
> > > > +	"L1.entry",			/* 0x12 */
> > > > +	"L1.idle",			/* 0x13 */
> > > > +	"L2.idle",			/* 0x14 */
> > > > +	"L2.transmitwake",		/* 0x15 */
> > > > +	"disable",			/* 0x16 */
> > > > +	"loopback.entry",		/* 0x17 */
> > > > +	"loopback.active",		/* 0x18 */
> > > > +	"loopback.exit",		/* 0x19 */
> > > > +	"hotreset",			/* 0x1A */
> > > > +};
> > > > +
> > > >  /**
> > > >   * mtk_pcie_config_tlp_header() - Configure a configuration
> > > > TLP
> > > > header
> > > >   * @bus: PCI bus to query
> > > > @@ -327,8 +358,16 @@ static int mtk_pcie_startup_port(struct
> > > > mtk_gen3_pcie *pcie)
> > > >  				 !!(val & PCIE_PORT_LINKUP),
> > > > 20,
> > > >  				 PCI_PM_D3COLD_WAIT *
> > > > USEC_PER_MSEC);
> > > >  	if (err) {
> > > > +		const char *ltssm_state;
> > > > +		int ltssm_index;
> > > > +
> > > >  		val = readl_relaxed(pcie->base +
> > > > PCIE_LTSSM_STATUS_REG);
> > > > -		dev_err(pcie->dev, "PCIe link down, ltssm reg
> > > > val:
> > > > %#x\n", val);
> > > > +		ltssm_index = PCIE_LTSSM_STATE(val);
> > > > +		ltssm_state = ltssm_index >=
> > > > ARRAY_SIZE(ltssm_str) ?
> > > > +			      "Unknown state" :
> > > > ltssm_str[ltssm_index];
> > > > +		dev_err(pcie->dev,
> > > > +			"PCIe link down, current ltssm state:
> > > > %s
> > > > (%#x)\n",
> > > > +			ltssm_state, val);
> > > >  		return err;
> > > >  	}
> > > >  
> > > 
> > > 
> > 
> > 
> 
> 


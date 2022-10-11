Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A25FB81A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKQQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKQQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 12:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32517B2A5;
        Tue, 11 Oct 2022 09:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615C661219;
        Tue, 11 Oct 2022 16:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61602C433C1;
        Tue, 11 Oct 2022 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665505001;
        bh=4El1xy5+4eBKChexAiLxCSxJfpt2cKVYwJcxgtmuLS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFlIkC42BJbtT1glp99wuVL8IXHt1dbkagpL2++6xgQZ4FkP1Gxtg2CzUgr3zHMBX
         D6ni754wsecjLDpGyGMGmyfVnMd6ivjgpaVbRnArceyQ5mIlXVQ701JKWNNcEGuaw7
         LuDr7H2kZ4NuY2BJly1kaa69+Po92N1n5qR0Yu6OL1wDByHbi2jc2P7oIttJbrBBzP
         crbb0tynak/diwP5j9D59x4OznNMZBlWk1/1/31VqULOdGuwj/DpHLReYgesDSK/jK
         P2+0rgIaRZNhuugfTiFGTDLWYdt4keLbCD1WizpDFxpnWjqyo8f1GsALqZ6ApF8Jtv
         DIC2lE6qYD7Wg==
Received: by pali.im (Postfix)
        id 74A897B3; Tue, 11 Oct 2022 18:16:38 +0200 (CEST)
Date:   Tue, 11 Oct 2022 18:16:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Message-ID: <20221011161638.ycxpg3ox2wv63vym@pali>
References: <20220928121911.14994-1-pali@kernel.org>
 <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 11 October 2022 16:42:34 Jon Hunter wrote:
> On 28/09/2022 13:19, Pali Rohár wrote:
> > Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() macro
> > for accessing PCI config space.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > Please look also at this related patch:
> > https://patchwork.kernel.org/project/linux-pci/patch/20220911113216.14892-1-pali@kernel.org/
> > ---
> >   drivers/pci/controller/pci-tegra.c | 11 +++--------
> >   1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > index 5df90d183526..c9924e75e597 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -417,13 +417,6 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
> >    * address (access to which generates correct config transaction) falls in
> >    * this 4 KiB region.
> >    */
> > -static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
> > -					   unsigned int where)
> > -{
> > -	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
> > -	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
> > -}
> > -
> >   static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
> >   					unsigned int devfn,
> >   					int where)
> > @@ -445,7 +438,9 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
> >   		unsigned int offset;
> >   		u32 base;
> > -		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
> > +		offset = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
> > +					       PCI_FUNC(devfn), where) &
> > +			 ~PCI_CONF1_ENABLE;
> >   		/* move 4 KiB window to offset within the FPCI region */
> >   		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
> 
> 
> Our PCIe test on Tegra124 Jetson TK1 is currently failing on -next and
> bisect points to this commit. Looking at bit closer, the problem appears to
> be the PCI_CONF1_REG_MASK which has a value of 0xfc. Before this patch was
> applied a mask of 0xff was applied to the lower 8-bits of 'where' and now it
> is 0xfc. So this does not work for Tegra as it is.
> 
> Let me know if you have any thoughts?
> 
> Jon
> 
> -- 
> nvpublic

I see, this is stupid mistake. PCIe config read and write operations
needs to be 4-byte aligned, so normally it is done by calculating 4-byte
aligned base address and then using appropriate cpu load/store
instruction to access just defined size/offset of 4-byte config space
register.

pci-tegra.c is using common helper functions pci_generic_config_read()
and pci_generic_config_write(), which expects final address with offset,
and not 4-byte aligned address.

I'm not sure what should be the proper fix, but for me it looks like
that pci_generic_config_read() and pci_generic_config_write() could be
adjusted to handle it.

In any case, above patch is a regressions and I see there two options
for now:

1) Reverting that patch

2) Adding "offset |= where & 0x3;" after the PCI_CONF1_EXT_ADDRESS()
   macro to set also lower 2 bits of accessed register.

Jon, Lorenzo, what do you think? Could you test if 2) is working fine?

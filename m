Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF44CB12A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiCBVWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 16:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiCBVWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 16:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE247393
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 13:21:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0E56198B
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 21:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F44C004E1;
        Wed,  2 Mar 2022 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646256081;
        bh=nWhTxPT2SPyjMiXFh65uIKsFFn6DD++9t6nYiENYYCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fH94B8v2HFRxUjriArCYvnlh9J9NaDHIYDqz4pfPpE3PLVjY602c8fKsIcTgIclVN
         /6PZsJ79KOdv3Q7k9a/c3CHo19JGIB5NrzOMuOi2CS/3Wt6bQXqgGsZmfmtOVCnEkO
         RAreRAAPFVngAxOJpcgXTxsey2BB4dGMd+wd83O7H0dKOIt8yTOHFEkGfjzuL8xa4A
         89YVmLjQZNlMdjHxFvy2jjTz/k8UEjFrNNH4aYsOR8Fg100UNLBCj6y7Xhi54vNIQC
         /9XYiU05FfjPbfgHKKzcq/69yOTtOvx7FzjqPy82nO5xh5twENxOWrbpszZdSNBOxd
         xVei0Xv7P9wTg==
Date:   Wed, 2 Mar 2022 15:21:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220302212119.GA754158@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqR8ZwNVFqqRo0hAAt8aDDrduXnBRTTw3G868wkOP3EKYg@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 02:49:45PM -0600, Zhi Li wrote:
> On Wed, Mar 2, 2022 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > In subject:
> >
> >   PCI: imx6: Add embedded DMA support
> >
> > to match existing style.  "PCIe" seems superfluous here since we
> > already mentioned it earlier in the subject.
> 
> Sorry, it is PCI when git log to check old history.

I don't understand.  But maybe this would be better?

  PCI: imx6: Add embedded DMA controller support

> > On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> > > ...

> > > The DMA can transfer data to any remote address location
> > > regardless PCI address space size.
> >
> > What is this sentence telling us?  Is it merely that the DMA "inbound
> > address space" may be larger than the MMIO "outbound address space"?
> > I think there's no necessary connection between them, and there's no
> > need to call it out as though it's something special.
> 
> There are outbound address windows. such as 256M, but RC sides have more
> than 256M ddr memory, such as 16GB. If CPU or external DMA controller,
> only can access 256M
> address space.
> 
> But if using an embedded DMA controller,  it can access the whole RC's
> 16G address without
> changing iAtu mapping.
> 
> I want to say why I need enable embedded DMA for EP.

OK, so if IIUC, the DMA controller is embedded in the imx6 host bridge
(of course; that's obvious from what you're doing here).  And unlike
DMA from devices *below* the host bridge, DMAs from the embedded
controller don't go through the iATU, so they are not subject to any
of the iATU limitations.  Right?

> > > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie,
> > > +                         struct platform_device *pdev,
> > > +                         struct resource *dbi_base)
> >
> > IIUC this is already in pci->dbi_base, so why not use that instead of
> > passing it in?  Passing both a struct and the contents of a member of
> > the struct is an opportunity for a mistake.
> 
> pci->dbi_base just provides a virtual address.
> I can change dbi_base as dbi_res.

Ah, I missed that you use the CPU physical address from the struct
resource.

Strictly speaking, what you need is not the CPU physical address, but
the DMA address that appears on the PCI bus.  In your case, these
likely have identical values, but the logical PCI architecture, which
allows things like IOMMUs, does not guarantee this.

> > > +{
> > > +     unsigned int pcie_dma_offset;
> > > +     struct dw_pcie *pci = imx6_pcie->pci;
> > > +     struct device *dev = pci->dev;
> > > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > > +     int i = 0;
> > > +     u64 pbase;
> > > +     void *vbase;
> > > +     int sz = PAGE_SIZE;
> > > +
> > > +     pcie_dma_offset = 0x970;
> > > +
> > > +     pbase = dbi_base->start + pcie_dma_offset;
> > > +     vbase = pci->dbi_base + pcie_dma_offset;

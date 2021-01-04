Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB112E94B9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbhADMWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 07:22:41 -0500
Received: from foss.arm.com ([217.140.110.172]:32972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADMWl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 07:22:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18A601FB;
        Mon,  4 Jan 2021 04:21:55 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18CA03F70D;
        Mon,  4 Jan 2021 04:21:53 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:21:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Message-ID: <20210104122147.GA9976@e121166-lin.cambridge.arm.com>
References: <20201016120431.7062-1-marek.vasut@gmail.com>
 <20201210181133.GA3766@e121166-lin.cambridge.arm.com>
 <83135f6f-8a98-4537-0df5-91a06af07955@gmail.com>
 <20201214160829.GA3623@e121166-lin.cambridge.arm.com>
 <d7279eff-2129-f58c-baed-aa805f26429d@gmail.com>
 <20201221100129.GA15846@e121166-lin.cambridge.arm.com>
 <b72d6558-64a5-6936-d46d-fddc0aa49b8a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72d6558-64a5-6936-d46d-fddc0aa49b8a@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 30, 2020 at 01:47:25PM +0100, Marek Vasut wrote:
> On 12/21/20 11:01 AM, Lorenzo Pieralisi wrote:
> 
> [...]
> 
> > > > > > > --- a/drivers/pci/controller/pcie-rcar-host.c
> > > > > > > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > > > > > > @@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
> > > > > > >     	}
> > > > > > >     	/* setup MSI data target */
> > > > > > > -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> > > > > > > +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
> > > > > > 
> > > > > > This does not do what you want on !CONFIG_ZONE_DMA32 (ie arm LPAE).
> > > > > 
> > > > > How come? I would expect GFP_DMA32 allocates a buffer below 4 GiB in any
> > > > > case.
> > > > 
> > > > For ARM LPAE allocation falls back to ZONE_NORMAL that happens to work
> > > > because if there is memory > 4GB it ends up in ZONE_HIGHMEM, so this
> > > > patch should still work on ARM LPAE too.
> > > > 
> > > > Regardless, thoughts above the alternative approach (that saves you
> > > > a page allocation) ?
> > > 
> > > Since this is a bugfix, I would prefer it to be minimal.
> > 
> > Yes, I agree with you on that.
> 
> Then maybe it makes sense to apply this bugfix so others can benefit from it
> too ?

I will apply it shortly, thanks.

> > > Also, in case there was some yet undiscovered hardware bug which would
> > > let the MSI write through, having unused memory as the MSI destination
> > > address would only lead to write into that memory -- instead of a
> > > write into some other address.
> > > 
> > > Changing this to some hard-coded address (any suggestions?) can be a
> > > subsequent patch.
> > 
> > The idea was taking the address from the host controller inbound window
> > (ie an address outside the dma-ranges ~(dma-ranges) and < 4GB), it
> > should not matter which one.
> 
> Wouldn't that make the code quite unnecessarily complex for no gain ?

Well, there is a gain, current code is allocating a page of memory -
there is no need to do that and I don't think that what I am asking is
complex.

Again, I will merge this patch but please have a look to check if what I
ask above is a possibility.

Thanks,
Lorenzo

> The above fix does just that in one line, unless there is some code in the
> PCI subsystem to select such an address already ?
> 
> > I agree though that this can be a
> > subsequent patch even though usually we send for -rc* only fixes for
> > patches that hit the previous merge window - this seems a quite
> > longstanding (I traced it back to v3.16) one so it would wait till
> > v5.12, there is time to refactor it.
> 
> I see, I was not aware of this policy toward bugfixes.

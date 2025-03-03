Return-Path: <linux-pci+bounces-22766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D023DA4C5C9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24943A9414
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE612144A7;
	Mon,  3 Mar 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itNRtysU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9001F4166
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017235; cv=none; b=my8AmUZdJ4S+m/Xl0neVuHHCLAIR1w6kOx1g0WrAdFM3vJ4gnzubF13j4XwzuNGgDmSO+ahILQHNK3alMRNbmLSo7s3G4Gi5HwCf2Ypco+3RL9QekWLtX5+RTh3GHRWmFK6XWVpiyN38Xdw5N7VFXmce6hvt+muqND+D4ldF/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017235; c=relaxed/simple;
	bh=Dzz2PSdxS1JmBxak+dRA6PFhClOX/mFNKjSZtHnI/+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r1hQnA8ZMi/+mV99mFRr5OQxosQtKQ3Y8jvEk6XCf2Bw1M4KQMgJqa9AnE/YQ9IdFAcjeeqpff5sL4DmUIUU+VW0Ty3j/F9keuZkS99zti9zUh35pY8Lj6+Mt8Ipt5DVRcFIBqfPkRKqK0e9pmkTz3XgFQrIi/rk4zVsM1QDS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itNRtysU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE49C4CED6;
	Mon,  3 Mar 2025 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741017234;
	bh=Dzz2PSdxS1JmBxak+dRA6PFhClOX/mFNKjSZtHnI/+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=itNRtysU2inf18E4+c1/rwe1YAcd2i9B2YnGnTFlCIGhLiyNZd3shu43rwX5D8psk
	 rfcmK8S7BL/TxFHajlyz7KY22CyqzJtlOA1vw689Q5NoirM40C5XFQy1Rh60+Q5O1t
	 pQNcpEqz0dmuYBIWIF50zHzrvrOVNH+iGHAXlc1IuDmT2uNw3rp3BZ0hpDoat1i7qL
	 rJeD/Uiw2s13Oofsb0Iv73C8Md1XA21ABbxwRj8vDqhmnQFRJvxOlaJMzsd8M/UYx4
	 anQJYU3ihjM0oGYA24QyClDFiVigyoIx0h4vWdvwdMWW8mNpnLMHUu0ah87ufEd060
	 nzQEBufJ+ftYg==
Date: Mon, 3 Mar 2025 09:53:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: Rob Herring <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Message-ID: <20250303155353.GA167309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR07MB8838D3064B113BA7925ED5BAFDC92@PA4PR07MB8838.eurprd07.prod.outlook.com>

On Mon, Mar 03, 2025 at 10:35:41AM +0000, Wannes Bouwen (Nokia) wrote:
> > On Fri, Feb 28, 2025 at 05:01:51PM -0600, Rob Herring wrote:
> > > On Fri, Feb 28, 2025 at 12:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Nov 14, 2024 at 02:05:08PM +0000, Wannes Bouwen (Nokia)
> > wrote:
> > > > > Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
> > > > > non-prefetchable windows.
> > > > >
> > > > > According to the PCIe spec, non-prefetchable memory supports only
> > > > > 32-bit BAR registers and are hence limited to 4 GiB. In the kernel
> > > > > there is a check that prints a warning if a non-prefetchable
> > > > > resource exceeds the 32-bit limit.
> > > > >
> > > > > This check however prints a warning when a 4 GiB window on the
> > > > > host bridge is used. This is perfectly possible according to the
> > > > > PCIe spec, so in my opinion the warning is a bit too strict. This
> > > > > changeset subtracts 1 from the resource_size to avoid printing a
> > > > > warning in the case of a 4 GiB non-prefetchable window.
> > > > >
> > > > > Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> > > > > ---
> > > > >  drivers/pci/of.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c index
> > > > > dacea3fc5128..ccbb1f1c2212 100644
> > > > > --- a/drivers/pci/of.c
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct
> > device *dev,
> > > > >             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > > > >
> > > > >             if (!(res->flags & IORESOURCE_PREFETCH))
> > > > > -               if (upper_32_bits(resource_size(res)))
> > > > > +               if (upper_32_bits(resource_size(res) - 1))
> > > > >                     dev_warn(dev, "Memory resource size exceeds
> > > > > max for 32 bits\n");
> > > >
> > > > I guess this relies on the fact that BARs must be a power of two in
> > > > size, right?  So anything where the upper 32 bits of the size are
> > > > non-zero is either 0x1_0000_0000 (4GiB window that we shouldn't warn
> > > > about), or 0x2_0000_0000 or bigger (where we *do* want to warn about
> > > > it).
> > > >
> > > > But it looks like this is used for host bridge resources, which are
> > > > windows, not BARs, so they don't have to be a power of two size.  A
> > > > window of size 0x1_8000_0000 is perfectly legal and would fit the
> > > > criteria for this warning, but this patch would turn off the warning.
> > >
> > > 0x1_8000_0000 - 1 = 0x1_7fff_ffff
> > >
> > > So that would still work. Maybe you read it as the subtract being
> > > after upper_32_bits()?
> > 
> > Right, sorry.  I guess a better example would be something like this:
> > 
> >   [mem 0x2000_0000-0x21ff_ffff] -> [pci 0x0_ff00_0000-0x1_00ff_ffff]
> > 
> > where the size is only 0x0200_0000, so we wouldn't warn about it,
> > but half of the window is above 4G on PCI.
> > 
> > > > I don't really understand this warning in the first place,
> > > > though.  It was added by fede8526cc48 ("PCI: of: Warn if
> > > > non-prefetchable memory aperture size is > 32-bit").  But I
> > > > think the real issue would be related to the highest address,
> > > > not the size.  For example, an aperture of 0x0_c000_0000 -
> > > > 0x1_4000_0000 is only 0x8000_0000 in size, but the upper half
> > > > of it it would be invalid for non-prefetchable 32-bit BARs.
> > >
> > > Are we talking CPU addresses or PCI addresses? For CPU
> > > addresses, it would be perfectly fine to be above 4G as long as
> > > PCI addresses are below 4G, right?
> > 
> > Yes, CPU addresses can be above 4G; all that matters for this is
> > the PCI address.
> > 
> > I think what's important is the largest PCI address in the window,
> > not the size.
> 
> I agree. The check is I believe in place to make sure the host
> bridge non-prefetchable window does not exceed the 4 GiB boundary.
> This is not possible due to the register map of PCIe configuration
> space type 1 (register 0x20). I guess the check would be more
> correct if we just check the end address of the resource instead of
> the size? Something like this?
> 
> @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> 
>             if (!(res->flags & IORESOURCE_PREFETCH))
> -               if (upper_32_bits(resource_size(res)))
> +               if (upper_32_bits(res->end))

res->end is a CPU address.  All that matters here is the PCI address,
which is different.

You would need pcibios_resource_to_bus() on res, and look at the
region.end it returns.


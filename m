Return-Path: <linux-pci+bounces-22911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FE4A4EF60
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BDD188EC5D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C31FC0EF;
	Tue,  4 Mar 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL/yncSb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B71FC0E8
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123852; cv=none; b=gQJqp80zB0PhKkGZuhw5PD5YDtF9yIyp38ucbZG9IJv9uZ8US9PUhaM9rDHOCSN14bKTa0+JDOW9ugbh2unR4wFFHwAl6hmW3hpLQgZUqXLHipOnrqZ2jrOkxXokfqjBPklhIKc9DQMuSnqtMVxL4duGN7FrKMwLRWduA/lEovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123852; c=relaxed/simple;
	bh=en5hEZKdS05HPca7N04a39/83vT34GwWZiJ9NFDwSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tA/wFQ5OcRtHGdRRoaSVMnLPea2BBxZWg0iMUyMekdWXDVyKIfAFYBi477kJpsgO29qKWt+8jPcr25RVDqQ14mop7pCZccKQN1J+nyALHeZhP/Sv6TxCAAwUYNTkp1L/k9OjESp2FChBwyafaXZdBfbZHXHRPgklTRfsYq7Wnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL/yncSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBBCC4CEE5;
	Tue,  4 Mar 2025 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123851;
	bh=en5hEZKdS05HPca7N04a39/83vT34GwWZiJ9NFDwSRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nL/yncSb058n5tqYAOBUYZo54peY3hxYvRBjltwOQZ/JcgEPygiltc20U8RW0GpTv
	 Lk76nLPMLZrEjhY1eaj5IKW7PsHRsfeXnrINv3wMHBggygFe2K4ZHnxed0Pts+Eih5
	 Ca9EF0GCrOm1ZTNQyfg4nrnlHFeO4AjSkBFFXkbx3GtB0Mv7UvLDFhhXX6GWWt/Sh8
	 GebGCVTy+PrKwfOuKp1ZzAPtDRa+g6Lcm7gRHT0OCI5SdQ+VCgJ63nv/eRi82SW+j1
	 hLrp1BMl2e/D4gMPPviEQnj5/LaB4ic+BRvOru5HyoOy9513Ox5auGkF70BPC6v8Io
	 dqavpjfdRL3PA==
Date: Tue, 4 Mar 2025 15:30:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: Rob Herring <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Message-ID: <20250304213050.GA258441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR07MB8838A3BD3588448BF50ED3D4FDC82@PA4PR07MB8838.eurprd07.prod.outlook.com>

On Tue, Mar 04, 2025 at 09:15:07AM +0000, Wannes Bouwen (Nokia) wrote:
> > On Mon, Mar 03, 2025 at 10:35:41AM +0000, Wannes Bouwen (Nokia)
> > wrote:
> > > > On Fri, Feb 28, 2025 at 05:01:51PM -0600, Rob Herring wrote:
> > > > > On Fri, Feb 28, 2025 at 12:27 PM Bjorn Helgaas <helgaas@kernel.org>
> > wrote:
> > > > > > On Thu, Nov 14, 2024 at 02:05:08PM +0000, Wannes Bouwen (Nokia)
> > > > wrote:
> > > > > > > Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
> > > > > > > non-prefetchable windows.
> > > > > > >
> > > > > > > According to the PCIe spec, non-prefetchable memory supports
> > > > > > > only 32-bit BAR registers and are hence limited to 4 GiB. In
> > > > > > > the kernel there is a check that prints a warning if a
> > > > > > > non-prefetchable resource exceeds the 32-bit limit.
> > > > > > >
> > > > > > > This check however prints a warning when a 4 GiB window on the
> > > > > > > host bridge is used. This is perfectly possible according to
> > > > > > > the PCIe spec, so in my opinion the warning is a bit too
> > > > > > > strict. This changeset subtracts 1 from the resource_size to
> > > > > > > avoid printing a warning in the case of a 4 GiB non-prefetchable
> > window.
> > > > > > >
> > > > > > > Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> > > > > > > ---
> > > > > > >  drivers/pci/of.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c index
> > > > > > > dacea3fc5128..ccbb1f1c2212 100644
> > > > > > > --- a/drivers/pci/of.c
> > > > > > > +++ b/drivers/pci/of.c
> > > > > > > @@ -622,7 +622,7 @@ static int
> > > > > > > pci_parse_request_of_pci_ranges(struct
> > > > device *dev,
> > > > > > >             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > > > > > >
> > > > > > >             if (!(res->flags & IORESOURCE_PREFETCH))
> > > > > > > -               if (upper_32_bits(resource_size(res)))
> > > > > > > +               if (upper_32_bits(resource_size(res) - 1))
> > > > > > >                     dev_warn(dev, "Memory resource size
> > > > > > > exceeds max for 32 bits\n");
> > > > > >
> > > > > > I guess this relies on the fact that BARs must be a power of two
> > > > > > in size, right?  So anything where the upper 32 bits of the size
> > > > > > are non-zero is either 0x1_0000_0000 (4GiB window that we
> > > > > > shouldn't warn about), or 0x2_0000_0000 or bigger (where we *do*
> > > > > > want to warn about it).
> > > > > >
> > > > > > But it looks like this is used for host bridge resources, which
> > > > > > are windows, not BARs, so they don't have to be a power of two
> > > > > > size.  A window of size 0x1_8000_0000 is perfectly legal and
> > > > > > would fit the criteria for this warning, but this patch would turn off the
> > warning.
> > > > >
> > > > > 0x1_8000_0000 - 1 = 0x1_7fff_ffff
> > > > >
> > > > > So that would still work. Maybe you read it as the subtract being
> > > > > after upper_32_bits()?
> > > >
> > > > Right, sorry.  I guess a better example would be something like this:
> > > >
> > > >   [mem 0x2000_0000-0x21ff_ffff] -> [pci 0x0_ff00_0000-0x1_00ff_ffff]
> > > >
> > > > where the size is only 0x0200_0000, so we wouldn't warn about it,
> > > > but half of the window is above 4G on PCI.
> > > >
> > > > > > I don't really understand this warning in the first place,
> > > > > > though.  It was added by fede8526cc48 ("PCI: of: Warn if
> > > > > > non-prefetchable memory aperture size is > 32-bit").  But I
> > > > > > think the real issue would be related to the highest address,
> > > > > > not the size.  For example, an aperture of 0x0_c000_0000 -
> > > > > > 0x1_4000_0000 is only 0x8000_0000 in size, but the upper half of
> > > > > > it it would be invalid for non-prefetchable 32-bit BARs.
> > > > >
> > > > > Are we talking CPU addresses or PCI addresses? For CPU addresses,
> > > > > it would be perfectly fine to be above 4G as long as PCI addresses
> > > > > are below 4G, right?
> > > >
> > > > Yes, CPU addresses can be above 4G; all that matters for this is the
> > > > PCI address.
> > > >
> > > > I think what's important is the largest PCI address in the window,
> > > > not the size.
> > >
> > > I agree. The check is I believe in place to make sure the host bridge
> > > non-prefetchable window does not exceed the 4 GiB boundary.
> > > This is not possible due to the register map of PCIe configuration
> > > space type 1 (register 0x20). I guess the check would be more correct
> > > if we just check the end address of the resource instead of the size?
> > > Something like this?
> > >
> > > @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct
> > device *dev,
> > >             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > >
> > >             if (!(res->flags & IORESOURCE_PREFETCH))
> > > -               if (upper_32_bits(resource_size(res)))
> > > +               if (upper_32_bits(res->end))
> > 
> > res->end is a CPU address.  All that matters here is the PCI address,
> > which is different.
> > 
> > You would need pcibios_resource_to_bus() on res, and look at the region.end
> > it returns.
> 
> I've moved the check to devm_of_pci_get_host_bridge_resources() instead of using
> pcibios_resource_to_bus() as suggested. Let me know what you think of this.
> 
> Subject: [PATCH] Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
>  non-prefetchable windows.
> 
> According to the PCIe spec, non-prefetchable memory supports only 32-bit
> host bridge windows (both base address as limit address). In the kernel
> there is a check that prints a warning if a non-prefetchable resource's
> size exceeds the 32-bit limit.
> 
> The check currently checks the size of the resource, while actually the
> check should be done on the PCIe end address of the non-prefetchable
> window.
> 
> Move the check to devm_of_pci_get_host_bridge_resources where the PCIe
> addresses are available and use the end address instead of the size of
> the window to avoid warnings for 4 GiB windows.

Seems reasonable to me.  Can you post as a patch (not in the middle of
this conversation)?

Are you seeing this warning on some system?  If so, can we include the
warning and kind of system?

Please include a PCIe spec citation ("PCIe r6.0, sec x.y.z") for the
actual restriction here.

Nits: Add "()" after function names.

> Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> ---
>  drivers/pci/of.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7a806f5c0d20..6523b6dabaa7 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -400,6 +400,10 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>             *io_base = range.cpu_addr;
>         } else if (resource_type(res) == IORESOURCE_MEM) {
>             res->flags &= ~IORESOURCE_MEM_64;
> +
> +           if (!(res->flags & IORESOURCE_PREFETCH))
> +               if (upper_32_bits(range.pci_addr + range.size - 1))
> +                   dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
>         }
> 
>         pci_add_resource_offset(resources, res, res->start - range.pci_addr);
> @@ -619,10 +623,6 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>         case IORESOURCE_MEM:
>             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> 
> -           if (!(res->flags & IORESOURCE_PREFETCH))
> -               if (upper_32_bits(resource_size(res)))
> -                   dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
> -
>             break;
>         }
>     }


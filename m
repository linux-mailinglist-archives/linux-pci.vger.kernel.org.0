Return-Path: <linux-pci+bounces-22686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A9A4A690
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3984B1891963
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B75A4D5;
	Fri, 28 Feb 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AytWf/0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5723F37F
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784644; cv=none; b=Aigd3fGWATE9CrEcELwR7PYN++FK2V9RuVIA6jWAkIn3re6u4+IX4oTSaLp0rCEr/Gkf7U/mVIrNWg8Osn/wY8aW9mdyAZdSxJYOA55tJcXABLx+ah0iXlrx/U8hDoSPhHEq06Fce5UuqoPkUSvmpepa6BxlT2xJ1oY896AwsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784644; c=relaxed/simple;
	bh=t47HH5vbAejdpTH4e9/pvJ2j6sBjisTsa05WYp91M5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NxCgOLbmVIV51awG/WiuhExlCXZ57tj54hR7Ui4lKuqHwPMtJi53MKDz5DruPqoFgmWqEHbWPBRzHoZbWyfGQciKdlWuDxg5ms0c00UIQ5xtGkpkugL4lqYDrJEhag5Mt/y4H0Ij5oUWW3KBhaZSL3osHnspvZccvxful/6GgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AytWf/0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C54EC4CED6;
	Fri, 28 Feb 2025 23:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740784643;
	bh=t47HH5vbAejdpTH4e9/pvJ2j6sBjisTsa05WYp91M5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AytWf/0Ue3MeBOQ6MvWXBt8f8ClzIPaOK+LLXfcmoiNI+OSFD6nMTW4YO7S0YJmT3
	 E3Z5E/Zy1qhnasYa34GnPncwYFHe/FsYFvhs9r3zGV1+KpPNCkFvhPiaobzZPHq5c2
	 yaS0JZofX5HZp2o8WeoOIuuPmI4nHLkHg3ltBRaCgDtJcSMfCfyNCtvwOQBB9AWg0P
	 dsYkyUBkDzXsSWfiHcJ2jKHk8JmIewWGcDbcztH+mDbASjxwDkMz74aAXR1HkcaMiZ
	 6gU6Dn2A0uNk+9xL8l+Ly2PL026lQced5fjGxlIdukXjH6f+fHpwumCzyjcNvRxqwq
	 NT5yDPX2WU+JQ==
Date: Fri, 28 Feb 2025 17:17:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Message-ID: <20250228231717.GA79086@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLzic6b_Bnwf9EOJvsb-HjXnu46czqGntwZyh6M4jZ9pA@mail.gmail.com>

On Fri, Feb 28, 2025 at 05:01:51PM -0600, Rob Herring wrote:
> On Fri, Feb 28, 2025 at 12:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Nov 14, 2024 at 02:05:08PM +0000, Wannes Bouwen (Nokia) wrote:
> > > Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable
> > > windows.
> > >
> > > According to the PCIe spec, non-prefetchable memory supports only 32-bit
> > > BAR registers and are hence limited to 4 GiB. In the kernel there is a
> > > check that prints a warning if a non-prefetchable resource exceeds the
> > > 32-bit limit.
> > >
> > > This check however prints a warning when a 4 GiB window on the host
> > > bridge is used. This is perfectly possible according to the PCIe spec,
> > > so in my opinion the warning is a bit too strict. This changeset
> > > subtracts 1 from the resource_size to avoid printing a warning in the
> > > case of a 4 GiB non-prefetchable window.
> > >
> > > Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> > > ---
> > >  drivers/pci/of.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index dacea3fc5128..ccbb1f1c2212 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> > >             res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > >
> > >             if (!(res->flags & IORESOURCE_PREFETCH))
> > > -               if (upper_32_bits(resource_size(res)))
> > > +               if (upper_32_bits(resource_size(res) - 1))
> > >                     dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
> >
> > I guess this relies on the fact that BARs must be a power of two in
> > size, right?  So anything where the upper 32 bits of the size are
> > non-zero is either 0x1_0000_0000 (4GiB window that we shouldn't warn
> > about), or 0x2_0000_0000 or bigger (where we *do* want to warn about
> > it).
> >
> > But it looks like this is used for host bridge resources, which are
> > windows, not BARs, so they don't have to be a power of two size.  A
> > window of size 0x1_8000_0000 is perfectly legal and would fit the
> > criteria for this warning, but this patch would turn off the warning.
> 
> 0x1_8000_0000 - 1 = 0x1_7fff_ffff
> 
> So that would still work. Maybe you read it as the subtract being
> after upper_32_bits()?

Right, sorry.  I guess a better example would be something like this:

  [mem 0x2000_0000-0x21ff_ffff] -> [pci 0x0_ff00_0000-0x1_00ff_ffff]

where the size is only 0x0200_0000, so we wouldn't warn about it, but
half of the window is above 4G on PCI.

> > I don't really understand this warning in the first place, though.  It
> > was added by fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
> > aperture size is > 32-bit").  But I think the real issue would be
> > related to the highest address, not the size.  For example, an
> > aperture of 0x0_c000_0000 - 0x1_4000_0000 is only 0x8000_0000 in size,
> > but the upper half of it it would be invalid for non-prefetchable
> > 32-bit BARs.
> 
> Are we talking CPU addresses or PCI addresses? For CPU addresses, it
> would be perfectly fine to be above 4G as long as PCI addresses are
> below 4G, right?

Yes, CPU addresses can be above 4G; all that matters for this is the
PCI address.

I think what's important is the largest PCI address in the window, not
the size.


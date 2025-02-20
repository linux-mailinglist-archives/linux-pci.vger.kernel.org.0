Return-Path: <linux-pci+bounces-21884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C5A3D325
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C027D3A66BC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334661EB180;
	Thu, 20 Feb 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3kDrQHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E81E570A;
	Thu, 20 Feb 2025 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040038; cv=none; b=JzLwPX5Q744srYPTHpLQvJpSq1cpXhPAFluv2LjjqkADNdq5FW5/AdDGydReUDmLdfk+//xYB7gTgGyCRt01NkIUvnBM1tQ8r7gWFq1dSK+lhftNaUAUjhAHABhUQ6g0mdW40757jaYJbrwo3s9mvveHx1/l2KTglEycuaoaSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040038; c=relaxed/simple;
	bh=rcBGyUMYZ/bHU0L3nRC+4rFrhWsLpbmpvNcc2KMnCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt36L0XntOScTacGH8sNEvR13nMUvi+0H8ODa65goGnYNM/qu2Vc3yuRXvIl5d6Y3WORe4YjIx/c3FzGz6/8htVECfYx5Nfi6Hc0mBrYW9DCPYeK9N+c5Vrzt2USOayRnZwwLsChoY7mGexzNhfWtIAy0vn9CYrthUUJKtgFVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3kDrQHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2547C4CED1;
	Thu, 20 Feb 2025 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740040036;
	bh=rcBGyUMYZ/bHU0L3nRC+4rFrhWsLpbmpvNcc2KMnCPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3kDrQHCrO5r8CDTY5nMv92tM/0n3KRY4oVthQGhMttqsECu+dRmRxCrhKbjPrnwh
	 jsR9tYx1MUOvKQ+p0jSUBlfkWqk/roIiPQv6bmr/O+tMJw//Vcjr1VZXRvGw0ba3LY
	 Od77ZOjpPOED5H5cEXcqRMWVR+kTW5sKNdXN5Zh4=
Date: Thu, 20 Feb 2025 09:27:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com,
	dwmw2@infradead.org, helgaas@kernel.org,
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
	joro@8bytes.org, jsbarnes@google.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	oohall@gmail.com, pavel@denx.de, rafael.j.wysocki@intel.com,
	rafael@kernel.org, rajatja@google.com, rajatxjain@gmail.com,
	will@kernel.org
Subject: Re: [v8 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <2025022053-circulate-pamphlet-a718@gregkh>
References: <20241118193024.2695876-1-jperaza@google.com>
 <2024111818-molecule-pedicure-db1b@gregkh>
 <CAFRSFxLF-i9Yvcf653-5gThV6PS_USqM3C5C8AaWrXuFaj8EZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFRSFxLF-i9Yvcf653-5gThV6PS_USqM3C5C8AaWrXuFaj8EZg@mail.gmail.com>

On Wed, Feb 19, 2025 at 01:53:48PM -0800, Joshua Peraza wrote:
> On Mon, Nov 18, 2024 at 11:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:

Wow this is a slow discussion :)

> > On Mon, Nov 18, 2024 at 07:30:22PM +0000, Joshua Peraza wrote:
> > > This patchset rebases two previously posted patches supporting
> > > recognition of Microsoft's DmaProperty.
> > >
> > > v8: Joshua renames untrusted_dma to requires_dma_protection and updates
> > > some comments, reducing use of the word "trust" to refer to PCI devices
> > > and matching the word choice in Microsoft's documentation.
> >
> > So this is the "clarity"?  I'm not sold, sorry.  Again, did you look at
> > the previous discussions we had about this name?  We don't have to use
> > Microsoft's term here as it is used differently by Linux today, right?
> > If you really want to support the DmaProperty, why not just support that
> > with a new bit as that's something different here, right?
> >
> > Again, look at what this is supposed to be conveying.  They ability to
> > DMA to anywhere isn't really the root issue here, or is it?  What is the
> > threat model you are trying to mitigate?
> >
> > > v7: Rajat updates a comment with Robin's suggestion. Joshua re-sends and
> > > Greg requests clarity and documentation on why untrusted_dma is the
> > > right name.
> > >
> > > v6: Rajat renames pci_dev_has_dma_property and links to Microsoft's
> > > documentation in the commit message. Robin suggests clarifying a
> > > comment.
> > >
> > > v5: Rajat changes the name to untrusted_dma. Bjorn suggesting changing
> > > another function's name pci_acpi_check_for_dma_protection to
> > > pci_dev_has_dma_property and seeks clarified documentation.
> > >
> > > v4: Rajat changes the name to poses_dma_risk. Christoph suggests this
> > > name doesn't capture the intent as well as untrusted_dma and Rafael
> > > agrees.
> > >
> > > v1,v2,v3: Greg suggests that (un)trusted is the wrong word for referring
> > > to PCI devices, recommending a name something like "platform wants to
> > > protect dma access for this device."
> >
> > Or is it?  I said this when?  Just how old is this patch series?
> >
> > confused,
> >
> > greg k-h
> 
> (sorry if you're getting this again; re-sending as plain text)
> 
> Sorry for the confusion! What do you think about the following for a
> new cover letter?

I really don't remember anymore, sorry.  Try submitting the whole series
again as I don't know what you wrote the first time here.

thanks,

greg "I get 1000 emails a day" k-h


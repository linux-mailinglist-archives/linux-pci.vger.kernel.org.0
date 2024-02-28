Return-Path: <linux-pci+bounces-4195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFE86B5D8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA431F275B1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4175B1FB;
	Wed, 28 Feb 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFP76c/2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB73FBB8;
	Wed, 28 Feb 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140977; cv=none; b=iV6U0bK2FocPXOtt35FChStlCLWyDHY8gqVp1fM2SZrz2AR1UDnN+w14EXW/U3uqlKjgMyko0FShkPP/TEtVKCJKXQl9M+8cb+CaPw/IGKChtgNRpZCYjG3bqXw6zSmEL9ifqkB94LkyJfCLiYTpyE0PqatK/0RCwNU1pnZuMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140977; c=relaxed/simple;
	bh=nRStdjfCcY7LSJLuSnjP760bh7C+8aHgl8Sn6p9a54c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt175Hxlf3/ue32JNCVpgsYTxKDZAdr6w7M+BKuskVzLZzhpCAjZyQP1K3/GWfOMHlgpVb9lOj1mVQh8Rw7pkyy2Jr6dZoCVPvrjWn9hC6BkvA9pBF1dnWLFjpk40pcJHMuqFBon0R3InqteLnZQdZkROWuT3gjqVipDMFPxEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFP76c/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB032C433C7;
	Wed, 28 Feb 2024 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709140977;
	bh=nRStdjfCcY7LSJLuSnjP760bh7C+8aHgl8Sn6p9a54c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFP76c/27QGJc+0KjT3gXE1b0bg/veuDKpkmd+8bBXr3xT/NuaN68Dc4uD+96knYe
	 DjELLTJTAHI3e8Z3gTqXcZk+NSZG9+2tU/gzor6pqlzoUyscNZnzJd16m6OQYsVO8t
	 DqSWBaQlWk+hxPP7aZOKTRLHas946LtCbxs+UFFJmvBeNjPRo0Qplu5v4YY+10GEM1
	 dhrwHTJHscRO3RO0JV9f1mY9y2CF7e2I14zW3Sfv39HrL0fsJ2fqPIcDgLx3ZOeIYH
	 WmWTSzrT8GYhLZnEohrvXsM+RI6BAZmOTDTO9IiErZUmWqfz35sVmLvmahVjHh7HAa
	 Zz7WuqiVCvL2A==
Date: Thu, 29 Feb 2024 02:22:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.stein@ew.tq-group.com, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240228172255.GA3579062@rocinante>
References: <20240227171458.GA16664@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240228152222.GA272403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228152222.GA272403@bhelgaas>

Hello,

Sorry for late reply.

[...]
> > > > Krzysztof has done a ton of work to convert these files to static
> > > > attributes, where the device model prevents most of these races:
> > > > 
> > > >   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
> > > >   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > >   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
> > > >   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
> > > >   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
> > > > 
> > > > and he even posted a series to do the same for the resource files:
> > > > 
> > > >   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> > > > 
> > > > I can't remember why we didn't apply that at the time, and it no
> > > > longer applies cleanly, but I think that's the direction we should go.
> > > 
> > > Thanks for you review.
> > > 
> > > Please inform me if there's existing feedback explaining why this
> > > series hasn't been merged yet. I am willing to further improve it
> > > if necessary.
> > 
> > Let us know your opinion so that we can move ahead in fixing this
> > long pending bug.

I really thought you were asking me about your patch.  So, I didn't reply
since Bjorn added his review.

> There's no feedback on the mailing list (I checked the link above), so
> the way forward is to update the series so it applies cleanly again
> and post it as a v3.

Start with a review, if you have some time.  Perhaps we can make it better
before sending another revision.

There are two areas which this series decided not to tackle initially:

  - Support for the Alpha platform
  - Support for legacy PCI platforms

Feel free to have a look at the above.  Perhaps you will have some ideas on how
to best convert both of these to use static attributes, so that we could convert
everything at the same time.

> There's no need to wait for Krzysztof to refresh it, and if you have
> time to do it, it would be very welcomed!  The best base would be
> v6.8-rc1.

That I can do, perhaps this coming weekend.  Or even sooner when I find some
time this week.

	Krzysztof


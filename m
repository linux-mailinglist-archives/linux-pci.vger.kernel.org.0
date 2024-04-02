Return-Path: <linux-pci+bounces-5527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FE9894E9D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 11:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736B21C20F26
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDD5733B;
	Tue,  2 Apr 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnrBuzK8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB51E525;
	Tue,  2 Apr 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049836; cv=none; b=tYgzL/Ir7q9qEFN+KOqSSKsmDqpXjgG0ELBr2pin0Bh8hfZfSlq362d6bE60R+I3KRaBZ7rtFtFwV9MfhnbaYirwCWOG+vfN9MNkSS6fV1nZLlWNORGhuflcn+zckEEj5RWXPvAJqom/+U8gWdkdkGjLHun4iWsfb72vEJ+mvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049836; c=relaxed/simple;
	bh=uP3ZmE2O+vWIbuxP60+6a2e0IG8mb6uOK8upxIwNDxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw+XcjfYqRVltEPGykyZUMghs6uy2kwK8k2OYlftSw2JGh1aaEzzZEprDih69gBIOz8OD/FkFj2K1rotJvGokS5obWBtlXVc877d01ZZu0+oyRKyUEIblTrebSSt2pBzMIxcQMitHKWSXn8o+xkLZ3BSrw+CX1jaD7zy7TClqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnrBuzK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12EEC433F1;
	Tue,  2 Apr 2024 09:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712049835;
	bh=uP3ZmE2O+vWIbuxP60+6a2e0IG8mb6uOK8upxIwNDxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnrBuzK8nGsFabYx53PEMMB0te+6pec8eOp74nmqVq0bPhfoJRvQ9s0jywus8q4GD
	 ead5w6G5Jmu6FlHmkbvWztAS+ZeB5qpDqd4Hogv2HZvsut4EcofECFqgcWKdTXr+pN
	 wbtO4pXWFpOOP32lpu3KGLGfzcMfoQukNeCyIaZ2OiF2qlYLrLwpcOwQIJCVJWPOt1
	 tmg+DukvgBG76/zUExNTDjjCdS/7i+rw3IS/rFQdV/EjP+Lrc+AfZJ+AIu+Dc9wyCG
	 4RjCGCnAcp5PEqxq0BCNpG132uA8c04yLfHGfvET9e7ZeWwJhjVL/mji7a/HVSsWiP
	 jxpJq83NbsbWA==
Date: Tue, 2 Apr 2024 11:23:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZgvOpTcNKPantiHg@ryzen>
References: <20240321171345.GA2385@thinkpad>
 <20240321180732.GA1329092@bhelgaas>
 <20240322052623.GA4092@thinkpad>
 <Zf0i1X5fg-E59NWx@ryzen>
 <20240402051228.GH2933@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402051228.GH2933@thinkpad>

On Tue, Apr 02, 2024 at 10:42:28AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 22, 2024 at 07:19:01AM +0100, Niklas Cassel wrote:
> > On Fri, Mar 22, 2024 at 10:56:23AM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 21, 2024 at 01:07:32PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Mar 21, 2024 at 10:43:45PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > > > > dw_pcie_ep_inbound_atu()
> > > > > > {
> > > > > > 	...
> > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > 	else
> > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > 	...
> > > > > > }
> > > > > > 
> > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > 
> > > > > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > > > > it have not allocate atu to the bar.
> > > > > 
> > > > > I'd rewrite the commit message as below:
> > > > > 
> > > > > "The mapping between PCI BAR and iATU inbound window are maintained in the
> > > > > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
> > > > > BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
> > > > > existing mapping in the array and if it is not found (i.e., value in the array
> > > > > indexed by the BAR is found to be 0), then it will allocate a new map value
> > > > > using find_first_zero_bit().
> > > > > 
> > > > > The issue here is, the existing logic failed to consider the fact that the map
> > > > > value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
> > > > > '0' as the map value for BAR0 (note that it returns the first zero bit
> > > > > position).
> > > > > 
> > > > > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > > > > platforms, the inbound window allocation restarts from BAR0 and the existing
> > > > > logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
> > > > > fact that it considers '0' as an invalid map value.
> > > > > 
> > > > > So fix this issue by always incrementing the map value before assigning to
> > > > > bar_to_atu[] array and then decrementing it while fetching. This will make sure
> > > > > that the map value '0' always represents the invalid mapping."
> > > > 
> > > > This translates C code to English in great detail, but still doesn't
> > > > tell me what's broken from a user's point of view, how urgent the fix
> > > > is, or how it should be handled.
> > > > 
> > > > DMA doesn't work because ATU setup is wrong?  Driver MMIO access to
> > > > the device doesn't work?  OS crashes?  How?  Incorrectly routed access
> > > > causes UR response?  Happens on every boot?  Only after a reboot or
> > > > controller reset?  What platforms are affected?  "PERST# supported
> > > > platforms" is not actionable without a lot of research or pre-existing
> > > > knowledge.  Should this be backported to -stable?
> > > > 
> > > 
> > > Severity is less for the bug fixed by this patch. We have 8 inbound iATU windows
> > > on almost all of the platforms and after PERST# assert + deassert, BAR0 uses map
> > > '6' instead of '0'.
> > > 
> > > This has no user visibility since the mapping will go fine and we have only 6
> > > BARs. So I'd not mark this as as critical fix that needs special attention.
> > 
> > So we will have 6 mappings configured, but only 5 BARs, so two mappings for
> > BAR0. The iATU looks at them in order, so index 0 will override index 6.
> > 
> > We are lucky that the endpoint subsystem does not clean up allocations properly
> > right now (you have an outstanding series which fixes this).
> > 
> > If the endpoint subsystem did clean up resources properly, we would DMA to the
> > area that was previously allocated for BAR0, instead of the new area for BAR0.
> > 
> 
> How would DMA happen to the previously allocated area? When the BARs are cleared
> properly and then allocated again, BAR0 will get the map of 0 again and then the
> iATU will map window 0 with BAR0. Only if we don't clear the BARs properly (as
> like now), then it will result in BAR0 having 2 identical mappings and even with
> that there won't be any issue since both map 0 and 6 are valid.
> 
> Am I missing anything?

Like Bjorn summarize it:
"We dodge the bullet as long as the mappings for BAR 0 are identical,
which doesn't feel like much comfort."

Yes, right now we don't have a cleanup of either the backing memory for
the BAR, or the iATUs mapping the PCI address to backing memory.
(We allocate the backing memory for the BARs in .bind(), and free it in
unbind().)

So the superfluous iATU6 mapping will be the same as the iATU0 mapping.

After your series, we will still allocate and free the backing memory
in .bind()/.unbind(), but we will set/clear the iATU mapping in the
.init()/.deinit() EPF callbacks.


> 
> > Perhaps just include this fix in your series that actually cleans up the BARs?
> > 
> 
> Yeah, makes sense. Once we agree on a finalized commit message in this thread,
> I'll include this patch in my series.

I think that we have spent too much time on this patch already.

My suggestion is that you simply apply it to pci/endpoint branch directly and
fixup the commit message (like Bjorn usually does with [bhelgaas: commit log])
after Frank's Sign-off.


Kind regards,
Niklas


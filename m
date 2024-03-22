Return-Path: <linux-pci+bounces-5017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8D8873C5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4161C22705
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611979933;
	Fri, 22 Mar 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr2PNy6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6479931;
	Fri, 22 Mar 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135292; cv=none; b=MboID71zkYqm8agw98Fv0Iics8e9MFMl+x8ayYV73+Ay03rXngb546+vM3GKzvwWP75IXMUk6fAHJxtjrFh7opVMYchykEs7IM+b5VMnqQzHO1nyaVBUEbCOQy789CKfNtIliC9ryxZ4TAb2U32piBZHdNEakweZO/BdJXnDnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135292; c=relaxed/simple;
	bh=8GHI0o7wqi9kjX1y8O2b7tkzv9Bz9lBCxkn7jE8Ae1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HMBaCN5iy9bxRmLkKdjZByAOQI0xf/0KNg8OL8vmXsEu8/wlL4wytZiPtu0YZsRAe+SndihIFt4wX71T+VaPaONN95QsRbNb1rZJOongkGHbAzjkNDYpzGZvmzTLrfY1eYOxXpzI+Yf5HGMwCKOfLPF05ha8yNdy2P2CZeoP8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr2PNy6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82CC43390;
	Fri, 22 Mar 2024 19:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711135292;
	bh=8GHI0o7wqi9kjX1y8O2b7tkzv9Bz9lBCxkn7jE8Ae1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kr2PNy6cevo37THCTvYRS4j8RR3WxYeJbQPxc/b/04Kk7Hlci/rpk0114furSEml3
	 1DypHJR8edT+SGLCcrFeL6CyzoXdk50Ln7aZIvsuBZ8mFMElt8IqHUnJ+bbdUuTZhk
	 VRkzv8WuOQovxYxM3jMH+G8+CLTATAlIvysGlSWcnwL2ZY/vHJ7DpZsytlh5uQq7MH
	 KnVUqUs8gimL8o35vHp3zcXdF3zG6buoBj/hrJbU92pXbMR9obub58UT3iXPRY6M3L
	 eoAzqohI33/w9ajQLaLz7pbsrWVTsWmwVy993XytK6CEgbbE5gYfQprz3/MMuOd96F
	 +sJfKST5IHiJQ==
Date: Fri, 22 Mar 2024 14:21:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240322192130.GA1367450@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf0i1X5fg-E59NWx@ryzen>

On Fri, Mar 22, 2024 at 07:19:01AM +0100, Niklas Cassel wrote:
> On Fri, Mar 22, 2024 at 10:56:23AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 21, 2024 at 01:07:32PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Mar 21, 2024 at 10:43:45PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > > > dw_pcie_ep_inbound_atu()
> > > > > {
> > > > > 	...
> > > > > 	if (!ep->bar_to_atu[bar])
> > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > 	else
> > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > 	...
> > > > > }
> > > > > 
> > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > 
> > > > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > > > it have not allocate atu to the bar.
> > > > 
> > > > I'd rewrite the commit message as below:
> > > > 
> > > > "The mapping between PCI BAR and iATU inbound window are maintained in the
> > > > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
> > > > BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
> > > > existing mapping in the array and if it is not found (i.e., value in the array
> > > > indexed by the BAR is found to be 0), then it will allocate a new map value
> > > > using find_first_zero_bit().
> > > > 
> > > > The issue here is, the existing logic failed to consider the fact that the map
> > > > value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
> > > > '0' as the map value for BAR0 (note that it returns the first zero bit
> > > > position).
> > > > 
> > > > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > > > platforms, the inbound window allocation restarts from BAR0 and the existing
> > > > logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
> > > > fact that it considers '0' as an invalid map value.
> > > > 
> > > > So fix this issue by always incrementing the map value before assigning to
> > > > bar_to_atu[] array and then decrementing it while fetching. This will make sure
> > > > that the map value '0' always represents the invalid mapping."
> > > 
> > > This translates C code to English in great detail, but still doesn't
> > > tell me what's broken from a user's point of view, how urgent the fix
> > > is, or how it should be handled.
> > > 
> > > DMA doesn't work because ATU setup is wrong?  Driver MMIO access to
> > > the device doesn't work?  OS crashes?  How?  Incorrectly routed access
> > > causes UR response?  Happens on every boot?  Only after a reboot or
> > > controller reset?  What platforms are affected?  "PERST# supported
> > > platforms" is not actionable without a lot of research or pre-existing
> > > knowledge.  Should this be backported to -stable?
> > 
> > Severity is less for the bug fixed by this patch. We have 8 inbound iATU windows
> > on almost all of the platforms and after PERST# assert + deassert, BAR0 uses map
> > '6' instead of '0'.
> > 
> > This has no user visibility since the mapping will go fine and we have only 6
> > BARs. So I'd not mark this as as critical fix that needs special attention.
> 
> So we will have 6 mappings configured, but only 5 BARs, so two mappings for
> BAR0. The iATU looks at them in order, so index 0 will override index 6.

Sounds like we dodge the bullet as long as the mappings for BAR 0 are
identical, which doesn't feel like much comfort.

> We are lucky that the endpoint subsystem does not clean up allocations properly
> right now (you have an outstanding series which fixes this).
> 
> If the endpoint subsystem did clean up resources properly, we would DMA to the
> area that was previously allocated for BAR0, instead of the new area for BAR0.

This is the right level of abstraction for the commit log -- sounds
like there's some reset scenario where the pre-reset iATU windows are
not cleared out and we reallocate iATU windows, and we end up using
one of the stale windows instead of the new one, which could lead to
DMA to the wrong area.  That incorrect DMA sounds like data corruption
in the right circumstances.

Of course it can *also* include some detail about the mechanism of why
that stale entry still exists and when it can be used.

Bjorn


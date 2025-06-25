Return-Path: <linux-pci+bounces-30654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E433FAE8EC2
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FAE164D8A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334C1FC8;
	Wed, 25 Jun 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTYUr2lj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAE10942
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879953; cv=none; b=VeoZIeXHhiv3Ju0NktIy/2Q+bbLMpJQJRxuDZ/+9YipTYmDFvOVg3Lt5UuhZlZdHDX1XZh7pOurkz6Y6deCpxdQ5BbM7GuhGfV0HQUKmj1WqDS/Ty5mfdC66Y/wdnbXgjF11VIu96jBSRqqmKyF9Rdbl2MsB2V6xHPwvxOYQOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879953; c=relaxed/simple;
	bh=kM558u0eEghpS9m73JPT8BiITNc9J51hLd2MNzA4tVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IMc481uSM0FevsekWOxa8tpvWWpE0UdlNUNSxsNK2m5OrLekFjLybsYFYcVXOGRQ6f/84wLS1XL4pm786A8yJh0651VnX9HSDuOMUtQhTpZ+f3pfRHyzRYZeoXjIoNKOIOGtR6szpafnaXYL1UkFr3OIAffTvrIaT9SpDBt8eQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTYUr2lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E68C4CEF0;
	Wed, 25 Jun 2025 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750879952;
	bh=kM558u0eEghpS9m73JPT8BiITNc9J51hLd2MNzA4tVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RTYUr2ljjpJ06OVcpKXnsb563uvqxr+n8tz4U/xmLO5ge95wlIDYH4H51503zcsB1
	 /4Y0WHR/R2vAJk2EYWiXyiuUIMBJdUNCUQghiqkCFnAhuBlV/e/RfyH7iKEg4iRG50
	 i158yjmaqjhI5yFkvsYAUa5Mtv4PRr/CANd1vzagb9iK/JOx+r5fTJosaelvoGh+xr
	 fHH5EHitlGw3vFMqhusiXJeTKwNxS/a1GlZiiaC0v5cOkhZOgqayB+hQgJicnT1a3+
	 3QgbhzfQRDFlFsLcTlgRYMYsLE1VqVLcugkX0S1onRB5WbARN+jI23H45B6E10G/XC
	 hJ1GyFyNe+NHg==
Date: Wed, 25 Jun 2025 14:32:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <20250625193231.GA1582741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFunQlDHNyQV4S_W@wunner.de>

On Wed, Jun 25, 2025 at 09:37:38AM +0200, Lukas Wunner wrote:
> On Tue, Jun 24, 2025 at 09:24:07AM -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> > > pcie_portdrv_probe() and pcie_portdrv_remove() both call
> > > pci_bridge_d3_possible() to determine whether to use runtime power
> > > management.  The underlying assumption is that pci_bridge_d3_possible()
> > > always returns the same value because otherwise a runtime PM reference
> > > imbalance occurs.
> > > 
> > > That assumption falls apart if the device is inaccessible on ->remove()
> > > due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> > > which accesses Config Space to determine whether the device is Hot-Plug
> > > Capable.   An inaccessible device returns "all ones", which is converted
> > > to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> > > longer seems Hot-Plug Capable on ->remove() even though it was on
> > > ->probe().
> > 
> > This is pretty subtle; thanks for chasing it down.
> > 
> > It doesn't look like anything in pci_bridge_d3_possible() should 
> > change over the life of the device, although acpi_pci_bridge_d3() is
> > non-trivial.
> > 
> > Should we consider calling pci_bridge_d3_possible() only once and
> > caching the result?  We already call it in pci_pm_init() and save the
> > result in dev->bridge_d3.  That member can be changed by
> > pci_bridge_d3_update(), but we could add another copy that we never
> > update after pci_pm_init().
> 
> If we did that, I think we'd still want to have a WARN_ON() like this in
> pcie_portdrv_remove():
> 
> +	WARN_ON(dev->bridge_d3_orig != pci_bridge_d3_possible(dev));
> +
> +	if (dev->bridge_d3_orig) {
> -	if (pci_bridge_d3_possible(dev)) {
> 
> Because without the WARN_ON(), such bugs would fly under the radar.
> 
> However currently we get the WARN_ON() for free because of the runtime PM
> refcount underflow.
> 
> So caching the original return value of pci_bridge_d3_possible(dev)
> wouldn't be a net positive.

Fair point.  pci_bridge_d3_possible() is mainly used by portdrv, and 
keeping another copy in the pci_dev does seem like overkill.

If the point is to ensure that the runtime PM setup done by
pcie_portdrv_probe() is undone by pcie_portdrv_remove() and
pcie_portdrv_shutdown(), maybe portdrv should remember what it did,
e.g., call pci_bridge_d3_possible() once in .probe() and save the
result for use in .remove() and .shutdown().

That's what I expect drivers to do in general for cleaning up things
in .remove(): it's the driver's problem to remember what needs to be
cleaned up.

But I feel like I'm missing your point about bugs flying under the
radar.  Having portdrv keep track of whether it did runtime PM setup
(i.e., the pci_bridge_d3_possible() state at .probe()-time) is
functionally the same as having struct pci_dev keep track of it, so
the bugs you're referring to could still fly under the radar.

Bjorn


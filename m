Return-Path: <linux-pci+bounces-3450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13059854AAD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233001C262B0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704054BCC;
	Wed, 14 Feb 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCBclJNn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDE54BC7
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918222; cv=none; b=mHXIwQNYuIySuo8Ee+D+nDW3+7Dqvo7Us7ZQiMIOgIQZ5BdicvbZPrJPdIS2P95UVXS2d66YRWqJPtYq8l9cQpw4uTwNy92SXtlEVdXKzZZG13toT9ooyXXhIi7HHfNw+5slrs1K9kleHpnnRu6JCrN5Wd0nK7mvlNwU2vCQuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918222; c=relaxed/simple;
	bh=q/4QZ2V1eqI6T4xLT5bZiBw6I/jIz+YkmXkwl6nhlWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcOGVHLe7dmoyOMoDsMjJuFobJxJ24Y1v//tcCbgnCCwYDQYIx/MhvEMe7sz7tQhYpIiiGfxj1bvEzzsSJ50JixPj7kxwKIX3o6Ih+IqQzUEpozGmsEOeEEu79JY7Y14Vbcr5MvHGkukJknvvUMZD78vBX0p3GH8VLnrNkSEnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCBclJNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2685C433F1;
	Wed, 14 Feb 2024 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707918221;
	bh=q/4QZ2V1eqI6T4xLT5bZiBw6I/jIz+YkmXkwl6nhlWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCBclJNnMAiHPFAAb9EdsYAVGug1YTEF/3wPMGtxvBLyBGGbtr+mqN3yHVjs+PH2U
	 QHJFZH60c8K6tBgAsVjhFYVKqiTvGTR4/ZI+h6Z63sQbKQIFXj9l5RxN/Tq04g1bsP
	 CmSOphoJln3mjmm17eYFO6vAEyaTZ98lsUGf7/N97j+kHSpLHUbklEgIW1RGCypdPK
	 z7ELTGHTzFBKpQ/wUqFge7lZy0Jzyrrx7JM9uKUOFEmqIPHTBpKvafd93OSHvYmwPz
	 bKJqAYixaaRFzRG+dIUq6hbmc7cT8Pe7lTRSyFC2gHn/rt9ZDh9PbSZZpNXdW4q9Gb
	 BheMcmRc1BsYQ==
Date: Wed, 14 Feb 2024 14:43:38 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <ZczDiu84/n8qJgSp@lpieralisi>
References: <20231202000704.GA529403@bhelgaas>
 <2728ad9d38442510c5e0c8174d0f7aae6ff247ac.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2728ad9d38442510c5e0c8174d0f7aae6ff247ac.camel@linux.intel.com>

On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:

[...]

> > In the host OS, this overrides whatever was negotiated via _OSC, I
> > guess on the principle that _OSC doesn't apply because the host BIOS
> > doesn't know about the Root Ports below the VMD.  (I'm not sure it's
> > 100% resolved that _OSC doesn't apply to them, so we should mention
> > that assumption here.)
> _OSC still controls every flag including Hotplug. I have observed that
> slot capabilities register has hotplug enabled only when platform has
> enabled the hotplug. So technically not overriding it in the host.
> It overrides in guest because _OSC is passing wrong/different
> information than the _OSC information in Host.
> Also like I mentioned, slot capabilities registers are not changed in
> Guest because vmd is passthrough.
> > 
> > In the guest OS, this still overrides whatever was negotiated via
> > _OSC, but presumably the guest BIOS *does* know about the Root Ports,
> > so I don't think the same principle about overriding _OSC applies
> > there.
> > 
> > I think it's still a problem that we handle
> > host_bridge->native_pcie_hotplug differently than all the other
> > features negotiated via _OSC.  We should at least explain this
> > somehow.
> Right now this is the only way to know in Guest OS if platform has
> enabled Hotplug or not. We have many customers complaining about
> Hotplug being broken in Guest. So just trying to honor _OSC but also
> fixing its limitation in Guest.

The question is: should _OSC settings apply to the VMD hierarchy ?

Yes or no (not maybe) ?

If yes, the guest firmware is buggy (and I appreciate it is hard to
fix). If no this patch should also change vmd_copy_host_bridge_flags()
and remove the native_pcie_hotplug initialization from the root bridge.

As a matter of fact this patch overrides the _OSC settings in host and
guest and it is not acceptable because it is not based on any documented
policy (if there is a policy please describe it).

> > I suspect part of the reason for doing it differently is to avoid the
> > interrupt storm that we avoid via 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > _OSC on PCIe features").  If so, I think 04b12ef163d1 should be
> > mentioned here because it's an important piece of the picture.
> I can add a note about this patch as well. Let me know if you want me
> to add something specific.

At the very least you need to explain the problem you are solving in the
commit log - sentences like:

"This patch will make sure that Hotplug is enabled properly in Host
as well as in VM while honoring _OSC settings as well as VMD hotplug
setting."

aren't useful to someone who will look into this in the future.

If _OSC does not grant the host kernel HP handling and *any* (that's
another choice that should be explained) slot
capability reports that the VMD root port is HP capable we do
override _OSC, we are not honouring it, AFAICS.

Then we can say that in your user experience the stars always align and
what I mention above is not a problem because it can't happen but it is hard
to grok by just reading the code and more importantly, it is not based
on any standard documentation.
 
> Thank you for taking the time. This is a very critical issue for us and
> we have many customers complaining about it, I would appreciate to get
> it resolved as soon as possible.

Sure but we need to solve it in a way that does not break tomorrow
otherwise we will keep applying plasters on top of plasters.

Ignoring _OSC hotplug settings for VMD bridges in *both* host and guests
may be an acceptable - though a tad controversial - policy (if based on
software/hardware guidelines).

A mixture thereof in my opinion is not acceptable.

Thanks,
Lorenzo


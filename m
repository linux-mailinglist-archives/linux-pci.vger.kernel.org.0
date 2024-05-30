Return-Path: <linux-pci+bounces-8100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A28D544E
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A37283B31
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5D145B3C;
	Thu, 30 May 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK08QQ/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3720011F;
	Thu, 30 May 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103304; cv=none; b=hXn6Ch19oIPO+D0+N8d0/IemIge4ptckoB83ZgCY54s1JpiNKf5omRjKCw2lyJLjNSobDN1EP6xOiemhQ+CNuNCSNBZdGFYBypfHP8UpK/u7RtXPcLwYkx9+3LdrxcCc5JS0ZAAOQ924Wg4UDDbZ/TE6xRF6TMQfZrtiqVT3PW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103304; c=relaxed/simple;
	bh=OUD1Rw0teDEGWIHNTfkxkNnUZFsookNxNTGDFwmriZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o/j4g3AHqr8R0DMp5+wqv4xaPzybGCjj8jL6iBiCZwrOAL9UyhCv5P+UdL9hLc+RFX4ratYTF/ycH8dMrqJJzY/Tcn95yzlmOzIrFdmrIgTwOaqLCGykjaxahZHDL7lr9BGon5mldEUcqB76Lw44CnFg3+WxLFoWbGQVwXIyHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK08QQ/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB61C2BBFC;
	Thu, 30 May 2024 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103304;
	bh=OUD1Rw0teDEGWIHNTfkxkNnUZFsookNxNTGDFwmriZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CK08QQ/iOQC4eN+83+4Rdrn99x2496f/cPVrCzhawM4Um4+8aNi/2Xrk/7eHLG8hs
	 3fNCkf/8VcgU/hIiivt7FFztI6t3/7Z2RrEc/u3GO2RQfHN09n4erNSMAGr54dhBMf
	 7lz/k8SmmkXqooEb53Bixva0xTJZRRBAMl5biwU7qwOrqVrlP9VUiFyPloaMS0Rudz
	 srVOptVAK4nmzaBfK+YYrARCljIgOyzhfihXxBVipMve7ilmh08f/t8oIVDBLBmAxZ
	 QmXOVZwGO8sYBqfXeJEr2I1h9mTQs7wPOdTO4RFUlc1Q74ml6rpXlGY0LVADHGdgX2
	 JBJAB2EyonNKg==
Date: Thu, 30 May 2024 16:08:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
	Imre Deak <imre.deak@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
Message-ID: <20240530210822.GA562010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8387ec-47f5-4c03-bb39-7a2a398a85f9@intel.com>

On Thu, May 30, 2024 at 02:03:09PM -0700, Dave Jiang wrote:
> On 5/30/24 1:52 PM, Bjorn Helgaas wrote:
> > On Thu, May 30, 2024 at 12:53:46PM -0700, Dan Williams wrote:
> >> Dan Williams wrote:
> >>> While the experiment did reveal that there are additional places that
> >>> are missing the lock during secondary bus reset, one of the places that
> >>> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> >>> lockdep annotation.
> >>>
> >>> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> >>> currently dependent on the fact that the device_lock() is marked
> >>> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> >>> annotation, pci_bus_lock() would need to use something like a new
> >>> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> >>> the topology, and a hope that the depth of a PCI tree never exceeds the
> >>> max value for a lockdep subclass.
> >>>
> >>> The alternative to ripping out the lockdep coverage would be to deploy a
> >>> dynamic lock key for every PCI device. Unfortunately, there is evidence
> >>> that increasing the number of keys that lockdep needs to track to be
> >>> per-PCI-device is prohibitively expensive for something like the
> >>> cfg_access_lock.
> >>>
> >>> The main motivation for adding the annotation in the first place was to
> >>> catch unlocked secondary bus resets, not necessarily catch lock ordering
> >>> problems between cfg_access_lock and other locks.
> >>>
> >>> Replace the lockdep tracking with a pci_warn_once() for that primary
> >>> concern.
> >>>
> >>> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> >>> Reported-by: Imre Deak <imre.deak@intel.com>
> >>> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> >>> Cc: Jani Saarinen <jani.saarinen@intel.com>
> >>> Cc: Dave Jiang <dave.jiang@intel.com>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >> Bjorn, this against mainline, not your tree where I see you already have
> >> "PCI: Make cfg_access_lock lockdep key a singleton" queued up. The
> >> "overkill" justification for making it singleton is valid, but then
> >> means that it has all the same problems as the device lock that needs to
> >> be marked lockdep_set_novalidate_class().
> >>
> >> Let me know if you want this rebased on your for-linus branch.
> >>
> >> Note that the pci_warn_once() will trigger on all pci_bus_reset() users
> >> unless / until pci_bus_lock() additionally locks the bridge itself ala:
> >>
> >> http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
> >>
> >> Apologies for the thrash, this has been a useful exercise for finding
> >> some of these gaps, but ultimately not possible to carry forward
> >> without more invasive changes.
> > 
> > No problem, this is a complicated locking scenario.  These fixes are
> > the only thing on my for-linus branch (which I regard as a draft
> > rather than being immutable) and I haven't asked Linus to pull them
> > yet, so I'll just drop both:
> > 
> >   ac445566fcf9 ("PCI: Make cfg_access_lock lockdep key a singleton")
> >   f941b9182c54 ("PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()")
> > 
> > I think the clearest way to do this would be to do a simple revert of
> > 7e89efc6e9e4, followed by a second patch to add the pci_warn_once().
> 
> Complete revert of 7e89efc6e9e4 will also remove the bridge locking
> which I think we want to keep right?

I dunno, you tell me.  If we want to revert just part of 7e89efc6e9e4,
it would be clearer to do that by itself, then add the new stuff
separately.

> > The revert would definitely be v6.10 material.  The pci_warn_once()
> > might be v6.11 material.  Or if you think it will find significant
> > bugs, maybe that's v6.10 material as well, but it'll be easier to make
> > that argument if it's in a separate patch.
> > 
> > Bjorn


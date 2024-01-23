Return-Path: <linux-pci+bounces-2478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC978838C66
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCBF1C22FE6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA05C8FD;
	Tue, 23 Jan 2024 10:45:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C985D8F3;
	Tue, 23 Jan 2024 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006730; cv=none; b=uJNW0UI2IeGmdltYTjXjPqcE+KCILRd7Oq2Mm32UtvdpV2Y0cv3G9AZycMcRUQngrbir58XRi098plOwonK5Y47XVUGod/dcmKCb4zGmc9roAA9as1pddS2BjZenxHPJiPn9tYCMT15QvA/DKvpuFhyLYG/dAlHzytDpg2hb1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006730; c=relaxed/simple;
	bh=QakUB1msMWnHAe3TzOTeuX7uJ1mjP5spjvgGTHzwFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+8OZIfoAqLHOL7p0agdtP65MCT4QQlYK6hslEKKqEFYnNgY4Gj6vhvyrWjZYgUO3WfEB2DWh9eHv0zdefoeAX8tZZPUgegDr1S0fqAdvsxAmetxBekVfIHQ0R7IZ4hFnl1lv3UibtrRRxmBThKMVNQEz6uiV0XapMxSROJw5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 562B62800BBC5;
	Tue, 23 Jan 2024 11:45:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 49DE6382E4; Tue, 23 Jan 2024 11:45:19 +0100 (CET)
Date: Tue, 23 Jan 2024 11:45:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, eric.auger@redhat.com,
	mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
	Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240123104519.GA21747@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
 <20230803171233.3810944-3-alex.williamson@redhat.com>
 <20240118115049.3b5efef0.alex.williamson@redhat.com>
 <20240122221730.GA16831@wunner.de>
 <20240122155003.587225aa.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122155003.587225aa.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 22, 2024 at 03:50:03PM -0700, Alex Williamson wrote:
> On Mon, 22 Jan 2024 23:17:30 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:
> > > To do that I used pm_runtime_get_if_active(), but in retrospect this
> > > requires the device to be in RPM_ACTIVE so we end up skipping anything
> > > suspended or transitioning.  
> > 
> > How about dropping the calls to pm_runtime_get_if_active() and
> > pm_runtime_put() and instead simply do:
> > 
> > 			if (pm_runtime_suspended(&pdev->dev) &&
> > 			    pdev->current_state != PCI_D3cold)
> > 				pci_pme_wakeup(pdev, NULL);
> 
> Do we require that the polled device is in the RPM_SUSPENDED state?

If the device is RPM_SUSPENDING, why immediately resume it for polling?
It's sufficient to poll it the next time around, i.e. 1 second later.

Likewise, if it's already RPM_RESUMING or RPM_ACTIVE anyway, no need
to poll PME.

This leaves RPM_SUSPENDED as the only state in which it makes sense to
poll.


> Also pm_runtime_suspended() can also only be trusted while holding the
> device power.lock, we need a usage count reference to maintain that
> state.

Why?  Let's say there's a race and the device resumes immediately after
we call pm_runtime_suspended() here.  So we might call pci_pme_wakeup()
gratuitouly.  So what?  No biggie.


> +			if (bdev) {
> +				spin_lock_irq(&bdev->power.lock);

Hm, I'd expect that lock to be internal to the PM core,
although there *are* a few stray users outside of it.

Thanks,

Lukas


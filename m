Return-Path: <linux-pci+bounces-2454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF6838667
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 05:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076CB1C2413D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 04:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE657E6;
	Tue, 23 Jan 2024 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPN9wR4a"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF061FA5
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985192; cv=none; b=ukqiVNZmdMWLuuEQkqkAwfYV40luWCdyBlRPgsaHc/LgcDr1nnWpC+qa0KupRWc9STmVDCn92dt6UzBGBaKsR4fpe5Jbrel9ysZXN8GBSEBTlJOodrkhTdlZMhsiiFj5DWZvQKxLuuN6x0/wroKBrHc7VHb8FCLG30dn8nSs1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985192; c=relaxed/simple;
	bh=Wacy5I+T9CRLTx94+CNh/e5bKsnII/fzDAmv3feOpqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/UkdPjm4aP6iZoVKTxEOZ/czrJiY6ON++1UVZla+GhRp4dZZ4ThyvwX7UoAhjO/Q21pXtytC6Lt2T9kPhLJh78TbU0Ts6sVucT0UociB8RlLo1ewBm/sWVPNwAAzX5lQDPP2ND2j/kSj1QAZSsamQUYXvYRz0uSgHOOfVq8e3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPN9wR4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705985188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTlRvMwOnO0UPcMkoFaMJHGHs64UaIwuE6uSrowYGn4=;
	b=YPN9wR4aBfjQ1oSfMA0SlsThnISmKleCCU2SVMHJRwQxYw+tX3mSjjxGe38oxqLZXdTP6B
	eBblAQVO4vS0IyRVjNcgr6gwUHK3vLdoEiD0Km3X+AaA7pwfuLySLb9wA9XlEWQTIZooYU
	sMBEQXzjWAS1v8HTQuR6Z+7KVRt6gNM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-voBuFjW6OA-4nxZtLNIvKw-1; Mon, 22 Jan 2024 23:46:25 -0500
X-MC-Unique: voBuFjW6OA-4nxZtLNIvKw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc6976630so33943275ab.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 20:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705985184; x=1706589984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTlRvMwOnO0UPcMkoFaMJHGHs64UaIwuE6uSrowYGn4=;
        b=nmoqRUE9BMR0a6P/rL7p7QT2gb+zy6cHFN/E++KeLcX2gzhLVuNPaMVuCPF0lY0Yht
         c3CYfv7piFL4Ztqfm9sTLM0BuzauH/dGO2u0JGo9T4lCpQpXV9KmOZWb5wN4PhsQAtFQ
         T32m0UPyX1Ll66k6KXBwm4CcKB2Z+NgbK0Ex0ehiCY2X+G2PBxT0lj81RJhANXEdx7l9
         JIZxQf+byFrYxJ3QwQsJ4VviTjPGW/dCso/koxofnv5cJdfxz3ewucE6e4z0o7hs4EEP
         UMOEES2C8e1Cg3PAE4iWFysd4Y4cFSQgX4YOI3rnsr1jm8ciJY11+v0Zw5YxcAX/SbjP
         homA==
X-Gm-Message-State: AOJu0Ywt2YSu6YTctGU9PKEd2Hx9vG/qkMRim1zd/THc5LiU/NOAK6Zh
	dcaj8FK2W3aos4rCdIMGp1lIpYhsW2fdHIGPzzEMLyGiN/gAiYS0tJPZnvj2Z6KKeguiVbMRYtX
	KwMSybxmn/uXQcWaTnp4RYo1XxitArmQU0yQ1U0dmFWqkH9w6mCDdFskCbQ==
X-Received: by 2002:a92:cd4e:0:b0:362:8ac6:e4bb with SMTP id v14-20020a92cd4e000000b003628ac6e4bbmr514238ilq.61.1705985184677;
        Mon, 22 Jan 2024 20:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWPFLKTYUzbs4Yo01PYvGmtBusU5ZY458xLzLkV8W/VZPhJhIYqYZJO7hYHDLZXzzC2xUmRQ==
X-Received: by 2002:a92:cd4e:0:b0:362:8ac6:e4bb with SMTP id v14-20020a92cd4e000000b003628ac6e4bbmr514225ilq.61.1705985184363;
        Mon, 22 Jan 2024 20:46:24 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id l4-20020a056e020dc400b00361b63c710csm2112298ilj.52.2024.01.22.20.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 20:46:23 -0800 (PST)
Date: Mon, 22 Jan 2024 21:46:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
 Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240122214622.32e8c5fa.alex.williamson@redhat.com>
In-Reply-To: <20240122155003.587225aa.alex.williamson@redhat.com>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
	<20240118115049.3b5efef0.alex.williamson@redhat.com>
	<20240122221730.GA16831@wunner.de>
	<20240122155003.587225aa.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:50:03 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 22 Jan 2024 23:17:30 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:  
> > > On Thu,  3 Aug 2023 11:12:33 -0600 Alex Williamson <alex.williamson@redhat.com wrote:    
> > > > Testing that a device is not currently in a low power state provides no
> > > > guarantees that the device is not immenently transitioning to such a state.
> > > > We need to increment the PM usage counter before accessing the device.
> > > > Since we don't wish to wake the device for PME polling, do so only if the
> > > > device is already active by using pm_runtime_get_if_active().
> > > > 
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > ---
> > > >  drivers/pci/pci.c | 23 ++++++++++++++++-------
> > > >  1 file changed, 16 insertions(+), 7 deletions(-)    
> > > 
> > > Resurrecting this patch (currently commit d3fcd7360338) for discussion
> > > as it's been identified as the source of a regression in:
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=218360
> > > 
> > > Copying Mika, Lukas, and Rafael as it's related to:
> > > 
> > > 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > > 
> > > where we skip devices in D3cold when processing the PME list.
> > > 
> > > I think the issue in the above bz is that the downstream TB3/USB4 port
> > > is in D3 (presumably D3hot) and I therefore infer the device is in state
> > > RPM_SUSPENDED.  This commit is attempting to make sure the device power
> > > state is stable across the call such that it does not transition into
> > > D3cold while we're accessing it.
> > > 
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
> Hi Lukas,
> 
> Do we require that the polled device is in the RPM_SUSPENDED state?
> Also pm_runtime_suspended() can also only be trusted while holding the
> device power.lock, we need a usage count reference to maintain that
> state.
> 
> I'm also seeing cases where the bridge is power state D0, but PM state
> RPM_SUSPENDING, so config space of the polled device becomes
> inaccessible even while we're holding a reference once we allow polling
> in RPM_SUSPENDED.
> 
> I'm currently working with the below patch, which I believe addresses
> all these issues, but I'd welcome review and testing. Thanks,
> 
> Alex
> 
> commit 0a063b8e91d0bc807db712c81c8b270864f99ecb
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Tue Jan 16 13:28:33 2024 -0700
> 
>     PCI: Fix active state requirement in PME polling
>     
>     The commit noted in fixes added a bogus requirement that runtime PM
>     managed devices need to be in the RPM_ACTIVE state for PME polling.
>     In fact, there is no requirement of a specific runtime PM state, it
>     is only required that the state is stable such that testing config
>     space availability, ie. !D3cold, remains valid across the PME wakeup.
>     
>     To that effect, defer polling of runtime PM managed devices that are
>     not in either the RPM_ACTIVE or RPM_SUSPENDED states.  Devices in
>     transitional states remain on the pci_pme_list and will be re-queued.
>     
>     However in allowing polling of devices in the RPM_SUSPENDED state,
>     the bridge state requires further refinement as it's possible to poll
>     while the bridge is in D0, but the runtime PM state is RPM_SUSPENDING.
>     An asynchronous completion of the bridge transition to a low power
>     state can make config space of the subordinate device become
>     unavailable.  A runtime PM reference to the bridge is therefore added
>     with a supplementary requirement that the bridge is in the RPM_ACTIVE
>     state.
>     
>     Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
>     Reported-by: Sanath S <sanath.s@amd.com>
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bdbf8a94b4d0..31dbf1834b07 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2433,29 +2433,45 @@ static void pci_pme_list_scan(struct work_struct *work)
>  		if (pdev->pme_poll) {
>  			struct pci_dev *bridge = pdev->bus->self;
>  			struct device *dev = &pdev->dev;
> -			int pm_status;
> +			struct device *bdev = bridge ? &bridge->dev : NULL;
>  
>  			/*
> -			 * If bridge is in low power state, the
> -			 * configuration space of subordinate devices
> -			 * may be not accessible
> +			 * If we have a bridge, it should be in an active/D0
> +			 * state or the configuration space of subordinate
> +			 * devices may not be accessible.
>  			 */
> -			if (bridge && bridge->current_state != PCI_D0)
> -				continue;
> +			if (bdev) {
> +				spin_lock_irq(&bdev->power.lock);

With the code as shown here I have one system that seems to be getting
contention when reading the vpd sysfs attribute when the endpoints
(QL41000) are bound to vfio-pci and unused, resulting in the root port
and endpoints being suspended.  A vpd read can take over a minute.
Seems to be resolved changing the above spin_lock to a spin_trylock:

				if (!spin_trylock_irq(&bdev->power.lock))
					continue;

The pm_runtime_barrier() as used in the vpd path can be prone to such
issues, I saw similar in the fix I previously proposed in the bz.

I'll continue to do more testing with this change and hopefully Sanath
can verify this resolves the bug report.  Thanks,

Alex

> +				if (!pm_runtime_active(bdev) ||
> +				    bridge->current_state != PCI_D0) {
> +					spin_unlock_irq(&bdev->power.lock);
> +					continue;
> +				}
> +				pm_runtime_get_noresume(bdev);
> +				spin_unlock_irq(&bdev->power.lock);
> +			}
>  
>  			/*
> -			 * If the device is in a low power state it
> -			 * should not be polled either.
> +			 * The device itself may be either in active or
> +			 * suspended state, but must not be in D3cold so
> +			 * that configuration space is accessible.  The
> +			 * transitional resuming and suspending states are
> +			 * skipped to avoid D3cold races.
>  			 */
> -			pm_status = pm_runtime_get_if_active(dev, true);
> -			if (!pm_status)
> -				continue;
> -
> -			if (pdev->current_state != PCI_D3cold)
> +			spin_lock_irq(&dev->power.lock);
> +			if ((pm_runtime_active(dev) ||
> +			     pm_runtime_suspended(dev)) &&
> +			    pdev->current_state != PCI_D3cold) {
> +				pm_runtime_get_noresume(dev);
> +				spin_unlock_irq(&dev->power.lock);
>  				pci_pme_wakeup(pdev, NULL);
> -
> -			if (pm_status > 0)
>  				pm_runtime_put(dev);
> +			} else {
> +				spin_unlock_irq(&dev->power.lock);
> +			}
> +
> +			if (bdev)
> +				pm_runtime_put(bdev);
>  		} else {
>  			list_del(&pme_dev->list);
>  			kfree(pme_dev);



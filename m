Return-Path: <linux-pci+bounces-3296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819884FB4E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B885028CC9F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE57F493;
	Fri,  9 Feb 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bky1nssf"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1D69E16
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501413; cv=none; b=AuXUzZARz0Rvl4SdnbZPVbnBY3BwFgHShUn/J3CKSYceMhMXkcYFrHOq4X1li6CkPgEzslIM12Nr3heCQVsO3jWrhrfzr1r6WYbbXcNtmAALT/EUgG6LOOX2XJStNiQbUeiR9pGmZ41WGtMARNtobMO30rA6kcZT/W4IyzBsLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501413; c=relaxed/simple;
	bh=dE0fOch8GFREEflrjtAJ8hYUXgvgOrldg31BXyPBLjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrfpFuHe7GbsIrIHuhsVO6E6E+jb04P2SnDI1GYnE4xq4D7FhO86n1oXhqak0TbZND7V95XRljgwYUjEXSPzZ6BnoFKIAe9k7lp6BocUzkiUTzIZ/xitgg7yDswau3eej9DKM0A3Pt5iypJC1PsdzZ7hktKZF81FydMjs9x0gH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bky1nssf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707501410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lroj6ntugWqRCbAoq4c/1l3q2HF6eEjLQk8CU/pQV34=;
	b=Bky1nssf59Cz1D/JAeQbMozTf1dD2SYMOmpc4pDY092uLOifQ0WQ57dSLnFMbM9mvWesLc
	E+oTcwVM9LIIie7dzNKPoiS5ZypuYD1/5QF9cZ0lRsaEE9VVGr1QNbJJrQEnCy/eM+FrUD
	ObBkSSo7RaFgKvZeQocigPpQ9zFj1vA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-ngl1fC94OriO-kmBXTy2aA-1; Fri, 09 Feb 2024 12:56:48 -0500
X-MC-Unique: ngl1fC94OriO-kmBXTy2aA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so139361139f.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 09:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501408; x=1708106208;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lroj6ntugWqRCbAoq4c/1l3q2HF6eEjLQk8CU/pQV34=;
        b=dtuRZC53oOxPBQXUBZWF2N+XZWKkFa+MYhFch15HzjI6Vq8N675aDtXYPz6K8HTXxv
         wNu5E2QrS97XYVbltjEfsrDHfWa9ujDjqOmix3oEVTfiXhqXvdAhs8YG7IZN4Uwxz3hy
         ccwwIivh4UK4Wr3XfsmYvgQlPek8u0O7xaWq+tK3FD2CBOt5DvBcIojW66J+EQ9pPA+Q
         Fb4yZT04lDMnBYraXsdttYlePYhj0D9wrS5uA+SdzsjIgso6kO1RjGy0eLAvHBgXaV3f
         hD6bH0ehrRrceb3qkuGlzfLetmI4xOm2JCR+HaynDknyJy/UzdojtpiuJjdakGFcOMfL
         F2yg==
X-Forwarded-Encrypted: i=1; AJvYcCW7HHU5FbRsnMFgYrD2niT5/vM2gULBsUKaUoM1pTYjpQXbDSLYFlr+Zn20g7/1xvjd0MmtjDvVnSR+cY6xQunjrPaesAlA+FGw
X-Gm-Message-State: AOJu0Yx6o6njskHZZMdV6pYEJ/sMzhlQgAR6dYvfy/pgfUwDV6x9hGit
	oqL/K7hYihnHiy/ysu/iCpK3dKJWVV97vlUR62KdP3XjvL/VC/FPkM57l2JQ1MaKUMA01sBdwtV
	ABuBPiPrCBX22DnmQD4Eb0hu/S+6/BaJtIFGN2weMPET6Nho30DXAPa3G1w==
X-Received: by 2002:a6b:e302:0:b0:7c3:e885:2550 with SMTP id u2-20020a6be302000000b007c3e8852550mr101490ioc.12.1707501407780;
        Fri, 09 Feb 2024 09:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqIxLFt2RpI4QH9xSgWGzJRpn6EIMlFn+k+gCAz4/W2cxdgpWFsNZnXfkFG+XUU2/+bwfdOA==
X-Received: by 2002:a6b:e302:0:b0:7c3:e885:2550 with SMTP id u2-20020a6be302000000b007c3e8852550mr101473ioc.12.1707501407444;
        Fri, 09 Feb 2024 09:56:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtp6b3T6OIgIJQ1c4hAK7yhFYkWhES/MQfVhMWc0cpcOhQLuOJ0oWekR790Q4hUzFLAk9fZwUaRyjkBJyH/m6d0jCw3lbou3j9wBDsATvg/beYHoRPsvX1oZWEUT4/rdm+YCMUXknDXh4NLeGeoMnb53IXqrWYRG4oQDV6cxQ5iTqqN3xW2s+12DMY4EAkK8ltXGENq4Sd5eNbLRMZ38Vs
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id g88-20020a028561000000b00471578e87d9sm535482jai.21.2024.02.09.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:56:46 -0800 (PST)
Date: Fri, 9 Feb 2024 10:56:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
 mika.westerberg@linux.intel.com, rafael@kernel.org, sanath.s@amd.com
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
Message-ID: <20240209105644.745682a5.alex.williamson@redhat.com>
In-Reply-To: <20240209163521.GA1003145@bhelgaas>
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
	<20240209163521.GA1003145@bhelgaas>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 10:35:21 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jan 23, 2024 at 11:55:31AM -0700, Alex Williamson wrote:
> > The commit noted in fixes added a bogus requirement that runtime PM
> > managed devices need to be in the RPM_ACTIVE state for PME polling.
> > In fact, only devices in low power states should be polled.
> > 
> > However there's still a requirement that the device config space must
> > be accessible, which has implications for both the current state of
> > the polled device and the parent bridge, when present.  It's not
> > sufficient to assume the bridge remains in D0 and cases have been
> > observed where the bridge passes the D0 test, but the PM state
> > indicates RPM_SUSPENDING and config space of the polled device becomes
> > inaccessible during pci_pme_wakeup().
> > 
> > Therefore, since the bridge is already effectively required to be in
> > the RPM_ACTIVE state, formalize this in the code and elevate the PM
> > usage count to maintain the state while polling the subordinate
> > device.  
> 
> This apparently fixes a problem: the bugzilla says something about
> disks attached to Thunderbolt/USB4 docks not working, but I doubt it's
> actually specific to Thunderbolt/USB4 or to disks.

Right, AIUI it's simply a PCIe hierarchy where a bridge was previously
scanned in response to a PME and no longer is because of the invalid
requirement added in d3fcd7360338 that the runtime power management
status of the device is active.

> The bugzilla also indicates that d3fcd7360338 was a regression.
> d3fcd7360338 appeared in v6.6, so this fix is likely a candidate for
> the current release (v6.8).

Agreed.

> I'd like to mention both the user-visible problem being fixed and 
> the fact that it fixes a regression here in the commit log so we can
> make the case for putting this in v6.8.

Ok, I've not experienced the regression myself, but I can add a
paragraph describing my understanding of the bugzilla.  I'd probably
just say:

	This resolves a regression reported in the bugzilla below where
	a Thunderbolt/USB4 hierarchy fails to scan for an attached NVMe
	endpoint downstream of a bridge in a D3hot power state.

If you'd like a respin including that or if you have further
phrasing/info suggestions, please let me know.  Thanks,

Alex

> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> > Reported-by: Sanath S <sanath.s@amd.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index bdbf8a94b4d0..764d7c977ef4 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struct *work)
> >  		if (pdev->pme_poll) {
> >  			struct pci_dev *bridge = pdev->bus->self;
> >  			struct device *dev = &pdev->dev;
> > -			int pm_status;
> > +			struct device *bdev = bridge ? &bridge->dev : NULL;
> > +			int bref = 0;
> >  
> >  			/*
> > -			 * If bridge is in low power state, the
> > -			 * configuration space of subordinate devices
> > -			 * may be not accessible
> > +			 * If we have a bridge, it should be in an active/D0
> > +			 * state or the configuration space of subordinate
> > +			 * devices may not be accessible or stable over the
> > +			 * course of the call.
> >  			 */
> > -			if (bridge && bridge->current_state != PCI_D0)
> > -				continue;
> > +			if (bdev) {
> > +				bref = pm_runtime_get_if_active(bdev, true);
> > +				if (!bref)
> > +					continue;
> > +
> > +				if (bridge->current_state != PCI_D0)
> > +					goto put_bridge;
> > +			}
> >  
> >  			/*
> > -			 * If the device is in a low power state it
> > -			 * should not be polled either.
> > +			 * The device itself should be suspended but config
> > +			 * space must be accessible, therefore it cannot be in
> > +			 * D3cold.
> >  			 */
> > -			pm_status = pm_runtime_get_if_active(dev, true);
> > -			if (!pm_status)
> > -				continue;
> > -
> > -			if (pdev->current_state != PCI_D3cold)
> > +			if (pm_runtime_suspended(dev) &&
> > +			    pdev->current_state != PCI_D3cold)
> >  				pci_pme_wakeup(pdev, NULL);
> >  
> > -			if (pm_status > 0)
> > -				pm_runtime_put(dev);
> > +put_bridge:
> > +			if (bref > 0)
> > +				pm_runtime_put(bdev);
> >  		} else {
> >  			list_del(&pme_dev->list);
> >  			kfree(pme_dev);
> > -- 
> > 2.43.0
> >   
> 



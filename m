Return-Path: <linux-pci+bounces-32043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55FEB03770
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3582216EAD8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB729228CB8;
	Mon, 14 Jul 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il16xPEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8120C030
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476103; cv=none; b=t9CGwwiB43OZFSnQRikv7TY0P4Z2D8XlODwe+wRVUZk9z00cjUO9WvvDOtZieBMH9Vkp99MtJRVNqBLBuy055wEjHMpUGECT560DHgZ6kNfpqN6uAY2i0zl4GEwP871IlUTE/mfihZzws0kxqcNuGhotTlr/16aoP6Ur9tm1VAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476103; c=relaxed/simple;
	bh=UGs/+B32gn3cy1d8qhjGPSwAy5GCOeHq/3OLNLkco8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkGc8Zi3097kNDoUS5bN4jUqPWLT7iMdFnWuwvOf8GCdyEEFNNq5WcwR011iCZzb+WLR85gABuEAfDjauGXgRjEJZVnCWfNLP7Wfn+bqdIFvXKCWEHJ/YWbAz8Js5Ea2ITYuToj8NATBRN3HrploXkcjLKFUmcLyXAennFaubKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il16xPEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752476100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
	b=Il16xPEmlJN4ebqeQRYH0wDxWSXzdhB8xkTsvGiE9ryzliixlkOUAF8K64EJigfRxzT3i9
	DzMXt3Cl4/RiCnJAupCBglwhqgeTfKF6VXirpImDsADRojHyPK08f76GvN623AGcC+aZ7X
	3/y/czG55KDDvAmWXN+h5cCU3jtiwaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-59wXcrI_P4uzIK4YeGXCqg-1; Mon, 14 Jul 2025 02:54:58 -0400
X-MC-Unique: 59wXcrI_P4uzIK4YeGXCqg-1
X-Mimecast-MFC-AGG-ID: 59wXcrI_P4uzIK4YeGXCqg_1752476097
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso30262005e9.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 23:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476097; x=1753080897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
        b=Dp3Q8RpWVqomBIWGFcknaijIjiuI6HvXtrRRRcIWxVYuPQ8bJTkeIIjBNTxT/WMcNI
         a9OBgPIdBpbLADD+ebaMyLnafPlHiKWDNrwuRgIzXpEfBL1N3L3MnHX+mO55L1/BKNtl
         2+HQhVHWLJazvy/aQDrWFeu4ySxo8FAkFwu/APIvi68O3miXvhhJYUrPWCWU7SstYGx1
         90GhYGdMZdBiXm4kHUlk1kLsCxwiQNCsCWT497ipVH+rMW1AKNLCSu2UdTZ7jBQhuK/I
         dvhdriW1Dp4SZ8hzLXbyCbD7dQkKWnyHpa4tT/fgrScaxuvwcRZp+ZFLzZ35idMqJGK5
         JPqA==
X-Forwarded-Encrypted: i=1; AJvYcCWOe3USkco8URGJq0LkRwpgphYc+TrNtQiPgnrX4lSuVlo6aEjvs2By+jRjviMu9hs4Uj8+RI06sKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNo9EL+yASE9T854pJUNH1KwqwYF8gDorLFfHqBMsxZzNmNU2
	T/W4jOeju7CtA2Qp5mVLAzeWN8/H6Xue4w+C27R8lyhSqm8nIsHaHH7u8OzYRDqDRaQf6TY0eUM
	LFKm2aiIb2kNui/fIJpZMGOkLC0YJM5hI9XHhtJ6JnrQm5lG1qvdfd3qtR0QNQg==
X-Gm-Gg: ASbGncvZRVBpv230YdOoEGZu2Zc88j4+UdMZ5QW1G0zMXGIu7Ti/aKAkHvs0uI3HnYo
	5/iGxkNu4TCGV1mDUAMC9AqKk2jhWZYJCZganpP8ob8jr3/t8H45hz74tJFhkZbIFO9x2cQJlm0
	Skr0mJnId6xOOYthEGxgPBAgHDBK3vYNkh1hhLhjLV+iASmJq2bqCLAqf55xy+BFXcQtqcz+7s8
	7Lr3/1MnNtotv7ZBMQCVDg0FzAbFmxPqetgu4iRx4wITMNG2FgY7iHoCCUi4UNhBsu0fgSOIQSU
	/pYhkyiZE2TnT5HuhWvjz+kQ5LTDMcyL
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785805e9.18.1752476096934;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE022c2VHr8WA+kO3hbXoaSxylmvCVJc9OW9gVm8pRiIUhm71J57/fOnW6tWgm61Q3Ykw7IA==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785655e9.18.1752476096517;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45610c518e9sm46492725e9.17.2025.07.13.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:54:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714025357-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHSfeNhpocI4nmQk@wunner.de>

On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly, the
> > cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> 
> For PCI devices in a hotplug slot, user space can initiate "safe removal"
> by writing "0" to the hotplug slot's "power" file in sysfs.
> 
> If the PCI device is yanked from the slot while safe removal is ongoing,
> there is likewise no way for the driver to know that the device is
> suddenly gone.  That's because pciehp_unconfigure_device() only calls
> pci_dev_set_disconnected() in the surprise removal case, not for
> safe removal.
> 
> The solution proposed here is thus not a complete one:  It may work
> if user space initiated *driver* removal, but not if it initiated *safe*
> removal of the entire device.  For virtio, that may be sufficient.


No, I just missed this corner case.

> > +++ b/drivers/pci/pci.h
> > @@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > +		/* Make sure work is up to date. */
> > +		smp_rmb();
> > +		schedule_work(&dev->disconnect_work);
> > +	}
> > +
> >  	return 0;
> >  }
> 
> Going through all the callers of pci_dev_set_disconnected(),
> I suppose the (only) one you're interested in is
> pciehp_unconfigure_device().
> 
> The other callers are related to runtime resume, resume from
> system sleep and ACPI slots.
> 
> Instead of amending pci_dev_set_disconnected(), I'd prefer
> an approach where pciehp_unconfigure_device() first marks
> all devices disconnected, then wakes up some global waitqueue, e.g.:
> 
> -	if (!presence)
> +	if (!presence) {
> 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> +		wake_up_all(&pci_disconnected_wq);
> +	}
> 
> The benefit is that there's no delay when marking devices disconnected.
> (Granted, the delay is small for smp_rmb() + schedule_work().)
> And just having a global waitqueue is simpler and may be useful
> for other use cases.
> 
> So instead of adding timeouts when waiting for interrupts, drivers would
> be woken via the waitqueue.
> 
> But again, it's not a complete solution as it doesn't cover the
> "surprise removal during safe removal" case.
> 
> I also agree with Bjorn's and Keith's comments that the driver should
> use timeouts for robustness,

Yes - we can consider this an optimization, as robust timeouts
are by necessity minutes.

> but still wanted to provide additional
> (hopefully constructive) thoughts.
> 
> Thanks!
> 
> Lukas



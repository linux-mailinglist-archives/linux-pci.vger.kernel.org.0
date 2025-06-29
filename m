Return-Path: <linux-pci+bounces-31030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100AAECF34
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB888170EB0
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4B2376EC;
	Sun, 29 Jun 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+Bv1vDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D143221277
	for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218099; cv=none; b=XiRZDxTw4BoLurtYq20IR7RfahRhVhIyRAYAOKXBba2L0i8rZp1P/zUjwl6Trru5RGxNnYXNpmws+PY5Le7aw9A/0IR3hqGi/ThrG5FAFgc9q3958tkH5JXVUd97RewmnylgvyA1qdH1EfZydAZoKyGngRtIUCa5yAw3OzjNysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218099; c=relaxed/simple;
	bh=J9YDXD4duvC3Wk7QUO6r6W8l64XMHZU2uOpTsU+NisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEK6ErK07zh+r5APFpOWQ5W1Ngsx4+C/7BjAS1+CNFm1GT8g3QEStM3Lkqe5tjS1keXcNd2Ir4wIsKvyVpriP0UydTPgVPvJR4x6U7yEh4ZppSB3lJhHs9hep061W5mWxe4mTeQe2OiKZ3ucLipULqnC497x4IbbvFW+sxDSDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+Bv1vDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751218095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGHkUjNmjIIMPgTkRg7VREABnqYi+wWbJyf4AWH8+h8=;
	b=R+Bv1vDT+AUEJpcGcfqk+fS/E5i1npJihQoy0USLkBM/6uKWC69SDk1poRYSAX1B1BNGys
	tRj4bQDx0Cpcs+RV5AL5NZJQFMkrikPqbHKYSHiXicLIZpUtmPogxcAUa2p16Tu64lrDp7
	igwDSSQTSE5/57Lonc42jwplefjerCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-neej10M0MaiZctezW_MGUQ-1; Sun, 29 Jun 2025 13:28:13 -0400
X-MC-Unique: neej10M0MaiZctezW_MGUQ-1
X-Mimecast-MFC-AGG-ID: neej10M0MaiZctezW_MGUQ_1751218093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d64026baso18145755e9.1
        for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 10:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751218093; x=1751822893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGHkUjNmjIIMPgTkRg7VREABnqYi+wWbJyf4AWH8+h8=;
        b=UsyVYIIgAjEP4mIUWT4XNRd+U8upUc5o8tRWW4gH/t2sCnp8mPkwY4mJ/jH9Al5w1/
         JeMlK2i7MkoTyPxbtthlUggZCajzcD4dV1EsO+sulUtVbxNgLaH2E5mojsJ4nCr8pp4Z
         1De0d6IqrbUpyIQz0+p1a/WfgHn0zprJcZ4vJl9X4Y/76QtNeqhKDKrfAXDDS0k3PPzY
         nS8g/eRqmzKPz5SCi39Uizqphm31cZsmXEpSLJKM53IsQMVFXBTl+PbbzFldz9GhEf7/
         ijvMo+O5C/bO3ev3qyFq8USiUOlYyIgC2NN2InWdpcjPBHCfRrPY5seF9WvY5u1GQ3Sw
         NcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXE01TkrnF/eqnn+AHF14GESFQnNb0uCozzMQKIVk4k5KtiS3qYh9XgMxWaRIjIVYqb99LUpLJkVTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyphg4eA43jzyP3B/Irm2ndVLj9y2llF2OTzAV0D1Oz30lPqF3N
	ioKgn3axgCqYHjVWIV3Pot2U6uBAHRmyXPSAcZSMHg4IYurz9sxEVbo2Wn74GsBasqgIap1kz9g
	gRRNkgL6rG4X+ISZr+quem6541+hbEFWrBqASFwlLY2lAjMku31q8m2CG4aJnJg==
X-Gm-Gg: ASbGnctrmTSF0SYDx5jut1wqLhoTGUheW34ojD1bzfnN6FkxHumwzO4aveQi8RW3rLn
	d8MZ5fQa99vF/vsvF8sIxskH0HsrKR9/czEpeG4rWl9q31HbiA8CRMXuDKDd33lyC7r8Z+agqB+
	8dyflF4jJuyRbJT+R7Fmot0fZcnyUa3AY7MfyKB5WZZDKLGNTf+cJ38GGQdnSp5c7ejgq8nTvT0
	D50COwoESXAzammqk0UBMg9x/mRD/kCOnwVBxmGMxcILb/wFcAzsC2UcJaQEzhyZ19SEi18qNgO
	WTs2I57tqDsQSwcw
X-Received: by 2002:a05:600c:6095:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-4538ee504demr102969605e9.7.1751218092521;
        Sun, 29 Jun 2025 10:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9HJ2OfndwPMREYIRxXW8JXGourHIYbXzVyfj8L8gZMgZLg5HRsqQ4PckajVtmi25Hd1plTA==
X-Received: by 2002:a05:600c:6095:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-4538ee504demr102969455e9.7.1751218092114;
        Sun, 29 Jun 2025 10:28:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59736sm8185715f8f.74.2025.06.29.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:28:11 -0700 (PDT)
Date: Sun, 29 Jun 2025 13:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, stefanha@redhat.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250629132113-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGFBW7wet9V4WENC@wunner.de>

On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular
> > remove callback is invoked, exclusively.
> > This works well, because mostly, the cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> > 
> > Drivers can artificially add timeouts to handle that, but it can be
> > flaky.
> > 
> > Instead, let's add a way for the driver to be notified about the
> > disconnect. It can then do any necessary cleanup, knowing that the
> > device is inactive.
> [...]
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -549,6 +549,15 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	/* Notify driver of surprise removal */
> > +	device_lock(&dev->dev);
> > +
> > +	if (dev->driver && dev->driver->err_handler &&
> > +	    dev->driver->err_handler->disconnect)
> > +		dev->driver->err_handler->disconnect(dev);
> > +
> > +	device_unlock(&dev->dev);
> > +
> >  	return 0;
> >  }

thanks for the feedback. Would appreciate a couple more hints:

> No, that's not good:
> 
> 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.

I see. What other way is there to prevent dev->driver from going away,
though? I guess I can add a new spinlock and take it both here and when
dev->driver changes? Acceptable?

> 2/ pci_dev_set_disconnected() needs to be fast so that devices are marked
>    unplugged as quickly as possible.  We want to minimize the time window
>    where MMIO and Config Space reads already return "all ones" and writes
>    go to nirvana, but pci_dev_is_disconnected() still returns false.
>    Hence invoking some driver callback which may take arbitrarily long or
>    even sleeps is not an option.

Well, there's no plan to do that there - just to wake up some wq so
things can be completed. I can add code comments.

> The driver is already notified of removal through invocation of the
> ->remove() callback.  The use case you're describing is arguably
> a corner case.  I do think that a timeout is a better approach
> than the one proposed here.  How long does it take for the interrupt
> to arrive?

It's a virtual device - kind of unpredictable.

>  If it's not just a few msec, consider polling the device
> and breaking out of the pool loop as soon as pci_dev_is_disconnected()
> returns true (or the MMIO read returns PCI_POSSIBLE_ERROR()).

Yes but with no callback, we don't know when to do it.
The config reads in pci_dev_is_disconnected are also expensive
on VMs...

> If/when respinning, please explain the use case in more detail,
> i.e. which driver, which device, pointers to code...
> 
> Thanks!
> 
> Lukas


It's virtio-blk. 



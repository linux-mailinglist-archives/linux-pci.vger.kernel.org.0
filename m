Return-Path: <linux-pci+bounces-31330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC70AF6A39
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D27A3541
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071528FFFB;
	Thu,  3 Jul 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwccRZ4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E73291166
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523860; cv=none; b=uz19ErvE65U4ruucx+LL5lt4kPl/D8POUP+vR7NqavixgDowml0JCvv8TW8N0SbT+BrkA4W6+TDGQc6VDyGqZrc06IIC5ZWh2wIKkH5cDQGu4QhA7Qhm2D5kR8vxeiytLuZ3wBf5phiifKmWPgY5ODimGK9LRNMRjiQ/7ItuAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523860; c=relaxed/simple;
	bh=dao9nTpC5C1q0JJDCBYH/D3fgkfHONt6s1hu70kqblQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb0w6b8F/FPNUnaBkvOhg4RJb60zfjBTt4vnaBYJ9yl8Siv2aMcnXeu8Y+JzCebPDji8iBgAvI1VQefXsTF+LAU8fbFgxdY70zzW2ulN19wgsnRBwSIa8JcqITEBzJAZJXzCI+XQ6TF20t7JJ/5FsjXfULzHdXd2TgUxT2v4Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwccRZ4V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751523856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNnWJxGDTYj2oLSlWuvTf5AvF7vq7QQGZ22ViGGEQZQ=;
	b=OwccRZ4Vxh5DvST4BMUgW1HUdqLBFGQUQZM8IJemps9xeyNn+i1bjIyLLHzIkfgc+knLrx
	oq2I4EKT2fXGv38kcl7Iz15z3f/WDdfYF+D3jpJYaA3cBq3X//p5ODYZmnqgNQRfZhlqeu
	GBDw58dC/CblSeyCbj+vA78Wr2TVVDE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-12-XF42XPCixud4rssopfA-1; Thu, 03 Jul 2025 02:24:14 -0400
X-MC-Unique: 12-XF42XPCixud4rssopfA-1
X-Mimecast-MFC-AGG-ID: 12-XF42XPCixud4rssopfA_1751523853
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f3796779so4199273f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 23:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751523853; x=1752128653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNnWJxGDTYj2oLSlWuvTf5AvF7vq7QQGZ22ViGGEQZQ=;
        b=MX3OxfqHmZKzMEjDDkIz09GzDTJ3xYUDB+uTP5E025PSTVkXO2WRl2s5k1zdPbgGRl
         3ISfSLsqxUImt+r3BDeJSsU9eYqkO0xSwOHDKQSRqhSBVzQ4YVlAoRpwMheRZMlbsNmj
         iOoGFzKfikws4lkqV1YlpED8aPixoe5lGwXJZDGq9K0Z/HVidzbIIYCgSMojadOP7dVA
         nJs43Hq9hQTTDV0EUGsHYioxE5fojmr5lyaQvnDKtF7TpZtAKGl1mqLmayEwoyqMUoue
         rrJV2cXDWgIVf8vYhIOs/WDm5/TXG5zH0GuxFkt9dJDIOGrpbi7MgVL61RWXURZ2pMbQ
         XUDg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Vp39J+wq5+UUNZnz34XrAVgUJdrmwNL3dWh0lunUgPrzR2Utt0A497YwSYt74a4BKuNsCNadHX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ7648NcjGl3XkTiyrwVDnDdaaxxDV+6jQlH2z4kBtgMzEkGf
	2yk9KRGpoH/bhSQfiAgSE1Lxp1Us4G7O/LM/QInPB3XMb/83FY5fwzikG/8z+MxEtXdm1P+enY9
	mk8zvn8pKLhJulYn8qXKUP8p6DirnpyPF8g5yLxqM4hA/TCyl/7opJA+dpT+a7Q==
X-Gm-Gg: ASbGncugdXkiFahtQIB7Snhv5RPXt5b8CMqxXRU/vYflmw8IxQUBHfAxCTi61WrAzVs
	IlsBvxMqbw5YGVnkPVIO3flwNwXXQE7W6+l5jNfVZN5hE8BN9WB4SQchusxT5boZoOjzAMZ+LQ3
	D7Hf5qtuKOzH/6XjfHao+aO+QhzmppHYkdZuygLsBP+N94fPx1YlmuiT+lgCgwYQtKiAQuRNjJa
	9cYet3pAHCMND0VT30+7Jhow1B8TMAaUbACjrbeLWuZJ1py5q60KZV74JMwu7zTlf+jXYt3xwa8
	kMZA2R2D4Vf4kOYW
X-Received: by 2002:a05:6000:490a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b1fe5c07d4mr4360126f8f.21.1751523853196;
        Wed, 02 Jul 2025 23:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGxmSX9oSYQVzW9zlIGbTQXs8hI4c+MXz2QtluF728gF5D2N2yEQOE0oBdUYHzNVwqbLlzgg==
X-Received: by 2002:a05:6000:490a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b1fe5c07d4mr4360105f8f.21.1751523852675;
        Wed, 02 Jul 2025 23:24:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb20esm18034642f8f.36.2025.07.02.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:24:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 02:24:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <20250703022224-mutt-send-email-mst@kernel.org>
References: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
 <20250702132314-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jul 03, 2025 at 05:02:13AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 02 July 2025 10:54 PM
> > 
> > On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > > At the moment, in case of a surprise removal, the regular remove
> > > callback is invoked, exclusively.  This works well, because mostly,
> > > the cleanup would be the same.
> > >
> > > However, there's a race: imagine device removal was initiated by a
> > > user action, such as driver unbind, and it in turn initiated some
> > > cleanup and is now waiting for an interrupt from the device. If the
> > > device is now surprise-removed, that never arrives and the remove
> > > callback hangs forever.
> > >
> > > For example, this was reported for virtio-blk:
> > >
> > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > 	   complete,
> > >
> > > 	2. Now few requests are yet to complete, and surprise removal started.
> > >
> > > 	At this point, virtio block driver will not get notified by the driver
> > > 	core layer, because it is likely serializing remove() happening by
> > > 	+user/driver unload and PCI hotplug driver-initiated device removal.
> > So
> > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > 	for requests completions to arrive which it never gets.  So
> > > 	del_gendisk() gets stuck.
> > >
> > > Drivers can artificially add timeouts to handle that, but it can be
> > > flaky.
> > >
> > > Instead, let's add a way for the driver to be notified about the
> > > disconnect. It can then do any necessary cleanup, knowing that the
> > > device is inactive.
> > >
> > > Since cleanups can take a long time, this takes an approach of a work
> > > struct that the driver initiates and enables on probe, and tears down
> > > on remove.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >
> > 
> > Parav what do you think of this patch? 
> The async notification part without holding the device lock is good part of this patch.
> 
> However, large part of the systems and use cases does not involve pci hot plug removal.
> An average system that I came across using has 150+ pci devices, and none of them uses hotplug.
> 
> So increasing pci dev struct for rare hot unplug, that too for the race condition does not look the best option.
> 
> I believe the intent of async notification without device lock can be achieved by adding a non-blocking async notifier callback.
> This can go in the pci ops struct.
> 
> Such callback scale far better being part of the ops struct instead of pci_dev struct.

Sorry, I don't see a way to achieve that, as the driver can go away
while hotunplug happens.

You would be welcome to try but you mentioned you have no plans to do so.



> > This you can try using this in virtio blk to
> > address the hang you reported?
> >
> The hang I reported was not the race condition between remove() and hotunplug during remove.
> It was the simple remove() as hot-unplug issue due to commit 43bb40c5b926.
> 
> The race condition hang is hard to reproduce as_is.
> I can try to reproduce by adding extra sleep() etc code in remove() with v4 of this version with ops callback.
> 
> However, that requires lot more code to be developed on top of current proposed fix [1].
> 
> [1] https://lore.kernel.org/linux-block/20250624185622.GB5519@fedora/
> 
> I need to re-arrange the hardware with hotplug resources. Will try to arrange on v4.
> 
> > > Compile tested only.
> > >
> > > Note: this minimizes core code. I considered a more elaborate API that
> > > would be easier to use, but decided to be conservative until there are
> > > multiple users.
> > >
> > > changes from v2
> > > 	v2 was corrupted, fat fingers :(
> > >
> > > changes from v1:
> > >         switched to a WQ, with APIs to enable/disable
> > >         added motivation
> > >
> > >
> > >  drivers/pci/pci.h   |  6 ++++++
> > >  include/linux/pci.h | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > > b81e99cd4b62..208b4cab534b 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct
> > pci_dev *dev, void *unused)
> > >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> > >  	pci_doe_disconnected(dev);
> > >
> > > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > > +		/* Make sure work is up to date. */
> > > +		smp_rmb();
> > > +		schedule_work(&dev->disconnect_work);
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > 51e2bd6405cd..b2168c5d0679 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -550,6 +550,10 @@ struct pci_dev {
> > >  	/* These methods index pci_reset_fn_methods[] */
> > >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> > >
> > > +	/* Report disconnect events */
> > > +	u8 disconnect_work_enable;
> > > +	struct work_struct disconnect_work;
> > > +
> 
> > >  #ifdef CONFIG_PCIE_TPH
> > >  	u16		tph_cap;	/* TPH capability offset */
> > >  	u8		tph_mode;	/* TPH mode */
> > > @@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct
> > pci_dev *pdev)
> > >  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) ==
> > > PCI_DEV_FLAGS_ASSIGNED;  }
> > >
> > > +/*
> > > + * Caller must initialize @pdev->disconnect_work before invoking this.
> > > + * Caller also must check pci_device_is_present afterwards, since
> > > + * if device is already gone when this is called, work will not run.
> > > + */
> > > +static inline void pci_set_disconnect_work(struct pci_dev *pdev) {
> > > +	/* Make sure WQ has been initialized already */
> > > +	smp_wmb();
> > > +
> > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1); }
> > > +
> > > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev) {
> > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > > +
> > > +	/* Make sure to stop using work from now on. */
> > > +	smp_wmb();
> > > +
> > > +	cancel_work_sync(&pdev->disconnect_work);
> > > +}
> > > +
> > >  /**
> > >   * pci_ari_enabled - query ARI forwarding status
> > >   * @bus: the PCI bus
> > > --
> > > MST



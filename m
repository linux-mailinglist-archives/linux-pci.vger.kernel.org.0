Return-Path: <linux-pci+bounces-31350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB6AF6FDC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96EC1BC5F71
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FC42E040A;
	Thu,  3 Jul 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQLk0DJ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA21B95B
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538048; cv=none; b=lbYo9pnZhpwPc9dD5eaK+DS7acEncTuiJ5ieXfo1r8xRTUjT1/DeFwrV9ILrbqlWIoqIlbmtcI18zb2loJz02zREhLAVhnoUeGdvWUg2zL/TFvEyfzoiJBBfCVDPpBKysf69c9XNoR3JomofBiflIS1szXSpGVS3eRe46i5OnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538048; c=relaxed/simple;
	bh=hWnj2JttZfQLVmU/kXS57bJGdhpWzPRLJtR52pCv/1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tllKpySP254y8EaYUjqeJcm3IbJ4HZ48bpCRzdWH4AsGX4lk1fDB7PSA42PyFqqrHOI4RRrzDM6l1TmyyfeH7BBLs7D24N9uSYG9oTuVeExW6jgMDeFwuXq6vf67UgAOX8/khCsgzEq4V48Z63x1/pKNW0Hi+cO4NFt6/y9nkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQLk0DJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751538045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbJvbfJA285FAzgUHDoYgxUWhabHJqvbcxotjo66HGg=;
	b=AQLk0DJ8wNnyxCR16XRJzL9Ufw8QcPP1c2wAnPGvlbbsKyfv5cYUspunyFfqJK3Qft2D9d
	Uw7kDH0VXFoC0DY9zibOu52c9VrG5avDdQnEMjXwaxHy/rQa9SDwH7CAIYdETAcF2FkAAq
	UT8hTVstd3Hp9PfYuvSczyWz6z4lBWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-DDIZ8pLUPAqLdh3jE5tWRA-1; Thu, 03 Jul 2025 06:20:44 -0400
X-MC-Unique: DDIZ8pLUPAqLdh3jE5tWRA-1
X-Mimecast-MFC-AGG-ID: DDIZ8pLUPAqLdh3jE5tWRA_1751538043
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b39cb4ca2eso254653f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2025 03:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751538043; x=1752142843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbJvbfJA285FAzgUHDoYgxUWhabHJqvbcxotjo66HGg=;
        b=GlBAFNmlx/EgeRVleGgp1uaAfK8sAMd7LpOvun1azcX3HhI+c+DxwvxhbgeFVBA/3K
         eA5Jhph1ZphQWH4yIuOKzpR0tSuasGBvhoowG4/ZoMPyazGwWHSgeZ8RNsxHJipytqWA
         GzImMp3uF+ZGlrGmdrfRxdnLVBYyk9ZpY4IShtEzcm9imOLEiuJ0BSq1R9B66ukDO1em
         6jLHVcaiiHPDQwRhF8UyOVFF3TiN8S7p8bI7aNI9etp4npjSk2ozvMINj7HMQ8wUylnt
         KS5Hk/RSGKTp8Rndfsa+NqZEjUB7eIsf+NP4VRp7KdQBubAtQ3NF4U7/gk3sLu8+eLg5
         0jBw==
X-Forwarded-Encrypted: i=1; AJvYcCUDVPCsN+9KUvS5mB8R9Z6ghMCfJ3dn/O1nx0Rl/zCB7b4qEhe3myIDCk5gix9lr/v87GbMAp9FkMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSfqN2RcsCoixwycJCUyvTk6IYNfpEi24TQDzWnX9RyzLw9lYp
	2XK2reKP6kcOtNYtaQIrmT/DBXTEbzF0xdbrT62vG7PkLGQGGHGSMCEcrkrpsZtWrwYeWIgpQeY
	HruZzg8sfy+ZgdyKv4ETKpBHbscYjUVqXkwIN7kslgtrI4+62Pkl5BZesfmSjHQ==
X-Gm-Gg: ASbGncsXpN2XKW1Mu9LdEOq21skKwR18o3cNX4xYDLFqTGRj6mJnnddNjnglgMAQE0H
	O4oZYYylYY7LxfnWtCuBB/EPdQZTFHogUqP1mEjkDCCgbugtuT1f+2Pipf9hxrI+1vawg0LW4cK
	X3dELCtlKADKrATnWwRnfFO1pd7cXduCtz47qBBwfWnOUrDCMAy8Ih0yRh5gWtKzUzZnH5kawQA
	AWBC+6nWlDK5fZXq02uHXkWMlFYBfMsxsumU5vU5mvCC0NRdGEJsCvy4jxwTE7XjJjyY/SYp9sd
	TQ1LPcY8+x1K1Quk
X-Received: by 2002:a05:6000:2485:b0:3b3:bd27:f2b0 with SMTP id ffacd0b85a97d-3b3bd27f7d4mr1023064f8f.43.1751538042631;
        Thu, 03 Jul 2025 03:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ZKDudPPhVPxOALtVbYFsiYPTxCVhE4LkBmemxP9beQpBH2tiZarCm0SxJb/9KB6b2t9B6Q==
X-Received: by 2002:a05:6000:2485:b0:3b3:bd27:f2b0 with SMTP id ffacd0b85a97d-3b3bd27f7d4mr1023042f8f.43.1751538042134;
        Thu, 03 Jul 2025 03:20:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61f48sm18527944f8f.93.2025.07.03.03.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:20:41 -0700 (PDT)
Date: Thu, 3 Jul 2025 06:20:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <20250703061813-mutt-send-email-mst@kernel.org>
References: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
 <20250702132314-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250703022224-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719536EDBEDCEA5866F37037DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719536EDBEDCEA5866F37037DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jul 03, 2025 at 09:51:57AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 03 July 2025 11:54 AM
> > 
> > On Thu, Jul 03, 2025 at 05:02:13AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 02 July 2025 10:54 PM
> > > >
> > > > On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > > > > At the moment, in case of a surprise removal, the regular remove
> > > > > callback is invoked, exclusively.  This works well, because
> > > > > mostly, the cleanup would be the same.
> > > > >
> > > > > However, there's a race: imagine device removal was initiated by a
> > > > > user action, such as driver unbind, and it in turn initiated some
> > > > > cleanup and is now waiting for an interrupt from the device. If
> > > > > the device is now surprise-removed, that never arrives and the
> > > > > remove callback hangs forever.
> > > > >
> > > > > For example, this was reported for virtio-blk:
> > > > >
> > > > > 	1. the graceful removal is ongoing in the remove() callback, where
> > disk
> > > > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > > > 	   complete,
> > > > >
> > > > > 	2. Now few requests are yet to complete, and surprise removal
> > started.
> > > > >
> > > > > 	At this point, virtio block driver will not get notified by the driver
> > > > > 	core layer, because it is likely serializing remove() happening by
> > > > > 	+user/driver unload and PCI hotplug driver-initiated device removal.
> > > > So
> > > > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > > > 	for requests completions to arrive which it never gets.  So
> > > > > 	del_gendisk() gets stuck.
> > > > >
> > > > > Drivers can artificially add timeouts to handle that, but it can
> > > > > be flaky.
> > > > >
> > > > > Instead, let's add a way for the driver to be notified about the
> > > > > disconnect. It can then do any necessary cleanup, knowing that the
> > > > > device is inactive.
> > > > >
> > > > > Since cleanups can take a long time, this takes an approach of a
> > > > > work struct that the driver initiates and enables on probe, and
> > > > > tears down on remove.
> > > > >
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >
> > > >
> > > > Parav what do you think of this patch?
> > > The async notification part without holding the device lock is good part of
> > this patch.
> > >
> > > However, large part of the systems and use cases does not involve pci hot
> > plug removal.
> > > An average system that I came across using has 150+ pci devices, and none
> > of them uses hotplug.
> > >
> > > So increasing pci dev struct for rare hot unplug, that too for the race
> > condition does not look the best option.
> > >
> > > I believe the intent of async notification without device lock can be achieved
> > by adding a non-blocking async notifier callback.
> > > This can go in the pci ops struct.
> > >
> > > Such callback scale far better being part of the ops struct instead of pci_dev
> > struct.
> > 
> > Sorry, I don't see a way to achieve that, as the driver can go away while
> > hotunplug happens.
> > 
> Well without device lock, driver can go away anyway.
> In other words when schedule_work() is called by the core in this patch, what prevents driver to not get unloaded?
> May be driver refcount can be taken conditionally before invoking the callback?

The work is flushed on driver unload.
Check out v4 for how it's used.

> 
> > You would be welcome to try but you mentioned you have no plans to do so.
> > 
> As I explained you can see that the support is needed at multiple modules.

Right. Check out v4: I did all the core work: pci, virtio and
virtio-pci, so what's left is just virtio blk.  For which I'm not the
best person, I think you are more familiar with that.


> Presently I couldn't spend cycles on this corner case race condition.
> IMHO, if we want to fix, first fix should be for the most common case condition, for which the proposed fix exists.
> 
> Followed by that your second patch of device reset should also be done.
> 
> Next should be corner case fix that possibly nvme can benefit too. 
> 
> But if you have better ideas, should be fine too.
> 
> > 
> > > > This you can try using this in virtio blk to address the hang you
> > > > reported?
> > > >
> > > The hang I reported was not the race condition between remove() and
> > hotunplug during remove.
> > > It was the simple remove() as hot-unplug issue due to commit
> > 43bb40c5b926.
> > >
> > > The race condition hang is hard to reproduce as_is.
> > > I can try to reproduce by adding extra sleep() etc code in remove() with v4
> > of this version with ops callback.
> > >
> > > However, that requires lot more code to be developed on top of current
> > proposed fix [1].
> > >
> > > [1] https://lore.kernel.org/linux-block/20250624185622.GB5519@fedora/
> > >
> > > I need to re-arrange the hardware with hotplug resources. Will try to
> > arrange on v4.
> > >
> > > > > Compile tested only.
> > > > >
> > > > > Note: this minimizes core code. I considered a more elaborate API
> > > > > that would be easier to use, but decided to be conservative until
> > > > > there are multiple users.
> > > > >
> > > > > changes from v2
> > > > > 	v2 was corrupted, fat fingers :(
> > > > >
> > > > > changes from v1:
> > > > >         switched to a WQ, with APIs to enable/disable
> > > > >         added motivation
> > > > >
> > > > >
> > > > >  drivers/pci/pci.h   |  6 ++++++
> > > > >  include/linux/pci.h | 27 +++++++++++++++++++++++++++
> > > > >  2 files changed, 33 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > > > > b81e99cd4b62..208b4cab534b 100644
> > > > > --- a/drivers/pci/pci.h
> > > > > +++ b/drivers/pci/pci.h
> > > > > @@ -549,6 +549,12 @@ static inline int
> > > > > pci_dev_set_disconnected(struct
> > > > pci_dev *dev, void *unused)
> > > > >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> > > > >  	pci_doe_disconnected(dev);
> > > > >
> > > > > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > > > > +		/* Make sure work is up to date. */
> > > > > +		smp_rmb();
> > > > > +		schedule_work(&dev->disconnect_work);
> > > > > +	}
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > > 51e2bd6405cd..b2168c5d0679 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -550,6 +550,10 @@ struct pci_dev {
> > > > >  	/* These methods index pci_reset_fn_methods[] */
> > > > >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order
> > */
> > > > >
> > > > > +	/* Report disconnect events */
> > > > > +	u8 disconnect_work_enable;
> > > > > +	struct work_struct disconnect_work;
> > > > > +
> > >
> > > > >  #ifdef CONFIG_PCIE_TPH
> > > > >  	u16		tph_cap;	/* TPH capability offset */
> > > > >  	u8		tph_mode;	/* TPH mode */
> > > > > @@ -2657,6 +2661,29 @@ static inline bool
> > > > > pci_is_dev_assigned(struct
> > > > pci_dev *pdev)
> > > > >  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) ==
> > > > > PCI_DEV_FLAGS_ASSIGNED;  }
> > > > >
> > > > > +/*
> > > > > + * Caller must initialize @pdev->disconnect_work before invoking this.
> > > > > + * Caller also must check pci_device_is_present afterwards, since
> > > > > + * if device is already gone when this is called, work will not run.
> > > > > + */
> > > > > +static inline void pci_set_disconnect_work(struct pci_dev *pdev) {
> > > > > +	/* Make sure WQ has been initialized already */
> > > > > +	smp_wmb();
> > > > > +
> > > > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1); }
> > > > > +
> > > > > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev) {
> > > > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > > > > +
> > > > > +	/* Make sure to stop using work from now on. */
> > > > > +	smp_wmb();
> > > > > +
> > > > > +	cancel_work_sync(&pdev->disconnect_work);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * pci_ari_enabled - query ARI forwarding status
> > > > >   * @bus: the PCI bus
> > > > > --
> > > > > MST



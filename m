Return-Path: <linux-pci+bounces-32041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F67B03705
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 08:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E11C1899133
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA33221739;
	Mon, 14 Jul 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bked8GzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F42218596
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474390; cv=none; b=YehXKtzl/x6kZzSzI/GIBqcMqhKrmuD+Gt2fd3pwMuUkdUPZQUMACCo/cma5IhD9IyKq3U1B3WZkVhYspTnlm36km2LXXCbw1bIqyXccOizelw5EfqF/m0Jm6kXi6RMT/22bXsT7anYOa0WGw/qBZmd2R4V+RajuTBhLDyl8y8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474390; c=relaxed/simple;
	bh=V+rwqecoT1VhxamTibKGXUp9Ch6sXkjq18TS0k6o+3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm9tnSWX+zM798RYlGj4sCr9XOzlaAaoH4POOCz1HxDbhPLtBGZuZ2FB2OQPNiqQpmrD7j2JSgIRpjE8c7s5/7dHjnFcq3VXwCXUgshzsjucpYKrPWPsr2zv7ZLAEdb57TlRZBLYU0+Rlw4D+4KUxSUrAFbP1OLfV1A+LXzLeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bked8GzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752474387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GP3d6FIZxQyy9y5NBWhl92sLho5OkS4ILaOBC7b/EwA=;
	b=bked8GzRCDxy2YzCiIhfQ6Fn6lnKYxm85hBjwbeMfHJI9gDU5pPFqKK/zyI71lCCLbW4+S
	W3XrfqvtbzjrK37swr+5uL2dQIrkvz4gRC1TkM5Mc2/eq7OUvpLozqsenUHFHKmdIQj79b
	YKq17wNXh4foPHiAxghw/Oc7rM7HznE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-PrXwWKpuNBWqO6H4_ouGVg-1; Mon, 14 Jul 2025 02:26:24 -0400
X-MC-Unique: PrXwWKpuNBWqO6H4_ouGVg-1
X-Mimecast-MFC-AGG-ID: PrXwWKpuNBWqO6H4_ouGVg_1752474384
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2636432f8f.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 23:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474383; x=1753079183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP3d6FIZxQyy9y5NBWhl92sLho5OkS4ILaOBC7b/EwA=;
        b=iQVxBuaBXKFSWa9Zth9rblgfBui42b8hssq3qWD6EHkF+8jOMPZn+onv+TsZx2K6dX
         Rtfw5mgVn8EDTf3+fYZYSfBYAUtkOuueZlCYMIOg0juJ2r033BiNmrsdUd4ICTYLWbQd
         01L+oFkdmJ+6uyOwwE/e4hnFsh2Ru347IPpB8TI6mN6+m6O7hDkHZbagICtsk2B5Lnfq
         Z7YxVXBYBPvqGcCNJKdk4OfBZsnnZUzx65u24RVJVjVpjZWrwdUc8PWy1/rS+BVClIWl
         1GgKgChL1M1k2/FIl82WEDsad+177uUxosqJqlC1WSbOtedrFQCrWM5qjjX+6coJl3P0
         NYng==
X-Forwarded-Encrypted: i=1; AJvYcCVX4VW4Lg7fX0ndhCO0dafMovUCcLbJhFt6DIlP1Wx5q2D+OP/pkGLOrXvcHGDDl/RP561tXwQgHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMuwRalcTJhr3InFjlcxTZIsOoZkb1PvQh3KOL4p++chCVzNF
	/hhnuoLWJOUM1YYkbXODU9S0sNjlheNpCpOtKkr9HCFP+uTL3uZv9O1jPKoI+vUqUGa/sWKtkK/
	GhmttJNGdQncVr1jYKE0pd8jv4WZl7SW/tSIYqBKKCOYvbfEBkxRYog1oTlyCIA==
X-Gm-Gg: ASbGncsaChfhdauYryf19DDLd0u3vsoZ/8mvXQO3DuhhN38ihXf1IbRLRi9iCDo1/Qn
	UobnVgq+UM+5ogVCyhG02EuYmIYP24lrlt5/k7eo/jtIBTFtTWDbFvgMFwcXp5vXSfxRvszRlus
	dX4YvrSUMo1bMC28nNtmsiUsKbx7yQ/JXTWexAxyHLTQkkBgdW6F64NBPCliu62FeBcoT9XVdcY
	jRg/9SmkHPYaIXE0gBR9bzJedNjtzWk/0g2uOTxLa1cvIgy4pHr9tMmMWI/C9pxTzlvGP7BnDK6
	z+ddP7MzXjwCZoBJKNQtXOv4UTSdRqcC
X-Received: by 2002:a05:6000:2002:b0:3a5:270e:7d3 with SMTP id ffacd0b85a97d-3b5e7f2e936mr12714219f8f.13.1752474383482;
        Sun, 13 Jul 2025 23:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nz+poUSNP2O8nttlooup0rJFpjoBiN8YSGlh9OAtjw4BvhaB9VzDWvT6aKNBMRIRnogc5g==
X-Received: by 2002:a05:6000:2002:b0:3a5:270e:7d3 with SMTP id ffacd0b85a97d-3b5e7f2e936mr12714190f8f.13.1752474382970;
        Sun, 13 Jul 2025 23:26:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561323a488sm40074555e9.1.2025.07.13.23.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:26:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:26:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714022128-mutt-send-email-mst@kernel.org>
References: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <20250709233820.GA2212185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709233820.GA2212185@bhelgaas>

On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> Housekeeping: Note subject line convention. Indent with spaces in
> commit log.  Remove spurious plus signs.


Thanks!

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
> > 
> > For example, this was reported for virtio-blk:
> > 
> > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > 	   complete,
> > 
> > 	2. Now few requests are yet to complete, and surprise removal started.
> > 
> > 	At this point, virtio block driver will not get notified by the driver
> > 	core layer, because it is likely serializing remove() happening by
> > 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> > 	vblk driver doesn't know that device is removed, block layer is waiting
> > 	for requests completions to arrive which it never gets.  So
> > 	del_gendisk() gets stuck.
> > 
> > Drivers can artificially add timeouts to handle that, but it can be
> > flaky.
> > 
> > Instead, let's add a way for the driver to be notified about the
> > disconnect. It can then do any necessary cleanup, knowing that the
> > device is inactive.
> 
> This relies on somebody (typically pciehp, I guess) calling
> pci_dev_set_disconnected() when a surprise remove happens.
> 
> Do you think it would be practical for the driver's .remove() method
> to recognize that the device may stop responding at any point, even if
> no hotplug driver is present to call pci_dev_set_disconnected()?
> 
> Waiting forever for an interrupt seems kind of vulnerable in general.
> Maybe "artificially adding timeouts" is alluding to *not* waiting
> forever for interrupts?  That doesn't seem artificial to me because
> it's just a fact of life that devices can disappear at arbitrary
> times.
> 
> It seems a little fragile to me to depend on some other part of the
> system to notice the surprise removal and tell you about it or
> schedule your work function.  I think it would be more robust for the
> driver to check directly, i.e., assume writes to the device may be
> lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
> never wait for an interrupt without a timeout.

virtio is ... kind of special, in that users already take it for
granted that having a device as long as they want to respond
still does not lead to errors and data loss.

Makes it a bit harder as our timeout would have to
check for presence and retry, we can't just fail as a
normal hardware device does.

And there's the overhead thing - poking at the device a lot
puts a high load on the host.

So I can imagine a very long timeout (minutes?), and then something like
the WQ I am trying to propose here as a shortcut.



> > Since cleanups can take a long time, this takes an approach
> > of a work struct that the driver initiates and enables
> > on probe, and tears down on remove.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/pci/pci.h   |  6 ++++++
> >  include/linux/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 12215ee72afb..3ca4ebfd46be 100644
> > --- a/drivers/pci/pci.h
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
> >  
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 05e68f35f392..723b17145b62 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -548,6 +548,10 @@ struct pci_dev {
> >  	/* These methods index pci_reset_fn_methods[] */
> >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> >  
> > +	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
> > +	u8 disconnect_work_enable;
> > +	struct work_struct disconnect_work;
> > +
> >  #ifdef CONFIG_PCIE_TPH
> >  	u16		tph_cap;	/* TPH capability offset */
> >  	u8		tph_mode;	/* TPH mode */
> > @@ -1993,6 +1997,47 @@ pci_release_mem_regions(struct pci_dev *pdev)
> >  			    pci_select_bars(pdev, IORESOURCE_MEM));
> >  }
> >  
> > +/*
> > + * Run this first thing after getting a disconnect work, to prevent it from
> > + * running multiple times.
> > + * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
> > + */
> > +static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
> > +{
> > +	u8 enable = 0x1;
> > +	u8 disable = 0x0;
> > +	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
> > +}
> > +
> > +/*
> > + * Caller must initialize @pdev->disconnect_work before invoking this.
> > + * The work function must run and check pci_test_and_clear_disconnect_enable.
> > + * Note that device can go away right after this call.
> > + */
> > +static inline void pci_set_disconnect_work(struct pci_dev *pdev)
> > +{
> > +	/* Make sure WQ has been initialized already */
> > +	smp_wmb();
> > +
> > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
> > +
> > +	/* check the device did not go away meanwhile. */
> > +	mb();
> > +
> > +	if (!pci_device_is_present(pdev))
> > +		schedule_work(&pdev->disconnect_work);
> > +}
> > +
> > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
> > +{
> > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > +
> > +	/* Make sure to stop using work from now on. */
> > +	smp_wmb();
> > +
> > +	cancel_work_sync(&pdev->disconnect_work);
> > +}
> > +
> >  #else /* CONFIG_PCI is not enabled */
> >  
> >  static inline void pci_set_flags(int flags) { }
> > -- 
> > MST
> > 



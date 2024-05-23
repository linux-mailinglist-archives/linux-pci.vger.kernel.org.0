Return-Path: <linux-pci+bounces-7796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E8B8CDA83
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4741C21A03
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EE8287D;
	Thu, 23 May 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN2wvDwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC082863
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491421; cv=none; b=EIMXWvN5Re1DH1sABHIlk0HaeRmWVxVGR5SapghniBeQvV8e9AVkEJXHYUzSGfwjNgVahVBhlRZ8UM+bcHwVhJ05+s2kZcdJG3cAITh49L1lR3/bAy+TUj5pbcltMrQGaQUu+/NsTlz08lBdZzOvpCVhiehhWGZbIJ5sEQJ0XV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491421; c=relaxed/simple;
	bh=8qvEpgij5NY4psFEdAgmC2/nCio37oi+zqZD0b+e3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqppeEFUX+F2PHzcma9yA74XrZHFqtEjaU3DWLEiudect0fRoSm0J8YMUEcgkuvQjyMGI19iDHIKwuBLLVoj7SClb7gqUHXdhr4k4lpOLslG0C2R+oVcNwwGZjHJLcqLBvutbvgiDuihdoNN7VLF+qZjb5r964PxmkWwuk9CcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QN2wvDwO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716491415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=an9CMjMvvy9z07HuADieYHDegy2qXYn37kwESjJWGyQ=;
	b=QN2wvDwOst714oK1FrYaZdMIoTRIPkGYUCFi/sn8jF6ZwIPjr16lFmkXpvcDFX4PjLc0zU
	6xOwg8fVIq4zf2mAa0xpgVOAVxV7oJCYgU1rYaEbmAyC/Q2Nd/vRyYZYnYdCVeknfFWA6o
	UtDEupEG8YFzPzDDAxnyJ5LQt2EH0xU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-dCFC-osuObithxF61Lcyqg-1; Thu, 23 May 2024 15:10:13 -0400
X-MC-Unique: dCFC-osuObithxF61Lcyqg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso207056139f.0
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 12:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491412; x=1717096212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an9CMjMvvy9z07HuADieYHDegy2qXYn37kwESjJWGyQ=;
        b=EAwEYdGyKU3HoW1hoNdyYXGlVpm22rZRY5UvTPdLB78eLeTqfhuZGy6dBqsu9I0aNV
         IxeppOTcLGUnYYyFZFPxmqtyQc+BskWSw+D1wRoK58cdqtiRft19Hs9fwkpOZILMIDw2
         +z8ikX5YdeMLv92Ip0cfY5DHgK9ufdpel7AnT8E3TS6PE1rasZ4loWxN+1QKXYM8HjqO
         Amy8LUW1ZkKcdi1/pfJXmybqnp8tSvBVVRPBHZVzXv2XLpUL8Tp9489xrm++Oxg5kBio
         cEbbC2mnjpS08b+ob5Jy1HYzSkm6WgPY9vglo9GsBdG15c2fsKtxnJEF9S9ZouL1/3/S
         iVZA==
X-Forwarded-Encrypted: i=1; AJvYcCWgASjjRfxvmCW2pAMSMVCxTSjfntQcbvZshy+2E+I5Vb6AaCxawtDQXk/ywkLUfmc/HMHevzisvB1x6fLjli4pui5NJoLIPzKj
X-Gm-Message-State: AOJu0Yw1grTMUQMpAJWJIKHxDWEgZBU8RycH7iq4vbLCLSde/D1xqBNl
	ZK9j241KLwvNl7GjccufGbExZjwVf5sQwRPBCPWKRupDS1lQqGjZDDaCauf+WV+lL+1rBYZdVlH
	f+dNSyutUPWC3DdwKvwRm15tD7jUjBsue1jP5gPEkHieww4sxx/PUKjT+mg==
X-Received: by 2002:a05:6602:24d2:b0:7e1:7e89:f6ee with SMTP id ca18e2360f4ac-7e8c19e5889mr41390239f.0.1716491411742;
        Thu, 23 May 2024 12:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhSPD+AgusmoyEntpTt+QVF+arFhJybZkLcPJDpGmVK5VS5TwKsy28Yil9Cvrm+Etg9zK/IA==
X-Received: by 2002:a05:6602:24d2:b0:7e1:7e89:f6ee with SMTP id ca18e2360f4ac-7e8c19e5889mr41375339f.0.1716491408191;
        Thu, 23 May 2024 12:10:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1f872cc61sm524714939f.12.2024.05.23.12.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:10:07 -0700 (PDT)
Date: Thu, 23 May 2024 13:10:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de
Subject: Re: [PATCH v6 2/5] PCI: Add locking of upstream bridge for
 pci_reset_function()
Message-ID: <20240523131005.5578e3de.alex.williamson@redhat.com>
In-Reply-To: <20240502165851.1948523-3-dave.jiang@intel.com>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
	<20240502165851.1948523-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 09:57:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Fix a long standing locking gap for missing pci_cfg_access_lock() while
> manipulating bridge reset registers and configuration during
> pci_reset_bus_function(). Add calling of pci_dev_lock() against the
> bridge device before locking the device. The locking is conditional
> depending on whether the trigger device has an upstream bridge. If
> the device is a root port then there would be no upstream bridge and
> thus the locking of the bridge is unnecessary. As part of calling
> pci_dev_lock(), pci_cfg_access_lock() happens and blocks the writing
> of PCI config space by user space.
> 
> Add lockdep assertion via pci_dev->cfg_access_lock in order to verify
> pci_dev->block_cfg_access is set.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/access.c    |  4 ++++
>  drivers/pci/pci.c       | 13 +++++++++++++
>  drivers/pci/probe.c     |  3 +++
>  include/linux/lockdep.h |  5 +++++
>  include/linux/pci.h     |  2 ++
>  5 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6449056b57dd..36f10c7f9ef5 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  {
>  	might_sleep();
>  
> +	lock_map_acquire(&dev->cfg_access_lock);
> +
>  	raw_spin_lock_irq(&pci_lock);
>  	if (dev->block_cfg_access)
>  		pci_wait_cfg(dev);
> @@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> +
> +	lock_map_release(&dev->cfg_access_lock);


This doesn't account for config access locks acquired via
pci_cfg_access_trylock(), such as the pci_dev_trylock() through
pci_try_reset_function() resulting in a new lockdep warning for
vfio-pci when we try to release a lock that was never acquired.
Thanks,

Alex

>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..482372f5d268 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4879,6 +4879,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>   */
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
> +	lock_map_assert_held(&dev->cfg_access_lock);
>  	pcibios_reset_secondary_bus(dev);
>  
>  	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> @@ -5245,11 +5246,20 @@ void pci_init_reset_methods(struct pci_dev *dev)
>   */
>  int pci_reset_function(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge;
>  	int rc;
>  
>  	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
>  
> +	bridge = pci_upstream_bridge(dev);
> +	/*
> +	 * If there's no upstream bridge, then no locking is needed since there is no
> +	 * upstream bridge configuration to hold consistent.
> +	 */
> +	if (bridge)
> +		pci_dev_lock(bridge);
> +
>  	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
> @@ -5258,6 +5268,9 @@ int pci_reset_function(struct pci_dev *dev)
>  	pci_dev_restore(dev);
>  	pci_dev_unlock(dev);
>  
> +	if (bridge)
> +		pci_dev_unlock(bridge);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_function);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1325fbae2f28..a3da776bf986 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2543,6 +2543,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> +	lockdep_register_key(&dev->cfg_access_key);
> +	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
> +			 &dev->cfg_access_key, 0);
>  
>  	dma_set_max_seg_size(&dev->dev, 65536);
>  	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 08b0d1d9d78b..5e51b0de4c4b 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -297,6 +297,9 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
>  		.wait_type_inner = _wait_type,		\
>  		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
>  
> +#define lock_map_assert_held(l)		\
> +	lockdep_assert(lock_is_held(l) != LOCK_STATE_NOT_HELD)
> +
>  #else /* !CONFIG_LOCKDEP */
>  
>  static inline void lockdep_init_task(struct task_struct *task)
> @@ -388,6 +391,8 @@ extern int lockdep_is_held(const void *);
>  #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
>  	struct lockdep_map __maybe_unused _name = {}
>  
> +#define lock_map_assert_held(l)			do { (void)(l); } while (0)
> +
>  #endif /* !LOCKDEP */
>  
>  #ifdef CONFIG_PROVE_LOCKING
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..e4e7b175af54 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -413,6 +413,8 @@ struct pci_dev {
>  	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
>  
>  	bool		match_driver;		/* Skip attaching driver */
> +	struct lock_class_key cfg_access_key;
> +	struct lockdep_map cfg_access_lock;
>  
>  	unsigned int	transparent:1;		/* Subtractive decode bridge */
>  	unsigned int	io_window:1;		/* Bridge has I/O window */



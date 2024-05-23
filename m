Return-Path: <linux-pci+bounces-7802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F28CDC37
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 23:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5787285DDB
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5097107A8;
	Thu, 23 May 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7sKBiYa"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B426E128363
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500327; cv=none; b=ZAHpUuWgekoapzuhGsFWi3+5hHxcRQnONX5x3QhXj/heTSLCQqb3GbOIfYsUyh/rVV8JcBqrdQDJCOKVJfw2JoHm6bQ2eLJE6h6cbjWhbIaCEPXfikcWAP5AeyLbXAV1WmsQKkJ6gA2+6+m+E6XKOf4Lm/RJEqfmuOjTR9wyNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500327; c=relaxed/simple;
	bh=Q+c2YMjmO8vdN8QLrUTZXTqHR1EGai+s5B4KneGQlB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPYQ/Kh0SDFCc/U62loshVvwsD5roqTn6fDyQqYH6/R6lR5J6hfXlYqlaAV8GLrS7dlcWS51GfkEFtqHFOtGClgj1vWd/Rd0w49y9h/JmVXKSKFrJW9mrYp28GWTg5cUOY/NG9C4M5IHP7Vz8e/1jRWBWHe5RTu4+xmPM83UJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7sKBiYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716500324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o5HP+0MqX2z44qSHTea3mYaXCgoy62GX3CuvevhGFI=;
	b=W7sKBiYajFbEUcmU1p/qJx2wtp7zK3PuuBORU7naEul6Q3eYoh9FBt7RdfHWNXc3vowB75
	MNq/Hf61Y1kO4/iDXvEg4f7n7jSZGNvk/FiVv34y6Cx67CZ7q/M6UuOKiEn4vFMX2LCLoZ
	rfkOWcLZZxodjwJAAhDtzt3l2wOytp0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-DXfUfNDEO8yefLRtXcQJdw-1; Thu, 23 May 2024 17:38:43 -0400
X-MC-Unique: DXfUfNDEO8yefLRtXcQJdw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so223380039f.1
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 14:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716500323; x=1717105123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o5HP+0MqX2z44qSHTea3mYaXCgoy62GX3CuvevhGFI=;
        b=XNU4Ssc5ukt5R+l0rhde/qREOklHToAHY3ZKucgGXKueX3pTDPF7883cyXLtKdwZZ3
         xKUhRj2atQ9/6f0ib/Yu2hpbgYcoVh2u/fjcH2+Uo/6zJ4oFnCA3tEjWyezrR2jixZ+S
         Cf/MJvf3gJni7hQLSXvqk2TVnI3cCZysvV37YinRhUgkD5n+bw4Z1O8BOEZjaEcyo2pj
         +UDtKs6safRbEr0uRI8ne4MQf6Ub/2b02hQNotidl8NghPjt12a9QVIhCLoK5tdt6nbq
         Jd+7KXzX8hq3Ci1tlxz3DZIYL3PVUTQpxZBNIjv0WhabqTJHpS9O6UpSmMQQHsJg9hTv
         wjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVXqzb70c647Hp1vzkxXbl5MVUNnXXpK5Lw53QpdB3k95gBy93LZWd7oNCW6JzQwVe3AW4FlwVoYlQh3e4DBd6iMduvgorZVkA
X-Gm-Message-State: AOJu0Yy6ID2bW/Me3RbYCOfO3e9c+ck5Zwiw6ifWhqGWHaFJSEs5f6Oj
	e5j5PeF0bZegAwfex+RBHocxLETqtR0LR7O1go+kCn6+CHwXAU8P6v6hHCgjcgx8rxnLcu7T6Kv
	0yVtoWsaOGajRBx9yUOt0RJdc1TDzxAjvkxW3qmn23RoFaABv56LnAMaMzA==
X-Received: by 2002:a6b:7e43:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e8c6c183aamr76819739f.17.1716500322687;
        Thu, 23 May 2024 14:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGifk9d+MfD2AFHnMnI801S7v/LhgxyOOXqYOMCa4unB24dBRc47U2Lkk9AateT6dg+Xjo3Eg==
X-Received: by 2002:a6b:7e43:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e8c6c183aamr76817639f.17.1716500322062;
        Thu, 23 May 2024 14:38:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03e8281b1sm66737173.13.2024.05.23.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:38:41 -0700 (PDT)
Date: Thu, 23 May 2024 15:38:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
 <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
 <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
 <lukas@wunner.de>
Subject: Re: [PATCH v6 2/5] PCI: Add locking of upstream bridge for
 pci_reset_function()
Message-ID: <20240523153839.16102e26.alex.williamson@redhat.com>
In-Reply-To: <664fb286639ed_195e29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
	<20240502165851.1948523-3-dave.jiang@intel.com>
	<20240523131005.5578e3de.alex.williamson@redhat.com>
	<664fb286639ed_195e29416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:17:58 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alex Williamson wrote:
> > On Thu,  2 May 2024 09:57:31 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > Fix a long standing locking gap for missing pci_cfg_access_lock() while
> > > manipulating bridge reset registers and configuration during
> > > pci_reset_bus_function(). Add calling of pci_dev_lock() against the
> > > bridge device before locking the device. The locking is conditional
> > > depending on whether the trigger device has an upstream bridge. If
> > > the device is a root port then there would be no upstream bridge and
> > > thus the locking of the bridge is unnecessary. As part of calling
> > > pci_dev_lock(), pci_cfg_access_lock() happens and blocks the writing
> > > of PCI config space by user space.
> > > 
> > > Add lockdep assertion via pci_dev->cfg_access_lock in order to verify
> > > pci_dev->block_cfg_access is set.
> > > 
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > ---  
> [..]
> > > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > > index 6449056b57dd..36f10c7f9ef5 100644
> > > --- a/drivers/pci/access.c
> > > +++ b/drivers/pci/access.c
> > > @@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
> > >  {
> > >  	might_sleep();
> > >  
> > > +	lock_map_acquire(&dev->cfg_access_lock);
> > > +
> > >  	raw_spin_lock_irq(&pci_lock);
> > >  	if (dev->block_cfg_access)
> > >  		pci_wait_cfg(dev);
> > > @@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
> > >  	raw_spin_unlock_irqrestore(&pci_lock, flags);
> > >  
> > >  	wake_up_all(&pci_cfg_wait);
> > > +
> > > +	lock_map_release(&dev->cfg_access_lock);  
> > 
> > 
> > This doesn't account for config access locks acquired via
> > pci_cfg_access_trylock(), such as the pci_dev_trylock() through
> > pci_try_reset_function() resulting in a new lockdep warning for
> > vfio-pci when we try to release a lock that was never acquired.
> > Thanks,  
> 
> Hey Alex, sorry about that, does this fix it up for you? Note I move the
> lock_map_acquire() relative to the global pci_lock just for symmetry
> purposes.

Thanks, Dan!  Yes, this fixes it.  Please feel free to add
Reported/Tested-by tags when you post it.  Thanks!

Alex

> -- >8 --  
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 30f031de9cfe..3595130ff719 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -289,11 +289,10 @@ void pci_cfg_access_lock(struct pci_dev *dev)
>  {
>  	might_sleep();
>  
> -	lock_map_acquire(&dev->cfg_access_lock);
> -
>  	raw_spin_lock_irq(&pci_lock);
>  	if (dev->block_cfg_access)
>  		pci_wait_cfg(dev);
> +	lock_map_acquire(&dev->cfg_access_lock);
>  	dev->block_cfg_access = 1;
>  	raw_spin_unlock_irq(&pci_lock);
>  }
> @@ -315,8 +314,10 @@ bool pci_cfg_access_trylock(struct pci_dev *dev)
>  	raw_spin_lock_irqsave(&pci_lock, flags);
>  	if (dev->block_cfg_access)
>  		locked = false;
> -	else
> +	else {
> +		lock_map_acquire(&dev->cfg_access_lock);
>  		dev->block_cfg_access = 1;
> +	}
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	return locked;
> @@ -342,11 +343,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
>  	WARN_ON(!dev->block_cfg_access);
>  
>  	dev->block_cfg_access = 0;
> +	lock_map_release(&dev->cfg_access_lock);
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  
>  	wake_up_all(&pci_cfg_wait);
> -
> -	lock_map_release(&dev->cfg_access_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
>  
> 



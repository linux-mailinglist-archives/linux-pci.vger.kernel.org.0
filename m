Return-Path: <linux-pci+bounces-37594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5958BB884B
	for <lists+linux-pci@lfdr.de>; Sat, 04 Oct 2025 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC7A3B1613
	for <lists+linux-pci@lfdr.de>; Sat,  4 Oct 2025 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5618EB0;
	Sat,  4 Oct 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA/VQWFg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797E1C27
	for <linux-pci@vger.kernel.org>; Sat,  4 Oct 2025 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543819; cv=none; b=MaCo6uOMaQ25eTw34iCiIFH7+Qt0rLPoP6KG5/CO7zfYczNPNb3M3j+9XKmOy7qaAiQlK3vKtN7aJ/i91uQnQT9pQpkp0MvSaWDgGr9zpjc1XW8Q3y9oWlfOdofcga6/7Uk05J77hYWF/HwcPHxCt3ysZn+W7B30bqUpJN9Gerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543819; c=relaxed/simple;
	bh=gxaPmCIQQMRFOi3Soy4h27vfD8On83p00azWe3RHjLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiYZpZG1iqvSFsLGdPF88lEvzYDCWMI3/vl/XtmiHMBLabbgWdO+pfUYut7/k5cP4I0FVjCbLK3pEdFxflEnULjQjQItaIGAQiNz0Ak6lJOEy7FHAhdNK4bfDJytoAu2/LZycEVKbyoeWBMrCAXLZAh5j7X1hIvUSOqLI3+4sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA/VQWFg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d3540a43fso28560495ad.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759543817; x=1760148617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQjbqLkRhbBe/lq2rN5ZJGKsuSM4xng+x8VlOH9wkK8=;
        b=EA/VQWFgZ5PCCVjLn6cz6BxlhV4oxCIuQOoabxKdJjytjvsUpFFQs3w1z29AWZGjkk
         /EOj06K7nAJV4n5tXu0GQkcY2znRFbIa1r3m0dqMxyr+N1dj7aAa77F7IWh240j2c2D+
         RP3BAc+Ylvh5nv/WfFOKDVsu9agLJlolA3zK1c+yD2GYn5vkcOEL0KLh5A2zMDbcBw4b
         8GKJtTlB9xn7EjLl/XeGy2YyRPqQUxut2a6SgEt71KHE696pi4suPUr734LroWwzlEVw
         1yOQHiQmKCbMPNPzyzrTeyyuioYhJPVatGu0gvbI8rFZH3GvIM0R1/qOqSrHULun3hqc
         nUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543817; x=1760148617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQjbqLkRhbBe/lq2rN5ZJGKsuSM4xng+x8VlOH9wkK8=;
        b=QSnDMrvxgOZwEXH5FE7dhqD+kRl+WX8IK8J/D8MKLtOebVT6X1vmjnoK+p8gmWa4Q7
         D3H4FPGvQh5ju9ooKKG/di4GjIjXkYcYGYl6iXDYPvQwR7hN5bS8OLe6+nwedB10HUAr
         bqf7PPfx1Qmhi8GsbVTBamiRJeVfggETIkAMSGlLFQPBo9ql7MJ3/0fAnRO2lMF5NR0g
         1XjSAZ1uvIJjdIl+Iu9H+ljboAwVqfwv7C0Vf457Az+XDhxe6oPTfW/UvyprfUdBYfDB
         CFOFkG0Py0mOKy0db65MOzCTi++v3/jtbUw9AuKlk1Usz6IhUg1/TSLG06Lnne0i36dj
         Cv7g==
X-Forwarded-Encrypted: i=1; AJvYcCXV6QeQvfaVI59FOrLxCJqaS1D/uPj1PdvSvcSy/ZMdmyWt0v9ss+XACyNAEy3Ck8fSBC+zvWdvg8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXycNsWlYkTsIqjRjI/3ZK2DJE0Tvn1lJTsQkvZfWVgbzhE9o
	SQ46EEZrDe4JC5WCAooIwKl0OC+NZNDpMkVH6cEZkrTHDIwY+M1xDWpj
X-Gm-Gg: ASbGnct03L2HwhEJ7VtS6AwqD9MVFFGFKIgfh0SWBTJw7vfMLhU1bWtHyeGJhIJxVzg
	F6bIe5NTOFikaU3UNUCYGsry64P4ZJNkdV9ATddLQnOO7gIc+25qZ12eIGqf9QqxST/AZHAT7O4
	iDBepGsiUNj8mWSM2KbI3eM6DKlD0hFOljkOFYLzahMExdZkCHMyRUAdBBX9gBFsYElU5EfLAZ9
	QegPNQI68o5vqETmPa6n7NN3qEbm5Sz5cyNO56zHJZztss7kL8rCBCYoABqJx4/XpKRhtbxlJmm
	B4BpV3NfyA7KlDE7hbq1d+JrrxpxymtPMt3MZsvux0i+Tzv1YUKpNHwl/l47n/1OGD9I+qHih08
	i5rL8Db+3Pj6fXeEpXPz5AFB8qdAIIKwIKK4HUhyBIDjwcw==
X-Google-Smtp-Source: AGHT+IESp4tnnumkx0BI5xrDTA1Eo90d2Rxad903UHQR5rZrldDw3rgJe8WFi9LVrQC81JWHf83r1g==
X-Received: by 2002:a17:903:41c9:b0:27e:de8a:8654 with SMTP id d9443c01a7336-28e9a674da9mr61847525ad.57.1759543816826;
        Fri, 03 Oct 2025 19:10:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-339a701bf31sm9391900a91.19.2025.10.03.19.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 19:10:14 -0700 (PDT)
Date: Sat, 4 Oct 2025 10:09:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, tglx@linutronix.de, bhelgaas@google.com, 
	unicorn_wang@outlook.com, linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <p6y3kmpohnx2b7dlj2pndrzlfosmketdfo2c33ukoqmgity2vb@oywnlt5vppkd>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
 <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
 <gtmre52no2rqbno2tkuh77a6kjd4i7hrjbmfenucduglgqv6hw@gv4idxswvyng>
 <b955d5a6-5553-4659-b02a-a763993fcd82@panix.com>
 <wfdzfzzemspxjecijckhrzurdfuxebnxff4lyyrcw4zrqcxio5@z4uaz3hcty6f>
 <69a89a6f-1708-4e34-86a4-f8f3a74e4da2@panix.com>
 <qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzogihz5oplw@gsvgn75lib6t>
 <7a21fb05-f7bd-4010-8488-10870b404bbc@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a21fb05-f7bd-4010-8488-10870b404bbc@panix.com>

Hi, Keith.

As I lack the information about the VMD device, it is hard for me to
adapt the change for new function set in 

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")

It is not good to remove the irq_startup/irq_shutdown callback and I
wonder a better way for it. Can you give some advice on how to fix this?

Regards,
Inochi

On Fri, Oct 03, 2025 at 06:18:13AM -0700, Kenneth Crudup wrote:
> 
> That seems to have done the trick, thank you.
> 
> LMK when you need me to test the formal solution.
> 
> BTW, the VMD has been somewhat problematic (for unrelated PM reasons), so
> I've added the/a VMD devel (David Box) to this discussion, in case you guys
> should sync up.
> 
> -Kenny
> 
> On 10/3/25 05:01, Inochi Amaoto wrote:
> > On Thu, Oct 02, 2025 at 10:36:35PM -0700, Kenneth Crudup wrote:
> > > 
> > > On 10/2/25 19:03, Inochi Amaoto wrote:
> > > 
> > > > Weird, this seems like affects more than the vmd itself.
> > > > I think I need to know hierarchical information of the irq
> > > > controller. Can you do me a favor for rebuilding a kernel
> > > > with CONFIG_GENERIC_IRQ_DEBUGFS enabled and check the
> > > > irq information under /sys/kernel/debug/irq/. Any of the
> > > > vmd irq and NVMe irq should show the information for it.
> > > > 
> > > > Regards,
> > > > Inochi
> > > > 
> > > 
> > > /proc/interrupts and egrep -r . /sys/kernel/debug/irq attached.
> > > 
> > > 
> > > Also, FWIW if I revert back to the commit in the Subject (but no further),
> > > and comment out the
> > > .irq_startup entry in the MSIX msi_domain_template struct, the system boots
> > > normally.
> > > 
> > 
> > I think I know why, the reason for this behavior is because I register
> > the irq_startup and irq_shutdown in the template msi domain, which is
> > called in the irq_startup() and irq_shutdown() and mask the enable/disable
> > callback.
> > 
> > And there is a diff for you to verify what I say (Just for verification,
> > not a formal patch), it should work for you.
> > 
> > ```
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 1bd5bf4a6097..8abca46c9b73 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -309,6 +309,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> >   	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> >   		return false;
> > +	info->chip->irq_startup		= NULL;
> > +	info->chip->irq_shutdown	= NULL;
> >   	info->chip->irq_enable		= vmd_pci_msi_enable;
> >   	info->chip->irq_disable		= vmd_pci_msi_disable;
> >   	return true;
> > ```
> > 
> > If this is worked, I think I should find an formal way to adapt the
> > new behavior. (convert this into startup/shutdown or maybe mask/umask).
> > 
> > Regards,
> > Inochi
> > 
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA
> 


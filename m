Return-Path: <linux-pci+bounces-36807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B341B97722
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CEC17D54C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480343019D8;
	Tue, 23 Sep 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLFqnU6d"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA82EBDE0
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658053; cv=none; b=ejsm33BxJ44LKcrOyAMLFiiIiFbR9WhGITLhwnAr9JRazFkhb/G7c9pUdmcEgenX9MXEK4a2nYNNCkaafgU3KsYIJJ8JNm45FXMDbmICdYl2RGBWxegdbHK94niCd7bUW6tGkBczRnR/w1mso9fFWIEB9Rkbl7DywUyGc+hfvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658053; c=relaxed/simple;
	bh=/cNMCmhs2+2GgzKjW2K7MV1lRjCXVMAS8z1dlxsrJ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFHtCmunNjDPdRP/dgaiHu9fsbkOH4h7u3KWNnjXWwD98O4+lIf3AZt1IlIPi/bjLXTjsKHixKW6Zm03tLs6N5pkloAlvy3fftmHJTDJg8VTClVVfgsEJ2aaqnFqWJl3dGoY5vXM+GVqysDOdpzwQeFBOGx8Ob41iK0sRKojBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLFqnU6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758658050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkF/1TIVCdQ8I35UWInq/5XGtjT7LO6t3DfocUuGzJk=;
	b=ZLFqnU6d+6znjZm1pAwJ06tM7mu3sevqZlUrT8MjnxwlkXnkTcyAXiAA6TG2ugWnXotjoI
	TdSoPOFUBZUupSa72gNvmK6pOUe++iUCJ2LAaZQ+ZbW03xt+Z/3dlVMHZjvF6jguJV9+zY
	anHh/hhO8vGM/0FtG3uQIIO8IH4Ytj4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8CimaSlfNRq09BJjDtaxHQ-1; Tue, 23 Sep 2025 16:07:29 -0400
X-MC-Unique: 8CimaSlfNRq09BJjDtaxHQ-1
X-Mimecast-MFC-AGG-ID: 8CimaSlfNRq09BJjDtaxHQ_1758658048
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8c24aa3f7f5so39434039f.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658048; x=1759262848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkF/1TIVCdQ8I35UWInq/5XGtjT7LO6t3DfocUuGzJk=;
        b=Ft/jOtGA2Rr9d2FQj4dGcv/HALuB7vkrag3BgP7bztRx3DC5fS16QsBCJ0GJ46D0Xq
         UMSiJ+54b0PmNRVOs8cXLyapfVus1UtVq2fA9fHN4725NxD31KnBOxrBthd+EkgTzfBr
         5ZL4BqY0QTExf1KjSyOiyf28zILx4hpp1sJd1Utouqq7vTfoc0eBWI1koWBrxVVf9oB0
         sE8mM9d84VG5IaLI+JqbXwkDuDXRD/0KaCz4kg4I7ys5QmCDC1IpiexCznOCuYAC5a8+
         NkAcl9KbLl9msq6zu80HKiPlfc0ylBRmsb4M0XOpvu8pm0yK2EIUnkAyqwCY+5VxeeXc
         TqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQTvOAsunypnRCItb0DeG43PiX4TY1ew3mXig6uTOJjXhaldrPfgyaUTRyI7HTOPhzJO+7U3nsP/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrHBnhvWnob4K5jSq7uEtTXg2N0GTbEx+KtpHVtBCj6EvVnDY
	3Vuhzi+JDCvkdxnt8/PaGZG+ewtyBliqCqAXUz3Fp0sSXnhnZdCyq8Q9+2DCdvNagSx2SVGEufI
	bwUbjeVl1XmosC5C2apwhhXxiZSTYWTB/ba8JAxLLdvJqhxOvHPPXxrn/RQKa+Q==
X-Gm-Gg: ASbGncsmMkK3+k+iFBw6lAHMG0wc9odTnGyZAzV4lbhfQNYhv6hdjvoXtobj5NdeKR8
	orHZp8jy7Gp0890HDOU4h4hZ7aRf2xdJchd2JP/xS9VP9Ui1EA5reJxmKTanumEjzRxIkYGScDO
	/iHi2b5NOLFt8HEPP/RJUMfMZSwE1Ghe+YsgxEARhaE4wayvDKodJUUvqCRs5rZuELqWfIEPaT4
	nZO8YmXZc/4IXX72y+4vEvpJ89LDnEduOQ5WUy6dsy6s5uih8oKSkcBLf+rK5WmviU20aafEjog
	DaPC2Hfv80aRC4908vWhPnnogVpH0WGxw6l9Jc80LFA=
X-Received: by 2002:a05:6e02:b27:b0:423:fd07:d3fe with SMTP id e9e14a558f8ab-42581e0924amr21638565ab.2.1758658048115;
        Tue, 23 Sep 2025 13:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmMxIqHNMDHwq6jPuldjwSxK84807XGPUliuEF5qCvF8SuPWmF0LqQLkrDELCWNHqAt6pi1g==
X-Received: by 2002:a05:6e02:b27:b0:423:fd07:d3fe with SMTP id e9e14a558f8ab-42581e0924amr21638385ab.2.1758658047638;
        Tue, 23 Sep 2025 13:07:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425813f3053sm15141865ab.21.2025.09.23.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:07:26 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:07:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923140723.14c63741.alex.williamson@redhat.com>
In-Reply-To: <20250923171228.GL10800@unreal>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923171228.GL10800@unreal>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 20:12:28 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:
> > On Thu, 11 Sep 2025 14:33:07 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Refactor the PCI P2PDMA subsystem to separate the core peer-to-peer DMA
> > > functionality from the optional memory allocation layer. This creates a
> > > two-tier architecture:
> > > 
> > > The core layer provides P2P mapping functionality for physical addresses
> > > based on PCI device MMIO BARs and integrates with the DMA API for
> > > mapping operations. This layer is required for all P2PDMA users.
> > > 
> > > The optional upper layer provides memory allocation capabilities
> > > including gen_pool allocator, struct page support, and sysfs interface
> > > for user space access.
> > > 
> > > This separation allows subsystems like VFIO to use only the core P2P
> > > mapping functionality without the overhead of memory allocation features
> > > they don't need. The core functionality is now available through the
> > > new pci_p2pdma_enable() function that returns a p2pdma_provider
> > > structure.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/pci/p2pdma.c       | 129 +++++++++++++++++++++++++++----------
> > >  include/linux/pci-p2pdma.h |   5 ++
> > >  2 files changed, 100 insertions(+), 34 deletions(-)  
> 
> <...>
> 
> > > -static int pci_p2pdma_setup(struct pci_dev *pdev)
> > > +/**
> > > + * pcim_p2pdma_enable - Enable peer-to-peer DMA support for a PCI device
> > > + * @pdev: The PCI device to enable P2PDMA for
> > > + * @bar: BAR index to get provider
> > > + *
> > > + * This function initializes the peer-to-peer DMA infrastructure for a PCI
> > > + * device. It allocates and sets up the necessary data structures to support
> > > + * P2PDMA operations, including mapping type tracking.
> > > + */
> > > +struct p2pdma_provider *pcim_p2pdma_enable(struct pci_dev *pdev, int bar)
> > >  {
> > > -	int error = -ENOMEM;
> > >  	struct pci_p2pdma *p2p;
> > > +	int i, ret;
> > > +
> > > +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> > > +	if (p2p)
> > > +		/* PCI device was "rebound" to the driver */
> > > +		return &p2p->mem[bar];
> > >    
> > 
> > This seems like two separate functions rolled into one, an 'initialize
> > providers' and a 'get provider for BAR'.  The comment above even makes
> > it sound like only a driver re-probing a device would encounter this
> > branch, but the use case later in vfio-pci shows it to be the common
> > case to iterate BARs for a device.
> > 
> > But then later in patch 8/ and again in 10/ why exactly do we cache
> > the provider on the vfio_pci_core_device rather than ask for it on
> > demand from the p2pdma?  
> 
> In addition to what Jason said about locking. The whole p2pdma.c is
> written with assumption that "pdev->p2pdma" pointer is assigned only
> once during PCI device lifetime. For example, see how sysfs files
> are exposed and accessed in p2pdma.c.

Except as Jason identifies in the other thread, the p2pdma is a devm
object, so it's assigned once during the lifetime of the driver, not
the device.  It seems that to get the sysfs attributes exposed, a
driver would need to call pci_p2pdma_add_resource() to setup a pool,
but that pool setup is only done if pci_p2pdma_add_resource() itself
calls pcim_p2pdma_enable():

        p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
        if (!p2pdma) {
                mem = pcim_p2pdma_enable(pdev, bar);
                if (IS_ERR(mem))
                        return PTR_ERR(mem);

                error = pci_p2pdma_setup_pool(pdev);
		...
        } else
                mem = &p2pdma->mem[bar];

Therefore as proposed here a device bound to vfio-pci would never have
these sysfs attributes.

> Once you initialize p2pdma, it is much easier to initialize all BARs at
> the same time.

I didn't phrase my question above well.  We can setup all the providers
on the p2pdma at once, that's fine.  My comment is related to the
awkward API we're creating and what seems to be gratuitously caching
the providers on the vfio_pci_core_device when it seems much more
logical to get the provider for a specific dmabuf and cache it on the
vfio_pci_dma_buf object in the device feature ioctl.  We could also
validate the provider at that point rather than the ad-hoc, parallel
checks for MMIO BARs.  Thanks,

Alex



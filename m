Return-Path: <linux-pci+bounces-37273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB7BAE031
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE58177FF2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74A2343B6;
	Tue, 30 Sep 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hW0AqKgz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BE2248A0
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248501; cv=none; b=GMVm8kAJ7ZoITGFE3COxl6tSLLgmcew3atgl5PsixJSm+IXlTooSZR7zXIq9/yIWxkIh16KAQ3nt9VxAgjng63mnh42GDCLad+VkPGmWykacvmkflnOaGxn6J5bIXEPHuZhS3+Xrhdbg2Y0e1qv2r4Qfa5mRcajypA5cq+92QYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248501; c=relaxed/simple;
	bh=snlcpuhg9ToSlXPE+QrSoUGnOciOVCfFz6OxetVNkco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf0BtFje5LT6zv1k/AbX3PP6iHJhGDqZpAaVT6Rtq3UPnt6rvEoa1UTTvq282v5Sewi/9ALHm1lb1f5t/s3FZY3rdJATJofwscQJSG6sKMLGPrJwUTOjlJ8YCjrp2pA0LUrj4sr5EqwXTUhsaOzsQ0fW5K2NJhkRwfMvKr5C+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hW0AqKgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSk9NtZOWjVSHAXaMNsatYeAsaJr+OLKF/ipGZAl/7o=;
	b=hW0AqKgzjYRoQhjuKFEcQ7xhnMnyMh8jyfQLbv8lkhDued1WbuFigohHJiLcIlq4d4QMem
	OH7dtaFxpjPcAhvMNzyDRDKHPnrHB/h3ZPpddPi2SbvhKfm5QN126L/xi99qIyfJ2/lM0E
	0EjWH7mbR5sejpoeg3QFAULw8O85rbI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-ykQgKCxgNhGD__yEOSmZug-1; Tue, 30 Sep 2025 12:08:04 -0400
X-MC-Unique: ykQgKCxgNhGD__yEOSmZug-1
X-Mimecast-MFC-AGG-ID: ykQgKCxgNhGD__yEOSmZug_1759248484
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7b30885170eso1098972a34.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 09:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248484; x=1759853284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSk9NtZOWjVSHAXaMNsatYeAsaJr+OLKF/ipGZAl/7o=;
        b=XGoqWosyroEVeP42fAd1UdIimVrqJ3C5VCVFd5LxdjVtDeszr2SnBYlAWBKutt03vF
         JNGO15ZcOAPPwozDI+gBhbgz8r01wmzuo2NTTlzxOgzYUdbGVlxzkVOK3IU8YkmRt4Hb
         C4hdRQhvL/FF/wHdZgkegUCXr9/Pl8Pgkdv18aYeBymZVF8mBmN79PnPBBN04+kHV6HQ
         YOclhO/ksFRiey8Wvoe5YTrIIy+Cd2yPyL4PAvlIRuSo878RUZ4i5EOY/p7sgmiXX2Pm
         Ot70R0emACjbyl9BGPssyYHrJN+dS/t+riO+SLelG6edbKPjWa9B9SDh2tYWDwCjiS8B
         +JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI7dnTS8S3x4XhksB2WKmK4XFq9FqAmPQ9rxtIIpNwf2WK6UXWTFV2CKPEVKizAiGGwqYP+DyXvu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyf+N1xBmc5ISOAP4rpUTNhcAVe4+S0o9XODlJMkmbNObtj7I
	Mc14OO7+UikqYjiMJ7OhRLsVvKxg8UgdUqRjm6qYNKkphf9mAEq/kTCNIdAJ9wGpiXXppGl3BsB
	KgM4zOgDuA8861vrIIcw5RMUc3UqMorvUmS7RHeIOe6LJ7GYu5Rv0ZRobxh0YBg==
X-Gm-Gg: ASbGncuzcAndbPLVVXDYSwTPYO3zhUccDN5qConanjovMeRQFsP2ZINPFDjCMMKQerP
	hwsxAO6cDEGE52nPw5ni3tDSJ10a/C/A9sunImwL5m0jUt+RcbD+lFtJXtrNK4e2zOtzQyTuKXU
	iiUmE1lmFBAUwU2XDCfXFImGRAm5EDY2blPAubi0yl61nlJhLK8+uQytGRYuLdw2xtsdMyy36rI
	NpdA7yghgKvQIgwZgz3g8rLwOHZh4gneWYTxC1u2qYWsOduxPR7nvFnU2vJC2RMN/nuNPXPu6q8
	t3wY3hW0Bkp22vIec6DZQY+K//TT8eFPOrEY7pqpDNesrVnG
X-Received: by 2002:a05:6820:5082:b0:621:2845:6daa with SMTP id 006d021491bc7-64bb6545f8bmr113859eaf.0.1759248483601;
        Tue, 30 Sep 2025 09:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJseUyrGoKfdwzuhrG64O9kfcQryt5nehwMqyr+Cc6sT4mD/DyY2Du1MoSsHbbw6RCv1mcDg==
X-Received: by 2002:a05:6820:5082:b0:621:2845:6daa with SMTP id 006d021491bc7-64bb6545f8bmr113843eaf.0.1759248483252;
        Tue, 30 Sep 2025 09:08:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7b4c0e92da9sm1836631a34.26.2025.09.30.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:08:02 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:07:58 -0600
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
Subject: Re: [PATCH v4 07/10] vfio/pci: Add dma-buf export config for MMIO
 regions
Message-ID: <20250930100758.1605d5a5.alex.williamson@redhat.com>
In-Reply-To: <20250930075748.GF324804@unreal>
References: <cover.1759070796.git.leon@kernel.org>
	<b1b44823f93fd9e7fa73dc165141d716cb74fa90.1759070796.git.leon@kernel.org>
	<20250929151740.21f001e3.alex.williamson@redhat.com>
	<20250930075748.GF324804@unreal>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 10:57:48 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Mon, Sep 29, 2025 at 03:17:40PM -0600, Alex Williamson wrote:
> > On Sun, 28 Sep 2025 17:50:17 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Add new kernel config which indicates support for dma-buf export
> > > of MMIO regions, which implementation is provided in next patches.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/vfio/pci/Kconfig | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > index 2b0172f54665..55ae888bf26a 100644
> > > --- a/drivers/vfio/pci/Kconfig
> > > +++ b/drivers/vfio/pci/Kconfig
> > > @@ -55,6 +55,26 @@ config VFIO_PCI_ZDEV_KVM
> > >  
> > >  	  To enable s390x KVM vfio-pci extensions, say Y.
> > >  
> > > +config VFIO_PCI_DMABUF
> > > +	bool "VFIO PCI extensions for DMA-BUF"
> > > +	depends on VFIO_PCI_CORE
> > > +	depends on PCI_P2PDMA && DMA_SHARED_BUFFER
> > > +	default y
> > > +	help
> > > +	  Enable support for VFIO PCI extensions that allow exporting
> > > +	  device MMIO regions as DMA-BUFs for peer devices to access via
> > > +	  peer-to-peer (P2P) DMA.
> > > +
> > > +	  This feature enables a VFIO-managed PCI device to export a portion
> > > +	  of its MMIO BAR as a DMA-BUF file descriptor, which can be passed
> > > +	  to other userspace drivers or kernel subsystems capable of
> > > +	  initiating DMA to that region.
> > > +
> > > +	  Say Y here if you want to enable VFIO DMABUF-based MMIO export
> > > +	  support for peer-to-peer DMA use cases.
> > > +
> > > +	  If unsure, say N.
> > > +
> > >  source "drivers/vfio/pci/mlx5/Kconfig"
> > >  
> > >  source "drivers/vfio/pci/hisilicon/Kconfig"  
> > 
> > This is only necessary if we think there's a need to build a kernel with
> > P2PDMA and VFIO_PCI, but not VFIO_PCI_DMABUF.  Does that need really
> > exist?  
> 
> It is used to filter build of vfio_pci_dmabuf.c - drivers/vfio/pci/Makefile:
> vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o

Maybe my question of whether it needs to exist at all is too broad.
Does it need to be a user visible Kconfig option?  Where do we see the
need to preclude this feature from vfio-pci if the dependencies are
enabled?

> > I also find it unusual to create the Kconfig before adding the
> > supporting code.  Maybe this could be popped to the end or rolled into
> > the last patch if we decided to keep it.  Thanks,  
> 
> It is leftover from previous version, I can squash it, but first we need
> to decide what to do with pcim_p2pdma_init() call, if it needs to be
> guarded or not.

As in the other thread, I think it would be cleaner in an IS_ENABLED
branch.  I'm tempted to suggest we filter out EOPNOTSUPP to allow it to
be unconditional, but I understand your point with the list_head
initialization.  Thanks,

Alex



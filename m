Return-Path: <linux-pci+bounces-33489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E07B1CE93
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C16D563C0C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051722F75B;
	Wed,  6 Aug 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE3GN6TL"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5822C35D
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516542; cv=none; b=ROYn7fSVUJeIxYJYYA3/0x0tSP+sqFkFXgE25HylvrPh6kUDFzx/blwuE/zFDzlWYTV0iFsHkqKoQ2Z9KdLfs5GzBnIJr5g7koUCVu6s+kkNo8EX3iWMuitR2RWgg7BXEHA8WuMVLwBrTA87+YdJzI5LKDJEQWGTx68uxN3FwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516542; c=relaxed/simple;
	bh=u5wJkgayWtoH/wDIjbh042FOJb9qmim8x01zf6tfYcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSSRi2Lkdvs7nscFk2DziudsyX566EXT68cq6qPlicqiiU2BLYzKIbdp6zJC8NPdyiUeLfdQ4X06akw9o811WzRQXGF8DeRBOnRoIvLmIs0TgH9K/SD5QyI+MH8r+X0LO8fepfhP4sMx3L2QC765GSyW+Fxfcm6RgFkwgl7nQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OE3GN6TL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754516540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEyeHS4HV3rZ/wSqVLFMAOzjnboPPP41DAzDFsrqTZs=;
	b=OE3GN6TLpBLEBrJyrryxB2GnZdeFZ8p/1nKKy9W2TMUmRak/2ofbmrq5xOp8IaapvxOP3j
	7ib0etQpkD2Mfq8KzasnyuslPhleGCv2EPeHdw7a7rbtAZzirvHdPwhZTDOApNGyJdxb89
	aPhNq7bOpqpyOcHf2uavZ/rSXAPLc/k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MfkU3seoNzKhuWcy2Rvzxw-1; Wed, 06 Aug 2025 17:42:19 -0400
X-MC-Unique: MfkU3seoNzKhuWcy2Rvzxw-1
X-Mimecast-MFC-AGG-ID: MfkU3seoNzKhuWcy2Rvzxw_1754516538
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-742e3d0ad61so22633a34.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 14:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754516538; x=1755121338;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEyeHS4HV3rZ/wSqVLFMAOzjnboPPP41DAzDFsrqTZs=;
        b=WRlHopOWLVftI94wjC0KyN3vuWBqYXOBZRjEQslRZjDPWU21MgREsWHT52eS6AIrPJ
         OiGv0N6J+RVzahU/VGPFkWpG4k+v4c6cfL86zHLi2Z1MJoB5amyErP2wJ135vYvDVgkp
         vOWcib8lbZpPpBspVTrdWP6Sg+vRq/8AqtMY81f+oSlk3NVbCpsLDT5595EPPVdZB8nz
         4oww6Bkp0KabQ8o8dpGue/DoHJ4A1Jlg0kDDv+c55iREK1L4/V5l17qxYwdteKozx3lZ
         5zyvddcnYsnfjSk5OpkqtpvQLw008emSlPmo0fVpLJVPhmqlq6Xn3NTKx0MuHQAEw6Kb
         ESLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1jxjIccEKQ4LSLqHcFn96Aqeoq7Ldnr7bdbuoLMqg0NESgk99ORJaCI7ErprjjHXO1xMB0tTVBBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxnv07D/pT9XOjMHbIumjlFqg+jdYzZrpytUD17grHAbfbpJ2
	PkvIFSV3WPDJsCiAVVTulX2AWXJGY20XvUDik0rOHkAfLamTSA/rqw8VmzPpM2SNFl3j7zcjJ4a
	mxGeHiYDDBWV0IfElrmpwriNApnsya/3p7qO9xrK1fJ7ag1IHp7rC27pKCnhignM4rEhe/w==
X-Gm-Gg: ASbGncu0gyTJ6G7IUOBKISqbRBS13Z5EZW5HMN846tuuiXOb0iCOJok39N3mfoM0lPi
	dPCN5YT/tutRjP2HvTysQiDKipARdD3h+P2cl0ZXvf1/ddFd370kF3ef49Lj9ikUn4xUSnPjusT
	9F2ZApIkdBt34pbHzeQO+GgGRYve0w1WawT+5Gpgvos5TcgdfhVqd2KSLunK843xcocZSnCck9x
	HKh57DrE3EuyNLmGYCW3lsXPs5LY0DEtXAOVB/tdfoZIXcpMBO7KB6+cD590l61MlZZdZgijXhG
	BbGKAus6uQYyrpqeSSiPui6z2Nwx+IHHccrONJJ0w0M=
X-Received: by 2002:a05:6830:3145:b0:741:a217:720f with SMTP id 46e09a7af769-7430e2000b0mr942362a34.2.1754516537609;
        Wed, 06 Aug 2025 14:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5QU5ZQlpYSxfTPMUFCWfqP/wnHyNw5oOZqDg/+tC9OzPbWJoK2cj/jTsdC9+aUwDUHNbnjQ==
X-Received: by 2002:a05:6830:3145:b0:741:a217:720f with SMTP id 46e09a7af769-7430e2000b0mr942353a34.2.1754516537077;
        Wed, 06 Aug 2025 14:42:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186cc4e1bsm3606901a34.21.2025.08.06.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:42:16 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:42:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 04/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250806154214.1c2618e8.alex.williamson@redhat.com>
In-Reply-To: <cab5f1bfd64becafcc887107bb4386f2c8630ef3.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<cab5f1bfd64becafcc887107bb4386f2c8630ef3.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 16:00:39 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Refactor the PCI P2PDMA subsystem to separate the core peer-to-peer DMA
> functionality from the optional memory allocation layer. This creates a
> two-tier architecture:
> 
> The core layer provides P2P mapping functionality for physical addresses
> based on PCI device MMIO BARs and integrates with the DMA API for
> mapping operations. This layer is required for all P2PDMA users.
> 
> The optional upper layer provides memory allocation capabilities
> including gen_pool allocator, struct page support, and sysfs interface
> for user space access.
> 
> This separation allows subsystems like VFIO to use only the core P2P
> mapping functionality without the overhead of memory allocation features
> they don't need. The core functionality is now available through the
> new pci_p2pdma_enable() function that returns a p2pdma_provider
> structure.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c       | 118 ++++++++++++++++++++++++++-----------
>  include/linux/pci-p2pdma.h |   5 ++
>  2 files changed, 89 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 176a99232fdca..24a6c8ff88520 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -25,11 +25,12 @@ struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
>  	struct xarray map_types;
> +	struct p2pdma_provider mem;
>  };
>  
>  struct pci_p2pdma_pagemap {
>  	struct dev_pagemap pgmap;
> -	struct p2pdma_provider mem;
> +	struct p2pdma_provider *mem;
>  };
>  
>  static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
> @@ -204,7 +205,7 @@ static void p2pdma_page_free(struct page *page)
>  	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
>  	/* safe to dereference while a reference is held to the percpu ref */
>  	struct pci_p2pdma *p2pdma = rcu_dereference_protected(
> -		to_pci_dev(pgmap->mem.owner)->p2pdma, 1);
> +		to_pci_dev(pgmap->mem->owner)->p2pdma, 1);
>  	struct percpu_ref *ref;
>  
>  	gen_pool_free_owner(p2pdma->pool, (uintptr_t)page_to_virt(page),
> @@ -227,44 +228,82 @@ static void pci_p2pdma_release(void *data)
>  
>  	/* Flush and disable pci_alloc_p2p_mem() */
>  	pdev->p2pdma = NULL;
> -	synchronize_rcu();
> +	if (p2pdma->pool)
> +		synchronize_rcu();
> +	xa_destroy(&p2pdma->map_types);
> +
> +	if (!p2pdma->pool)
> +		return;
>  
>  	gen_pool_destroy(p2pdma->pool);
>  	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> -	xa_destroy(&p2pdma->map_types);
>  }
>  
> -static int pci_p2pdma_setup(struct pci_dev *pdev)
> +/**
> + * pci_p2pdma_enable - Enable peer-to-peer DMA support for a PCI device
> + * @pdev: The PCI device to enable P2PDMA for
> + *
> + * This function initializes the peer-to-peer DMA infrastructure for a PCI
> + * device. It allocates and sets up the necessary data structures to support
> + * P2PDMA operations, including mapping type tracking.
> + */
> +struct p2pdma_provider *pci_p2pdma_enable(struct pci_dev *pdev)
>  {
> -	int error = -ENOMEM;
>  	struct pci_p2pdma *p2p;
> +	int ret;
> +
> +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (p2p)
> +		/* PCI device was "rebound" to the driver */
> +		return &p2p->mem;
>  
>  	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
>  	if (!p2p)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	xa_init(&p2p->map_types);
> +	p2p->mem.owner = &pdev->dev;
> +	/* On all p2p platforms bus_offset is the same for all BARs */
> +	p2p->mem.bus_offset =
> +		pci_bus_address(pdev, 0) - pci_resource_start(pdev, 0);

But not all devices implement BAR0, nor is BAR0 necessarily in the
memory space, wouldn't this calculation be wrong if BAR0 were
unimplemented or an IO BAR?  Even within memory BARs I can imagine
different translations for 32 vs 64 bit, prefetch vs non-prefetch, but
per the comment I guess we're excluding those.  Thanks,

Alex



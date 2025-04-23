Return-Path: <linux-pci+bounces-26603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D7A997A7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A34A2CCA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46028D82B;
	Wed, 23 Apr 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dzaUhanA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64128CF7F
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432230; cv=none; b=uMfO0IoDwwu9LB335c366F7VLyXl+yyIyycsrx7dhbZz/kBeDX+/HDcZntzGk7kEBdiEkgUA+UzgzlJhtf5easebwhbBLnujhPHtXb5bMDRTHgYm2Rx9FlcUURfqTrqLuqaUYfc4VT9P4RTcQwLDsW55vAZYD5dC3TO2iC0Wbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432230; c=relaxed/simple;
	bh=ZwDA7dKaeXsaxB3idhnk/64Z7wWQuL5MluTl3MVfp1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afTi6U7iPfZP17zjAFq5kEK+aLL2fpZIWROdXxmSIAW2hY554cFTfeRQbKaByMi26OkD/3ceyJlVIiF2ZiDALaaSIXpsHSxLgMuXreGmp7LhqSBJORKOCr0mPmiAd1wQnvgb78xdon5Fr8f7V1wgvhykCo+oggPcWtMIAjC1kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dzaUhanA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47663aeff1bso1561711cf.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745432227; x=1746037027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=dzaUhanAGnWmjNzX6EyAJDr56KrTb45PN/EThCXWubagFRugBhYwJihgbUIyGS7Oy1
         7GCzjFgYzXJUcXpS8X+v0qNySEabX0xTyun1iMVdJj3qj7/oFbt6x+cURruzijRAYdDk
         zJXE80/VTSJyoH+CBJNYr9Vdstbr/gur7d8cvS2fLvOMqEGRPHY5k6Y6gLOO5/5May8s
         H49s9x4oaXHEAdgo7tHaFvKLT9alL5RGrDTb+nerpdzTtDdRYFk429vfBzWlKvfpumte
         pXaxpLOcpJsZjP3xS3wk5BUoqNCzCRTm/fkrFCf4Nifmgv7OBgK+QHEISYKhL//7rMfK
         9lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432227; x=1746037027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ8s1tHlAlZHZLBcym34Knli5JlhGSSEZ8s9pr2exho=;
        b=UF+g8p8MrWhQLEau/VATrctyeeShB8Ai2/eSKTQXuoeEIRseKMN8NFAHjUkpopmbaG
         OCui7DW6xBnuLlIzros1NpxWsYI+4W7cStDNycWbQr7O1MrlwdK03/m3nyl8dgLQvbMN
         mhb62xlaSpIwnfKYtHNqJNJX6igSv0aWAOVUD82ZtK3stWzYWEiYxdkwUH0qG1foDous
         BbZulb/Zu4gdvgJGDX7wkb5yazsTxC9pmhcirbe7EF9S3Zj1I8a2WGvfecKVWcMJe98S
         fvbTzhj5MDJhGh2gLWqzxEf9+HBJl26Hq1ePumvAIhojTNVX9qHvcvtpxSLpTrNjjC30
         TMXA==
X-Forwarded-Encrypted: i=1; AJvYcCWyUs1PkbBQBYu49nsd+kJ+LNho/dyaa8Z5534S4LocM9Y7BglaQDR54JTCdpLZt8D537OKSg7evTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcnWmgLReGf9reMSRCB4d/oDka++Sudpb8UGl+bXSbXc4gWrb
	nsifgAndCm9UqsInib1VWc9t6RYKReOuX6R73zyoIxRwZ07+e57wljk1QInh3Kc=
X-Gm-Gg: ASbGncsrNBN2LTHKKJuYUDh+r3c1qn/FNkpNnS8ijo8NoRQ9K956PoO7fPATy2LAWmn
	liohSp+9/AQ1ZzeUAi+LmL2gkdRiDrH2zICCJNHwk8eNS+DsFoS35uXXjxuAaUOIypmCraA9+7v
	/tjknz0yTSqjdSkCKOQCyEJbKZUWec3uWxogQpl+m9ioQWjBdSEZlWfBUbYBR7qU78dmGnQ9bWe
	OD7rpiFMDssIJPRGyOlyv+O7++oyXqaePVOIQSpG0eREcPBbshgmKB2LgCe9z0yK/IYHPoR/5Th
	vQA6wmQfRWzP/o0FvuW753oY+PVxkbu0Aqy09aLIBvcrbetvdzeAD/pwZ9zQjqVQSwh1lZhYCLX
	9rdBrhzb8fnuJJ97DfYA=
X-Google-Smtp-Source: AGHT+IECPlcFTYHnkwAKKk3B5MzEp2J+Q23qmmOis8VDE/Xdu9ZIh9LzQbjBc0+xoVESECxntDW6lg==
X-Received: by 2002:a05:622a:d4:b0:476:95a2:64a1 with SMTP id d75a77b69052e-47e76175c16mr4073601cf.17.1745432227237;
        Wed, 23 Apr 2025 11:17:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c16dd2sm70921841cf.14.2025.04.23.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:17:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eeg-00000007Lzi-1CSb;
	Wed, 23 Apr 2025 15:17:06 -0300
Date: Wed, 23 Apr 2025 15:17:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423181706.GT1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>

On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
> > @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
> >  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
> >  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
> >  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
> > +
> > +	/*
> > +	 * Sticky flags, carried from input to output,
> > +	 * don't forget to update HMM_PFN_INOUT_FLAGS
> > +	 */
> > +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
> > +
> 
> How is this playing together with the mapped order usage?

Order shift starts at bit 8, DMA_MAPPED is at bit 7

The pfn array is linear and simply indexed. The order is intended for
page table like HW to be able to build larger entries from the hmm
data without having to scan for contiguity.

Even if order is present the entry is still replicated across all the
pfns that are inside the order.

At least this series should replicate the dma_mapped flag as well as
it doesn't pay attention to order.

I suspect a page table implementation may need to make some small
changes. Indeed with guarenteed contiguous IOVA there may be a
significant optimization available to have the HW page table cover all
the contiguous present pages in the iommu, which would be a higher
order than the pages themselves. However this would require being able
to punch non-present holes into contiguous mappings...

Jason


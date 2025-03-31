Return-Path: <linux-pci+bounces-25016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCABA76D56
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686FC1886870
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C87217647;
	Mon, 31 Mar 2025 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lx5B0Y7s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9C215064
	for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448253; cv=none; b=H6hu2Mr3XHXMsxTo7AlXj72RBLjfyi1x5BHnbwgorksQLg50PtL765Mh1KvIcNx41ZGamgVDxjVU1XUoYVBgTpYMfRW7NQ1koW7zrLO7o3h2hnlSVpqsPZjmIyIMYc6ciQe/bHk/wrKNPWK+IFidqftwrUH4fqKOKCLkE7NbpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448253; c=relaxed/simple;
	bh=YZzEwSKb0kqBKb0A2H4+zAX/AS8Wvht4a2tMV6ys5+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heXaDGBoLRaapheoUvyDfdUtLilL6CmqXT3tLxiViY3XFI08l8YP6cauIQXp3oPpUziS0rwVpGKDLdEz//Zv6sniT5rFThr5qwoBS3wKEkl1RuYYMTs79QurGBL33FO1ZWflgHmiYXdM2byy2o3g3WzTSz4NG7YWX3VwTkVcIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lx5B0Y7s; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4767e969b94so33691941cf.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743448251; x=1744053051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=lx5B0Y7sjuoNzd1d9i0ULXlJuFWlw50miz8KET6BzT5VFVWlzWti1qBXbQ3xuU4G7S
         A0CO1k0tWEEysAcdeEJMmzTgXuug9Tc1daOkdBpqiD2jzT05mPtSNgKzPH2cZV9ahGwA
         A7g/fFs7CmBaUimn9ZX52UpMrKMpVDrJPCb+HdorFxqJYgVhyTyJ9PoymkPKE5o2pFMe
         CDhKqsIjTiKcHwVBYWLXeoJLL+e/Lnx7AwpRGoqh8/hUOocZ4Hnsld1GswY2P9cgw/QC
         qxiFtbgZADqRhS0k/V/eVWP6yr4EleWUUOGLhuJfQuoPs10ZrsL7SnyaUgZ0R6HTG4q0
         i/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448251; x=1744053051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=akUKLFjUQ3b9HKV9RwO5Hh0db/R1J3LexLupoR+Fl4XaXjRKVHls8JKihspAGuIK1M
         BFXNPa2fV/V5sj+uwTYretl/Di4T16J89E5JLBSRhsC8UaN/jFcFZF5IGUjytperFcoJ
         cK94wwM635XqVOZM0Sm4jn8ZYNyyIagU0XZ9FQWCQTR8Z4DriyZ+m+9Ajlw21d4/bKGH
         5UCRZsLW3UGb0wCXhd+a60ii+gUCjvQI+EkFajPz0qO2QcBnVnXkIqMxHC3nCvqcSC4F
         /DP/sWv/XI556AQfbXQgEY7QsMjo2XlwbXse7Ttp1k4Nqx5l3OKMmwhul0SSTtHeEIeZ
         ANHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7vzT5aojSgpqAk2ibMcpFT3H2hhe2IqI9MHfsoDCMFJonyYdMlZ7n6JdAxj92pekNtKRCmQTwi0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTH32gwp9CCc9EWyumlrk6K518tLXigF17hDPOMPzPSGKkZ5M
	1tGEbd7nvkUFSiRe+bcyrXkRFyne0jvlcNXMDGcb4nJo+2g3H3bLY3Lej0fVhCk=
X-Gm-Gg: ASbGnct/cZRyjPtRhSs32KGvb/eFqs7BQHepECFBSyYPH/UBAWw32XtRUNNCCN9Ue8c
	3ijx31eC8HRNTG9f/2TzzaPCyoOxm5SYya5mX9rFzplGDC81W720bsI5AY2UDf8bu5UfS6yO4MZ
	CdSZfIZolCz+OliZYZAI5s2Kz8wscV1WeWDJ8zq/kfjkNXrR3rztIcw5GjNgr0chEdulrotXopV
	zY9o9SeMH3tHdweJ2ftWWV/PPyNQgU2WQHk1/5PY1fnf8rnu2E1yq7K6RK0gMm3/UmDrgQtMTAK
	cLQrQ0eUiBvE5AZbquW8D3EixVv1iUQSLihhe0id6E0Zs8CdURrNvNek9yS2rSIJazdw5Xv3XyS
	tWpcQ2Aj77pE3GnJijeZ4mUs=
X-Google-Smtp-Source: AGHT+IEZHkY9cceG9Xv7rEu7PB72dn7pTp6BwVJLHoJ1MHilW0TdQewa+AGCIOjjtFFGEUJX/PJSGA==
X-Received: by 2002:a05:6214:19cd:b0:6df:99f7:a616 with SMTP id 6a1803df08f44-6eed5f4e587mr150303596d6.2.1743448250916;
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9797136sm49986056d6.103.2025.03.31.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzKX3-00000001EjT-33eb;
	Mon, 31 Mar 2025 16:10:49 -0300
Date: Mon, 31 Mar 2025 16:10:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250331191049.GB186258@ziepe.ca>
References: <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
 <20250319175840.GG10600@ziepe.ca>
 <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
 <20250322004130.GS126678@ziepe.ca>
 <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>

On Fri, Mar 28, 2025 at 03:18:39PM +0100, Marek Szyprowski wrote:

> What kind of a fix is needed to dma_map_resource()/dma_unmap_resource() 
> API to make it usable with P2P DMA? It looks that this API is closest to 
> the mentioned dma_map_phys() and has little clients, so potentially 
> changing the function signature should be quite easy.

I looked at this once, actually it was one of my first ideas to get
the VFIO DMABUF side going. I gave up on it pretty fast because of how
hard it would be to actually use..

Something like this:

dma_addr_t dma_map_p2p(struct device *dma_dev, struct device *mmio_dev,
		       phys_addr_t phys_addr, u8 *unmap_flags, size_t size,
		       enum dma_data_direction dir, unsigned long attrs);
void dma_unmap_p2p(struct device *dev, dma_addr_t addr, u8 *unmap_flags,
		   size_t size, enum dma_data_direction dir,
		   unsigned long attrs);

Where 'unmap_flags' would have to be carried by the caller between map
and unmap. mmio_dev is part of the P2P metadata that dma_map_sg gets
out of the struct page via the pgmap.

unmap_flags is the big challenge, there is not an easy data structure
to put that u8 as a per-call array into in the DMABUF space. It could
maybe work not bad for VFIO, but the DRM DMABUF drivers would be a
PITA to store and this wouldn't be some trivial conversion I could do
to all drivers in a few hours.

But, the big killer is that such an API would not be suitable for
performance path, so even DMABUF might not want to use it.

If we start to fix the performance things then we end up back to this
series's API design where you have the notion of DMA transaction. The
more of the micro optimizations that this series has the closer the
APIs will be..

So, IDK, we could make some small painfull progress for VFIO with the
above, but replacing scatterlist would be off the table, we'd have to
continue to live with the DMABUF scatterlist abuse, and there is no
advancement toward a performance struct-page-less DMA API.

Jason


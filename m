Return-Path: <linux-pci+bounces-15946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D344C9BB489
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A1B255D4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB915C139;
	Mon,  4 Nov 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bU/bwQTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62541B4F17
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722770; cv=none; b=RyEZqRxvNxZoPgP/G0l9LgtKllUNP9NemeYNqTIvBnxsmSZgZLbsj4GkTMS6Ao6ngU89z1Vw183oh39TKbmbrYOSl1wUz7oqhYibwezcMsW6sLOtEzKIUNir+03CcVle8gJloKkGHKa7IwmKtAKPTYN+5KR/cdkLJ6eYFNB05Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722770; c=relaxed/simple;
	bh=WafvJUVr8z2C1zDRQCvtKO+6K1W+UrIoTEdLDQdvuUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCW6e9RoABZNNPoHoy0z4F9lN/TiOtQH54m8rOFxQfrEF4Z48gNghBo2jj9pLvEGKn1rV920w1EuE7SaBuH5rxgucvmx0a0d2D6lWtdQzsY+gdRlbAjKbpXXmJV4Vf1IOlSCPNl81dZTbFyltEb19XViv2wMYeML6uddFaQiONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bU/bwQTR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d36f7cf765so14328466d6.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730722767; x=1731327567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=bU/bwQTRIAnSnu3ity+sjC0E2sq7Lx/G0WwuhQK1tFta0i+JHHb4ZgDaI+BwMp0GjP
         mTuJkPdog3bS5cRlvNdXCOGo6r9C6lL8DpawfLdS9WQBuXkSkb3uRvVJ+3Jft2TU0l4z
         Z7KQQ+bkelEINXuk6QjGwNJ1comMgCWJsIkvNFZ5eRsjDjojgELoEC7yc5lG8mAlNej8
         74E5s7BmIpYr0/slUqyH43XmVbIAUeR4ArRinA/7yHVjpHr70CAydaCZc60vL5kQVRHN
         60rPc+umLegF9M1e2Yl3TaNdXedLwfhi/5tJn9HzowNouiuDeuDVDwHWq3Uougepuohw
         t3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722767; x=1731327567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=f+p9wbNM+P1cY7ZsNAfnvQbzJ/oTTFYobefzwjp9z9+6aTqQmTrlpdVsoP5AqPSKXO
         jJQFgtjYP+RRcOgEpPf2x0768/Gske/JMfMP4wXXCsnwkEmu/QajTyQuvEHcALz37cOH
         5z81zas4JQJ4eeDJ7ObY9dYORbG9PZon6QJf3amqozfpOh+6Ge94aeFNiLA//Hs0Y2RY
         KUGFChyffl/RjSVJwKn/l2MP4KPN9wJzq+pgia38qhEt0KVM52B/+BH4XPltPUj5PIR3
         3BqeQhkIFyTO2CBcPOvKDyU4izjGdafLUKbg4cVz6Yt6S7iyNU756YkAoezuWVUhlYVM
         vCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPZVGwXNoPfA0UBSqADpXxs3FJzvlCRKePMKzSi7+Stt5G1Rb7/uw5ySfIRfHHDxj91B6rgUcYDaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKwVMeKe7LkZC1IvpVeHtqbdq/pBJ5b3jiGbiHulSF41xJ3xx
	SDDR6UcZ2aqAOmp8psz5QhlZ27ZewKhPFtHE3TeuWudCO9bvuz1v6ucx/1lQgDk=
X-Google-Smtp-Source: AGHT+IGGw97HgDqXEc70DPdglFSAiLC2/hvL6iix2sWZheUlrSMhSyN4gGvDNAQMyTZfPVibvICZkw==
X-Received: by 2002:a05:6214:3a8b:b0:6cb:c199:462a with SMTP id 6a1803df08f44-6d35c137657mr208089456d6.27.1730722766648;
        Mon, 04 Nov 2024 04:19:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc718csm47611946d6.38.2024.11.04.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:19:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7w3I-00000000hJn-3gHO;
	Mon, 04 Nov 2024 08:19:24 -0400
Date: Mon, 4 Nov 2024 08:19:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241104121924.GC35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org>
 <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
 <20241104091048.GA25041@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104091048.GA25041@lst.de>

On Mon, Nov 04, 2024 at 10:10:48AM +0100, Christoph Hellwig wrote:
> >> +		arch_sync_dma_for_device(phys, size, dir);
> >
> > Plus if the aim is to pass P2P and whatever arbitrary physical addresses 
> > through here as well, how can we be sure this isn't going to explode?
> 
> That's a good point.  Only mapped through host bridge P2P can even
> end up here, so the address is a perfectly valid physical address
> in the host.  But I'm not sure if all arch_sync_dma_for_device
> implementations handle IOMMU memory fine.

I was told on x86 if you do a cache flush operation on MMIO there is a
chance it will MCE. Recently had some similar discussions about ARM
where it was asserted some platforms may have similar.

It would be safest to only call arch flushing calls on memory that is
mapped cachable. We can assume that a P2P target is never CPU
mapped cachable, regardless of how the DMA is routed.

Jason


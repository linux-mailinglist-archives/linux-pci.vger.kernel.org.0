Return-Path: <linux-pci+bounces-26575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8BA995F2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A465A2730
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87413283689;
	Wed, 23 Apr 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ObjdV4+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB427FD60
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427624; cv=none; b=N7x/jslJ0soCeX4fDm/J/J6oqHLt/l8ZTXFJyYMxzpFqFCeBWgG+/TgSaxAzyU9HKJpgdh2njwRv8vt09YTXaaVRwItUt6hsBNqv3AFBZbbvKbK+Sy8/4s8HJBUZd2cXTdrHJsXW2KW5oynHObXFOi1pp990AhYWcOLV07t4oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427624; c=relaxed/simple;
	bh=Oq+RUVKXoierg4o0zQGaueU+iLWLxzwb7ZA+t/XFi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdDamWCZweHXydtbnwb6gv4yD37n9CiME2nHEziUuhYgFFp+69qz59d2e5sjCfK7Paud/kxXULrcBT4n0ObRigdreKNw7YP5YDlFV5ODOCjTiLHADeETYVMZXpefbyYD/ebOoADGNv1ADIUflbhKX3IhyLmQK0XR2IAxkpZJToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ObjdV4+g; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47664364628so1045871cf.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745427622; x=1746032422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=ObjdV4+g8VXIT6EYYdUQC/VnAcd/Tj58dnK+XTWvpmqSxFUgbRazmfdyfEA1jMkBbj
         C+6GYboX3ASJ+Nq3hL5Y0YAy+D1i4/Ih/ZSmFeN4M6gqRU0850akjuP82Q+hEQKxT67K
         l+hESJfqUG6IMwJ483jR4Lq/4jqzCd10ONl9/dkSYJQE8E1DMxkqBNQvF8ifzc9inE/o
         6HOPsU57ZeQ4X09nqNqCMu9+I8UagbybcVmUqgy44ZBVRBaUvf3x0jIplkaoYSRLyo5Q
         1B5YWciKEL4rPvczlJE5Q5myRVWqsePj9DQq96ZlS5Ut0EwJcOJT2mt9+FYZb/OXl28A
         bDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427622; x=1746032422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=b/H/NstcfoDLSByzRVW5EeYgXg0LqzS7SBFIggnusxJrDo+i8XbhgkNyF7dvh8oQKi
         Q2bFMS9vo7Fl+v+QPoR5SetiR+OLrNG3hz/mcc+GXS+qTc9gFGFXEELljOXfrqnYcWMe
         rqxn247EJOxZ0ku/eZMM54HWgQmY5jFa1t5FAn1J+m4IddnGLeWF8J/BBR9y1MPCKyRg
         zXsTCR/UW4GIl0wbp31IcbWgQFSYHBj3a/8URrUGYlrczd48TH8rvBLvD5PTEaYnK6hR
         SN8SaouHrwFvX06ux2JHH8dUSn9M2CfRnvVF6pBAgC+p/ifCyI36iB3u5e+1Lqme6O71
         gOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN9wHT5tl65a84A/g1XCSAXqAEFdc3k2qnBQd2x6ixf3lF7RPf0iT4sdX1TNHmdcSDmGszpjIzRg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx1/ataIp/JnK4/HKxrDbmsXuMPdoJnt+abXA1UnrLtOliQrX
	lOLXU7fVU0tdwUwv7Lss83TTNQW/Sd/TF9P0+y4PiaMBjrZ/dPfiXLul1rduqT4=
X-Gm-Gg: ASbGncuTIizcwFFb2T/hOc+VQ62S3ZRlDmAPA7L7+/F9nCTK5UHvyr5ajWb+MiWeD+u
	lIwyEiW9C5vGcno1rwHdlm6nAW2y+khaGs86tw1plVWIgtSp4mIBBsKV/YZLXGuADJYg60mr4UC
	7d8s2wf1Eg8qG3c5dBV/kA05PwX6GAd6NoxjBxAXf+cS7Qq6zU/MlFz21WIE0eG3xXJpb/OYwQa
	r24nvvj/wBXRyex1V3g0RUvGNgRrh0/e9YOZAiVwh/NNqMXfvgh2SHVqGQ4QP39f1bxu9ruKJ64
	mr9Qmq29qjhAE/sCZyXEd25yt5kaa9o8vtvz3fAHgCLn3HVbNHN3NoHbBGEJZ3VQJDxg9S427bT
	z5N2WiDhBqlNshPAe1rK/giD7bwXLUw==
X-Google-Smtp-Source: AGHT+IHksHmB8zXVAbJv0K8R7XmlcjQan86yStXGt3YpvcZVpCrvagDTNNdOsaaJ2R0ZGC6sR1O+4g==
X-Received: by 2002:a05:622a:118f:b0:47e:641:9665 with SMTP id d75a77b69052e-47e0641979dmr20773641cf.5.1745427621264;
        Wed, 23 Apr 2025 10:00:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfcfd0sm72347416d6.82.2025.04.23.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:00:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dSO-00000007LHo-0vIz;
	Wed, 23 Apr 2025 14:00:20 -0300
Date: Wed, 23 Apr 2025 14:00:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423170020.GI1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
 <20250423100314.GH48485@unreal>
 <20250423154712.GA32009@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423154712.GA32009@lst.de>

On Wed, Apr 23, 2025 at 05:47:12PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 01:03:14PM +0300, Leon Romanovsky wrote:
> > On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> > > I don't think the meta SGL handling is quite right yet, and the
> > > single segment data handling also regressed.  Totally untested
> > > patch below, I'll try to allocate some testing time later today.
> > 
> > Christoph,
> > 
> > Can we please progress with the DMA patches and leave NVMe for later?
> > NVMe is one the users for new DMA API, let's merge API first.
> 
> We'll need to merge the block/nvme patches through the block tree
> anyway to avoid merges from hell, so yes.

RDMA has been having conflicts on the ODP patches too, so yeah we need
a shared branch and this thing into each trees. I'd rely on Marek to
make the shared branch and I'll take the RDMA parts on top.

Thanks,
Jason


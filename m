Return-Path: <linux-pci+bounces-26583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B6A996C6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8BA921E4C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E1A28C5AF;
	Wed, 23 Apr 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jKeC0wG0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4A27F73E
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429700; cv=none; b=qY28j1r56+nj50XShQucyWjD88oZ+oT6+AnTfsDUxmls4GCnJOEYptaQiZaHlGBhZyLsOyCdR0blX9iMbDHwhNp8HRGiyAHN9ZKcR+tYOyDOyJyLHw2YeJxe7W/5XYCpkGvxW8wZRNzs5pwr3FAMz01YzGvzcutL1AFlMQl/oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429700; c=relaxed/simple;
	bh=zB24IJl1jZzMHzgO4K1Iy0NHxHgoWs9FaxvjZYsQalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inTzuD33tbYeHep3+u0aE0lLsF6gPGGfjPTp5rbAl8BKBBSMbLhsT/RhW6/FanpdEgGyPNXUScJsFejLeVUe2VYZiHwZcKiM2BkIpHGDKPdUP7U4NkdibbvfO7qwtO0iY35+795VQlVdBvi/KUzaLU0QIsUhYWAusW37EXk9v3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jKeC0wG0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5e2fe5f17so7656785a.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429696; x=1746034496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=jKeC0wG0Rxs29aLtFTXrwvm6sCjBlI+WjPNCPmALgo/mjnmuyNi8RzQ8EoTi2n9ato
         G2uR8+wTHeXdzUwlwgxBh5NicR8ymrLhg0bWgtzToqLWFgmbk1yR2sBCKvTWpQ2XzEqK
         c+gqSngWmaHabqIMpagt+bie9Wb3ZUbIY0uf9WN8dkBe5oq6/jz0Omc/q/isRe5XxD6s
         wIyd2QIvWZ+V+k8HV/tY0iBuNr8JlAnZaGxdHRzWwWJdpEc7zUCULfC7NElEQ7ugzKS1
         ukaL0jDlfBwfBtKiA5JthSNqw13rTy4KL+WCFZHxth3Teiilhqthip7KWkPBUKtkiX7c
         Z7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429696; x=1746034496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=ClvaamSu4PBwr6EG+f09QASDagSHE0v0KL9kLs3wsZFe26e/JD6Odwtk5LzLEIwfbB
         904FyZ3zZ7AMBPJslvqxHmOxW1llk9eAd/d3Qw981lMwBKZlev7674nyX0tXt6Yh4S6q
         spM+dPVC/bDNbbNrinw2LWrLbQkjjFamhwAilTW2dPL8aAiey/4tmuEOpEOabTOB70n1
         yn+XbHsd391M1M3B9+bzb72HiLIwnxZ9FK+5xR6Rw8zUFVhdEiKq0MV09Q2c8bAc/6mj
         n9pT8ewSzLutUHgmUvbJ6aQoDHENLjVfiDck2SpWYBxufd7Gi/kFbNVbkWqHEcLCrglQ
         y9qg==
X-Forwarded-Encrypted: i=1; AJvYcCVFmLWhy5tnz142BKNHMvh8RYFAVrRfgvXk3e1r+/KtoxOgFZSZeGtbwa7wUPWHJlnjEAGFS1eeQUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7yQAaSRtJcVfab9m2RUlSvPSlnib67kNuVO9QxSUPmLOifNX
	/x1h2touWPoEz9ZcuXFvuCKUK97mNOmHAxKGJobv3ry1faTwosQejOSMZSNEMqg=
X-Gm-Gg: ASbGncsMT1P4UWSlfKAn9OsCNIE/R2bzNU5J26VRT9MBBe3ZJw6PWl/aZmv/lkdrPly
	XJpjMSQ4b0Y8/nuIgTsk7kJu6LKMEnR+hzed4YZoD4MC8zhIgEGVSguYNuX7bAq//7MJh0PhO8r
	iklUpZa4M4EcWGdEAAPyMzdPpihtKWkvPkxM1v78VVmM5Kp9ygUZRRYqc7UlmsAyDhRU/CR5/3O
	FrHt77r1N8K8RyXJvsHGlGBmwh1UbGFNtCg9v/AurtKkQGu0xFtpb8od6SKWiQET/r/e18EEl0J
	ls3UWymvjELx9XkQALR174mBvomYeK38J3QcLPW256l2nHEStVLVtSWTO5mMnMLQQnNnW/30oIe
	BLzc0hBis+orQQ11MoXI=
X-Google-Smtp-Source: AGHT+IHrcKTZfJXCAhkO2WaOum0PT2hRMW3vGaRhpe2sCjwAXzgjbldqD9beTUKDcznlrIIPKNuBAw==
X-Received: by 2002:a05:620a:2953:b0:7c7:97ff:ca42 with SMTP id af79cd13be357-7c955e7c7d7mr65261285a.41.1745429696505;
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8bf65sm707741185a.25.2025.04.23.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dzr-00000007LbA-2PtY;
	Wed, 23 Apr 2025 14:34:55 -0300
Date: Wed, 23 Apr 2025 14:34:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v9 12/24] RDMA/umem: Store ODP access mask information in
 PFN
Message-ID: <20250423173455.GN1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> As a preparation to remove dma_list, store access mask in PFN pointer
> and not in dma_addr_t.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 103 +++++++++++----------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
>  drivers/infiniband/hw/mlx5/odp.c     |  37 +++++-----
>  drivers/infiniband/sw/rxe/rxe_odp.c  |  14 ++--
>  include/rdma/ib_umem_odp.h           |  14 +---
>  5 files changed, 70 insertions(+), 99 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason


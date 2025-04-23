Return-Path: <linux-pci+bounces-26578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DF0A9963C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A8F465883
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDF28B518;
	Wed, 23 Apr 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igc8GuoA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF928B509
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428557; cv=none; b=qR9gjbg76pLWbqCV0MDt1sYpasshpGMd2radvIXbLhPxzFaT9lL3IgQlQlrLEVO6P/htWtkAlU19rucPDQkzgn883V7m8CXK1Hup41uW5m7jTwgjv/o9oAmYuvrYfJfbDHhRZo3Yqf38GQ6vCi+aF9oWpH4lOGiXy+rY0KSIeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428557; c=relaxed/simple;
	bh=vMXucndq2S6GHUftC4QAjKIvCRBxtQ3mQadyEEn05iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on30cp1LYW3RdJXvGBsQTHiVuxJLM1z6yzIHGVA4tkBjMcaNQSe0BhvW49oDaDAH/COBJHD2oRaYGCekLTxtavjOhgJZxLjRmZJKcpNSlfU8XvCRWF1Psf0LBO4cp97eUY5MFqTKXUWj9LCNkMNhYoXoC6MQcpqcincKjf/TOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igc8GuoA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c560c55bc1so5671585a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428555; x=1746033355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=igc8GuoAzkxq23x3zTwtP5oibqkeQg53VG0Iq7gad/MlX8rlFoaVwdhQ0apeqpKH2h
         U63IQo5nrNVr/aYRLNtMYNdCv4gydkVivRxSKp9R7pa6wsgSApmCtQMmO9kL+FNLuCYl
         X/+CooWu7xCeo0ATpiDWk+fOrcm0n3wgS7PLKA/bTH1rXQkbm6fbMji0uJQNUxm58yoB
         Rqu6j7oRTifpHPPn+9M3hN6fwsO7KeVdJS2pUvi/LGbn6oETIDds/1hWRCeug9xrcImW
         WzY6PYLDgjbbO+z5bnOFm9GEuBEpX2dZ4T7e+CqVXT1fnIfwTIv3FZayq4iQBioe8nnf
         CfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428555; x=1746033355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=F9vFFCUECCBiccrris16B6PiJaEqpWCW+yL6418CY9GyTdpZWW2AgQ8pjfcpJoa0/K
         9WYI6uzo+jyg535IjP9zr5FTT14MNmqQOepQZD3i3Ma74Z5ss2alxpQmtqYBJKKB3AQ0
         09BQYLWVQ6tUE9gNmvk0hb5TrSHMEBFz7imSJBkd2zg7BsiMTsfeH+w/1eY43yeoQMws
         8PKWvct/rKltuJlyY7xRJ3z8VyOqVsIgkEBM5U4bHRd3vkMdATsGtT16OGPBvGOf9j7A
         SLWrYpwFhjCdDimjT7XG+gvvafP6Nx+yEBxTv5asVuGnzhs3E14lRxq50HskHuvGZpJb
         FxiA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAnLLXWmKuCnpWRQPh+9xvxpqGLIdAQBJ2Id6hwcHK61eN2XELk2roZwBJr/kXDWCq1TAPWbuCdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfFTq9mlySzw4RTkHK2I1qWMiQPKMTcbbEC8Lq/gDILcWnJFa
	MrjQNCIvl8fqtBIhKJlDqbW/KKWhtbwnqI0/bbytUbmoYDRU+vl6noNDtOKb4E8=
X-Gm-Gg: ASbGncsqhyQ5PlclloDwuphhGzUEo5UZH1yqdyEuNigd7cgdvRoB3PkTwG9T9qS6nuA
	zxwEplZsuCgv+aaSxaKNo1vv8iaoXH/dJnpxIv0OJIyrbz2f7SuLavPNUHaAbbeM6i1Fjc9ec5e
	CHL7O0RGoaoAYxIsNj0Sn2Sqkw2fj6j8Vk37eMn5gttuTZalzSWdQsw4OoM1RHEfpefkmVnBerr
	t2fcgy/xfWY7w+7AgzR+XpaLL4yiwZrnr9PZS5QvXqs8Rllyqp/3rpeqrQDG1yQd2kwqm17Kmjj
	LvKAUsFsJOko9ugWqAP5lYo0tBEbge6BOyNjTyt9p5cSFPcKWoDxpvS8GXC2zGDNnuJ5ySrZpXH
	BhJ5UWNYq2ZmhbvbvpMs=
X-Google-Smtp-Source: AGHT+IHusnUQ6QwwVsDnvg+0qYOM6lcQLPltCEX7WmRgNJP3vwJodfip7PxZnn5pgy7BG5cQ6pnE/Q==
X-Received: by 2002:a05:620a:4456:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7c955e14768mr54555485a.56.1745428554903;
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e93asm705867885a.70.2025.04.23.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhR-00000007LQy-3kud;
	Wed, 23 Apr 2025 14:15:53 -0300
Date: Wed, 23 Apr 2025 14:15:53 -0300
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
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <20250423171553.GK1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason


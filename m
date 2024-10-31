Return-Path: <linux-pci+bounces-15668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035759B7231
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D6B1C246CB
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D1156967;
	Thu, 31 Oct 2024 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tuf643hV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39012C465
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339059; cv=none; b=cnlbUn5JtvxlHcGM7bXrlsw7bSC/sXqVMol4Oh2zDSviy8UQKr/ebTbLZg5Ji2m5+eAJmnoTrYnh+Kicjo9lDMqY/lW0KvICbV2oBlbxlNLiv5k5Dvj0J8g6AcS3F0kAaR3WV/WPqPB8zFuRtuj3jN2NtKqUxA2XMfoCyUXb3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339059; c=relaxed/simple;
	bh=OfvPc+5lwRb7y4SbauPRI4zVY/IksQfQWO+Wr/AIhFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDHdATteHVSfZOuyhsYIUfl4qF5L0FabKVNo76YWHUz/JO3mfHQJWpJg3fhfLnsdPKcngYU4z4DG5cVSWbAOaH2A0lNp1Kp2PNpN6hhqeYJvBTxfBJ5rwKxe8KHYjN6SP3SngkC7oTVJzF3+31P4wgnaEfxlmVpEz2cVB1dep18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tuf643hV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so346246a91.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730339056; x=1730943856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=tuf643hV+ElfF954yMb77toE1oTjXBM1ZnTPWjIsarNiqJiWLJH3kVwqlx0n7wnyix
         Mlzo/QVip836Lq9BRDnT00HsemKyVERhP55CMuNi3qXORGgz+axl5HOO1gv2a0x75sFW
         Tt+JSfxEXB92xCrnzBBfduSg5vNF7ml7MZN6WAN77PPIDQuJJrY3iLmfxKqhmQxARi+7
         nA8yOJx+PjnVl9APuoL/sGMBVnBm+rWyOv2NkoackRF36CJu6hlxiJ8mQoYMouFQxiwI
         b4RQLnL4IdX7uG0YoERijcl85YOmCrthVAgS26Upyc9T2VRhPQCg3o/xqeqZqVwLGINY
         3Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339056; x=1730943856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=kBKUIYEST1WXvL5OEv+b0aMRokKeeFOdC/x0DMquoUxv746DqzTgIOclTe1yx8whyA
         gEA3YHbaA/QyFwWrfqElK6HF5cxYXMc/OTstYU3vmyLZI9AONQi3sNde0sZBxEw2Ih7U
         gjDtBcU2ucVzK7LytAa61Lll6FQXnKy+44iIx1j2J6yCYw48z74r7nz1Vu8NrYDi7ZZ4
         ZV3dckEog1Gso7z+9nblTPki+qpfCC+Lzdvvwe2tfXDi65zqiIvf+b2mltDsCDLqyxTR
         X5b7p6VSXEcWVCdKpwsRPnrVJE+E33ELPVKcr5JNFCHLkimDqM1gPn7jy0jw3C9T0fKG
         0RkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFpwU6eAeW2CrjbSYWnsPlDoiiy8427BsNtu4FRN3JNbqM+GK7VqOEcE2qOFYqQoQm27UKtkMGKgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyS4P6Yf5sjEeMFVqMPUh/c2CraYj3O4PF1uwiR6KLvnZ0nUto
	g3KjQgb9sqst9o5gZKcq8XBN1bwoF5I23htkDlZ0kS713LfQhZs5ANH+hzxUWuw=
X-Google-Smtp-Source: AGHT+IGsg2gMuDdd8QNd8tlE79QeVlOXl87E5sZsK92hB7UM4f0gqnlbEouiOfBHyppk70cC1W17JQ==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1d9a840aaf4mr23384613637.26.1730339055795;
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac966sm332679a91.17.2024.10.30.18.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Message-ID: <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
Date: Wed, 30 Oct 2024 19:44:13 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 9:12 AM, Leon Romanovsky wrote:
> Changelog:
> v1: 
>  * Squashed two VFIO patches into one
>  * Added Acked-by/Reviewed-by tags
>  * Fix docs spelling errors
>  * Simplified dma_iova_sync() API
>  * Added extra check in dma_iova_destroy() if mapped size to make code more clear
>  * Fixed checkpatch warnings in p2p patch
>  * Changed implementation of VFIO mlx5 mlx5vf_add_migration_pages() to
>    be more general
>  * Reduced the number of changes in VFIO patch
> v0: https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org
> 
> ----------------------------------------------------------------------------
> The code can be downloaded from:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git tag:dma-split-oct-30

On Christoph's request, I tested this series last week and saw some
pretty significant performance regressions on my box. I don't know what
the status is in terms of that, just want to make sure something like
this doesn't get merged until that is both fully understood and sorted
out.

-- 
Jens Axboe


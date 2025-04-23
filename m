Return-Path: <linux-pci+bounces-26580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B07A99651
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C9465996
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB0628C5B6;
	Wed, 23 Apr 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="npaeDpuZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134528C5A5
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428645; cv=none; b=gUKYAUTrs3EL4oK1auv9a6eFGegv8gYDbTiOrQF86B2GjxHoE8rMDJIWnbG55CW7DJgMvmF2Xv1WN9jE5GAb2ogW8edw3Vas+T5Wf///Txsdp4MxU7l0MDKFzUVcPuHZTP0mKneIE+4XMU7hc1wMLXaUXNz0uqhVEklAkw747A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428645; c=relaxed/simple;
	bh=EiBhyUfzV2Z7UDyJtWT+jDVz3vG5z4pmjKVdd/tf4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DveRqum03NfMejaPuJi6bKL8da5SmsnyEnMQJ4srh2XWn9Kkou+Qx4i2ep4rqrmNF7zY4iHJHyiBjyGI/fi8uhP+7/+UlI+GH8PnRwqJIQsLep+D9NspNABdPUVHl1WnRvvXcuMNEMyrzYFkeH+tc8e0iD6p6FGTjI/xfCvW2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=npaeDpuZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476a1acf61eso763061cf.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428641; x=1746033441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=npaeDpuZ5VPkOZqrigtgKEO3dCkGR0IX2y98q9Ii9PH6a4ySKU1Jl4WwtNJ6vivJox
         7hEhKgYIFPYqeHFyrzJiO3d33Z8ckzVE0eaA8fEtLnT8cYn03BrtVZuBiETLqrfiK/nf
         gFTPKeLi7Cpt7+qx2b+ZjMHPmjzmah7oNakivA1lRSbQMUGY1if5wHCAKmZlpI9uAt6a
         Zy6Lvyyn98F2uzFdf2FiWobaepLTsF6ukZ61MMk+0nGEE0Blu0FjWpPxnQrpfafrFL4m
         rX9Cge4tjMFyn+s+tbrBkE7lZCL4t6Rs9j2pRiBe6X2c5Xq9grXs9D9XN/yfjfw31f4z
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428641; x=1746033441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=sj57cUYSXx81rQcjags48tHXrhMrH/P11m6rJNCRLWPLdc6y9H70mI3P8QFF1l5Jie
         /7sB6oCp4VFgCbcNpvz4YaGUJQBOYON+6b2I9Vq9y5EflLkIpnIRSgUYwMUwm0Ad7cmO
         +2a1p8eFhKU6f58JWz9mgNuC4yq49jYJj+6FPu0AMq4ty7YV9/hfh5kQosDHUQmTtjbJ
         AwVzZZE319/fbkKhzDrRtLG22c2WM/BRCou8avNtFAbmML9ykoryNHTjmhvpaYr1SlKB
         kooKUdGj1YaxuGsJ/LBzindueP+W06c5armBs7W2kr68R8d4KD8sNhkWIwO3eOoRRb96
         Us0A==
X-Forwarded-Encrypted: i=1; AJvYcCXnxRQBgYjSsWhF102+CCbLKCoC0+/yujodvgODbBAMjl0Cmqm76w3J9QD8/ffi+l95WEMF45ATV7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8nRveP0bHQEOhgOjT1jmgNSTG+E7+ICl22yaH8XvkWCXbVGi
	uSMTkSh2cdhnSDS7DBdoUH4oBmSsv/R2TM8COH8mTzgxfbkFkdYPU6sUp3jEuSk=
X-Gm-Gg: ASbGncvRu6rN5rKntLvA0c7veNvMZTY4EpAmlo3WJW6iP+FChVLhqe2nSiiHTRwrLN3
	CH1ALkgd67rkYkAUoTNYkU6A1RoSsirbtg4hZehIHxLmz5xNKTbO3NuuSw6uTjq9jy5MEMkHXda
	ejpJwzpoysnsokGVuIjsQ63cY4RYEigqryXW5QezG3byvYBFiAYHHWdlxbSn3IHE/Ns/EBJvXMk
	LUBcFsur+N3UcsUDtl1obTgHmX91qoZ1ZuTc/KnwknAzuzSR/sbRgtmaMIIPwQPuEI16GrFspUD
	DUQyY9rdySY7IV7cbdwAPR0bcataepcUENY9XNDGFAMtEP5Ak7/KjeCXNIS9yg4DHyfF/6mc//M
	yw4htHr2Mui8jzUAxvnE=
X-Google-Smtp-Source: AGHT+IFtKlYmuMPWfMKQK8kh2VV5wwxeBA4j6ePEQHIEvAPMlC2NtpfOcLZrcYI7RZQRiXVuJwSHAw==
X-Received: by 2002:ac8:7f51:0:b0:476:838c:b0ce with SMTP id d75a77b69052e-47e7607d5ddmr844071cf.13.1745428641397;
        Wed, 23 Apr 2025 10:17:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm70808611cf.71.2025.04.23.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:17:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7diq-00000007LSZ-1iS9;
	Wed, 23 Apr 2025 14:17:20 -0300
Date: Wed, 23 Apr 2025 14:17:20 -0300
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423171720.GL1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This would be part of the RDMA bits

Jason


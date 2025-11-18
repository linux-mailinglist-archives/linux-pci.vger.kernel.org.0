Return-Path: <linux-pci+bounces-41506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BAFC69F9D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 15:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E98AF2BD45
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F52355020;
	Tue, 18 Nov 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B/WGySyv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5D30216C
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476209; cv=none; b=lQ5Pdpk50g36lDZ/ZCDm9+vHuUB3XSZKS6It8Y3xOm8Rzb/ODqiY2FUZSlpQrLvBxEnmzUZ6f4rvieDxHlVvqoeXEYujeGpNotZxTIPgO6eKQhH7NeFryL7h28Las1OgktezmK9nsFryvwEzgAw1ijzt2ONx4tq8HsYDCYopzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476209; c=relaxed/simple;
	bh=Vzm9kAK03gjq3/EFXB7Lf/qLfrswTurpUBT72P7Q9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHfA0jdgqB4LSW824FPncC3fDJRDYwWfRUKa8htGvIh6blLOpRMtXlr6F//Cehvkxvn4QnMIFcu4o1EfP1hIS2tuRtcj0BtKGTUQWmSWMrhVIViCPV+Bwbauljc6kljRqbHxPst8I9MO/dk5guzZ46zkAXR1FGTi9IlBnfXtrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B/WGySyv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b1e54aefc5so469860985a.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763476205; x=1764081005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=B/WGySyvLaU8JIymArDTv5WHkDz63O8yjgtHNuDkhXoWlTVVEPwduRMKJRIl0VF0pt
         8TX3wC2CbRl78X8YvI6a76RvnNUvSap8sF82eEalnIXUMlSH6IQZ2lf/EfXMaqK3D0ge
         X5WIamr7y8ESnWfA/FuSzY5Ur6gzM7VRfSLkcWXG5ZJT1jx/WSECD5qqvvLR/jW4FtK5
         lXAqbLAS2gBp1REviCoz1CfM4ZfT1CkwTYXQnaa+Q+f0AhzEUqD9RCYPP7bMY70mYbIq
         d0nSRxqUw+WlBG8E/FBiGUk4abSaitO3o2hlCXsKqA/G/VWD92vKkCqNV5klizdv4fJN
         4ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476205; x=1764081005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=vRSXwldRWJjp9ErpaHpZLjTD+BIxVvASqRTeM9f7q8jAYc8xJ4gureM2/c9UAK5sdt
         MUZ7MAQ5jDdIh2jaq78mmafocsLxZQx+K1GYfCz8mpRWP8Rff/PSKhsvlogZcnvSEm+c
         C7pQGBF8iV9XoTrbJUtjnnpsfYIZFARsyD9d62DdKXt7NR/hQj62m/vopgtW+YYcPt7A
         J6HgqAaWtSnhIK1pRLqEXL8sMdZesEgoBwa5uJ5EAlT+U5RmALZP5BqTquHNxWQIHqno
         OZSXwPosljGQ5TGoJ3t3+JVPvj59Bd6u4+djrSby616xUjE5N0RcMzvZ30IxFLgYhPSt
         deYw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJGr8/Vncg7qeyFvhJ+xR77pLvtmjDukxIyPWLjHULoCrZXlEAX5hLiqR/LrXzseX0+L5D2Q/rpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLrMpL2jA27qi5HaqRoeqkOHEp9dJsC1Ot5maYahyqa66JziU
	gqcqtOMT6XN5aJfVXB3Xa2dH/u6bop3dAz92UySU9h+8Ua1evOIRfhl2rxKIGoIdCLY=
X-Gm-Gg: ASbGncuvFc1vo1z6Ph80sQjRXJ0tFfp7MEwlqm35E9V16HCGtI5n7PBGqTgMglxEVMr
	51jkUxvjf0wUibcA8QaO+TCl3hppcN/kv3zKYOGofu8uid7y/tyVY4FR+g6OTShvpc+L8TcQjjG
	WN0YEV8sXkTd5sl4owSMl7ye1NHxnLsq3J7KdXcpLjMoA2IPdgPGvHLLvx37b+WVnMSUbgiwEc3
	K0ool1Q/iHPzgle+3O/WOFg7FR/nz4nwEqSEc1ibnVVDLKl5ji7Fa1lyWZuEk+9SDI+ihgk1LVe
	22W+qbEPK/DOJPb0CweNRNHKDyPpmbRHqeWMJuqWSEgMRz/P1WXWiwvUfZUhTzJoOzVrWBfa6nT
	PPQlZGnZA5U4gmbQE35RIAHRWjkdYg+C15DEuoFLE61ZC809Pz918YI0Ana30CuujXDT2EFYVMe
	EKzUlVXA9UuXi5gs4mR/pztpz+fV8z49bK5vVbYgrvV5ohLs3af0nvgCjWREkPr2GTmwQ=
X-Google-Smtp-Source: AGHT+IGl2QxjkDkgi5jKGR6lwtLy9hLDUjSd3xhjzd2vh/OGWRtCENW0fUVdt2sQ45uUuO7DIyidjQ==
X-Received: by 2002:a05:622a:4a15:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4edfc875136mr206770331cf.13.1763476204719;
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d0944sm115395396d6.9.2025.11.18.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLMiZ-00000000NFZ-1yj6;
	Tue, 18 Nov 2025 10:30:03 -0400
Date: Tue, 18 Nov 2025 10:30:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Alex Mastro <amastro@fb.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 11/11] vfio/nvgrace: Support get_dmabuf_phys
Message-ID: <20251118143003.GH17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-11-fd9aa5df478f@nvidia.com>
 <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>

On Tue, Nov 18, 2025 at 07:59:20AM +0000, Ankit Agrawal wrote:
> +       if (nvdev->resmem.memlength && region_index == RESMEM_REGION_INDEX) {
> +               /*
> +                * The P2P properties of the non-BAR memory is the same as the
> +                * BAR memory, so just use the provider for index 0. Someday
> +                * when CXL gets P2P support we could create CXLish providers
> +                * for the non-BAR memory.
> +                */
> +               mem_region = &nvdev->resmem;
> +       } else if (region_index == USEMEM_REGION_INDEX) {
> +               /*
> +                * This is actually cachable memory and isn't treated as P2P in
> +                * the chip. For now we have no way to push cachable memory
> +                * through everything and the Grace HW doesn't care what caching
> +                * attribute is programmed into the SMMU. So use BAR 0.
> +                */
> +               mem_region = &nvdev->usemem;
> +       }
> +
> 
> Can we replace this with nvgrace_gpu_memregion()?

Yes, looks like

But we need to preserve the comments above as well somehow.

Jason


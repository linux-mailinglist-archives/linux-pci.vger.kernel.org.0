Return-Path: <linux-pci+bounces-40289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71949C32C59
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AA9427346
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E032D8DB8;
	Tue,  4 Nov 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Br/CW/Tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E742D8DA8
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284380; cv=none; b=MM3cBPD0/A4meuWnCt21qiYF6AVB+S0SFgUfhvQ+bwnHOm1/RTZW9eygimbHFZRrnAGmYrphxjbUkeMY+1Zz6AKKKLNeBvp6gElB/KDVwAmkiulsi0lq2IhyoejicTqbWRVK/42/2DsLWa3i4EWowxBmbgBV14tv1QPT8deMux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284380; c=relaxed/simple;
	bh=cCkLeU8n/VC4gjMMSvE8Q9FQGCPzymEWRBS/d9chZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8kfdqmPPvnf7D9R/sMamSohw6ydxj2dEJeLdn8nR4XJRorGGZ1U+3AKlStLgkbXP8lKFZmna6IC/rpED6evnyvSvSMDfA5/8X/pT1DdYeS/PZ4D3kamrOwVyl6AJfFn3HZwmUWCCmhSgbFTOWT1+kuECsijcS2cyybbDc2SiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Br/CW/Tf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a2eb837c91so530337285a.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762284378; x=1762889178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=Br/CW/TflUHqW09MD8LVZEVmTCEpByqeZHXbQmDqLNS3W7/P5QMsLqXUYUPvpa00O/
         NDbeKxURSRAOEgZlt4pyN7AoCusEuXP7xgt69+GEqYsa5zkF1QDghaXdoYgbz0DWHmSq
         U9OeOmRjTDCIT0/cBPF/t3LUA1zcAtJYiTLN0gEIejp0Ov18P4I2koBnQy6dI54enVuc
         QyQX43ev4/pqNhdtIzyRUoDdKf6k1sRujr/hJGrkQZGhZ3OH+U3yhJimlpvTSAlkgBve
         sPmwUqWOuz/s/qZcYM4qKj2PZVpK1eQqqu4mmee1GT71ewrvnKTZdaqwowoBMd35XkLE
         eoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284378; x=1762889178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=czGpuFHWAglaF2hfasIUVD2il4iTx2PIkaDAFTQUJnwhFJCaHrXZGFimAk0wpP3Ajw
         84vxKU2h6HJxd3nbfIf0nXr/sAc4Gw/FpCRd6+2Z2AYEMCmPx6kDLVbZ2D2LY8LwY261
         GwO7zSW7Uq8ZNJJNXmuFHJppGoOXem2wJZYsgScCAjTJQ599XIZ1dpFj2Toz+UK6Ok30
         Ihq8n5X4N9IpejuDUHVQcxwShKTUd5pHa1dyxtdbfKDoSNeYKaui3BVQ1ojzkVgRNCap
         kndypJlzwcnc7YtJwSLVnkJl6YgEogdVYJmB6i1AFWWxUvGpaBa1q/BMJ7bcUnHOm8Kc
         Qglw==
X-Forwarded-Encrypted: i=1; AJvYcCVl/gKcO0dYRqEJ3mqS/q4BFJ/VZfNE1uTk2xCEcAFU35Fh822ZXIxzO0UOoWqJjnCbatqrTULEM3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvNKJQnN1ZnOk5U5Z6bKVkBG3SjYIYF5qvRfFkudxoQEVNJ2N
	MsFNQu4lGFgwSiazptQYOgg7Iy71Q9atXh7NwvgZI1TthRjXL91Md3r/146NzEWodoE=
X-Gm-Gg: ASbGnctDn7GZRwMzLkQ5g+nmm7no3cJJ/OEejHzVUdFu4FyBQniBgDsg474rA/UTSZF
	8J0SgU2DMEHKAuaavqBrOUgnJvKOWRCM1Z4yU5a0liEVV8gy/oGEblEyUmN27RZtUzncWdEb9ut
	Ezpf8wu9q+eTKOrjCmfS/o37+wnmQDLK2OdkwR/g2K04eo/M5nickM0jvkxMIMP/u25pf7UlQjR
	3WMexmt8vyUCW2TYO/BgXJsS0jXNvEmJ9AbPtgx/TLbLYaztQCkeg4VwQI7Bz8yh3zjsQu+ffv9
	5LQpvWYxj9vz/M7/UqgKXczxoIxe+xiVDiVGwAos+67J+4MX+jxKrW+uHU0JfmMznWJCmJUShj7
	/fv9wM5SitPlq1UIuBst+7nvEmng8Zs7Zulv/NDeP5sdpW0/aFkxKnNiXZ2j34e1hT0dsHTKvWR
	8GU+KLBvHPpdxnlOxXs4fvV6/yaVS1lAqavdXB05sjRVisOw==
X-Google-Smtp-Source: AGHT+IFUVGYM+r9VlnujjXwSiyntNScv3JSZn85Gft/uvY+ZvhCxVbalAnSefdp5Rhr2H4+z2gOTFg==
X-Received: by 2002:a05:620a:2a06:b0:86f:aee8:fcbc with SMTP id af79cd13be357-8b220b9ef27mr103417385a.79.1762284377655;
        Tue, 04 Nov 2025 11:26:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f7bb3e33sm250495385a.39.2025.11.04.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:26:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGMfY-000000073Bk-1Ldv;
	Tue, 04 Nov 2025 15:26:16 -0400
Date: Tue, 4 Nov 2025 15:26:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v6 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251104192616.GJ1204670@ziepe.ca>
References: <20251102-dmabuf-vfio-v6-0-d773cff0db9f@nvidia.com>
 <aQpRz74RurfhZK15@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpRz74RurfhZK15@Asurada-Nvidia>

On Tue, Nov 04, 2025 at 11:19:43AM -0800, Nicolin Chen wrote:
> On Sun, Nov 02, 2025 at 10:00:48AM +0200, Leon Romanovsky wrote:
> > Changelog:
> > v6:
> >  * Fixed wrong error check from pcim_p2pdma_init().
> >  * Documented pcim_p2pdma_provider() function.
> >  * Improved commit messages.
> >  * Added VFIO DMA-BUF selftest.
> >  * Added __counted_by(nr_ranges) annotation to struct vfio_device_feature_dma_buf.
> >  * Fixed error unwind when dma_buf_fd() fails.
> >  * Document latest changes to p2pmem.
> >  * Removed EXPORT_SYMBOL_GPL from pci_p2pdma_map_type.
> >  * Moved DMA mapping logic to DMA-BUF.
> >  * Removed types patch to avoid dependencies between subsystems.
> >  * Moved vfio_pci_dma_buf_move() in err_undo block.
> >  * Added nvgrace patch.
> 
> I have verified this v6 using Jason's iommufd dmabuf branch:
> https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf/
> 
> by drafting a QEMU patch on top of Shameer's vSMMU v5 series:
> https://github.com/nicolinc/qemu/commits/wip/iommufd_dmabuf/
> 
> with that, I see GPU BAR memory be correctly fetched in the QEMU:
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 0", offset: 0x0, size: 0x1000000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 2", offset: 0x0, size: 0x44f00000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 4", offset: 0x0, size: 0x17a0000000

Great thanks! This means we finally have a solution to that follow_pfn
lifetime problem in type 1! What a long journey :)

For those following along this same flow will be used with KVM to
allow it to map VFIO as well. Confidential Compute will require this
because some arches can't put confidential MMIO (or RAM) into a VMA.

Jason


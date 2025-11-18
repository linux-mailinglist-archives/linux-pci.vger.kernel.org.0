Return-Path: <linux-pci+bounces-41508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1FC6A29D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB01236513C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD0361DDF;
	Tue, 18 Nov 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="er7kMnPx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCB361DD2
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477980; cv=none; b=ZfDQwpB8HxwtaZFvn+8jmLq2die20oh7ww5nUjU0G45adJzwUro3/67Y65kRz7Sy56JZ0tP4wJhgLHRmHekLkhWQSI5/NmuWVQ5xBC6YiyKXh/Ne2uBreznxBNpGLn5pJjM4MlusHRmsaI9q7qe7x3Xxpw4ydMQwEoXr8B6t03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477980; c=relaxed/simple;
	bh=yCZWg4HDLfx+KlOFPmT2qV/mW2ZLzgnFX5/2HTcppS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r14ro7gb3MJ/6mjTOaXzu9xP0A9QRheOnxyrmU6oKxFOcnvsGR2hkWoqPC0lTkSVlZnapVamjWNLlIjlzsmP9wLBWW8pWxfG4sYCp2OA8GEOnIVtYIaTJZtFGRZcCdOS54ER18Ubpcr3T666oam8kBTlntusjiYHk+EaMLy+XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=er7kMnPx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edb7c8232aso80251801cf.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763477977; x=1764082777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6zUAnqwUQ7mMEKfAAq0Pm8CCEggD/qceLgK2oNv/WhY=;
        b=er7kMnPxEnnCHS03TpdmRNrOEitAyOOf8yVpFrYKaO+QdD8Th6DRFAFJNqEIuj+t69
         i3f+yxOyp798g3jbaoQjk07GnCnqdj5omEQnf9sTu3i8ICNIXiITPWnZRwTO73YgkhSw
         G+W8mmVFGfL7fxxdcjvsiduCOzpOyNVUc7SMCU0pEkmD5vMkSmVDG45JPMxihPOMmzHM
         OghNRBvgE/XQ1m1fHbyXTiBlLMO83ID+CXl5vDLmGpVUpJ7SOqCmcJCx0T4Z19Wx4o/3
         lpXsu1BmgEjN4bdCvRm5QYQrK+YyCz4CdL0yMNwjN88Fw3wxnC9nYPXagRHr7e3oo8Pj
         OZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763477977; x=1764082777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zUAnqwUQ7mMEKfAAq0Pm8CCEggD/qceLgK2oNv/WhY=;
        b=EGdOuRevc3zZTo8DzP/EHqHcpyuz5dBvoocFgBn7APKyAaXFf6CWJITjxb8ZDbwxbd
         c4T1/gSue3rZu6x/EOsan39ZviM1BGrsGLXXdEndH4vv3yOrK1opedzw2Xg4QV+6yrNM
         2xKSAxB6H6jHFgqhIlbM7Ckpq9erdlIo6irgajczsDUDC4Z6G7huwDAWhdGMG0BVrDjp
         t9nB/CzJD6enMsDxOvNFsBW84drOolu4nOUl3Jmm28g6NdRnWcGo3zpcRWRDgx45k3CB
         UOOOhnNmKDgrAcXPjlt9KKtZRHkGMsRJZy78A0a5/BqWtVA71iTn6hsc5aBQGswSYmXS
         zasg==
X-Forwarded-Encrypted: i=1; AJvYcCU964A3q/sfhZTl3ZUeT5bMhZ036lQ2JCPhtyQvxXKApGWxXk7/tj/F0hK+1ZJa3MjXdk0uVbw8G88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4J05bA/nQgCeFQuj4azNwHDS6XL4UNF06x6XSa3fgNpVrRZk
	qWNUyu4jVLbLVascniYgx34+hZxndqvGck1C2IUeRqm5InIDtmpB00j7wkMWZFugUk4=
X-Gm-Gg: ASbGncuyWdGOrfwG8i/HDogHqAeVrraUZWryNb/rCCwbb29vmySV5wcd3Uhrz7JzufB
	znTkJJHqad0Z4n1DTvyP2Cdh4ustProzDvCmzL/UUHam2kzluPUa7TGjQXVwLF3sBy5Q7WdOcNy
	wyGS/0KGBrkbhwjYrcY9ZexYcUI2n00f9ZYHuWaL9Ij8OnrZ+uya1OlTqhcV9ZClCp8vk4tarmz
	TAqjdYMUlSafzRbJxcwi2ChNlqwHIX58yMkyn+IuLnqt1RGXSWkhI+1mVXbNPGt7+d+Hj30/Ya6
	tk5gntojOWdFkB94sWGZTmkDNIet8Ag/U4admNNx3vUH1lebKjXPdMMolm09MUdK2cH/apB8A0k
	CSvdarHd+b0lm9KBJosxu3LfqlHLdVjikvPn5vbJh3D5wfrwr5yWoP2ohr9j3Enub0IK/nrAUDk
	yAlMgCNlKtd6tHW1J/J7ZV/FqisTp3s3qwLwt9eVhYevvJOoP7C+ybbeYemEpTegh3aMU=
X-Google-Smtp-Source: AGHT+IFmOGfhY23WsMGsPUUjQKfSR05e4XRcukJGt61kp9ViFdOBWiVKVUUuzQ+TB82GrGuUAmTsrw==
X-Received: by 2002:a05:622a:1a08:b0:4ee:1563:2829 with SMTP id d75a77b69052e-4ee15632a6bmr144570871cf.72.1763477977218;
        Tue, 18 Nov 2025 06:59:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee275abad5sm34184941cf.14.2025.11.18.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:59:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLNB9-00000000NQI-239J;
	Tue, 18 Nov 2025 10:59:35 -0400
Date: Tue, 18 Nov 2025 10:59:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
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
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v7 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251118145935.GI17968@ziepe.ca>
References: <20251106-dmabuf-vfio-v7-0-2503bf390699@nvidia.com>
 <20251110134218.5e399b0f.alex@shazbot.org>
 <da399efa-ad5b-4bdc-964d-b6cc4a4fc55d@amd.com>
 <20251117083620.4660081a.alex@shazbot.org>
 <20251117171619.GB17968@ziepe.ca>
 <3599880e-5b50-4bad-949b-0d3b1fb25f3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3599880e-5b50-4bad-949b-0d3b1fb25f3f@amd.com>

On Tue, Nov 18, 2025 at 03:37:41PM +0100, Christian König wrote:

> Skimming over it my only concern is patch #6 which adds the helper
> to the common DMA-buf code and that in turn would need an in-deep
> review which I currently don't have time for.

I think you should trust Leon on the implementation. He knows what he
is doing here when it comes to the DMA API, since he made all the
patches so far to use it.

Please consider just reviewing the exported function signature:

+struct sg_table *dma_buf_map(struct dma_buf_attachment *attach,
+			     struct p2pdma_provider *provider,
+			     struct dma_buf_phys_vec *phys_vec,
+			     size_t nr_ranges, size_t size,
+			     enum dma_data_direction dir)

If issues are discovered inside the implementation later on then Leon
will be available to fix them.

The code is intended to implement that basic function signature which
can be thought of as dma_map_resource() done correctly for PCI
devices.

> So if we could keep those inside the VFIO driver for now I think
> that should be good to go.

That was several versions ago. Christoph is very strongly against
this, he wants to see the new DMA API used by wrapper functions in
subsytems related to how the subsystem's data structures work rather
than proliferate into drivers. I agree with this, so we need to go in
this direction.

Other options, like put the code in the DMA API area, are also not
going to be agreed because we really don't want this weird DMABUF use
of no-struct page scatterlist to leak out beyond DMABUF.

So, this is the start of a DMA mapping helper API for DMABUF related
data structures, it introduces a simplified mapping entry point for
drivers that only use MMIO.

As I said I expect this API surface to progress as other DRM drivers
are updated (hopefully DRM community will take on this), but there is
nothing wrong with starting by having a basic entry point for a narrow
use case.

Thanks,
Jason


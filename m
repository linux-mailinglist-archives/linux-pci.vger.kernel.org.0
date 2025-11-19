Return-Path: <linux-pci+bounces-41622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190FC6EFB9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DCC635AF2D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92413587B3;
	Wed, 19 Nov 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q0A2KJ7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7B352FB5
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559334; cv=none; b=j2nvPOA9SRqlLgooleAebZcHXpYpBAM5+1hlUfBwHDQ/CODW3E6wkbCVI+U/f33be2cZYPrTzUqmDvUn81JjhRR2HrkLWpRGMl2i3ZQZs1iQFJ5kcJSraPWXlX6XaRHmvE++TSbt4GaJwfmFFB4K/9UAY8SqyjLtWRUJUyANYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559334; c=relaxed/simple;
	bh=JbbhmQiTlI31d28XPGRBqj9eq2p7XGaOpuCDuXLlBNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABinw5B/kUvhOhKEqy+opI24sUlBtdHlDTZroQJg8C21xkk3rMos0wbZoE5eUyCgyz8bt4C2FUGzOBRdQcOVrXxuRiClD5nsKsfHwwk283zc0isOVe9wLXeCCBjv6ikAz96UgpqUerZV2vk//0KL9+MWHRYYKRMZLpIqmSqZ8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q0A2KJ7+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eda26a04bfso75869741cf.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559331; x=1764164131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72A2miNlT6HYTvn6gfrMP1LsN3+/rcjlJPwocEiTvrs=;
        b=Q0A2KJ7+QNz7Du+Iu0DMoQYF9BPquUCs/jIMwr6j8yjAJYCoUd2gtuG8vQUjR8XFmz
         BWU0OXFasN+uYXzui5ccF9deC4HtKGvvT+DRuxn1jSOtubFSQSTLMDOCI0v+OkrmnQo9
         j30dh3Ui+99KMkOenB22DloIr/bkj7hqXrn/VjYcH8e78vnEJUMWflxtjGpc5bOYPhAo
         KXmcPuwjhRA8P5J/K6B3nGGLubDNoWabMG9R/EXoYaFsaHe68biGjnve1stMiZBlv7Em
         nn9dpCi4NhEsLSnTb4JJW9K645HB/HQBjJ/ZBpJ8CfKLpA3GNs2AkNnBXK9kcFhw5d1U
         l8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559331; x=1764164131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72A2miNlT6HYTvn6gfrMP1LsN3+/rcjlJPwocEiTvrs=;
        b=nGLH6d+tNlfhMqiEuFFiTKDlQK1GzJLjkxW8bvGSB01Ra4dUkgJVH65J9lDyRmlYRR
         hm6opRo+lp9E+EBRfC2OPV3XbpS8FmHzRzVu/oAjcOYNsoQOx4ILJitKSpBYTFHvJCE8
         epp7QBs09wDyS6i5Mc0c5yfh7HAOy4wse33IepRUlprPVJa09Cf4YO+VdWzhuhQtzbkb
         ze3/wU2tfSspKvx+pccXBNknmLKXQCyx/CEeS+RGnHB6Qdw2cxJ9AjXQOk6fDz9S3smr
         /OhSV+gJOm+57CDIiB0gK3/8TUEk6M/Y4L+ZPCO5ilU5qA9zEHd+yyu6C4lpjMbltXTb
         drPA==
X-Forwarded-Encrypted: i=1; AJvYcCVbatZKRo8KBv/XQGOgY3kBHAht/Vzz/t1aa7HjzRQol6SbLTEmWGh+mPGV5QH3nfMGCsTlj8KcvoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOcR8LUEv9xjs405oV4VgEv+8a4o257PwXxdz0AZUAH+ABqCQ
	WhSu/Y+kWR6BcquF7XfM/YsOn2DxZ/a5XFhgVAmNp20+JqdiUw4bF1Ejqa7/z+jb4pQ=
X-Gm-Gg: ASbGncuPYvr7MMJdIp7mRMwzdk81PfsUGJWT6mZCvu39NJcqdo3AwQc4unRQJPiJBIw
	hfqiTkkF+FF4FxuHE8N4ROMg5bZuyay2izKt0KcS+lYgYaEyxKNtaIltsfde1x/f3OenkxEOAYy
	YIGlLI5Sexi9P45mJyUOPrurgmLrdaVdP6ffpYHnh2wWwDAHJvvaNgvdCslVu/WMKy0tcUMtIkg
	jgMVyq/lL2OEM0G0Hl28U+zb1o46kFI3DOeZf4oDGqpPvp9yRWMgF5ubf/g/4mIW0R85qHNOiH6
	rsvvBCGjQNrhFPhWB5ZIakuV13FyJbd5TUupkH3/5CZ2zk7Afwquadc9FrAkiDtgMVrcxrzqCFu
	50cYKfAwM/bRrw6FACZIw4SqAqICOgG8OGeI0RO2n+LbQnw9YP+pXHZ7zr8WSTvAa01nmeQkp9M
	m9HNQuR4fk6S0LZqpGsKKpCwLKlfOknT01Xwgz/gUYZuTUjM+DLtNyR7Ua
X-Google-Smtp-Source: AGHT+IE7dgToIwQMvgHU78QddWp+ZiJRe5Ch8SPXRMVN2DOwf2T1NT7zeC+YapS6FYUcpx8f/T/2tw==
X-Received: by 2002:a05:622a:256:b0:4ee:16a8:dd0 with SMTP id d75a77b69052e-4ee16a8d595mr193299331cf.53.1763559331028;
        Wed, 19 Nov 2025 05:35:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b376dsm127986771cf.7.2025.11.19.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:35:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiLJ-00000000Z9b-1C3G;
	Wed, 19 Nov 2025 09:35:29 -0400
Date: Wed, 19 Nov 2025 09:35:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 05/11] PCI/P2PDMA: Document DMABUF model
Message-ID: <20251119133529.GL17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-5-fd9aa5df478f@nvidia.com>
 <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>

On Wed, Nov 19, 2025 at 10:18:08AM +0100, Christian König wrote:
> > +As this is not well-defined or well-supported in real HW the kernel defaults to
> > +blocking such routing. There is an allow list to allow detecting known-good HW,
> > +in which case P2P between any two PCIe devices will be permitted.
>
> That section sounds not correct to me. 

It is correct in that it describes what the kernel does right now.

See calc_map_type_and_dist(), host_bridge_whitelist(), cpu_supports_p2pdma().

> This is well supported in current HW, it's just not defined in some
> official specification.

Only AMD HW.

Intel HW is a bit hit and miss.

ARM SOCs are frequently not supporting even on server CPUs.

> > +At the lowest level the P2P subsystem offers a naked struct p2p_provider that
> > +delegates lifecycle management to the providing driver. It is expected that
> > +drivers using this option will wrap their MMIO memory in DMABUF and use DMABUF
> > +to provide an invalidation shutdown.
> 
> > These MMIO pages have no struct page, and
> 
> Well please drop "pages" here. Just say MMIO addresses.

"These MMIO addresses have no struct page, and"

> > +Building on this, the subsystem offers a layer to wrap the MMIO in a ZONE_DEVICE
> > +pgmap of MEMORY_DEVICE_PCI_P2PDMA to create struct pages. The lifecycle of
> > +pgmap ensures that when the pgmap is destroyed all other drivers have stopped
> > +using the MMIO. This option works with O_DIRECT flows, in some cases, if the
> > +underlying subsystem supports handling MEMORY_DEVICE_PCI_P2PDMA through
> > +FOLL_PCI_P2PDMA. The use of FOLL_LONGTERM is prevented. As this relies on pgmap
> > +it also relies on architecture support along with alignment and minimum size
> > +limitations.
> 
> Actually that is up to the exporter of the DMA-buf what approach is used.

The above is not talking about DMA-buf, it is describing the existing
interface that is all struct page based. The driver invoking the
P2PDMA APIs gets to pick if it uses the stuct page based interface
described above or the lower level p2p provider interface this series
introduces.

> For the P2PDMA API it should be irrelevant if struct pages are used or not.

Only for the lowest level p2p provider based P2PDMA API - there is a
higher level API family within P2PDMA's API that is all about creating
and managing ZONE_DEVICE struct pages and a pgmap, the above describes
that family.

Thanks,
Jason


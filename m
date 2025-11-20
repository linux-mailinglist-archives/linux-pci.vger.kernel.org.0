Return-Path: <linux-pci+bounces-41789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D72C743EB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C7A04F0A75
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0533AD8A;
	Thu, 20 Nov 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jMJVlNB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277533A6ED
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644850; cv=none; b=D/Ez9ZU7Pf4shL56qSS9ch7dGPUR4V8kSVkAu7psPhZth02EZCcBCy/NAfdZ03WcyiGlcH4QI4DHb8LIOF/xQlmVFVfArfgGLcdFHBWxO9efXWvdaSYZI/34C+qZq2vZw8gWNUr0VaIpte3JHzZBWpfATA+2pEF1WnkE+LsVgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644850; c=relaxed/simple;
	bh=FAIy2u4gJscDNGUshiInImCPqOKl3iOKQJH6e6Bc4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j73Is1L1y/hYZPTLGyM2b1FX5oE11NPoP8+GHXxjSWSqBJH27j8ZTcBuYQpTPxx8s89sj6hK9gFFbTcg/VLnnJyL8Sm+PsBYyh31534V6ZvDQGhhe6Qsa3um+YLkIJDjJAjQLj+dnsHS2VnMEcHVUFzESOclAKx5+ex52iYODVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jMJVlNB8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2ed01ba15so72054885a.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763644847; x=1764249647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=jMJVlNB8LyM4AYZyl088cBiSIlJ90Q1dm2hb+qOJix1EHdJs4siUbnVhSfjdoo+d8b
         CpJ6KfO7u7JniZDhdoBs1zVrqavLhdwn31rKFf/kVN8vkyxieUH5wcPJTih/9lZw+PEX
         fzdm1aYuxKCanV8/aYUVsuP51mR3HV9FaHggDK4qYX5m3Eht6ufYvvO9vptn0SOijTOl
         cfmQgVoxaFFQaCv0MtR3VFkL7VdP7LsWZJMB5e2tkAY+4CqMtLl57rP2UzUjo5ld0ad3
         Ew7cnRVtQJOT76Gc3wbQzgtVC/yQSTJ4MullMwUuBOCRwifmwR9JypsEhj+RRVt4akF1
         VX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644847; x=1764249647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=lJLXxM2zoR/yVnunuOO/w0U8/r+YG+mDOoZB0MfS5/e0THU4xNRtK+snqY3yIdUZKK
         jTLrf4bn8x26jv8BmarB9ddjLnGXpPElflMcqdawUxOJFEs7T9ZQg7ltrqqhK31Vi2cs
         w9+C4cci6yMiOo3NHoTzXR/DgKLOJ+muWILmJ1qgbsHWQciBHep03IW51ZXzVkoAC/aE
         7ioioBOwmkDvah1+Hlu9omiwFIIkw9i5iaq8wixhU6lkdqZW3yFf01n7MhZ9xS8GMzVc
         QsqI+mqUFT8iTC0+F96MCiV3SHS2urp9EXMicicLzqBN180xmbu57cqEcFuOleRue0CC
         606w==
X-Forwarded-Encrypted: i=1; AJvYcCWOvM1NyHwIfs1u1CiaySDI+himSV7apQHKoDzcP9Mhi8xbtATO8PqINndXhuJDD1KpdiUJw/RD2nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3w3HCKnsyEKgNafgBfUxBg7ZbweaWrUheabl6UqrJsjngCdOw
	gclPTxHAQU1oLAJPQQTLw5Och5CSEQaX0oGj/x4/NIFcrr+2Ro1+0QShCmy76OQr64k=
X-Gm-Gg: ASbGncvB8he8igSyQL6oK5x2ruZ5K9H2PGFNanA6KXQWv9xSiaZ7x4biETKB71klz0+
	wap5T+k3PCUB2/nQ1go2S4FA3gx8N8Yd7ZWZI/h5y/A1MDYu2CzffQmwB1won0pWXiLSGuHj8Xy
	1i0Du634iwvf0MS2yiFqsPG//mDGsvkERLwZOgKE4/yiOi8U4T8BHAgLSXMkNbNuwnFGsY4OfqH
	kTcaomj0spmdLfsQ3ipYPMw1AK30UZrEzncW5RC/+AL3piFTocPZgOiaOGSMtILHs0cVSSI4g2j
	0JGtxoYwtUQmCczg1YlrXEFeRM3hmoiYugK95U+CBCa5BO0TOUh5DvSW+JkFiU3m7s1WXbVblRi
	pTEJCttWIhU1jYoa07dyQ65dTCeHbQ3DbafVmdVjkB82tG0YqcrXhE0ateKIkl5e+/kVkO0Lq/S
	MxanWRQgtPO23RDW2AbieklV9ULUSq32k6zjpXF8FXxQmeu+XbUaoB1IMN
X-Google-Smtp-Source: AGHT+IHQ4fmxCAI4/D2tK1B8sYqUFbudidu6PckWMercsX/iRS90WBjHNHkg95yPWC8b179KW1QKQA==
X-Received: by 2002:a05:620a:318a:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b32a193b85mr303322785a.54.1763644847316;
        Thu, 20 Nov 2025 05:20:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13ccsm148498285a.26.2025.11.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:20:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM4ac-00000000gLM-0tBz;
	Thu, 20 Nov 2025 09:20:46 -0400
Date: Thu, 20 Nov 2025 09:20:46 -0400
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
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251120132046.GU17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
 <20251119193114.GP17968@ziepe.ca>
 <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>

On Thu, Nov 20, 2025 at 08:08:27AM +0100, Christian König wrote:
> >> The exporter should be able to decide if it actually wants to use
> >> P2P when the transfer has to go through the host bridge (e.g. when
> >> IOMMU/bridge routing bits are enabled).
> > 
> > Sure, but this is a simplified helper for exporters that don't have
> > choices where the memory comes from.
> 
> That is extremely questionable as justification to put that in common DMA-buf code.

FWIW we already have patches for a RDMA exporter lined up to use it as
well. That's two users already...

Jason


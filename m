Return-Path: <linux-pci+bounces-41624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FDC6F152
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAEDF4F7834
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8035A92B;
	Wed, 19 Nov 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fbXe4Vjx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA9359FAB
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559432; cv=none; b=Vev7Igw0+MK4BdqHptppoeBObzTWAr0+Db68QjPsij6YedcaCRlSGFBZ0PVjnOLHWu9gyrY1XQYAlJ2bsoG0yGS/4Ygk1r7vmrC/xkjzlpVBZW237EVGAFtfe+lXIINeJNUm7Ka03+8vlVRa8ECKesMH8TFLzu1Gxcf8ETgBkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559432; c=relaxed/simple;
	bh=xHij0HoeROljwYVIzlugVWfpQyDCueEmuef+LW2XwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gymeCRaZBafXZMoPpxmw01L8W33wFJ0MKI9t+7o5GjmZiDJWg2dkxu3TImU9GtbpLDp/68yaFVmTmn+p8vsrTxHHt8fg0f/TiypY8H/S451te/Sy7GCZDqc4+8+q61p4bm3l8xM2tc72kBN09QqCzSP5UbWx29tbHe/jMV/MRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fbXe4Vjx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804650ca32so61216856d6.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559430; x=1764164230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=fbXe4VjxC23iYkeLY6whMHNkkabBkvJIbJP5uWEZ9VyfGmzFQGzB51LkWHp8IJDAfy
         bc+eLn4USPmSpsqj3w8yzTCbSWrINyQaCzhx2fEyFsGqHQot9GoulHgvevmJK/p+6YJe
         uuqgBjlYy9SZ2oFV1DyKPu/HDjlNaS7AdAB3/WXAttezKn3TRJQih2HNbzrWUBTHOeu0
         UJ2OeI0gafI/ERIzGOe9pXUqUOsEzFQpKb1VF8JKgbox0izii7oPTuI8eo/HdU9yTM8m
         sWOXfMhDn1cdFkJBrCL78GFZ1KRdezr14MAtsv1TRUBQrZyIN8Rm6LRdR8ltbAsYsTUe
         42Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559430; x=1764164230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=fxSDonZi7Bn/BLw8vcXkUcNa35ZWqaRmZCvHY3GvGnN5zhgEC4I4TwZn4OgKbHKMqH
         irynxMtRB/OVnERaM0uC9QRaCJmiEnuh9k5PPbBd9AQ09cfCYvsYrIzNOKK+xORRYS9y
         Z8oYwwrs3D1P92KTvJuiIUYWAbDAroighfEYlaRnLx8XNo0LrXMZHOopzjtYyQXwgxTL
         7nWMJxO4gSqilhquHd8pfdUdZYP9dCaLrHsd9UyFqdhBlRceA3ZdmHPb5Jy6bCI2/IBv
         pDZhRWiMIm2cAYlcSmi+puH71SEzBBOi01DeUpKuFCtNLtqo7NTnYzEWABp8NrhcRoxS
         k9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVvQtmIi3AlszglcisEaTWQ7ncGZeDx2+EYr+gE/1DfRFFz+m7yCHmselwV84z7iWSTGN6AKP2Iy0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNH9V3kj/Myb4ichCS+ehs6NFWlEiBMqjH6Qsc9u6HOOaxumLv
	4u6uhNtVdZVGTHMpJ/AXc/EqmVoxSkvTvhoBfyzV2u3Uj2ipIsWZdi2OKq7T3ZXZ1sM=
X-Gm-Gg: ASbGncuIUxnsN13+ikM/q66mfW1R/7XNhJXpjJincNcsq6/GvQ5vnTQLDxQCrqncURl
	+96GYbQVlurJCsUEnsbG+fBUjZSGudU5Ga8UudnKcg8xx1V5dRfB8KgtsHQN/C9p9X3nx5TJEQg
	nE9BetIovYfrkMgWxMKN4vSijW/ZWCyEfaZApue/dOCIF+xv6dT7nXp0O2iemdlQxL8B39BweEt
	v2Bnq2yioZhRnSBg9ybh4Y5FUsqpznJgfd0YG21hEKk89fJL5bXo8FxydV2BpfHcfglO8S4UB2u
	GeVuOI0t/4EbK2HJwW7R3TJnc2zAEf5SL1fyd5ZVJRqEmgoNIGvxRckvXnj7hjA7t0ceh7zIMyH
	spwhhvSxW//pLUISRCFS9JSycXWu8eJ1cscdSoB2KgSjK8GOHh7Gv66ObmiPSXcNtZJggxEtJIv
	ENmtTTuW+xumdQC/GLPGbFpDym0RvfLTQQDZo2cuwYbthVkCZc2qFpVF/2HZ0QIT2l7nM=
X-Google-Smtp-Source: AGHT+IGopBrMkEkq4/9KDO3x1qdzFmkcFO+Cz6Is5DlvxN8PyWRrz38DMZOLki2k1pBf80D+Z8AYkg==
X-Received: by 2002:a05:6214:419f:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8845fc3e0f0mr26190076d6.10.1763559429603;
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm135128356d6.0.2025.11.19.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiMu-00000000ZAY-2EdI;
	Wed, 19 Nov 2025 09:37:08 -0400
Date: Wed, 19 Nov 2025 09:37:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
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
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251119133708.GM17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <BN9PR11MB5276BC3C0BDA85F0259A35058CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251119133000.GB18335@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133000.GB18335@unreal>

On Wed, Nov 19, 2025 at 03:30:00PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 19, 2025 at 05:54:55AM +0000, Tian, Kevin wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, November 11, 2025 5:58 PM
> > > +
> > > +	if (dma->state && dma_use_iova(dma->state)) {
> > > +		WARN_ON_ONCE(mapped_len != size);
> > 
> > then "goto err_unmap_dma".
> 
> It never should happen, there is no need to provide error unwind to
> something that you won't get.

It is expected that WARN_ON has recovery code, if it is possible and
not burdensome.

Jason


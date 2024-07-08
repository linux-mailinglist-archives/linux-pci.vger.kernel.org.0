Return-Path: <linux-pci+bounces-9968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6A92ACC6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 01:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80217282BED
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551561534E7;
	Mon,  8 Jul 2024 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="al5nZvOv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221315217B
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483045; cv=none; b=GeO92vyHEMXGBh9n4wZsHl8zx7Sgqj/n8BHbvkY6tCDeFKuGhgpVoK1M62/FZAW2l6N6u+jZWo1fLI2Y7XZXnjfsUCnV+LK9T2qRRjio3/Y8YHXh4D6XhrGgcsUOCJY/1UFpTeG1/iFAfUGkomNBIdRrQ+S8m1wGKhP8JyC5YN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483045; c=relaxed/simple;
	bh=p7iQjHJ2M5dwP07IVo/MoA0+Dlglnl6jpSoHPFEK4Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9K3esKMNBpM/0ckNQTfK88wzSg3sxhS8vthNlYyXVAW/8bo8Iyi6XuWh7r5AdvmRzVvPoR8cwIKtUHakw8MRD9ZQbNQ2tD3xq+2jmfvSi2iZgSkXXuEMjF2q+21pfqp5MFQCKjZvMppeyNWSKuBiPx9kde0O8FgmA/Mz+qjVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=al5nZvOv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e02748b2402so4937779276.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720483042; x=1721087842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=al5nZvOvTQgd0+PLH+wEqyGI34zrtBrPl0sh4/DvnqRTier4GyenayxwkcEoV0UylR
         oYPLyoC4X1Y1qupf4DQ6QhZEMhXlpSrfAjrtk+/wzLylYwHdlE/lU0L9j6518du3Lh/P
         9505Ih1x8pdAHacpozHNXGLwisZWFK87wTmdeSkEqNhy8KtlqkfWZ1xKj0GmJPNFh+st
         bYQsUSyHUftG+JDTjJy1QyOnz3NuY/q9IteUepxJhWa++pz3FVzLfALbaDZ5EKO2U01z
         97o0xtujbO8Sb/lktaPRzrLBcHlprLxOjnWS5xziKEBREJUxIuhnxYHqO2kb4rW51v1c
         bMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483042; x=1721087842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=A0rg1h2cyBPj8JoDYMl/h/8Cmm/lEydlqWvzR36GP+t3YYZex23ShEpWBN8RXR4PD8
         Uz/QlzfOCt/e++njfj7gV0rMeybarSVKsynqRFMkJab8USz8zVcWToPJBusO5z9Nmr5x
         HmqRm8bDocoyhmb8xCOv7fCSsG8hAhP6nZkxa5kLWAT/g66NZ6M/HiYlsmy9UIigSoF1
         wh0HzRgqksmHWRedGd0Z/SkAKgtIoPtOv75umeYvp09UElAPevP8hYdt4GT+OZfekjB0
         XQcT/5pIo9PLTacdh7M9LRgvpHJ093ld3HX2u1uRYXX58Hw6gBEphEy5CHwqn6OBPWo+
         Sdfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQfqRtNe0560uC/BqLN6LrNPAPOrOzb4N0pLcLM4qijhTzPUAf18+VMu5N1hA8vFHyNhNros1HxUsSE1+UNV1c08ot3PNQvn6p
X-Gm-Message-State: AOJu0Yz36G9wVrEpHiBVIn20aQ36M1liCvPsegCJCfWnzjdeXlGhDlaq
	CKHAYxtG71Uj+aHyF0AEUMRAQSWiTlhVEZuWP4pgKYWpXM8a4LLDfKd9r2YZaJk=
X-Google-Smtp-Source: AGHT+IFVd0YPFm+CFj+OFAbn4VlgzR0c7GB9Ja/EMJb3su7krIj2ap0s4sP+8C7C1jj96rzmX8e+3g==
X-Received: by 2002:a25:d694:0:b0:e03:b14e:350f with SMTP id 3f1490d57ef6-e041b125e84mr1427037276.50.1720483042570;
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8ad1esm3902106d6.105.2024.07.08.16.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQyET-0014tP-5Q;
	Mon, 08 Jul 2024 20:57:21 -0300
Date: Mon, 8 Jul 2024 20:57:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240708235721.GF14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705063910.GA12337@lst.de>

On Fri, Jul 05, 2024 at 08:39:10AM +0200, Christoph Hellwig wrote:
> Review from the NVMe driver consumer perspective.  I think if all these
> were implement we'd probably end up with less code than before the
> conversion.

One of the topics that came up with at LSF is what to do with the
dma_memory_type data?

The concept here was that the new DMA API would work on same-type
memory only, meaning the caller would have to split up by type.

I understand the block stack already does this using P2P and !P2P, but
that isn't quite enough here as we want to split principally based on
IOMMU or !IOMMU.

Today that boils down to splitting based on a few things, like
grouping encrypted memory, and grouping by P2P provider.

So the idea was the "struct dma_memory_type" would encapsulate
whatever grouping was needed and the block layer would drive its
splitting on this, same structs can be merged.

I didn't notice this got included in this RFC..

The trivial option is to store the dma_memory_type per-BIO and drive
the de-duplication like that. The other could be to derive it from
first entry in the bio_vect every time a new page is added.

This same-type design is one of the key elements of this API
arrangement - for RDMA I expect we will need a data structure storing
a list of types with a list of pages, and we will DMA map type by
type.

Jason


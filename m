Return-Path: <linux-pci+bounces-44230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD561CFFFED
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDDA03009692
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3883242B3;
	Wed,  7 Jan 2026 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SVfBwqXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236B338936
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817468; cv=none; b=mchvZ+Qr0zgAiMaBL8acTTCNxvuWiFAHl3Xhq/KiYmj1LHkcytWnCdPevYZ69VslV/e1RGPkOP/zLw2zdJ32kZR/uQqkI+pZlta8qBJ+EkRHLh4raut6yBtzwp4kpysl98NSU/S9wjccJUX3Erl+aieHXYPZVcYulOU1VV9VJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817468; c=relaxed/simple;
	bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZCOU6NNUxE76V1ZVuNg64hkRHxFTJ2FtkDqW2A8EjOhOlTt+B+WFHzRsRu2FHDuoKxFfZKWNbuGHJTUUvfw1KamLsBHq8Amxsk4iMgkkSU+XmLRZ/b3HWqYPSCvB4OWmWP58xXO69GOSjffyWIMywUamFEctutk8aiExFXkkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SVfBwqXm; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2ea2b9631so274901185a.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767817465; x=1768422265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=;
        b=SVfBwqXmo9INeGgwj8+M0QkR0kNN1fKIykr9WSqmGV97J21rTBh1doiTFP43DmwM/N
         64PCjXzq7dBIAjkMSpLR8fiLoAkZ1mJFxCzRdmxaFKOZ8vsjOrk9Kgy7K0sqw9EkG70q
         fkPCBQILucR/MAzILD0SqD1+hNvFdtGEI9eysTxGy8o6Lxfz+yZrLg+LK0tivmJ8ZeKw
         ZSy7naOr+y70hGcYOTvm2r5Wfn0BHjm4SFrl1Xh5fHd1bpZBwTzyHqJTH7sBhQuC5W72
         yMajX7cu4+aPdGWhDgzWKKp+vOf15oz7KRyQxFLEVNhycs8UIBdgIvpMzvV/IQEQ7FmY
         jWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817465; x=1768422265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u8/mdCRbNm8MvpUWRoGYHAWAojzapM2ntHzieeqBkA=;
        b=Eggr/K78U1W/BH6mY5N+KxVDJPGSl7fcMprrEs04/mbR3xQMxmGLCg4zsNFBMbRAUn
         fGp9RBNu0N4IZasYZrrDYWTqkJyLie+kvNn8mPW8HfqSLo0/s4hjy5Z7CzxHCvedBFyX
         mmj4w+IpaHhNswHAW0t7mdY0wvyO3PQxh81Xdf9sryJP9GSxwSzFApktC4llMfz5KnQ4
         zUh0W7kc0N/ICxsZGdO3eYgyqruNKq0FZCVE5gQAyPp8LYOjOEzkrD/z/1MVB0q5JLFP
         NleATGrr5aQ9Cyo03OL1iGiGwhpXzjsQV+WrY05qvoiAeovwYCLQI+G2YEekABEIKQqL
         CvyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCwGtnvNPxbJOw+skziugxdMs0mmOq4Po1pP5FAcurMCCnma1bWQdSUSKwlERfZhy67OHP7rBKbWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxe7mm9EQkAKPThwSWZ3WFDcR/esxXI0gFvbWvqeOSwaMd9FQi
	D1x9lw/pYOrmPZUfvDSQJebK4Dy457v4UGLt/MEbouhVOh0+YTF9c4oZUQhKhac8qY4=
X-Gm-Gg: AY/fxX4AKHsV5G0qgpTV8sbJsfcZf/8HG/wMyn+HDCCbxBdvBYEvOJT97lxxAXrofuF
	etQuG2ifPNUpLXTA3LQDb9m1XX2wjXCSQTI7VBMJ+dSqi+i/hua+D75apSXkDbzDBwfg3s2Icy0
	IXsMwlS+MFn10PGkRCvV6sEvCfYt3+Q7DYwEZQIOmr0yjKzjUzKzhpJbCv2fc/S4aY44uAF5zLx
	rTW4nRV4OcNH/nSc/AN3sSyGjAjH9aKLb6X7qb/eZUcnNk4OozJ5fnnlCgnLcUS7t5cHnQ7Ug36
	PQ/Q22/NwsSnVNvOzniaw0BuvT124hbbREnrz7lEZha8tOkUeTeV3Xqek5RSAcI3uExwj8Hap0N
	zecpopXgQasvoAAMJs+H5JpPG10kmOpnoYGyguhe/bAar+4A5k+mMaG5oYiYYo0juy2ckCleAhs
	hh2V7Q5rsp07w4xemNzAE4HzQQBMv98H+MYXr4gqkk1fXytlD2FVSF7U4+688NrR4cHQw=
X-Google-Smtp-Source: AGHT+IFkPMUDNbhV7qApG1EaAD4bH67XKeWGZyq9t6Oa6ftUcT4ea6J2MjhLCsI7jETaTx/wz1BYtw==
X-Received: by 2002:a05:620a:2681:b0:8b2:e669:987e with SMTP id af79cd13be357-8c3893dcc02mr421767485a.46.1767817465357;
        Wed, 07 Jan 2026 12:24:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51ceb5sm470433485a.35.2026.01.07.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:24:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vda4u-00000002F6i-0YUA;
	Wed, 07 Jan 2026 16:24:24 -0400
Date: Wed, 7 Jan 2026 16:24:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
Message-ID: <20260107202424.GC340082@ziepe.ca>
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-11-houtao@huaweicloud.com>
 <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>

On Mon, Dec 22, 2025 at 10:04:17AM -0700, Logan Gunthorpe wrote:
> I would have expected this code to allocate an appropriately aligned
> block of the p2p memory based on the requirements of the current
> mapping, not based on alignment requirements established when the device
> is probed.

Yeah, I think this is not right too.

I think the flow has become confused by trying to set a static
vmemmap_shift when creating the pgmap. That is not how something like
this should work at all.

Instead the basic idea should be that each mmap systemcall will
determine what folio order it would like to have, it will allocate an
aligned range of physical from the genpool, and then it will alter the
folios in that range into a single high order folio.

Finally the high order folio is installed in one shot with the mm
dealing with placing it optimally in the right page table levels.

You could use a heuristic (ie I'm 2M size aligned or 1G size aligned)
or maybe use the MAP_HUGE_2M/MAP_HUGE_1G flags, or something else
perhaps.

Don't follow what DAX did, this doesn't have the limitations DAX had
to work with.

I also don't think drivers should be open coding the
vm_insert_folio_xx() stuff, the mm should have a helper to accept a
folio of any order, the VA and the phys, then install it optimally. So
don't export vm_insert_folio_pmd()/etc please.

Finally, Peter Xu has been working on the issue of setting the
alignment of VMAs when they will be used to hold large aligned folios,
that would help this be more useful by avoiding the need for MAP_FIXED:

https://lore.kernel.org/kvm/20251204151003.171039-1-peterx@redhat.com/

Assuming the folio size can be determined early enough in the VMA
process, though Lorenzo's recent refactorying here into mmap_prepare
may be helpful.

Jason


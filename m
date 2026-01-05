Return-Path: <linux-pci+bounces-44043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43160CF4FAB
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFA043006465
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7933164C2;
	Mon,  5 Jan 2026 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Jap+phMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E889309F18;
	Mon,  5 Jan 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633897; cv=none; b=Arns9T7gGO51Ya3xAle7kGcF1NnLITIBCOFIc/zJd8D009gXftsoa4y5qBbweRUx+oe9iyTaUU2N/46RMl8CVnOoAt3Zp5HABCDFIJajgftIzHXB3PiYAZ7cJ0RdA9ddaoh4DNywTl26bkOEu0sIFjFUPTkDuIU3r+E+mpBWg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633897; c=relaxed/simple;
	bh=VvYOibbMOU9im5pRKA7o25bVCGnIv2Js/nSypY+/9sg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=V1eRbN1nz0sBXTOHpemWvglhUssx9fL2wtoJlCSwZ3UYnLMViCBYNfrmrt8MUJNtJBj6Ki5VYObLvEYU0W5q5KPDgM5qjohmPIy0kJxyKdECYPFbc6NhvMGizeHwc/uGGJWo/2/5lqMQXlRjP38Ix68gwd2M/4/R0ONK/Pw4tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Jap+phMR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=nPXCpaMeKr8anhQvykVWaeOhAh4K2CJRGmcFaO12UK0=; b=Jap+phMRmtmaCkqb9qwsgwj7JI
	nMb91j6DyoHvobSJzXUHGruB3Md3M3d+UdUDnY8fFM6Y5JkrTYHdUS2o9O6mpHaDQTTc0u/yInpwo
	AYAaUQQgA9xT5m6foMA/rc4K/cc8QTvc9kZKNSpiT04fGCUVkkKn6cyZr+yyC+UAkbXMP8D/oajbc
	RmXXZoikMBxNLvXL0mdn+hM0em/4gcWamJK4HCbXZbeMe+bpjqXZ5NpCPt6E0HzlOIBdwy9FJpwPQ
	KsZt6XtHv/FPrBYPCBxljHV5iyzEuLykHtPMXVOR7zpqsmVQ0nDXEPdkFH5tZ9nr0hmCI4iEHwHL1
	vZdU8p+A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vcoK6-00000000l4E-1xnz;
	Mon, 05 Jan 2026 10:24:55 -0700
Message-ID: <1a6ff388-c282-42c7-a0a2-d8b2f5ed720b@deltatee.com>
Date: Mon, 5 Jan 2026 10:24:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-11-houtao@huaweicloud.com>
 <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
 <beb61666-020a-d99e-e84f-c16111039e66@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <beb61666-020a-d99e-e84f-c16111039e66@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

>> I'm a bit confused by some aspects of these changes. Why does the
>> alignment become a property of the PCI device? It appears that if the
>> CPU supports different sized huge pages then the size and alignment
>> restrictions on P2PDMA memory become greater. So if someone is only
>> allocating a few KB these changes will break their code and refuse to
>> allocate single pages.
>>
>> I would have expected this code to allocate an appropriately aligned
>> block of the p2p memory based on the requirements of the current
>> mapping, not based on alignment requirements established when the device
>> is probed.
> 
> The behavior mimics device-dax in which the creation of device-dax
> device needs to specify the alignment property. Supporting different
> alignments for different userspace mapping could work. However, it is no
> way for the userspace to tell whether or not the the alignment is
> mandatory. Take the below procedure as an example:

Then I don't think the approach device-dax took makes sense for p2pdma.

> 1) the size of CMB bar is 4MB
> 2) application 1 allocates 4KB. Its mapping is 4KB aligned
> 3) application 2 allocates 2MB. If the allocation from gen_pool is not
> aligned, the mapping only supports 4KB-aligned mapping. If the
> allocation support aligned allocation, the mapping could support
> 2MB-aligned mapping. However, the mmap implementation in the kernel
> doesn't know which way is appropriate. If the alignment is specified in
> the p2pdma, the implement could know the aligned 2MB mapping is appropriate.

Specifying a minimum alignment as a property of the p2pdma device makes
no sense to me.

I think the p2pdma code should just make the best effort to get the
highest aligned buffer for the allocation it can. If it can not, it
falls back to just getting page aligned buffers. We might have to make
some minor modifications to genalloc to create an aligned version of the
allocator (similar to gen_pool_dma_alloc_align()).

Logan


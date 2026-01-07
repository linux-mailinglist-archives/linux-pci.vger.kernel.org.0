Return-Path: <linux-pci+bounces-44232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB54D00274
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDE2302D934
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E4218E91;
	Wed,  7 Jan 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="sAs7KK64"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A5F4FA;
	Wed,  7 Jan 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821002; cv=none; b=Ol6vGr6nGlZp13iFUt8lXek3EoZ9mJNJwayIaT2N8L5MV61R0hxr7Pk3wnTrU8iLs4QeBy8z7cG/8Kpw7GHX142gfEWZvzUKOZ2C5JtXlZLDMF9pAudNrBsPLF5j3w8C7F/ETIanVZ9QMtddfSlSZ2uzt7MPr8FqSjyQB4s4958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821002; c=relaxed/simple;
	bh=b4yeaqVGqKNUKfjDWCItXN0+EUzle6tRSNvMaZb6t+U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=eXe6KeIn00ru4+gb2VcloWGdtYDrY/NvP+nbIK/+tiEvxG5pbJgseaVm/hahhxR03RMNDgca6/mB+YL+aADWdJhVlnL6lEGMiNkw71zXDFyVeniniScVT7P/ByRlIF1nZE86LCuO+jVdZC411ErVeMUS6Y01QzFQBfFntXptaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=sAs7KK64; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UkZv5onkyAXg00ymNzmBDBe0GBLZo5D/WkzgMa+G8aE=; b=sAs7KK643BWbWhoo6dF6UQ1/hT
	ZLLmOL/LPVznRjY+5D4R/1OIBjEGbBOAKimg/TrjMiTYbZ9Suqs5NKYOv2oYJIaV0Rx5hzGUkn6vd
	/9KjuYX4IPOeSz5EF/TriHk3wHFgOz6Sz/lAmLXfLaejw2/5GozSnvKBlFB7DlrSzk59G/tHTLq1E
	85vfcq1tY1L6TJ8DUK2kGelCJqhlxt4crpt5Tck1bCOssOIZo0Mu3hk1t5Fg8EUxOgsx11R8LDK6e
	e9kT6VK8iumDWsc2JoHZLObgto8LS/BXGS0VnuqYEirj8o55U+UXAMOFyVcUMXldKifXSan0zEErN
	nzh97lrw==;
Received: from d142-179-236-232.abhsia.telus.net ([142.179.236.232] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vdazo-00000002GOe-3sYV;
	Wed, 07 Jan 2026 14:23:13 -0700
Message-ID: <1d2714eb-f5fc-4e73-9114-8d644deccdcc@deltatee.com>
Date: Wed, 7 Jan 2026 14:22:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
 <20260107202424.GC340082@ziepe.ca>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260107202424.GC340082@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 142.179.236.232
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-01-07 13:24, Jason Gunthorpe wrote:
> On Mon, Dec 22, 2025 at 10:04:17AM -0700, Logan Gunthorpe wrote:
>> I would have expected this code to allocate an appropriately aligned
>> block of the p2p memory based on the requirements of the current
>> mapping, not based on alignment requirements established when the device
>> is probed.
> 
> Yeah, I think this is not right too.
> 
> I think the flow has become confused by trying to set a static
> vmemmap_shift when creating the pgmap. That is not how something like
> this should work at all.
> 
> Instead the basic idea should be that each mmap systemcall will
> determine what folio order it would like to have, it will allocate an
> aligned range of physical from the genpool, and then it will alter the
> folios in that range into a single high order folio.
> 
> Finally the high order folio is installed in one shot with the mm
> dealing with placing it optimally in the right page table levels.

This all sounds the same as what I was advocating for. genpool does
still need to be modified to support the specified alignment
requirements for the allocation.

If there is more help from the VM layer to insert different orders of
memory, that would be fantastic too.

Logan


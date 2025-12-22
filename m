Return-Path: <linux-pci+bounces-43534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A2CD6B6C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F11305FAB3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BD3277AF;
	Mon, 22 Dec 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qWc9bzQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC61925BC;
	Mon, 22 Dec 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422221; cv=none; b=DHz0hyXYQpeIgejDl9nG9kgDFei5zma8r+sglZVYARwayFImvkJvepqk67D7cI4KSNVNAcO6MZPRzhkfcxX5bVpFzAEdGB74fwR+R6DuZuPvyrOfzl+6hr/wsvQp6iVGhd5+Zciaq9HmxdVd0oECzHY73R+GF8UD6banc2ZXUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422221; c=relaxed/simple;
	bh=cGJeLKesR+zhk8haxMAf6cuYSCJc8bxKLIvj5GKFCPI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=TAjn+jvhp5zaR3JUFKYo9yjPUzg5j9co4WcqUaQOdDWocmnfWgRa1A50ukWs4YzDb+L52C4Wd8Sj8Q3ii+BLGWQVIuqYIvBMpTVigDZOolkLnVM4Z2zWjXdNxRy1LCPz0jb/593sUOhJR94pAalrI08rwr7LHngYV96nkwyJzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qWc9bzQ+; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=t8GQsgEnNEdrFwBBtAuZn0Q9GIr1eN47gP4XtMI9muc=; b=qWc9bzQ+KWzrrDDEfmRCfKMy+q
	BpQQ82uAdGJVYXBD4KbGvK6kg/vNGd4ro2s3ZAI08XZMZmPOKf73pPfo8VjP/fLk6D6ZYFADioP3P
	GhiuFn2SS6ykpv7UgUvLbr5nUfYtfCetjQsvpQX44xh6MOMuFgnEgw6iQT1oXEAQFU9Qw5jf+F/Iw
	BXqB+iX4HfwVfIH5wkARC9vO9NKsItHqonsl3W8aK0PiHf+oE92O/7LLApq+cSgM045iM+LHzVQwI
	q7KHwMC32e1xDGMn9M5r8AELIYedCjq6alJDW5jr7ILlAmaD/C8LTLwE5FIKbnMcKdxmI5Kimu8P1
	V7mFoPvw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXj6w-00000008Jb7-2atl;
	Mon, 22 Dec 2025 09:50:19 -0700
Message-ID: <4a91cfe7-75f5-49a4-89a4-fd6717e7e9d2@deltatee.com>
Date: Mon, 22 Dec 2025 09:50:18 -0700
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
 <20251220040446.274991-3-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Fix the warning condition in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Commit b7e282378773 has already changed the initial page refcount of
> p2pdma page from one to zero, however, in p2pmem_alloc_mmap() it uses
> "VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))" to assert the initial page
> refcount should not be zero and the following will be reported when
> CONFIG_DEBUG_VM is enabled:
> 
>  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x380400000
>  flags: 0x20000000002000(reserved|node=0|zone=4)
>  raw: 0020000000002000 ff1100015e3ab440 0000000000000000 0000000000000000
>  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: VM_WARN_ON_ONCE_PAGE(!page_ref_count(page))
>  ------------[ cut here ]------------
>  WARNING: CPU: 5 PID: 449 at drivers/pci/p2pdma.c:240 p2pmem_alloc_mmap+0x83a/0xa60
> 
> Fix by using "page_ref_count(page)" as the assertion condition.
> 
> Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Thanks for the fix

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan




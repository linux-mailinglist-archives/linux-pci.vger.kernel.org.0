Return-Path: <linux-pci+bounces-43533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CB8CD6B66
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F50E302B77B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AC1925BC;
	Mon, 22 Dec 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ee8WmXun"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F72C11E2;
	Mon, 22 Dec 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422212; cv=none; b=YC7faElqGWzstkbFmJJWT/G+659hDNsN7BScReB73FRO+qtMs20KAGP0Di+ewE96lV0JJxotq/8WzO89OSPyB46NL8ZARLMpr3DNxyrHuwiQnRYIkAdaJa12GrG+obRogVnJrLbU3v39fv0vAlBeDDXykrpYhBw/8sFjISRlBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422212; c=relaxed/simple;
	bh=ocNJIRWZwohj6MrUPO7CVvRPSq341IVNLYtqRY7pq60=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=ls6V5h/2NBnQ8UKBHIZpd33h0TtSByX1k/FROX43G0xO+Cx67oreQ/UgJvTahShLS50tdXkkIuWyTA7eCxCndsjOe1tcNqJhrKWzGr/QIt5TnkmwntE0HvPFZzqWhyY1foxlWkwMEGEnfCDmZO5c0Ytswfr/vSptrJw4hyNes/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ee8WmXun; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Kg190DLkPKaiJohQI6jqmDPUrKa96yp2xevLyMH3St0=; b=ee8WmXunPJLOsQa4E7AD0Qn0/W
	CJseKOSYhTHpdSF3EIwXXjV0QzPZFAOy9hUJChrTEzpfA7nmQ9UeMhrgoJmyyOnkjwB7IRUVLyobP
	zO5/D77jRsl6BgVBDnzdECyg7Gfr1rcES7bXQAIEOHiG0zUJZTPhAQatgzPN0ZvO5VBglFlXHZh5E
	zP/wqKqGoD7/BLOf5J4trN1m/sRkvSkoAbe4rHTGFj8bmGM0n30zAHBo+GEpIE+zDYGUOBx49vEXW
	2QPhSmMNSQIReNrNkFDZtzuh2uEXXd+/+JNvdyCTrs2ol95Nt0H/hs+5EkslWz28fs3K52AdQtVdH
	FXi0e4UA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXj6h-00000008Jae-1nLB;
	Mon, 22 Dec 2025 09:50:03 -0700
Message-ID: <7ee29764-487a-4b23-8580-a9f45d73e088@deltatee.com>
Date: Mon, 22 Dec 2025 09:49:41 -0700
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
 <20251220040446.274991-2-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> forever when trying to remove the PCIe device.
> 
> Fix it by adding the missed percpu_ref_put().
> 
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
Nice catch, thanks:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


Logan


Return-Path: <linux-pci+bounces-43623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DBCDB152
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD1C30198E8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807F20010A;
	Wed, 24 Dec 2025 01:38:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4042A96;
	Wed, 24 Dec 2025 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540299; cv=none; b=kzhaEhQYWR4JfkTilejIecZCl7gJL/KCpQCAiXkEw3XK7uIwjt77NGEoRN9RZgEf780vkpeRMUmudwR5FupaOpeVnj3SAm+FipM5NfbJRRHHtEG3nNFt5m4PRJlTswbJqrh6T5IcxtA71bqpKlGY3+xpC0FAM6dRaXcyDbWdEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540299; c=relaxed/simple;
	bh=Mk+uDUOmpLQgG+tbYNfv9H+9CAy9QA+i0uij0fh7Bmk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P4oRl8cjUmZshH9yBevCYEfEOLHEqXPn+VrN65SNojK2gvvM0q3brNZBKqxNucX6ekWh16grvrz8zUp5jjgCJf1bhuavAaVi86VxbS0ibGRpBpUAtU3EnpPA00+xhcFy4H9Ym0M1AZnTjLgAyoGF9BIPgtx54QS8fuYElVZMvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbZJD5T3DzKHMHx;
	Wed, 24 Dec 2025 09:37:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D4E934057A;
	Wed, 24 Dec 2025 09:38:07 +0800 (CST)
Received: from [10.174.179.156] (unknown [10.174.179.156])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_fjQ0tpM74RBQ--.51212S2;
	Wed, 24 Dec 2025 09:38:03 +0800 (CST)
Subject: Re: [PATCH 00/13] Enable compound page for p2pdma memory
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, linux-nvme@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Alistair Popple <apopple@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251221121915.GJ13030@unreal>
 <416b2575-f5e7-7faf-9e7c-6e9df170bf1a@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <996c64ca-8e97-2143-9227-ce65b89ae35e@huaweicloud.com>
Date: Wed, 24 Dec 2025 09:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <416b2575-f5e7-7faf-9e7c-6e9df170bf1a@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3l_fjQ0tpM74RBQ--.51212S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWUWw15XF15Zr4xZw4fKrg_yoWrAr4kpF
	Z5KF1rJryDG342y3sIv3WDCF1avwn5KFWjqryxKry3AwnxtFn2vw4jyF15u34UXr47G3Wr
	KF47ZFy3uwn5XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/24/2025 9:18 AM, Hou Tao wrote:
> Hi,
>
> On 12/21/2025 8:19 PM, Leon Romanovsky wrote:
>> On Sat, Dec 20, 2025 at 12:04:33PM +0800, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Hi,
>>>
>>> device-dax has already supported compound page. It not only reduces the
>>> cost of struct page significantly, it also improve the performance of
>>> get_user_pages when 2MB or 1GB page size is used. We are experimenting
>>> to use p2p dma to directly transfer the content of NVMe SSD into NPU.
>> I’ll admit my understanding here is limited, and lately everything tends  
>> to look like a DMABUF problem to me. Could you explain why DMABUF support 
>> is not being used for this use case?
> I have limited knowledge of dma-buf, so correct me if I am wrong. It
> seems that as for now there is no available way to use the dma-buf to
> read/write files. For the userspace vaddr backended by  the dma-buf, it
> is a PFN mapping, get_user_pages() will reject such address.

Hit the send button too soon :) So In my understanding, the advantage of
dma-buf is that it doesn't need struct page, and it also means that it
needs special handling to support IO from/to dma-buf (e.g.,  [RFC v2
00/11] Add dmabuf read/write via io_uring [1])

[1]
https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
>> Thanks
>>
>>> The size of NPU HBM is 32GB or larger and there are at most 8 NPUs in
>>> the host. When using the base page, the memory overhead is about 4GB for
>>> 128GB HBM, and the mapping of 32GB HBM into userspace takes about 0.8
>>> second. Considering ZONE_DEVICE memory type has already supported the
>>> compound page, enabling the compound page support for p2pdma memory as
>>> well. After applying the patch set, when using the 1GB page, the memory
>>> overhead is about 2MB and the mmap costs about 0.04 ms.
>>>
>>> The main difference between the compound page support of device-dax and
>>> p2pdma is that p2pdma inserts the page into user vma during mmap instead
>>> of page fault. The main reason is simplicity. The patch set is
>>> structured as shown below:
>>>
>>> Patch #1~#2: tiny bug fixes for p2pdma
>>> Patch #3~#5: add callbacks support in kernfs and sysfs, include
>>> pagesize, may_split and get_unmapped_area. These callbacks are necessary
>>> for the support of compound page when mmaping sysfs binary file.
>>> Patch #6~#7: create compound page for p2pdma memory in the kernel. 
>>> Patch #8~#10: support the mapping of compound page in userspace. 
>>> Patch #11~#12: support the compound page for NVMe CMB.
>>> Patch #13: enable the support for compound page for p2pdma memory.
>>>
>>> Please see individual patches for more details. Comments and
>>> suggestions are always welcome.
>>>
>>> Hou Tao (13):
>>>   PCI/P2PDMA: Release the per-cpu ref of pgmap when vm_insert_page()
>>>     fails
>>>   PCI/P2PDMA: Fix the warning condition in p2pmem_alloc_mmap()
>>>   kernfs: add support for get_unmapped_area callback
>>>   kernfs: add support for may_split and pagesize callbacks
>>>   sysfs: support get_unmapped_area callback for binary file
>>>   PCI/P2PDMA: add align parameter for pci_p2pdma_add_resource()
>>>   PCI/P2PDMA: create compound page for aligned p2pdma memory
>>>   mm/huge_memory: add helpers to insert huge page during mmap
>>>   PCI/P2PDMA: support get_unmapped_area to return aligned vaddr
>>>   PCI/P2PDMA: support compound page in p2pmem_alloc_mmap()
>>>   PCI/P2PDMA: add helper pci_p2pdma_max_pagemap_align()
>>>   nvme-pci: introduce cmb_devmap_align module parameter
>>>   PCI/P2PDMA: enable compound page support for p2pdma memory
>>>
>>>  drivers/accel/habanalabs/common/hldio.c |   3 +-
>>>  drivers/nvme/host/pci.c                 |  10 +-
>>>  drivers/pci/p2pdma.c                    | 140 ++++++++++++++++++++++--
>>>  fs/kernfs/file.c                        |  79 +++++++++++++
>>>  fs/sysfs/file.c                         |  15 +++
>>>  include/linux/huge_mm.h                 |   4 +
>>>  include/linux/kernfs.h                  |   3 +
>>>  include/linux/pci-p2pdma.h              |  30 ++++-
>>>  include/linux/sysfs.h                   |   4 +
>>>  mm/huge_memory.c                        |  66 +++++++++++
>>>  10 files changed, 339 insertions(+), 15 deletions(-)
>>>
>>> -- 
>>> 2.29.2
>>>
>>>



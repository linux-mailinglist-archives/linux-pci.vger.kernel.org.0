Return-Path: <linux-pci+bounces-43626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D03CDB289
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 03:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53190304355B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9124501B;
	Wed, 24 Dec 2025 02:20:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5921240604;
	Wed, 24 Dec 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542814; cv=none; b=b8egmRXcwsGtS4IyK47Sjoo9M9vllTsEXxPSerscJnVg/P+8ZR64SG2YgCq66SxyCVrKhrL4mjWoK6Kavb/vU2vEvWyM+PcKxOay/HojDfdmGfRcrBGdZpoux6z+5JUa3pWvFJB4PUy5dRyJqMNINsbJYCqNh6b7ALmNOEZoJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542814; c=relaxed/simple;
	bh=u68+XX9H1v74B1OWgy9kShohbaMWGGkeMdOqUcLmihE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V1mT+ISb1TYa6JVTbaLcILOsjb9jDkINs/U1unMsZzGen+lo4ODdeY+XFi9YHbOlQjzEgaGHyCqs8SsaPzlysklIAjuVPdURPZMsWaJkOGYV2VFLph+88M9ylkdxU1GSui/lHFb82uJmYf5Erec2+quCt6ejc96Iap8n/OPKa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbbDJ2ZbfzYQtLk;
	Wed, 24 Dec 2025 10:19:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4809040583;
	Wed, 24 Dec 2025 10:20:06 +0800 (CST)
Received: from [10.174.179.156] (unknown [10.174.179.156])
	by APP4 (Coremail) with SMTP id gCh0CgBXt_fRTUtpYCYVBQ--.1169S2;
	Wed, 24 Dec 2025 10:20:05 +0800 (CST)
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <beb61666-020a-d99e-e84f-c16111039e66@huaweicloud.com>
Date: Wed, 24 Dec 2025 10:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBXt_fRTUtpYCYVBQ--.1169S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3GF1UuFW5tFWkur1xZrb_yoWrCFW7pF
	W8JFn8tay8X3y2gwnIq3WDuryava1kK3yjyryxt34a9FnIkF1fKa4UtFyYq3WUCr97Wr13
	tF4YvF9ruwn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/23/2025 1:04 AM, Logan Gunthorpe wrote:
>
> On 2025-12-19 21:04, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> P2PDMA memory has already supported compound page and the helpers which
>> support inserting compound page into vma is also ready, therefore, add
>> support for compound page in p2pmem_alloc_mmap() as well. It will reduce
>> the overhead of mmap() and get_user_pages() a lot when compound page is
>> enabled for p2pdma memory.
>>
>> The use of vm_private_data to save the alignment of p2pdma memory needs
>> explanation. The normal way to get the alignment is through pci_dev. It
>> can be achieved by either invoking kernfs_of() and sysfs_file_kobj() or
>> defining a new struct kernfs_vm_ops to pass the kobject to the
>> may_split() and ->pagesize() callbacks. The former approach depends too
>> much on kernfs implementation details, and the latter would lead to
>> excessive churn. Therefore, choose the simpler way of saving alignment
>> in vm_private_data instead.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  drivers/pci/p2pdma.c | 48 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index e97f5da73458..4a133219ac43 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -128,6 +128,25 @@ static unsigned long p2pmem_get_unmapped_area(struct file *filp, struct kobject
>>  	return mm_get_unmapped_area(filp, uaddr, len, pgoff, flags);
>>  }
>>  
>> +static int p2pmem_may_split(struct vm_area_struct *vma, unsigned long addr)
>> +{
>> +	size_t align = (uintptr_t)vma->vm_private_data;
>> +
>> +	if (!IS_ALIGNED(addr, align))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +static unsigned long p2pmem_pagesize(struct vm_area_struct *vma)
>> +{
>> +	return (uintptr_t)vma->vm_private_data;
>> +}
>> +
>> +static const struct vm_operations_struct p2pmem_vm_ops = {
>> +	.may_split = p2pmem_may_split,
>> +	.pagesize = p2pmem_pagesize,
>> +};
>> +
>>  static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  		const struct bin_attribute *attr, struct vm_area_struct *vma)
>>  {
>> @@ -136,6 +155,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  	struct pci_p2pdma *p2pdma;
>>  	struct percpu_ref *ref;
>>  	unsigned long vaddr;
>> +	size_t align;
>>  	void *kaddr;
>>  	int ret;
>>  
>> @@ -161,6 +181,16 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  		goto out;
>>  	}
>>  
>> +	align = p2pdma->align;
>> +	if (vma->vm_start & (align - 1) || vma->vm_end & (align - 1)) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: unaligned vma (%#lx~%#lx, %#lx)\n",
>> +				     current->comm, vma->vm_start, vma->vm_end,
>> +				     align);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
> I'm a bit confused by some aspects of these changes. Why does the
> alignment become a property of the PCI device? It appears that if the
> CPU supports different sized huge pages then the size and alignment
> restrictions on P2PDMA memory become greater. So if someone is only
> allocating a few KB these changes will break their code and refuse to
> allocate single pages.
>
> I would have expected this code to allocate an appropriately aligned
> block of the p2p memory based on the requirements of the current
> mapping, not based on alignment requirements established when the device
> is probed.

The behavior mimics device-dax in which the creation of device-dax
device needs to specify the alignment property. Supporting different
alignments for different userspace mapping could work. However, it is no
way for the userspace to tell whether or not the the alignment is
mandatory. Take the below procedure as an example:

1) the size of CMB bar is 4MB
2) application 1 allocates 4KB. Its mapping is 4KB aligned
3) application 2 allocates 2MB. If the allocation from gen_pool is not
aligned, the mapping only supports 4KB-aligned mapping. If the
allocation support aligned allocation, the mapping could support
2MB-aligned mapping. However, the mmap implementation in the kernel
doesn't know which way is appropriate. If the alignment is specified in
the p2pdma, the implement could know the aligned 2MB mapping is appropriate.

> Logan
>
>
>
> .



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7775A9D2E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiIAQdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiIAQdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 12:33:10 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721E647C4;
        Thu,  1 Sep 2022 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=5gkmuO+qoqnmDsP41ZiRbkDae1Udt8/Fk8pl8Xm9Hs0=; b=mOsx/k4psgsJL3q6FjjiML9zVe
        qJ71SG2hugvvrfumPhF5dZZujShfV6qK6vaMaVXOKMOnVglDLQfitdVCYJ+noFk4so4TLGng/SUzQ
        k+TVmZAgcC3pmjLZDA8Op+/DG26pvPZKUF+TgmtapDlPjM3Vu6Lks+x7m61QSlnwTCTa4fYXEY2Tz
        Jy45GIppuKl8F/bICvYHyd4V0iWR/up/OqqQtI45TqUUDbC78aKSRu6CnhXVSUb2DSiVp06jRO59D
        FVQgqVYZVuOUvlsikqOPKgIx51xugfbVrnA5WeUQVeuKUfFG2Eu7pJdzFGniWBCcKj9MkN/ScLbgi
        KbiFhtPg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oTn7n-00DuUi-W0; Thu, 01 Sep 2022 10:33:04 -0600
Message-ID: <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
Date:   Thu, 1 Sep 2022 10:32:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxDb2MyRx6o/wDAz@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
> On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
>> Create a sysfs bin attribute called "allocate" under the existing
>> "p2pmem" group. The only allowable operation on this file is the mmap()
>> call.
>>
>> When mmap() is called on this attribute, the kernel allocates a chunk of
>> memory from the genalloc and inserts the pages into the VMA. The
>> dev_pagemap .page_free callback will indicate when these pages are no
>> longer used and they will be put back into the genalloc.
>>
>> On device unbind, remove the sysfs file before the memremap_pages are
>> cleaned up. This ensures unmap_mapping_range() is called on the files
>> inode and no new mappings can be created.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 124 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 4496a7c5c478..a6ed6bbca214 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -89,6 +89,90 @@ static ssize_t published_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(published);
>>  
>> +static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>> +		struct bin_attribute *attr, struct vm_area_struct *vma)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>> +	size_t len = vma->vm_end - vma->vm_start;
>> +	struct pci_p2pdma *p2pdma;
>> +	struct percpu_ref *ref;
>> +	unsigned long vaddr;
>> +	void *kaddr;
>> +	int ret;
>> +
>> +	/* prevent private mappings from being established */
>> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted private mapping\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (vma->vm_pgoff) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted mapping with non-zero offset\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rcu_read_lock();
>> +	p2pdma = rcu_dereference(pdev->p2pdma);
>> +	if (!p2pdma) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	kaddr = (void *)gen_pool_alloc_owner(p2pdma->pool, len, (void **)&ref);
>> +	if (!kaddr) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * vm_insert_page() can sleep, so a reference is taken to mapping
>> +	 * such that rcu_read_unlock() can be done before inserting the
>> +	 * pages
>> +	 */
>> +	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
>> +		ret = -ENODEV;
>> +		goto out_free_mem;
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
>> +		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
>> +		if (ret) {
>> +			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
>> +			return ret;
>> +		}
>> +		percpu_ref_get(ref);
>> +		put_page(virt_to_page(kaddr));
>> +		kaddr += PAGE_SIZE;
>> +		len -= PAGE_SIZE;
>> +	}
>> +
>> +	percpu_ref_put(ref);
>> +
>> +	return 0;
>> +out_free_mem:
>> +	gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
>> +out:
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>> +static struct bin_attribute p2pmem_alloc_attr = {
>> +	.attr = { .name = "allocate", .mode = 0660 },
>> +	.mmap = p2pmem_alloc_mmap,
>> +	/*
>> +	 * Some places where we want to call mmap (ie. python) will check
>> +	 * that the file size is greater than the mmap size before allowing
>> +	 * the mmap to continue. To work around this, just set the size
>> +	 * to be very large.
>> +	 */
>> +	.size = SZ_1T,
>> +};
>> +
>>  static struct attribute *p2pmem_attrs[] = {
>>  	&dev_attr_size.attr,
>>  	&dev_attr_available.attr,
>> @@ -96,11 +180,32 @@ static struct attribute *p2pmem_attrs[] = {
>>  	NULL,
>>  };
>>  
>> +static struct bin_attribute *p2pmem_bin_attrs[] = {
>> +	&p2pmem_alloc_attr,
>> +	NULL,
>> +};
>> +
>>  static const struct attribute_group p2pmem_group = {
>>  	.attrs = p2pmem_attrs,
>> +	.bin_attrs = p2pmem_bin_attrs,
>>  	.name = "p2pmem",
>>  };
>>  
>> +static void p2pdma_page_free(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
>> +	struct percpu_ref *ref;
>> +
>> +	gen_pool_free_owner(pgmap->provider->p2pdma->pool,
>> +			    (uintptr_t)page_to_virt(page), PAGE_SIZE,
>> +			    (void **)&ref);
>> +	percpu_ref_put(ref);
>> +}
>> +
>> +static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
>> +	.page_free = p2pdma_page_free,
>> +};
>> +
>>  static void pci_p2pdma_release(void *data)
>>  {
>>  	struct pci_dev *pdev = data;
>> @@ -152,6 +257,19 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>>  	return error;
>>  }
>>  
>> +static void pci_p2pdma_unmap_mappings(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +
>> +	/*
>> +	 * Removing the alloc attribute from sysfs will call
>> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
>> +	 * mappings and prevent new ones from being created.
>> +	 */
>> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
>> +				     p2pmem_group.name);
> 
> Wait, why are you manually removing the sysfs file here?  It's part of
> the group, if you do this then it is gone for forever, right?  Why
> manually do this the sysfs core should handle this for you if the device
> is removed.

We have to make sure the mappings are all removed before the cleanup of
devm_memremap_pages() which will wait for all the pages to be freed. If
we don't do this any userspace mapping will hang the cleanup until those
uses are unmapped themselves.

> And worst case, just pass in the device, not the pci device.

Ok, I'll make that change for v10.

Logan

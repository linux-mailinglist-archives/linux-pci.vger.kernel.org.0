Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12541CE53
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbhI2Vn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:43:56 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59160 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbhI2Vn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=3WA1KpyUg4a9gkCdh4NdRSTCNhCxgDrQHUyIFuEcPKQ=; b=YQ7Pgy3UA4s4WDhJgR56ldVLZa
        aarTUnhSWeZoaQ9XqoPtb8J4kCHbW5DZWtfpd6kiFewgouwOGQmyuMkSarYIcMeXLTQt4tDJSPf4a
        s3Cles1vcGAIVK5HH+sKtExXol+X/LJ0ITXpylU2RUjtAfnFitq7egHhPN+vnbLfsjBT727eeJJYW
        H7b2kX4EmNJ56lcfRB71Eg53F9hf8LVdioB4nnhm6Gm5kaDhd+o1XSlQkhJU859u9pc2Kf8Ej5LEB
        QjScyz4JhjwVsjawSaxV3AQfZ0qXHixKZL72zEfKVQ17MznS+q5nLDZ+sbw85NHk2exob1mrzGBrY
        X59623ew==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVhL0-0006W2-Fd; Wed, 29 Sep 2021 15:42:03 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
Date:   Wed, 29 Sep 2021 15:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928195518.GV3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-28 1:55 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
>> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
>> +{
>> +	struct pci_p2pdma_map *pmap;
>> +	struct pci_p2pdma *p2pdma;
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
>> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
>> +	if (!pmap)
>> +		return -ENOMEM;
>> +
>> +	rcu_read_lock();
>> +	p2pdma = rcu_dereference(pdev->p2pdma);
>> +	if (!p2pdma) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
>> +			    &pci_p2pdma_fs_cnt);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ihold(p2pdma->inode);
>> +	pmap->inode = p2pdma->inode;
>> +	rcu_read_unlock();
>> +
>> +	vma->vm_flags |= VM_MIXEDMAP;
> 
> Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
> struct page, right?

Yes. This decision is not so simple, I tried a few variations before
settling on this.

The main reason is probably this: if we don't use VM_MIXEDMAP, then we
can't set pte_devmap(). If we don't set pte_devmap(), then every single
page that GUP processes needs to check if it's a ZONE_DEVICE page and
also if it's a P2PDMA page (thus dereferencing pgmap) in order to
satisfy the requirements of FOLL_PCI_P2PDMA.

I didn't think other developers would go for that kind of performance
hit. With VM_MIXEDMAP we hide the performance penalty behind the
existing check. And with the current pgmap code as is, we only need to
do that check once for every new pgmap pointer.

Logan

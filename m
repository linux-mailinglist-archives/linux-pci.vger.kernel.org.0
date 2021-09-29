Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68E41CE5D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbhI2Vss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:48:48 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59254 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhI2Vsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=E0+dWT8gAeYt6sxwFEz+vMLQHximHDqyya3XwSsMquA=; b=B1+ojUPj4nQ9gfTcjrhn2ItoGQ
        aINPbvBXV9Nds1L0hVw7x1w9p2f358U5Fu3wsB7LxIEcnVMidcZxVp9bnuYVbm+woQWShpT40RVzU
        OWcloGv5IVDL4LO1/uqKO7qJp8yyXESOWL5Pk908ezjO+8d79gGLYr04akWdskoQQITHB9DMMIHmA
        92BxFHqUONXLFywx+DHgJ56IhJUbz68+CmbfX8Rw8Ao+P9/K4WRFREHY1Dgj8ZBtJ3HAi1EpCtHUm
        l5AU9JEaCtAhOL0zCRMIIQj6PRFACLBxlb8WUFdKUs9k94DRCRe5C1KpsFdiatomWcFHdJ3AjXAfr
        abJCdzRA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVhPY-0006ZO-78; Wed, 29 Sep 2021 15:46:45 -0600
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
 <20210928200506.GX3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3dfbfb6c-321c-f717-8adf-a37956f15678@deltatee.com>
Date:   Wed, 29 Sep 2021 15:46:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928200506.GX3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-09-28 2:05 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
> 
>> +static void pci_p2pdma_unmap_mappings(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
>> +
>> +	p2pdma->active = false;
>> +	synchronize_rcu();
>> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
>> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
>> +}
> 
> If this is going to rely on unmap_mapping_range then GUP should also
> reject this memory for FOLL_LONGTERM..

Right, makes sense.

> 
> What along this control flow:
> 
>> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
>> +                                        pdev);
> 
> Waits for all the page refcounts to go to zero?

That's already in the existing code as part of memunmap_pages() which
puts the original reference to all the pages and then waits for the
reference to go to zero.

This new action unmaps all the VMAs so that the subsequent call to
memunmap_pages() doesn't block on userspace processes.

Logan

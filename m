Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE5371E46
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhECRTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 13:19:00 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58914 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhECRS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 13:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=SAQ4S+jSIpU03o924OYwfD9SEbxJ72ZyqTFfTksfdhA=; b=aHvkXNhJC0Th2xBJKUmBj+YFHL
        UzUUk1ISTbtYsp83553YSXXGRA++kbSiJtSN05jEXVqt9VEX+wniOJS1RplCEqtuDD5dEX6odZ4Kq
        cu222eZYaQudBjSH8A2rSJDXWW+51r3qeRWafwKoGAm6AVx0/RQ21Pp4Domc5hgQYrYZGJC3acctI
        oDyhQ6cbTWTz+4TBfHuPIS5Ncok4vJKWmc5qIIjxy5BONLC07sANEe9vDy3pqahAl0m4DRp8PkoaL
        1+iVIZ7RcwI7jzxYjW8Dkp9JZw0qq1u+WTSwK8ErzNEhrqQw5/H+bDo+O6nCitRx5LdA8d9D7PVCk
        nOiYSZ1A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldcCd-0005A2-F7; Mon, 03 May 2021 11:17:52 -0600
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-13-logang@deltatee.com>
 <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f33a9cff-82d0-7a05-070a-8c6018fbaba9@deltatee.com>
Date:   Mon, 3 May 2021 11:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 12/16] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-02 7:29 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Introduce a supports_pci_p2pdma() operation in nvme_ctrl_ops to
>> replace the fixed NVME_F_PCI_P2PDMA flag such that the dma_map_ops
>> flags can be checked for PCI P2PDMA support.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/host/core.c |  3 ++-
>>   drivers/nvme/host/nvme.h |  2 +-
>>   drivers/nvme/host/pci.c  | 11 +++++++++--
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0896e21642be..223419454516 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3907,7 +3907,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>>   
>>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>> -	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>> +	if (ctrl->ops->supports_pci_p2pdma &&
>> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> 
> This is a little excessive, as I suspected. How about providing a
> default .supports_pci_p2pdma routine that returns false, so that
> the op is always available (non-null)? By "default", maybe that
> means either requiring an init_the_ops_struct() routine to be
> used, and/or checking all the users of struct nvme_ctrl_ops.

Honestly that sounds much more messy to me than simply checking if it's
NULL before using it (which is a common, accepted pattern for ops).

> Another idea: maybe you don't really need a bool .supports_pci_p2pdma()
> routine at all, because the existing .flags really is about right.
> You just need the flags to be filled in dynamically. So, do that
> during nvme_pci setup/init time: that's when this module would call
> dma_pci_p2pdma_supported().

If the flag is filled in dynamically, then the ops struct would have to
be non-constant. Ops structs should be constant for security reasons.

Logan

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD136CF0A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhD0XAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 19:00:52 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42848 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhD0XAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 19:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=RGdRC5FBlsTWfpWtOgCpYwh/6l+bY/lLU227Fr0Oa7w=; b=e1cQkHUii+OnXHxuzyVnv2FOWU
        yRhslccFTPCSUZBHv6r9i2BtLYMYFFuNX+vj1xNOq/lXobsZ3eYFuedGTORJxwDIMCEh7Qthqs1Q7
        RVxgzfvWzK3UWw1HMRbfVYTe3vQzXRIV/ILbih4akY/evNrEaGCAlfgG+L3AXOME+jur1eJqyKhD1
        TMGSqOXU7r9XcMpgA/2JBpdbNNP7X3lLSbdPwHl2H10OkRWO75ot4KGzAuXd2ZJB/tmfOyTGaMv6M
        ae+aEYfgGtkGVcUSMzK45Ps6AhzhkNnGarVg7/1Ky1Fn+SEciywNHOIOcE/kvvy4C616xFskQ500w
        hxifV8fg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lbWgQ-0002oO-8N; Tue, 27 Apr 2021 16:59:59 -0600
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
 <20210427194753.GU2047089@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6e78cdc8-8189-b778-20b4-7a108e28e557@deltatee.com>
Date:   Tue, 27 Apr 2021 16:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194753.GU2047089@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,NICE_REPLY_A autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 1:47 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
>> Ensure the dma operations support p2pdma before using the RDMA
>> device for P2PDMA. This allows switching the RDMA driver from
>> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/target/rdma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 6c1f3ab7649c..3ec7e77e5416 100644
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>>  		goto out_free_rsp;
>>  
>> -	if (!ib_uses_virt_dma(ndev->device))
>> +	if (!ib_uses_virt_dma(ndev->device) &&
>> +	    dma_pci_p2pdma_supported(&ndev->device->dev))
> 
> ib_uses_virt_dma() should not be called by nvme and this is using the
> wrong device pointer to query for DMA related properties.
> 
> I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
> everything else.

Makes sense. Will add for v2.

Logan

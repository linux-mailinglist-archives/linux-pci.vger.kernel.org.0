Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9633833A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 02:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCLBhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 20:37:52 -0500
Received: from ale.deltatee.com ([204.191.154.188]:36550 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCLBhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 20:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=TthgKQQeKaY8Nk8kByxBsMn1+rajpO9j2vCO0oMycYg=; b=k5/TOv/t9MI8U4lhl5xd0eVHRI
        DEKyTXEcuq5sX7Xy2TXIwqOAOZ73ZqhrLuTntYIMTvCOCq8PRu9o7rWRFdwy4LEmwJcHwyWL9BvxE
        E3psi+/9MRziL+BVzgCEmcxCM77bWwNBiF0H8QBoLUfFeTtCEH58WSnu/bBSwfWEc0X1HLYx+UY6W
        Ig6tahtLX1Cp8ddWB4Vw3kJiR4S7bXzhUgT4PrlGFGZiBmn37haj35vV85OvDcD2h9GakgTEPhmP8
        5ULZeqF8e05hdIS9qe+Vati5jKVwahKR4z2FkN46o43eFB9sPRT5TVTR6byB7fKBkdA6vj9c1GMvK
        qXUpe9FA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKWjj-0005aG-5w; Thu, 11 Mar 2021 18:37:08 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
 <20210311235943.GB2710221@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c6cc9e07-b7cf-6d3d-b0bf-25428b197731@deltatee.com>
Date:   Thu, 11 Mar 2021 18:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311235943.GB2710221@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-11 4:59 p.m., Jason Gunthorpe wrote:
> On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
>> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
>>
>> This should be equivalent, though support will be somewhat less
>> (only dma-direct and dma-iommu are currently supported).
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>>  1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 7d40c6a9e58e..89ca5acf7a62 100644
>> +++ b/drivers/nvme/host/pci.c
>> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>>  
>>  }
>>  
>> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
>> -{
>> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> -
>> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
>> -				    rq_dma_dir(req));
>> -	else
>> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
>> -}
> 
> Can the two other places with this code pattern be changed too?

Yes, if this goes forward, I imagine completely dropping
pci_p2pdma_unmap_sg().

Logan

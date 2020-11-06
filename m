Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C732A9AC2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKFR2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:28:16 -0500
Received: from ale.deltatee.com ([204.191.154.188]:58642 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFR2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QpuHLB0GpYTnQrdJoCEWfsKDl3xh5PNClZ27s55U+do=; b=ZP0R0HzdgH1uFfEUZzzikuYDfI
        zqaPSQGeQvgM5YjaFvhCmlSs4rN5X1m1sqlZV9ed6j0uJF7a1RS+fTwtp1gP1X9N8KodSiYvt+uPN
        uZQKAE5qAr8FdL5Owfwzb8VEesIyBead7s8R6Zm9WHJN4vMTNGcM+ddbVw9gYc4myoSfcTyFWsqC7
        47NWcc50emSaTQajUsHV0+gGGJfZIMPB5+TQg9V0LSTnPdPKecJnCqfC70vqTLUhWCaTf31rwFOlt
        UmzKn/5wlKuw9Wdl7UBmStDMNhpka7cU6SP3l8+zi591j4n58kY7NS/qm8hOrSau9vRmLye1yHat0
        4ObFWpcQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kb5Wu-00036E-5n; Fri, 06 Nov 2020 10:28:05 -0700
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
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
Date:   Fri, 6 Nov 2020 10:28:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106172206.GS36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-11-06 10:22 a.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 10:00:35AM -0700, Logan Gunthorpe wrote:
>> Introduce pci_mmap_p2pmem() which is a helper to allocate and mmap
>> a hunk of p2pmem into userspace.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/pci/p2pdma.c       | 104 +++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h |   6 +++
>>  2 files changed, 110 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 9961e779f430..8eab53ac59ae 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/genalloc.h>
>>  #include <linux/memremap.h>
>>  #include <linux/percpu-refcount.h>
>> +#include <linux/pfn_t.h>
>>  #include <linux/random.h>
>>  #include <linux/seq_buf.h>
>>  #include <linux/xarray.h>
>> @@ -1055,3 +1056,106 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>>  	return sprintf(page, "%s\n", pci_name(p2p_dev));
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
>> +
>> +struct pci_p2pdma_map {
>> +	struct kref ref;
>> +	struct pci_dev *pdev;
>> +	void *kaddr;
>> +	size_t len;
>> +};
> 
> Why have this at all? Nothing uses it and no vm_operations ops are
> implemented?

It's necessary to free the allocated p2pmem when the mapping is torn down.

> This is very inflexable, it would be better if this is designed like
> io_remap_pfn where it just preps and fills the VMA, doesn't take
> ownership of the entire VMA

If someone wants to manage their own P2P memory and create their own
userspace mapping with vmf_insert_mixed they are free to do so. But this
helper is specifically for users of pci_p2pdma_map_alloc(). I know you
don't intend to use that but it doesn't make it any less valid.

Logan


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1871533D85B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhCPPzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 11:55:32 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36728 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbhCPPzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 11:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=oFF8o/RVegrG3G5YG5dTK44WOWDv57bdoGVgR2ktNWc=; b=dsqiw2UqRHpc2m6czITifyPazC
        l3KC3T9j57KTF3XoWiyV+LPgw4lbLtgOWKdd598bgRLfvrtkF2yuQDTcMKhGG9vB+KiBIJHVKMqOo
        mz5L+MEsdNsRbgo0gzz/8XPLL0CEathKtt+ZC61Qu6pAMYwbwCzqpb34Hfj+pEJnqN+lbJ6lzm9Ih
        wMlXJ7CnBmVPIFSao3qYHQjM/uSXXdMUZqbGyOWB+ccwh0ZmHoBC+XWjsMT4ETu8VxhHGEnyC4uu8
        9v/yv+i4wmpSzCRFdT+0I+6inCilQdZbbQP3yiENwxiLiBsWDTPHNXrs7QPi+fZVB9gawHTLngfEt
        /Q9Irqsg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lMC27-00012D-3W; Tue, 16 Mar 2021 09:54:59 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-7-logang@deltatee.com>
 <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com>
 <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com>
 <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com>
 <367fa81e-588d-5734-c69c-8cdc800dcb7e@deltatee.com>
 <20210316075821.GB15949@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <093b77cb-e8b1-c8a8-620b-ab36cdb7f3cc@deltatee.com>
Date:   Tue, 16 Mar 2021 09:54:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316075821.GB15949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca, christian.koenig@amd.com, willy@infradead.org, dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-16 1:58 a.m., Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 11:27:46AM -0700, Logan Gunthorpe wrote:
>> So then we reject the patches that make that change. Seems like an odd
>> argument to say that we can't do something that won't cause problems
>> because someone might use it as an example and do something that will
>> cause problems. Reject the change that causes the problem.
> 
> No, the problem is a mess of calling conventions.  A calling convention
> returning 0 for error, positive values for success is fine.  One returning
> a negative errno for error and positive values for success is fine a well.
> One returning 0 for the usual errors and negativ errnos for an unusual
> corner case is just a complete mess.

Fair enough. I can try implementing a dma_map_sg_p2p() roughly as Robin
suggested that has a more reasonable calling convention.

Most of your other feedback seems easy enough so I'll address it in a
future series.

Thanks,

Logan

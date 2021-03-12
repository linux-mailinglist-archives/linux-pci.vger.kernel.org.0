Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3463392F7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLQTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 11:19:40 -0500
Received: from ale.deltatee.com ([204.191.154.188]:42376 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhCLQTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 11:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=I89VDuZejubSyokWT+qiAjRrhT4T4AjRHHyD/4UUauw=; b=YWISg10aSxm+jQaX+X6OhfxFPO
        wP4pNsP9huRyLmE2n03E4hyIpdRH1yQeyJ+V9wg1wgsxjmVmS1xL+gBAk6XsaxpB+l0aIYU98JxQZ
        ciEEug4Y5ay/LYN0UyHg/bEyINwquKoUxnSPKQlqr1ajywPFKVP1ujdzy7/srZYnjWdTlz12JRzIw
        pI3U2FUOw+RIbjwTV9CMHkfRjKlk6ew/bqxHeIk3ZfYxJ+T4OZozC6OE16gN7hqtn6YLwyH0xRZPH
        86uvVT4Ir+w62abwFg8otMV5BX+4owBFgtQVj4Uu2xHzYQCNGi5/KyJe8bEhgCWqEgHXOqoB1UiVm
        ehwWevcw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKkV1-00079p-IQ; Fri, 12 Mar 2021 09:18:52 -0700
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <iweiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
Date:   Fri, 12 Mar 2021 09:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, hch@lst.de, andrzej.jakowski@intel.com, sbates@raithlin.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch, jason@jlekstrand.net, jgg@ziepe.ca, christian.koenig@amd.com, willy@infradead.org, iweiny@intel.com, dave.hansen@linux.intel.com, jhubbard@nvidia.com, dave.b.minturn@intel.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 8:51 a.m., Robin Murphy wrote:
> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>> Hi,
>>
>> This is a rework of the first half of my RFC for doing P2PDMA in
>> userspace
>> with O_DIRECT[1].
>>
>> The largest issue with that series was the gross way of flagging P2PDMA
>> SGL segments. This RFC proposes a different approach, (suggested by
>> Dan Williams[2]) which uses the third bit in the page_link field of the
>> SGL.
>>
>> This approach is a lot less hacky but comes at the cost of adding a
>> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
>> scarce bit in the page_link. For our purposes, a 64BIT restriction is
>> acceptable but it's not clear if this is ok for all usecases hoping
>> to make use of P2PDMA.
>>
>> Matthew Wilcox has already suggested (off-list) that this is the wrong
>> approach, preferring a new dma mapping operation and an SGL
>> replacement. I
>> don't disagree that something along those lines would be a better long
>> term solution, but it involves overcoming a lot of challenges to get
>> there. Creating a new mapping operation still means adding support to
>> more
>> than 25 dma_map_ops implementations (many of which are on obscure
>> architectures) or creating a redundant path to fallback with dma_map_sg()
>> for every driver that uses the new operation. This RFC is an approach
>> that doesn't require overcoming these blocks.
> 
> I don't really follow that argument - you're only adding support to two
> implementations with the awkward flag, so why would using a dedicated
> operation instead be any different? Whatever callers need to do if
> dma_pci_p2pdma_supported() says no, they could equally do if
> dma_map_p2p_sg() (or whatever) returns -ENXIO, no?

The thing is if the dma_map_sg doesn't support P2PDMA then P2PDMA
transactions cannot be done, but regular transactions can still go
through as they always did.

But replacing dma_map_sg() with dma_map_new() affects all operations,
P2PDMA or otherwise. If dma_map_new() isn't supported it can't simply
not support P2PDMA; it has to maintain a fallback path to dma_map_sg().
Given that the inputs and outputs for dma_map_new() will be completely
different data structures this will be quite a lot of similar paths
required in the driver. (ie mapping a bvec to the input struct and the
output struct to hardware requirements) If a bug crops up in the old
dma_map_sg(), developers might not notice it for some time seeing it
won't be used on the most popular architectures.

Logan

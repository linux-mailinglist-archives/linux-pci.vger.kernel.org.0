Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B4339558
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhCLRrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:47:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhCLRqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 12:46:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4DC1FB;
        Fri, 12 Mar 2021 09:46:43 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74DF03F7D7;
        Fri, 12 Mar 2021 09:46:38 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
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
 <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <90a2825c-da2f-c031-a70f-08c5efb3db56@arm.com>
Date:   Fri, 12 Mar 2021 17:46:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c66d247e-5da9-4866-8e6b-ee2ec4bc03d5@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-12 16:18, Logan Gunthorpe wrote:
> 
> 
> On 2021-03-12 8:51 a.m., Robin Murphy wrote:
>> On 2021-03-11 23:31, Logan Gunthorpe wrote:
>>> Hi,
>>>
>>> This is a rework of the first half of my RFC for doing P2PDMA in
>>> userspace
>>> with O_DIRECT[1].
>>>
>>> The largest issue with that series was the gross way of flagging P2PDMA
>>> SGL segments. This RFC proposes a different approach, (suggested by
>>> Dan Williams[2]) which uses the third bit in the page_link field of the
>>> SGL.
>>>
>>> This approach is a lot less hacky but comes at the cost of adding a
>>> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
>>> scarce bit in the page_link. For our purposes, a 64BIT restriction is
>>> acceptable but it's not clear if this is ok for all usecases hoping
>>> to make use of P2PDMA.
>>>
>>> Matthew Wilcox has already suggested (off-list) that this is the wrong
>>> approach, preferring a new dma mapping operation and an SGL
>>> replacement. I
>>> don't disagree that something along those lines would be a better long
>>> term solution, but it involves overcoming a lot of challenges to get
>>> there. Creating a new mapping operation still means adding support to
>>> more
>>> than 25 dma_map_ops implementations (many of which are on obscure
>>> architectures) or creating a redundant path to fallback with dma_map_sg()
>>> for every driver that uses the new operation. This RFC is an approach
>>> that doesn't require overcoming these blocks.
>>
>> I don't really follow that argument - you're only adding support to two
>> implementations with the awkward flag, so why would using a dedicated
>> operation instead be any different? Whatever callers need to do if
>> dma_pci_p2pdma_supported() says no, they could equally do if
>> dma_map_p2p_sg() (or whatever) returns -ENXIO, no?
> 
> The thing is if the dma_map_sg doesn't support P2PDMA then P2PDMA
> transactions cannot be done, but regular transactions can still go
> through as they always did.
> 
> But replacing dma_map_sg() with dma_map_new() affects all operations,
> P2PDMA or otherwise. If dma_map_new() isn't supported it can't simply
> not support P2PDMA; it has to maintain a fallback path to dma_map_sg().

But AFAICS the equivalent fallback path still has to exist either way. 
My impression so far is that callers would end up looking something like 
this:

	if (dma_pci_p2pdma_supported()) {
		if (dma_map_sg(...) < 0)
			//do non-p2p fallback due to p2p failure
	} else {
		//do non-p2p fallback due to lack of support
	}

at which point, simply:

	if (dma_map_sg_p2p(...) < 0)
		//do non-p2p fallback either way

seems entirely reasonable. What am I missing?

Let's not pretend that overloading an existing API means we can start 
feeding P2P pages into any old subsystem/driver without further changes 
- there already *are* at least some that retry ad infinitum if DMA 
mapping fails (the USB layer springs to mind...) and thus wouldn't 
handle the PCI_P2PDMA_MAP_NOT_SUPPORTED case acceptably.

> Given that the inputs and outputs for dma_map_new() will be completely
> different data structures this will be quite a lot of similar paths
> required in the driver. (ie mapping a bvec to the input struct and the
> output struct to hardware requirements) If a bug crops up in the old
> dma_map_sg(), developers might not notice it for some time seeing it
> won't be used on the most popular architectures.

Huh? I'm specifically suggesting a new interface that takes the *same* 
data structure (at least to begin with), but just gives us more 
flexibility in terms of introducing p2p-aware behaviour somewhat more 
safely. Yes, we already know that we ultimately want something better 
than scatterlists for representing things like this and dma-buf imports, 
but that hardly has to happen overnight.

Robin.

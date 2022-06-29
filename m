Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4B5608FB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiF2SYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiF2SYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 14:24:47 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B0B255AB;
        Wed, 29 Jun 2022 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=6f/hfdoWC+PgJWoBH5fqwFGRbVxwuN3ohOs8yiOPg/w=; b=KqlIdYHpF5kcUd1uj3HgVczqN5
        +LiC/fe4thV0n4GWyYvjongR/yShAMienfuQ1vSKr2dlutBWKxI1nszo45XAnij64gY60aWl25yKn
        9yS7YZF5VmQ5saw9wKgfKuTqMswh1/nBQISRAQ25FYKkr6Le3Ih3GarYYS3dES6F4h5ipa5KBXImW
        +5AYt7ZvYxGywfXkmA46cmlkEvd9ckJZYnEqkIBKI2tycRJV07BzAnX9mR41JUrGOel82aqdx3sqr
        111sVLF6oie65Xr6Z42l/GsfBOMAbGWd8Y9f26Frw8Cb4XUZDZkK9lUUkK39WvPZjSo78/eCvKrz8
        ZKirfsHg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o6cMk-002URm-20; Wed, 29 Jun 2022 12:24:43 -0600
Message-ID: <9725fc38-cbe6-f660-8d5f-6ceb983e6976@deltatee.com>
Date:   Wed, 29 Jun 2022 12:24:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
 <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
 <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <d84a0498-3b7f-3d38-2bfd-9a175db4002a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-29 12:02, Robin Murphy wrote:
> On 2022-06-29 16:39, Logan Gunthorpe wrote:
>> On 2022-06-29 03:05, Robin Murphy wrote:
>>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>> Does this serve any useful purpose? If a page is determined to be device
>>> memory, it's not going to suddenly stop being device memory, and if the
>>> underlying sg is recycled to point elsewhere then sg_assign_page() will
>>> still (correctly) clear this flag anyway. Trying to reason about this
>>> beyond superficial API symmetry - i.e. why exactly would a caller need
>>> to call it, and what would the implications be of failing to do so -
>>> seems to lead straight to confusion.
>>>
>>> In fact I'd be inclined to have sg_assign_page() be responsible for
>>> setting the flag automatically as well, and thus not need
>>> sg_dma_mark_bus_address() either, however I can see the argument for
>>> doing it this way round to not entangle the APIs too much, so I don't
>>> have any great objection to that.
>>
>> Yes, I think you misunderstand what this is for. The SG_DMA_BUS_ADDDRESS
>> flag doesn't mark the segment for the page, but for the dma address. It
>> cannot be set in sg_assign_page() seeing it's not a property of the page
>> but a property of the dma_address in the sgl.
>>
>> It's not meant for use by regular SG users, it's only meant for use
>> inside DMA mapping implementations. The purpose is to know whether a
>> given dma_address in the SGL is a bus address or regular memory because
>> the two different types must be unmapped differently. We can't rely on
>> the page because, as you know, many dma_map_sg() the dma_address entry
>> in the sgl does not map to the same memory as the page. Or to put it
>> another way: is_pci_p2pdma_page(sg->page) does not imply that
>> sg->dma_address points to a bus address.
>>
>> Does that make sense?
> 
> Ah, you're quite right, in trying to take in the whole series at once
> first thing in the morning I did fail to properly grasp that detail, so
> indeed the sg_assign_page() thing couldn't possibly work, but as I said
> that's fine anyway. I still think the lifecycle management is a bit off
> though - equivalently, a bus address doesn't stop being a bus address,
> so it would seem appropriate to update this flag appropriately whenever
> sg_dma_address() is assigned to, and not when it isn't.

Yes, that's pretty much the way the code is now. The only two places
sg_dma_mark_bus_address() is called are in the two pci_p2pdma helpers
that set the dma address to the bus address. The lines before both calls
set the dma_address and dma_len.

Logan


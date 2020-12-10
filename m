Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84F2D6263
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbgLJQpF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 11:45:05 -0500
Received: from ale.deltatee.com ([204.191.154.188]:46608 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbgLJQpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 11:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=NLEerKoLFowaewjPdadKIQl7nLE1s4J5rPHYICcJITQ=; b=crqyakMNfLD0XUfh6F2e3swVLx
        mTcpouhD/gNOfYXfGn6Ra4lmr58g0DKEFh8v8XZhw7oj3+a2PAQ6gUNE4XzkizYW5DHLyF7Z962+u
        VOgMKxoM2ZoNxRHEGrF0b8DeCOHUdreOXpoHW86yykGzbOaDPRYZrLjPGRT3Dq5Jj+ROOKFo4RVTC
        5Qm3rUKnhRLUuRiAammvF8OZt0oHLqzqWos19uRirQOx2TCgMA9I/ZpGTKhrPR3+HiCsA9JBUukjC
        Id/rXnpnKxi4H2NChsUtSFGKaCBNLpYj+WfkrEFTOTBeR3z3ReJdU/ek2w8kaxqIVYFLxOVpqyS+5
        pjQzCBCg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1knP32-000791-LR; Thu, 10 Dec 2020 09:44:09 -0700
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Stephen Bates <sbates@raithlin.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com> <20201109091258.GB28918@lst.de>
 <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com>
 <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
 <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7b08e6e9-eca4-0070-8444-5eb00965a0ad@deltatee.com>
Date:   Thu, 10 Dec 2020 09:44:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-12-09 9:04 p.m., Dan Williams wrote:
> On Wed, Dec 9, 2020 at 6:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2020-12-09 6:22 p.m., Dan Williams wrote:
>>> On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
>>>>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
>>>>>> We make use of the top bit of the dma_length to indicate a P2PDMA
>>>>>> segment.
>>>>>
>>>>> I don't think "we" can.  There is nothing limiting the size of a SGL
>>>>> segment.
>>>>
>>>> Yes, I expected this would be the unacceptable part. Any alternative ideas?
>>>
>>> Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
>>> segment-pages for is_pci_p2pdma_page()?
>>
>> Because the DMA and page segments in the SGL aren't necessarily aligned...
>>
>> The IOMMU implementations can coalesce multiple pages into fewer DMA
>> address ranges, so the page pointed to by sg->page_link may not be the
>> one that corresponds to the address in sg->dma_address for a given segment.
>>
>> If that makes sense -- it's not the easiest thing to explain.
> 
> It does...
> 
> Did someone already grab, or did you already consider the 3rd
> available bit in page_link? AFAICS only SG_CHAIN and SG_END are
> reserved. However, if you have a CONFIG_64BIT dependency for
> user-directed p2pdma that would seem to allow SG_P2PDMA_FLAG to be
> (0x4) in page_link.

Hmm, I half considered that, but I had came to the conclusion that given
the mis-alignment I shouldn't be using the page side of the SGL.
However, reconsidering now, that might actually be a reasonable option.

However, the CONFIG_64BIT dependency would have to be on all P2PDMA,
because we'd need to replace pci_p2pdma_map_sg() in all cases. I'm not
sure if this would be a restriction people care about.

Thanks,

Logan


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3441CFF6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbhI2Xaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:30:35 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60536 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbhI2Xaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=NYyTaf27EInHhX60ljYBoeATyLjSGs1NVod8tkafPeY=; b=EWozigDhXaXheIOw3+nHDtN4G6
        eFSOZ5q8F/2nZpK2IzAxIYKC4S9LDPF19Ym9gqJ8EQH2CYYB0eZPhBVZFPNgllppCzKBbLElzRGxI
        mjOi6SpfbjHBdpYGGFSewfSUDyh7wanUxSZDj+03pzSkYeqm/aIZoPsTswsfEkqn0df+fg2/B8ZNP
        eLLZtU513+UpUEKzyBAWGXBYdkvhYZyf3h7NVOsMnsbHERQjNOXVhBo5XV1nMbOTXEnvBbdqySQqu
        xIv45bM6TtjludpPxa83ejx2eBYBOoqqEyohv4QngbqSVtzDM3nLZqpla5/bYOnKPfhp+diVGMaME
        v4VgN3yw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVj0C-0008Eg-58; Wed, 29 Sep 2021 17:28:41 -0600
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
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
Date:   Wed, 29 Sep 2021 17:28:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929232147.GD3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
>>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
>>>> Hi,
>>>>
>>>> This patchset continues my work to add userspace P2PDMA access using
>>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
>>>> patches in this series, but the early P2PDMA cleanup and map_sg error
>>>> changes from that series have been merged into v5.15-rc1. To address
>>>> concerns that that series did not add any new functionality, I've added
>>>> back the userspcae functionality from the original RFC[2] (but improved
>>>> based on the original feedback).
>>>
>>> I really think this is the best series yet, it really looks nice
>>> overall. I know the sg flag was a bit of a debate at the start, but it
>>> serves an undeniable purpose and the resulting standard DMA APIs 'just
>>> working' is really clean.
>>
>> Actually, so far, nobody has said anything negative about using the SG flag.
>>
>>> There is more possible here, we could also pass the new GUP flag in the
>>> ib_umem code..
>>
>> Yes, that would be very useful.
> 
> You might actually prefer to do that then the bio changes to get the
> infrastructur merged as it seems less "core"

I'm a little bit more concerned about my patch set growing too large.
It's already at 20 patches and I think I'll need to add a couple more
based on the feedback you've already provided. So I'm leaning toward
pushing more functionality as future work.

Logan

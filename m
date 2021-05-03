Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E549371890
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhECP6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 11:58:53 -0400
Received: from ale.deltatee.com ([204.191.154.188]:56462 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhECP6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 11:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=GRATXEdDLtmHYm2zR9BEphk7UXJZV3Wtupp7N/wM0ac=; b=KNKJz1k9cORPoOeawf3gcXlCu5
        eI5GgEzgHHpsYGlQc305kr/f0HuWYO8UNczmVWxt1wCYcoLWokF5N2V6w0Tr7HbLBBwOhuaZYiBVJ
        RXbD1gckXcqlsUMeH9JobfBXeFE5SdNlofp70fCSoNaQ37ycRBY2AiN/N2MGbLxcVQsKPdjEDluEe
        xb+cwsUh7oSz+dRCBwiTM/nRSQ/P9EnqjLLnduy9HUZFFtdlvwQIiZwlOJ3I55O2xSohd2rV9g6Un
        JoFznbmJCUxco07ATLbqEg9Sb2LPcjgV4llvYQvj9+M1NAvWehU2wAYl3X5X+lgSipjOFaQhNM/X1
        iheL+1Kg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldax0-0003G8-Dd; Mon, 03 May 2021 09:57:39 -0600
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
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
Date:   Mon, 3 May 2021 09:57:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-01 9:58 p.m., John Hubbard wrote:
> Another odd thing: this used to check for memory failure and just give
> up, and now it doesn't. Yes, I realize that it all still works at the
> moment, but this is quirky and we shouldn't stop here.
> 
> Instead, a cleaner approach would be to push the memory allocation
> slightly higher up the call stack, out to the
> pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
> the kmalloc() call, and fail out if it can't get a page for the seq_buf
> buffer. Then you don't have to do all this odd stuff.

I don't really agree with this assessment. If kmalloc fails to
initialize the seq_buf() (which should be very rare), the only thing
that is lost is the one warning print that tells the user the command
line parameter needed disable the ACS. Everything else works fine,
nothing else can fail. I don't see the need to add extra complexity just
so the code errors out in no-mem instead of just skipping the one,
slightly more informative, warning line.

Also, keep in mind the result of all these functions are cached so it
only ever happens once. So for this to matter, the user would have to do
their first transaction between two devices exactly at the time memory
allocations would fail.


> Furthermore, the call sites can then decide for themselves which GFP
> flags, GFP_ATOMIC or GFP_KERNEL or whatever they want for kmalloc().
> 
> A related thing: this whole exercise would go better if there were a
> preparatory patch or two that changed the return codes in this file to
> something less crazy. There are too many functions that can fail, but
> are treated as if they sort-of-mostly-would-never-fail, in the hopes of
> using the return value directly for counting and such. This is badly
> mistaken, and it leads developers to try to avoid returning -ENOMEM
> (which is what we need here).

Hmm? Which functions can fail? and how?

Logan

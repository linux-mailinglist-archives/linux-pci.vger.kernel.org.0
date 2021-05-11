Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A267437AB92
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEKQOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:14:12 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53438 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhEKQOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=BHBUlVYkvN7U/TbnhdmSfxdbBO7hmMx8+ZQaSS91pAY=; b=rsu7y4L6BqjnqY43bR2EjC+q8w
        I21N4GuEIsZtEN66HoQVR0eBUqXn9sLnhmeyjs1LmpX8ONK+4bR40It7S3HEyHUIadkFTRMjL6PnS
        bB0n5Fr7Zjp0fYF0PszR86jiQekrG0/YiMxjzKlvZ/EcoIT5WUU+u4BdzM71EtarOlouiAJGtNWbC
        OG0YRsSDn0akFPUGxxgbghzFEP500GKyJxOfhhP+VXZH6y4SdBhM2JjpjA9kGzUYu84S0WPnK8dl7
        8QQukFL6DMVaPGaBHKFNGJzPQm7aOqvldJK3cdI6OmASeQ1CBV71z6pmz8w0UZUeslplJDlf0fzGw
        VvW5QwDQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lgUzy-0006Xk-Lw; Tue, 11 May 2021 10:12:43 -0600
To:     Don Dutile <ddutile@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Date:   Tue, 11 May 2021 10:12:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-11 10:05 a.m., Don Dutile wrote:
> On 5/1/21 11:58 PM, John Hubbard wrote:
>> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>>> In order to call upstream_bridge_distance_warn() from a dma_map function,
>>> it must not sleep. The only reason it does sleep is to allocate the seqbuf
>>> to print which devices are within the ACS path.
>>>
>>> Switch the kmalloc call to use a passed in gfp_mask and don't print that
>>> message if the buffer fails to be allocated.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>   drivers/pci/p2pdma.c | 21 +++++++++++----------
>>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>>> index 196382630363..bd89437faf06 100644
>>> --- a/drivers/pci/p2pdma.c
>>> +++ b/drivers/pci/p2pdma.c
>>> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>>>     static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>>   {
>>> -    if (!buf)
>>> +    if (!buf || !buf->buffer)
>>
>> This is not great, sort of from an overall design point of view, even though
>> it makes the rest of the patch work. See below for other ideas, that will
>> avoid the need for this sort of odd point fix.
>>
> +1.
> In fact, I didn't see how the kmalloc was changed... you refactored the code to pass-in the
> GFP_KERNEL that was originally hard-coded into upstream_bridge_distance_warn();
> I don't see how that avoided the kmalloc() call.
> in fact, I also see you lost a failed kmalloc() check, so it seems to have taken a step back.

I've changed this in v2 to just use some memory allocated on the stack.
Avoids this argument all together.

Logan

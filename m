Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85648372001
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECS5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:57:48 -0400
Received: from ale.deltatee.com ([204.191.154.188]:33118 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhECS5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 14:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=urpUAlDPWXWZ2PL8g2ilur2+t9PFDduUWmpK1ApASI4=; b=EGs4zed9LFZZW/mzhwWHYEjE0Z
        PHHUuLEGeSLk+W1aahq2QNx3W9/ZN9eUEQNL8pjV86YZ404ID70rIa9JL7Gj9k/VFNyyG2W/0mEpW
        j9PMktgtnJi+bqWdUL4/wQJ/EhovHZjUCoeeurGmEuI6njPEjZZDqsxbjyXrKle9c8M00sj64QOan
        ew/2u53ZBRe7NtELL9gUdiz5auwlqvF3ohetSSDQEhMBCxQtcc02pFc5LMU1xXbGLawhnTwLaGYl/
        gi1aNFASd3y4O1Fd9aRvnvwOBTdU02mZZHD99r8jAmAIWzNWCSPBZJXvK7H1AFPt25U7v3wZ73Hxo
        os5/4ocg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lddkJ-0001F0-C7; Mon, 03 May 2021 12:56:44 -0600
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
 <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
 <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab0e4256-79c9-c181-5aec-f6869a92a80c@deltatee.com>
Date:   Mon, 3 May 2021 12:56:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-03 12:31 p.m., John Hubbard wrote:
> On 5/3/21 9:30 AM, Logan Gunthorpe wrote:
>>
>>
>> On 2021-05-02 2:41 p.m., John Hubbard wrote:
>>> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>>>> All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
>>>> struct device (of the client doing the DMA transfer). Thus move the
>>>> conversion to struct pci_devs for the provider and client into this
>>>> function.
>>>
>>> Actually, this is the wrong direction to go! All of these pre-existing
>>> pci_*() functions have a small problem already: they are dealing with
>>> struct device, instead of struct pci_dev. And so refactoring should be
>>> pushing the conversion to pci_dev *up* the calling stack, not lower as
>>> the patch here proposes.
>>>
>>> Also, there is no improvement in clarity by passing in (pgmap, dev)
>>> instead of the previous (provider, client). Now you have to do more type
>>> checking in the leaf function, which is another indication of a problem.
>>>
>>> Let's go that direction, please? Just convert to pci_dev much higher in
>>> the calling stack, and you'll find that everything fits together better.
>>> And it's OK to pass in extra params if that turns out to be necessary,
>>> after all.
>>
>> No, I disagree with this and it seems a bit confused. This change is
> 
> I am not confused here, no. Other places, yes, but not at this moment. :)

I only meant confused because you suggested that such a change would
reduce checks in the leaf functions when in fact it's the opposite.

>> allowing callers to call the function with what they have and doing more
>> checks inside the called function. This allows for *less* checks in the
>> leaf function, not more checks. (I mean, look at the patch itself, it
>> puts a bunch of checks in both call sites into the callee and makes the
>> code a lot cleaner -- it's removing more lines than it adds).
>>
>> Similar argument can be made with the pci_p2pdma_distance_many() (which
>> I assume you are referring to). If the function took struct pci_dev
>> instead of struct device, every caller would need to do all checks and
>> conversions to struct pci_dev. That is not an improvement.
>>
> 
> 
> IMHO, it is better to have all of the pci_*() functions dealing with pci_dev
> instead of dev, but it is also true that this is a larger change, so I
> won't press the point too hard right now.

As a general rule, I'd agree with you. However, it's not good to blindly
follow the rule when there might be good reasons to do it differently.

In this case, the caller doesn't have PCI devices. The nvme fabrics code
has a number of block devices and an RDMA device. It doesn't even know
if these devices are backed by PCI devices and it doesn't have a direct
path to obtain the pci_dev.

Each struct device, might be turned into a pci_dev using the static
function find_parent_pci_dev(). If any device is not a PCI device then
we reject the P2PDMA transaction as not supported. Pushing the
find_parent_pci_dev() logic into the callers is, IMO, just asking the
callers to replicate a bunch of logic it shouldn't even be aware of
creating messier code as a result.

Logan

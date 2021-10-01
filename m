Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC241F769
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355829AbhJAWYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 18:24:36 -0400
Received: from ale.deltatee.com ([204.191.154.188]:36804 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhJAWYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 18:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=ent50A2FumpC9aDXR5Qm0QH4qyHyD1xD/705x8AcEeY=; b=s/z7F8PLrEmDP31iQENlxVoSTT
        4H9l1aoVN8hef71V44S4SxGoamROPJy+o+t5Inv+9wUfb0JlZBmRG9IP5Q5pkDIiMhbUs2EWCzOQD
        ij7Nano0aq6SDFRlJb1aqMkZUYSsEE5MPUok4lkBY/76ZdxutXBGBkZlvnvzvMarVcbrwZUiJHy8x
        hz9y+5idzSe5S/rECi/Cde14mXwHV6WqVx3bDj4NrGxyLns/zKclaYP5wBoByv2HQy7cZ/+ZlvwJ2
        BmRbZwnBFl3l22PHfA1sw7r1YVy4zXYebzwz0wDI8zcvW670GNrgnJ5WAVHpcxCuzGJqAI4LD3eTx
        ng/1j+9w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mWQvK-0000Wo-1S; Fri, 01 Oct 2021 16:22:35 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
Date:   Fri, 1 Oct 2021 16:22:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001221405.GR3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, hch@lst.de, Felix.Kuehling@amd.com, apopple@nvidia.com, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-10-01 4:14 p.m., Jason Gunthorpe wrote:
> On Fri, Oct 01, 2021 at 02:13:14PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2021-10-01 11:45 a.m., Jason Gunthorpe wrote:
>>>> Before the invalidation, an active flag is cleared to ensure no new
>>>> mappings can be created while the unmap is proceeding.
>>>> unmap_mapping_range() should sequence itself with the TLB flush and
>>>
>>> AFIAK unmap_mapping_range() kicks off the TLB flush and then
>>> returns. It doesn't always wait for the flush to fully finish. Ie some
>>> cases use RCU to lock the page table against GUP fast and so the
>>> put_page() doesn't happen until the call_rcu completes - after a grace
>>> period. The unmap_mapping_range() does not wait for grace periods.
>>
>> Admittedly, the tlb flush code isn't the easiest code to understand.
>> But, yes it seems at least on some arches the pages are freed by
>> call_rcu(). But can't this be fixed easily by adding a synchronize_rcu()
>> call after calling unmap_mapping_range()? Certainly after a
>> synchronize_rcu(), the TLB has been flushed and it is safe to free those
>> pages.
> 
> It would close this issue, however synchronize_rcu() is very slow
> (think > 1second) in some cases and thus cannot be inserted here.

It shouldn't be *that* slow, at least not the vast majority of the
time... it seems a bit unreasonable that a CPU wouldn't schedule for
more than a second. But these aren't fast paths and synchronize_rcu()
already gets called in the unbind path for p2pdma a of couple times. I'm
sure it would also be fine to slow down the vma_close() path as well.

> I'm also not completely sure that rcu is the only case, I don't know
> how every arch handles its gather structure.. I have a feeling the
> general intention was for this to be asynchronous

Yeah, this is not clear to me either.

> My preferences are to either remove devmap from gup_fast, or fix it to
> not use special pages - the latter being obviously better.

Yeah, I rather expect DAX users want the optimization provided by
gup_fast. I don't think P2PDMA users would be happy about being stuck
with slow gup either.

Loga

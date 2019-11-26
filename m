Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE610A61D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 22:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKZVpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 16:45:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKZVpc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 16:45:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F5431B;
        Tue, 26 Nov 2019 13:45:31 -0800 (PST)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37D3B3F52E;
        Tue, 26 Nov 2019 13:45:26 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
 <20191123165108.GA15306@ubuntu-x2-xlarge-x86> <20191125074412.GA30595@lst.de>
 <0b851d0e-37c7-062e-c287-05f8c8a54c16@arm.com>
 <45feed391bbd95c46f64b31cf8817d4f773c8da1.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <935d65b4-a28e-d7b9-7392-42fec71b5150@arm.com>
Date:   Tue, 26 Nov 2019 21:45:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <45feed391bbd95c46f64b31cf8817d4f773c8da1.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-26 6:51 pm, Nicolas Saenz Julienne wrote:
> On Mon, 2019-11-25 at 16:33 +0000, Robin Murphy wrote:
>> On 25/11/2019 7:44 am, Christoph Hellwig wrote:
>>> On Sat, Nov 23, 2019 at 09:51:08AM -0700, Nathan Chancellor wrote:
>>>> Just as an FYI, this introduces a warning on arm32 allyesconfig for me:
>>>
>>> I think the dma_limit argument to iommu_dma_alloc_iova should be a u64
>>> and/or we need to use min_t and open code the zero exception.
>>>
>>> Robin, Nicolas - any opinions?
>>
>> Yeah, given that it's always held a mask I'm not entirely sure why it
>> was ever a dma_addr_t rather than a u64. Unless anyone else is desperate
>> to do it I'll get a cleanup patch ready for rc1.
> 
> Sounds good to me too
> 
> Robin, since I started the mess, I'll be happy to do it if it helps offloading
> some work from you.

No worries - your change only exposed my original weird decision ;)  On 
second look the patch was literally a trivial one-liner, so I've written 
it up already.

Cheers,
Robin.

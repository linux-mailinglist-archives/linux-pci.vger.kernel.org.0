Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B07E2234
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKFMrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 07:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjKFMrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 07:47:18 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31210E2;
        Mon,  6 Nov 2023 04:47:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SP9kZ65MQz9xHvq;
        Mon,  6 Nov 2023 20:33:42 +0800 (CST)
Received: from [10.48.129.39] (unknown [10.48.129.39])
        by APP1 (Coremail) with SMTP id LxC2BwC3pnYu4Ehl160mAA--.43166S2;
        Mon, 06 Nov 2023 13:46:46 +0100 (CET)
Message-ID: <90ea3460-a715-47b6-a151-181e542512e9@huaweicloud.com>
Date:   Mon, 6 Nov 2023 13:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
 <20231103195949.0af884d0@meshulam.tesarici.cz>
 <20231106074448.GB17777@lst.de>
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20231106074448.GB17777@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3pnYu4Ehl160mAA--.43166S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFykWFWDGw17ZF4xtw1fWFg_yoW8AFWfpF
        WrtwsxKrs0qF13A397Cw45Wwn5Cwn7uay5JrZ09r9F9wsxGr17Cry7tw4Yva48Ar4kZw1Y
        yFyYvr1DC3WUZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 11/6/2023 8:44 AM, Christoph Hellwig wrote:
> On Fri, Nov 03, 2023 at 07:59:49PM +0100, Petr Tesařík wrote:
>> I don't think it's possible to improve the allocation logic without
>> modifying the page allocator and/or the DMA atomic pool allocator to
>> take additional constraints into account.
>>
>> I had a wild idea back in March, but it would require some intrusive
>> changes in the mm subsystem. Among other things, it would make memory
>> zones obsolete. I mean, people may actually like to get rid of DMA,
>> DMA32 and NORMAL, but you see how many nasty bugs were introduced even
>> by a relatively small change in SWIOTLB. Replacing memory zones with a
>> system based on generic physical allocation constraints would probably
>> blow up the universe. ;-)
> 
> It would be very nice, at least for DMA32 or the 30/31-bit DMA pools
> used on some architectures.  For the x86-style 16MB zone DMA I suspect
> just having a small pool on the side that's not even exposed to the
> memory allocator would probably work better.
> 
> I think a lot of the MM folks would love to be able to kill of the
> extra zones.

There's more to it. If you look at DMA buffer allocations, they need
memory which is contiguous in DMA address space of the requesting
device, but we allocate buffers that are contiguous in physical address
of the CPU. This difference is in fact responsible for some of the odd
DMA address limits.

All hell breaks loose when you try to fix this properly. Instead, we get
away with the observation that physically contiguous memory regions
coincide with DMA contiguous regions on real-world systems. But if
anyone feels like starting from scratch, they could also take the extra
time to look at this part. ;-)

FWIW I'm not volunteering, or at least not this year.

Petr T


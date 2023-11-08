Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2F7E596C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjKHOp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 09:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHOp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 09:45:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF08172E;
        Wed,  8 Nov 2023 06:45:55 -0800 (PST)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SQSXx4VQQz6K8y5;
        Wed,  8 Nov 2023 22:44:49 +0800 (CST)
Received: from [10.195.35.156] (10.195.35.156) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 15:45:51 +0100
Message-ID: <7a4f87c3-b3c6-42c5-9200-8eb56d1c8530@huawei-partners.com>
Date:   Wed, 8 Nov 2023 15:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Content-Language: en-US
To:     Halil Pasic <pasic@linux.ibm.com>
CC:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
 <20231103195949.0af884d0@meshulam.tesarici.cz>
 <20231108115207.791a30d8.pasic@linux.ibm.com>
 <41c0baf6-ba4d-4876-b692-279307265466@huawei-partners.com>
 <20231108153230.6491acaa.pasic@linux.ibm.com>
From:   Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <20231108153230.6491acaa.pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.156]
X-ClientProxiedBy: frapeml100002.china.huawei.com (7.182.85.26) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/8/2023 3:32 PM, Halil Pasic wrote:
> On Wed, 8 Nov 2023 12:04:12 +0100
> Petr Tesarik <petr.tesarik1@huawei-partners.com> wrote:
> [..]
>>>
>>> For the sake of simplicity let us assume we only have the min_align_mask
>>> requirement. Then I believe the worst case is that we need 
>>> (orig_addr & min_align_mask & PAGE_MASK)  + (min_align_mask & ~PAGE_MASK)
>>> extra space to fit.
>>>
>>> Depending on how the semantics pan out one may be able to replace
>>> min_align_mask with combined_mask.
>>>
>>> Is your point that for large combined_mask values 
>>> _get_free_pages(GFP_NOWAIT | __GFP_NOWARN, required_order) is not
>>> likely to complete successfully?  
>>
>> Yes, that's the reason. OTOH it's probably worth a try. The point is
>> that mapping a DMA buffer is allowed to fail, so callers should be
>> prepared anyway.
>>
>> And for the case you reported initially, I don't think there is any need
>> to preserve bit 11 (0x800) from the original buffer's physical address,
>> which is enough to fix it. See also my other email earlier today.
> 
> Hm. Do you mean "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
> with CONFIG_SWIOTLB_DYNAMIC" or a different one?
> 
> I only see "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
> with CONFIG_SWIOTLB_DYNAMIC" but I don't think that one takes
> care of "I don't think there is any need to preserve bit 11 (0x800)
> from the original buffer's physical address".

Yes, I mean only this patch. I want to fix memory corruption fast, while
waiting for more feedback on my understanding of the alignment masks.
What I'm trying to say is that your specific use case may not even need
a bigger allocation if the page alignment should be interpreted differently.

Again, thank you for your in-depth inspection, because it's not totally
clear how the various alignment parameters should be interpreted. It's
difficult to write correct code then...

Petr T

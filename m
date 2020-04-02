Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB93819C0A4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgDBMBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 08:01:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgDBMBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 08:01:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 032C1opR030916;
        Thu, 2 Apr 2020 07:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585828910;
        bh=1e22BO+4f4fw4nP/CxqdEm797bCO43XXz7zI8qKK1fc=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=UbkVzdKB/0aLNeaOnnfq79EsrwgCjrKbW5jjtzhTWg012Kc89C+co4VwBt3m/RqVJ
         aUw60LodF9fVjz6NP43B4pWWRQwxvxhBvolm7U4CZGZf7MJLi2qLGVxZGbVcaARrR6
         Rh5o34tUx9aw7yHG1HZI60UJlUo1JbbNWbW+Pu04=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 032C1n08055479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Apr 2020 07:01:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Apr
 2020 07:01:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Apr 2020 07:01:34 -0500
Received: from [10.250.133.232] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 032C1XCU099944;
        Thu, 2 Apr 2020 07:01:33 -0500
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
 <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
 <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com>
 <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com>
 <20200205091959.GA24413@lst.de> <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com>
 <20200205160542.GA30981@lst.de> <20200217142333.GA28421@lst.de>
 <a7d920ab-b681-45bc-677b-3db76e96cf7c@ti.com>
Message-ID: <c832540a-802a-e361-758d-67f387ae37a5@ti.com>
Date:   Thu, 2 Apr 2020 17:31:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a7d920ab-b681-45bc-677b-3db76e96cf7c@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 2/18/2020 5:45 PM, Kishon Vijay Abraham I wrote:
> Christoph,
> 
> On 17/02/20 7:53 pm, Christoph Hellwig wrote:
>> On Wed, Feb 05, 2020 at 05:05:42PM +0100, Christoph Hellwig wrote:
>>> On Wed, Feb 05, 2020 at 03:03:13PM +0530, Kishon Vijay Abraham I wrote:
>>>> Yes, I see the mismatch after reverting the above patches.
>>>
>>> In which case the data mismatch is very likely due to a different root
>>> cause.
>>
>> Did you manage to dig into this a little more?
> 
> I'll probably get to this later half of this week. Will update you then.
> 

Sorry for the delay in getting back to this. But I guess I have root caused the
issue now.

The issue was because NVMe is requesting a sector size (4096KB) which is more
than what is supported by SWIOTLB default (256KB). NVMe driver actually has a
mechanism to select the correct sector size

 dev->ctrl.max_hw_sectors = min_t(u32,
                NVME_MAX_KB_SZ << 1, dma_max_mapping_size(dev->dev) >> 9);
However dma_max_mapping_size() here misbehaves and gives 4G. Ideally it should
have given 256KB -> the max supported by SWIOTLB

Tracing through the dma_max_mapping_size(), dma_direct_max_mapping_size() was
giving incorrect value

size_t dma_direct_max_mapping_size(struct device *dev)
{
        /* If SWIOTLB is active, use its maximum mapping size */
        if (is_swiotlb_active() &&
            (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
                return swiotlb_max_mapping_size(dev);
        return SIZE_MAX;
}
In the above function swiotlb_max_mapping_size(dev) gives 256KB however
dma_addressing_limited(dev) always returns false. So 256KB is never returned to
the NVMe driver.

Tracing dma_addressing_limited(dev), found a bug in
dma_direct_get_required_mask(). When it passes the physical address to
phys_to_dma_direct(), the upper 32 bit is lost and dma_addressing_limited(dev)
thinks the entire address is accessible by the device.

A patch that type casts the argument of phys_to_dma_direct() like below fixes
the issue.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 32ec69cdba54..0081410334c8 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -51,7 +51,9 @@ static inline struct page *dma_direct_to_page(struct device
*dev, u64 dma_direct_get_required_mask(struct device *dev)
 {
-       u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+       u64 max_dma =
+               phys_to_dma_direct(dev,
+                                  (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT);
        return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }

If this looks okay to you, I can post a patch for it.

Thanks
Kishon

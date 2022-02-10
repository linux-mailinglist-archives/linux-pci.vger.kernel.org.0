Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419754B1469
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbiBJRkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 12:40:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245254AbiBJRkl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 12:40:41 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1A25C2
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 09:40:40 -0800 (PST)
Message-ID: <2244c362-44c0-81b5-da1c-5b0311c93152@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644514839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6Rfy/UKKgLazHa3clHJ2vgyrgQCqHhS7QKoIwSTyyA=;
        b=iP6nu2i1AKa4SWdXVoGDVq/vBNhQac0bIIncHKro+JKozcLBOCzgQiD5fcRaJdQGbq3BRz
        3cuq0ovEMH8AH/uettb6JRN5lEcbInJYbUtyHZBbmpwY7l32G//0wKvY9ra+UZJy+Uya3Q
        T+CPyYt4PgF65h1Oo9cUtKdqzEnzFCQ=
Date:   Thu, 10 Feb 2022 10:40:18 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Check EIME mode before MSI remapping
Content-Language: en-US
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220204084036.5017-1-nirmal.patel@linux.intel.com>
 <6def8bea-d6ae-90ec-0804-11812d1ae8eb@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <6def8bea-d6ae-90ec-0804-11812d1ae8eb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/2022 1:56 PM, Patel, Nirmal wrote:
> On 2/4/2022 1:40 AM, Nirmal Patel wrote:
>> We are observing DMAR errors from vt-d when vmd is enabled along with
>> interrupt remapping and extended interrupt mode. As a result the host
>> machine is not able boot successfully.
>>
>> DMAR: DRHD: handling fault status reg 2
>> DMAR: [INTR-REMAP] Request device [0xc9:0x05.0] fault index 0xa00
>> [fault reason 0x25] Blocked a compatibility format interrupt request
>>
>> The issue was observed in intel Whitley platform and newer with ICE
Capitalize 'Intel'


>> Lake processor with latest kernel. The issued was also reproduced in
>> 5.10 by backporting patches related to commit ee81ee84f873 ("PCI: vmd:
>> Disable MSI-X remapping when possible")
>>
>> According to Intel VT-d specs section "5.1.4 Interrupt-Remapping
>> Hardware Operation", If Extended Interrupt Mode is enabled (EIME), or
>> if the Compatibility format interrupts are disabled (CFIS), the
>> Compatibility format interrupts are blocked.
>>
>> Do not disable MSI remapping if interrupt remapping enabled and
>> x2apic_opt_out mode is disabled.
This doesn't really satisfy the explanation as to why this mode is not
working. The compatibility format interrupt requests are correctly blocked,
however they should not be being programmed with compatibility format
interrupt requests in the first place. The interrupt request programming
should be done according to the Intel IRQ remapping formats and this should
be VMD-compatible (or at least, it was at one point). Though I don't know
how EIME differs from what I observed before...

If this patch is just a placeholder until the issue can be investigated
and fixed, can you please say that in the commit message?


>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>   drivers/pci/controller/vmd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index cc166c683638..4eb38c6bd578 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/srcu.h>
>>   #include <linux/rculist.h>
>>   #include <linux/rcupdate.h>
>> +#include <asm/apic.h>
>>   
>>   #include <asm/irqdomain.h>
>>   
>> @@ -814,7 +815,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>   	 * remapping doesn't become a performance bottleneck.
>>   	 */
>>   	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>> +	    x2apic_enabled() || !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>   	    offset[0] || offset[1]) {
This conditional is getting a little unsightly and over-encompassing.
Can you split it up into multiple conditionals and add appropriate comments?


>>   		ret = vmd_alloc_irqs(vmd);
>>   		if (ret)
> 
> Hello,
> 
> Gentle ping. Please let me know if there is a suggestion.
> 
> Thanks.
> 

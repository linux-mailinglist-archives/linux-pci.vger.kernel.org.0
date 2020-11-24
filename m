Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B444E2C1C57
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 04:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKXD5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 22:57:19 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16324 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKXD5T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2020 22:57:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc849f0001>; Mon, 23 Nov 2020 19:57:19 -0800
Received: from [10.40.101.31] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 03:57:11 +0000
Subject: Re: [PATCH] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201120213036.GA278887@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <a11f7fb2-6512-484f-70f8-bd9493ab7766@nvidia.com>
Date:   Tue, 24 Nov 2020 09:27:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201120213036.GA278887@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606190239; bh=tw/iAw+vbSDGofDACoQ9Ai9A4bgTac58Miq7w2/0VPY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=brxhgsxwG2qvo3vLJIq4+l1u16J9irnZMeNKS2e8RQNKs91OYStlqeCsNH6dQHG6G
         RfuQ5nS1RhS2z4SOvwqX9wWq6y0Q48R4723ohQ+oK45CoZ+TDNIqh+MAgfFLZQeMUT
         4G5Q4wPN1751jsoZAEslHiBpcS0/IaMF0v1EEtzw9jlqijfUF5VywkpBUg9o2XoZc6
         yuigXwp/HrItaz9DnWMo21kt2+i4hPDaVCIedspzBzhVXYrp4WRhCJTFjdApckz7k7
         lbFNmFX5YtWA8KgeLCFI5DqIDQMgCgiWKmw1qCPSE2cqnEpsZG6EZUUrvid3FMj0qO
         cW54w2t05XJ2g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/21/2020 3:00 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Nov 17, 2020 at 08:27:28PM +0530, Vidya Sagar wrote:
>> There are devices (Ex:- Marvell SATA controller) that don't support
>> 64-bit MSIs and the same is advertised through their MSI capability
>> register.
> 
> I *think* you're saying these devices behave correctly per spec: they
> don't support 64-bit MSI, and they don't advertise support for 64-bit
> MSI.  Right?
Yes. That is what I intended to say.

> 
>> Set no_64bit_msi flag explicitly for such devices in the
>> MSI setup code so that the msi_verify_entries() API would catch
>> if the MSI arch code tries to use 64-bit MSI.
> 
> And you want msi_verify_entries() to catch attempts by the arch code
> to assign a 64-bit MSI address?
Yes.

> 
> That sounds OK, but the error message ("Device has broken 64-bit MSI")
> is not appropriate if the device is actually *not* broken.
Ok. I didn't change the existing error message. I'll change it to cover 
both the scenarios i.e. either the device is broken or the device 
doesn't really support 64-bit MSI.

> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/msi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d52d118979a6..af49da28854e 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>>        entry->msi_attrib.multi_cap     = (control & PCI_MSI_FLAGS_QMASK) >> 1;
>>        entry->msi_attrib.multiple      = ilog2(__roundup_pow_of_two(nvec));
>>
>> -     if (control & PCI_MSI_FLAGS_64BIT)
>> +     if (control & PCI_MSI_FLAGS_64BIT) {
>>                entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
>> -     else
>> +     } else {
>>                entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>> +             dev->no_64bit_msi = 1;
>> +     }
>>
>>        /* Save the initial mask status */
>>        if (entry->msi_attrib.maskbit)
>> --
>> 2.17.1
>>

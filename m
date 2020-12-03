Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF982CDE6C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgLCTEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 14:04:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6680 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgLCTEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 14:04:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc9369c0000>; Thu, 03 Dec 2020 11:03:56 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 19:03:49 +0000
Subject: Re: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201203182423.GA1555592@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <75de8b9d-b4f1-5a68-8510-019017163baa@nvidia.com>
Date:   Fri, 4 Dec 2020 00:33:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201203182423.GA1555592@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607022236; bh=Jq7vSLsV6byVAkVtan9MuuBS66+ooNRMO13M285XTYI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=a2vr3PmJr/WLDQU0AgXbrsMW7RvDqop+L0APY0lfCQCc+zJsR3QlBHHU9BgY6XDeQ
         PmuXTxals7cIn9U+N4P6FqbecgkKL0iANtEYnrhbdN8WFTQNHqqMfBnwOkX7kZ5h/5
         /pdmffHR7CvyoF/G/oDeZFYOHS1GZCpizOZS2UQvKLkzAu76wQa6owRrwNtdesjrOk
         5uxT4S6vvJGn7LzRW8fnpGeYB23Obib3UwVh4syjDMTSNzTTOVsCPTmVttj1h0+ewQ
         RMAsFo55j98c9IOvHqYsCiaB+EFZmgusXNND6ZDHbRAkGxFqoNOuV1Ob+g9G3QfiZs
         VYskpei0sC35w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/3/2020 11:54 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Nov 24, 2020 at 04:20:35PM +0530, Vidya Sagar wrote:
>> There are devices (Ex:- Marvell SATA controller) that don't support
>> 64-bit MSIs and the same is advertised through their MSI capability
>> register. Set no_64bit_msi flag explicitly for such devices in the
>> MSI setup code so that the msi_verify_entries() API would catch
>> if the MSI arch code tries to use 64-bit MSI.
> 
> This seems good to me.  I'll post a possible revision to set
> dev->no_64bit_msi in the device enumeration path instead of in the IRQ
> allocation path, since it's really a property of the device, not of
> the msi_desc.
> 
> I like the extra checking this gives us.  Was this prompted by
> tripping over something, or is it something you noticed by code
> reading?  If the former, a hint about what was wrong and how it's
> being fixed would be useful.
I observed functionality issue with Marvell SATA controller (1b4b:9171) 
when the allocated MSI target address was a 64-bit address. I mentioned 
the Marvell SATA controller as an example in the commit message.

Thanks,
Vidya Sagar

> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Addressed Bjorn's comment and changed the error message
>>
>>   drivers/pci/msi.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d52d118979a6..8de5ba6b4a59 100644
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
>> @@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
>>        for_each_pci_msi_entry(entry, dev) {
>>                if (!dev->no_64bit_msi || !entry->msg.address_hi)
>>                        continue;
>> -             pci_err(dev, "Device has broken 64-bit MSI but arch"
>> -                     " tried to assign one above 4G\n");
>> +             pci_err(dev, "Device has either broken 64-bit MSI or "
>> +                     "only 32-bit MSI support but "
>> +                     "arch tried to assign one above 4G\n");
>>                return -EIO;
>>        }
>>        return 0;
>> --
>> 2.17.1
>>

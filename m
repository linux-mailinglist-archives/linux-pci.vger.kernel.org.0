Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D4B2CE5B4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 03:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLDC3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 21:29:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5469 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLDC3b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 21:29:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc99ee20001>; Thu, 03 Dec 2020 18:28:50 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Dec
 2020 02:28:43 +0000
Subject: Re: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201203195404.GA1587879@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <43adb2d1-1fed-763d-c52f-152bee29f199@nvidia.com>
Date:   Fri, 4 Dec 2020 07:58:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201203195404.GA1587879@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607048930; bh=437wcV7/qjO1rE8/1idJpMKx2nxR8pdl6JPcxfFTyDA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ZjsJeLXLHoAMG/l16IYdrT0R3IQYxvDLOG1BKJOIJJHxrGK05m8l1irts7pAGbB64
         mBOXOhk8QqdG8PP3+kf/URvaewALVXtwz/iXg4s6wCgQmFSa+8+2bW1VFAo6bE+t0s
         5CO3cYbOrt4ScgmQz57n8FWrM2qsgOpbd7Owj/pYdV+TdiE90JXfda5ON1T7cJByab
         GDDjnZIshGugT23zvzDO6Kx+4MMUqVotvWy9VkNjbo+gohRNzroiY1p+ymteqDDwP3
         rtxqWUYHkh/5K2Z5ltC5igs2iiMJJl6UH/ZWQAMPhkbca5kRgaKnUmksxNT4jKxnvi
         NmfK7OG9mecjQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/4/2020 1:24 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Dec 04, 2020 at 12:33:45AM +0530, Vidya Sagar wrote:
>> On 12/3/2020 11:54 PM, Bjorn Helgaas wrote:
>>> On Tue, Nov 24, 2020 at 04:20:35PM +0530, Vidya Sagar wrote:
>>>> There are devices (Ex:- Marvell SATA controller) that don't support
>>>> 64-bit MSIs and the same is advertised through their MSI capability
>>>> register. Set no_64bit_msi flag explicitly for such devices in the
>>>> MSI setup code so that the msi_verify_entries() API would catch
>>>> if the MSI arch code tries to use 64-bit MSI.
>>>
>>> This seems good to me.  I'll post a possible revision to set
>>> dev->no_64bit_msi in the device enumeration path instead of in the IRQ
>>> allocation path, since it's really a property of the device, not of
>>> the msi_desc.
>>>
>>> I like the extra checking this gives us.  Was this prompted by
>>> tripping over something, or is it something you noticed by code
>>> reading?  If the former, a hint about what was wrong and how it's
>>> being fixed would be useful.
>> I observed functionality issue with Marvell SATA controller (1b4b:9171) when
>> the allocated MSI target address was a 64-bit address. I mentioned the
>> Marvell SATA controller as an example in the commit message.
> 
> I know you mentioned the Marvell controller, but apparently that
> device is working perfectly correctly: it does not support 64-bit MSI,
> and it does not advertise support for 64-bit MSI.
> 
> So if there's a functionality issue, that means something is wrong in
> Linux that caused us to assign a 64-bit MSI address to it.  *That*
> issue is what I want to know about.  Your patch only warns about the
> issue; it doesn't fix it.
The issue is in the DWC code. I pushed a generic patch to fix that issue 
by specifying the limit of MSI target address to 32-bit region. Patch is 
up for review at 
http://patchwork.ozlabs.org/project/linux-pci/patch/20201117165312.25847-1-vidyas@nvidia.com/

> 
> I don't think there's any point in specifically mentioning the Marvell
> device if it is working correctly, because the same issue should
> affect *any* device that doesn't support 64-bit MSI.  But if there's
> some arch code that incorrectly assigns a 64-bit address, it would
> definitely be useful to specify the arch.  And hopefully there's a fix
> for that arch code, too.
> 
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> V2:
>>>> * Addressed Bjorn's comment and changed the error message
>>>>
>>>>    drivers/pci/msi.c | 11 +++++++----
>>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>>> index d52d118979a6..8de5ba6b4a59 100644
>>>> --- a/drivers/pci/msi.c
>>>> +++ b/drivers/pci/msi.c
>>>> @@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>>>>         entry->msi_attrib.multi_cap     = (control & PCI_MSI_FLAGS_QMASK) >> 1;
>>>>         entry->msi_attrib.multiple      = ilog2(__roundup_pow_of_two(nvec));
>>>>
>>>> -     if (control & PCI_MSI_FLAGS_64BIT)
>>>> +     if (control & PCI_MSI_FLAGS_64BIT) {
>>>>                 entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
>>>> -     else
>>>> +     } else {
>>>>                 entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>>>> +             dev->no_64bit_msi = 1;
>>>> +     }
>>>>
>>>>         /* Save the initial mask status */
>>>>         if (entry->msi_attrib.maskbit)
>>>> @@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
>>>>         for_each_pci_msi_entry(entry, dev) {
>>>>                 if (!dev->no_64bit_msi || !entry->msg.address_hi)
>>>>                         continue;
>>>> -             pci_err(dev, "Device has broken 64-bit MSI but arch"
>>>> -                     " tried to assign one above 4G\n");
>>>> +             pci_err(dev, "Device has either broken 64-bit MSI or "
>>>> +                     "only 32-bit MSI support but "
>>>> +                     "arch tried to assign one above 4G\n");
>>>>                 return -EIO;
>>>>         }
>>>>         return 0;
>>>> --
>>>> 2.17.1
>>>>

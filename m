Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB21B704D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDXJLV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 05:11:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2851 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbgDXJLV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 05:11:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 383DAF85E61B18CF6E1D;
        Fri, 24 Apr 2020 17:11:19 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Apr 2020
 17:11:16 +0800
Subject: Re: [PATCH RFC] pci: Make return value of pcie_capability_read*()
 consistent
To:     Saheed Bolarinwa <refactormyself@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20200423223819.GA248903@google.com>
 <83f65f3f-6586-3986-4c5e-011735758c7e@gmail.com>
CC:     <bjorn@helgaas.com>, <skhan@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <d80f8d9e-0676-5661-6031-39fe4460b66c@hisilicon.com>
Date:   Fri, 24 Apr 2020 17:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <83f65f3f-6586-3986-4c5e-011735758c7e@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/4/24 14:02, Saheed Bolarinwa wrote:
>
> On 4/24/20 12:38 AM, Bjorn Helgaas wrote:
>> On Thu, Apr 23, 2020 at 07:55:17PM +0800, Yicong Yang wrote:
>>> On 2020/4/19 14:51, Bolarinwa Olayemi Saheed wrote:
>>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>>> index 79c4a2ef269a..451f2b8b2b3c 100644
>>>> --- a/drivers/pci/access.c
>>>> +++ b/drivers/pci/access.c
>>>> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>> Maybe provide some comments for the function, to notify the outside
>>> users to do the error code conversion.
>> A short function comment about the set of possible return values
>> wouldn't hurt.  We don't have those for pci_read_config_word() and
>> friends, and there are several pcie_capability_*() functions.  I don't
>> think it's worth repeating the comment for every function, so maybe we
>> could just extend the existing comment at pcie_capability_read_word().
>
> Is enough to adjust the comment on pcie_capability_read_word() to this:
>
>    /*
>      * Note that these accessor functions are only for the "PCI Express
>      * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
>      * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
>      *
>      * On error, this function returns a PCIBIOS_* error code,
>      * you may want to use pcibios_err_to_errno()(include/linux/pci.h)
>      * to convert to a non-PCI code
>      */

okay. Or we can provide kernel-doc as you wish.

>
>>> BTW, pci_{read, write}_config_*() may also have the issues that
>>> export the private err code outside. You may want to solve these in
>>> a series along with this patch.
>> If you see a specific issue, please point it out.

arch/x86/platform/intel/iosf_mbi.c, iosf_mbi_pci_read_mdr():
        result = pci_read_config_dword(mbi_pdev, MBI_MDR_OFFSET, mdr);
        if (result < 0)
            goto fail_read;
        return 0;
    fail_read:
        dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
        return result;

Not sure if there is much in the kernel.

>>
>> I looked at pci_read_config_word(), and it can return
>> PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, or the return
>> value from bus->ops->read().
>>
>> I looked at all the users of PCIBIOS_*.  There's really no interesting
>> use of any of them except by pcibios_err_to_errno() and
>> xen_pcibios_err_to_errno(), so I'm not sure it's even worth keeping
>> them.

maybe we can mark them as deprecated. I can send a RFC one to do so.

>>
>> But I think it's probably more work to excise all of them than it is
>> to simply make pci_read_config_word() and pcie_capability_read_word()
>> return the same set of error values.  So I think we should do this
>> first.
>>

okay.

>>>>       *val = 0;
>>>>       if (pos & 1)
>>>> -        return -EINVAL;
>>>> +        return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>         if (pcie_capability_reg_implemented(dev, pos)) {
>>>>           ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>>>> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>>>         *val = 0;
>>>>       if (pos & 3)
>>>> -        return -EINVAL;
>>>> +        return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>         if (pcie_capability_reg_implemented(dev, pos)) {
>>>>           ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
>
> Also, can I just send this as a single patch while we conclude on pcie_capability_write*() ?

Sure. As Bjorn suggested.

Regards.
Yicong

>
> Thank you.
>
> - Saheed
>
> .
>


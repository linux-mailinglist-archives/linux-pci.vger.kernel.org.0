Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F0304E0
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 00:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3Wta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 18:49:30 -0400
Received: from alpha.anastas.io ([104.248.188.109]:34025 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE3Wta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 18:49:30 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B9F0480876;
        Thu, 30 May 2019 17:49:27 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1559256569; bh=xTKJQEWUHcj4qHERUh0/IJuLqBqEnff/lEqXt1KT7ek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jBqByJkpcmWoHfxjLWMWipsqctjA038FfsazWJbI+62m9EkHiXSYrBz38k5OuzUTp
         2AOQSNiCUlP3wh8yW+IAXSbgcc6Utk+0/wp4Nn0NE5mBNwZSKPmwRCovqWcseto0Ro
         6AqxEpkog+VZZx2XeEeH6MRHvqK9joXQyl1BsVHIOGzwFedaRZ/5vFJyj4w+7PYC+Q
         M/Ep9Nupt+9TgTgy9hq3m4/wYTEuHh9agMeXusFUXArsMgjkVXH68ZnUKPjtKcnn2B
         tT9PF482cdllv6dUVCjtyvawKjxRwAro7msdtRcJiQJKGzE8kaSGuFWxYUJGEuNrl3
         qPRcg+wAcNzjg==
Subject: Re: [PATCH v3 1/3] PCI: Introduce pcibios_ignore_alignment_request
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, Oliver <oohall@gmail.com>
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rppt@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>, xyjxie@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20190528040313.35582-1-shawn@anastas.io>
 <20190528040313.35582-2-shawn@anastas.io>
 <CAOSf1CEFfbmwfvmdqT1xdt8SFb=tYdYXLfXeyZ8=iRnhg4a3Pg@mail.gmail.com>
 <b0a38504-24c3-77bc-b308-7b498f07760a@ozlabs.ru>
 <bccfec8f-c8a4-fac1-7e96-be84113b9a73@anastas.io>
 <3e6b9d7d-5d18-645e-5ef9-6b8a77fa62e9@ozlabs.ru>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <985681e4-1236-fff7-e9e7-189a340487dd@anastas.io>
Date:   Thu, 30 May 2019 17:49:27 -0500
MIME-Version: 1.0
In-Reply-To: <3e6b9d7d-5d18-645e-5ef9-6b8a77fa62e9@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/29/19 10:39 PM, Alexey Kardashevskiy wrote:
> 
> 
> On 28/05/2019 17:39, Shawn Anastasio wrote:
>>
>>
>> On 5/28/19 1:27 AM, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 28/05/2019 15:36, Oliver wrote:
>>>> On Tue, May 28, 2019 at 2:03 PM Shawn Anastasio <shawn@anastas.io>
>>>> wrote:
>>>>>
>>>>> Introduce a new pcibios function pcibios_ignore_alignment_request
>>>>> which allows the PCI core to defer to platform-specific code to
>>>>> determine whether or not to ignore alignment requests for PCI
>>>>> resources.
>>>>>
>>>>> The existing behavior is to simply ignore alignment requests when
>>>>> PCI_PROBE_ONLY is set. This is behavior is maintained by the
>>>>> default implementation of pcibios_ignore_alignment_request.
>>>>>
>>>>> Signed-off-by: Shawn Anastasio <shawn@anastas.io>
>>>>> ---
>>>>>    drivers/pci/pci.c   | 9 +++++++--
>>>>>    include/linux/pci.h | 1 +
>>>>>    2 files changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 8abc843b1615..8207a09085d1 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -5882,6 +5882,11 @@ resource_size_t __weak
>>>>> pcibios_default_alignment(void)
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> +int __weak pcibios_ignore_alignment_request(void)
>>>>> +{
>>>>> +       return pci_has_flag(PCI_PROBE_ONLY);
>>>>> +}
>>>>> +
>>>>>    #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
>>>>>    static char
>>>>> resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
>>>>>    static DEFINE_SPINLOCK(resource_alignment_lock);
>>>>> @@ -5906,9 +5911,9 @@ static resource_size_t
>>>>> pci_specified_resource_alignment(struct pci_dev *dev,
>>>>>           p = resource_alignment_param;
>>>>>           if (!*p && !align)
>>>>>                   goto out;
>>>>> -       if (pci_has_flag(PCI_PROBE_ONLY)) {
>>>>> +       if (pcibios_ignore_alignment_request()) {
>>>>>                   align = 0;
>>>>> -               pr_info_once("PCI: Ignoring requested alignments
>>>>> (PCI_PROBE_ONLY)\n");
>>>>> +               pr_info_once("PCI: Ignoring requested alignments\n");
>>>>>                   goto out;
>>>>>           }
>>>>
>>>> I think the logic here is questionable to begin with. If the user has
>>>> explicitly requested re-aligning a resource via the command line then
>>>> we should probably do it even if PCI_PROBE_ONLY is set. When it breaks
>>>> they get to keep the pieces.
>>>>
>>>> That said, the real issue here is that PCI_PROBE_ONLY probably
>>>> shouldn't be set under qemu/kvm. Under the other hypervisor (PowerVM)
>>>> hotplugged devices are configured by firmware before it's passed to
>>>> the guest and we need to keep the FW assignments otherwise things
>>>> break. QEMU however doesn't do any BAR assignments and relies on that
>>>> being handled by the guest. At boot time this is done by SLOF, but
>>>> Linux only keeps SLOF around until it's extracted the device-tree.
>>>> Once that's done SLOF gets blown away and the kernel needs to do it's
>>>> own BAR assignments. I'm guessing there's a hack in there to make it
>>>> work today, but it's a little surprising that it works at all...
>>>
>>>
>>> The hack is to run a modified qemu-aware "/usr/sbin/rtas_errd" in the
>>> guest which receives an event from qemu (RAS_EPOW from
>>> /proc/interrupts), fetches device tree chunks (and as I understand it -
>>> they come with BARs from phyp but without from qemu) and writes "1" to
>>> "/sys/bus/pci/rescan" which calls pci_assign_resource() eventually:
>>
>> Interesting. Does this mean that the PHYP hotplug path doesn't
>> call pci_assign_resource?
> 
> 
> I'd expect dlpar_add_slot() to be called under phyp and eventually
> pci_device_add() which (I think) may or may not trigger later reassignment.
> 
> 
>> If so it means the patch may not
>> break that platform after all, though it still may not be
>> the correct way of doing things.
> 
> 
> We should probably stop enforcing the PCI_PROBE_ONLY flag - it seems
> that (unless resource_alignment= is used) the pseries guest should just
> walk through all allocated resources and leave them unchanged.

If we add a pcibios_default_alignment() implementation like was
suggested earlier, then it will behave as if the user has
specified resource_alignment= by default and SLOF's assignments
won't be honored (I think).

I guess it boils down to one question - is it important that we
observe SLOF's initial BAR assignments? If not, the device tree
modification that Sam found would work fine here. Otherwise,
we need a way to honor the initial assignments from SLOF while
still allowing custom alignments for hotplugged devices, either
by deferring to the platform code like I do here, unsetting
PCI_PROBE_ONLY in certain cases or by using IORESOURCE_PCI_FIXED
like Bjorn suggested.

> 
> 
>>> [c000000006e6f960] [c0000000005f62d4] pci_assign_resource+0x44/0x360
>>>
>>> [c000000006e6fa10] [c0000000005f8b54]
>>> assign_requested_resources_sorted+0x84/0x110
>>> [c000000006e6fa60] [c0000000005f9540]
>>> __assign_resources_sorted+0xd0/0x750
>>> [c000000006e6fb40] [c0000000005fb2e0]
>>> __pci_bus_assign_resources+0x80/0x280
>>> [c000000006e6fc00] [c0000000005fb95c]
>>> pci_assign_unassigned_bus_resources+0xbc/0x100
>>> [c000000006e6fc60] [c0000000005e3d74] pci_rescan_bus+0x34/0x60
>>>
>>> [c000000006e6fc90] [c0000000005f1ef4] rescan_store+0x84/0xc0
>>>
>>> [c000000006e6fcd0] [c00000000068060c] bus_attr_store+0x3c/0x60
>>>
>>> [c000000006e6fcf0] [c00000000037853c] sysfs_kf_write+0x5c/0x80
>>>
>>>
>>>
>>>
>>>
>>>>
>>>> IIRC Sam Bobroff was looking at hotplug under pseries recently so he
>>>> might have something to add. He's sick at the moment, but I'll ask him
>>>> to take a look at this once he's back among the living
>>>>
>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>> index 4a5a84d7bdd4..47471dcdbaf9 100644
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -1990,6 +1990,7 @@ static inline void
>>>>> pcibios_penalize_isa_irq(int irq, int active) {}
>>>>>    int pcibios_alloc_irq(struct pci_dev *dev);
>>>>>    void pcibios_free_irq(struct pci_dev *dev);
>>>>>    resource_size_t pcibios_default_alignment(void);
>>>>> +int pcibios_ignore_alignment_request(void);
>>>>>
>>>>>    #ifdef CONFIG_HIBERNATE_CALLBACKS
>>>>>    extern struct dev_pm_ops pcibios_pm_ops;
>>>>> -- 
>>>>> 2.20.1
>>>>>
>>>
> 

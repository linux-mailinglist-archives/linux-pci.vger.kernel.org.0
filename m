Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F21435CD8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 10:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUI2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 04:28:19 -0400
Received: from office.oderland.com ([91.201.60.5]:35556 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUI2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 04:28:19 -0400
Received: from [193.180.18.161] (port=58520 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mdTOj-000PeQ-Go; Thu, 21 Oct 2021 10:26:01 +0200
Message-ID: <3434cb2d-4060-7969-d4c4-089c68190527@oderland.se>
Date:   Thu, 21 Oct 2021 10:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [PATCH v2] PCI/MSI: Re-add checks for skip masking MSI-X on Xen
 PV
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jason Andryuk <jandryuk@gmail.com>
References: <20211019202906.GA2397931@bhelgaas>
 <5f050b30-fa1c-8387-0d6b-a667851b34b0@oderland.se>
 <877de7dfl2.wl-maz@kernel.org>
 <CAKf6xpt=ZYGyJXMwM7ccOWkx71R0O-QeLjkBF-LtdDcbSnzHsA@mail.gmail.com>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <CAKf6xpt=ZYGyJXMwM7ccOWkx71R0O-QeLjkBF-LtdDcbSnzHsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/21 16:03, Jason Andryuk wrote:
> Hi, Marc,
>
> Adding Juergen and Boris since this involves Xen.
>
> On Wed, Oct 20, 2021 at 8:51 AM Marc Zyngier <maz@kernel.org> wrote:
>> On Tue, 19 Oct 2021 22:48:19 +0100,
>> Josef Johansson <josef@oderland.se> wrote:
>>> From: Josef Johansson <josef@oderland.se>
>>>
>>>
>>> PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
>>>
>>> commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>>> functions") introduce functions pci_msi_update_mask() and
>>> pci_msix_write_vector_ctrl() that is missing checks for
>>> pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
>>> new mask/unmask functions"). Add them back since it is
>>> causing severe lockups in amdgpu drivers under Xen during boot.
>>>
>>> As explained in commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X
>>> on Xen PV"), when running as Xen PV guest, masking MSI-X is a
>>> responsibility of the hypervisor.
>>>
>>> Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>>> functions")
>>> Suggested-by: Jason Andryuk <jandryuk@gmail.com>
>>> Signed-off-by: Josef Johansson <josef@oderland.se>
>>>
>> [...]
>>
>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>> index 0099a00af361..355b791e382f 100644
>>> --- a/drivers/pci/msi.c
>>> +++ b/drivers/pci/msi.c
>>> @@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
>>>       raw_spinlock_t *lock = &desc->dev->msi_lock;
>>>       unsigned long flags;
>>>
>>> +     if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>> +             return;
>>> +
>> I'd rather be consistent, and keep the check outside of
>> pci_msi_update_mask(), just like we do in __pci_msi_mask_desc().
>> Something like this instead:
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 0099a00af361..6c69eab304ce 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -420,7 +420,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
>>         arch_restore_msi_irqs(dev);
>>
>>         pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>> -       pci_msi_update_mask(entry, 0, 0);
>> +       if (!(pci_msi_ignore_mask || desc->msi_attrib.is_virtual))
>> +               pci_msi_update_mask(entry, 0, 0);
>>         control &= ~PCI_MSI_FLAGS_QSIZE;
>>         control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
>>         pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
>>
>> But the commit message talks about MSI-X, and the above is MSI
>> only. Is Xen messing with the former, the latter, or both?
> My understanding is pci_msi_ignore_mask covers both MSI and MSI-X for Xen.

Please let me know if I should go ahead and try it out and send in a v3
of the patch.

I'm watching for further discussion right now, just to be clear.
>>>       raw_spin_lock_irqsave(lock, flags);
>>>       desc->msi_mask &= ~clear;
>>>       desc->msi_mask |= set;
>>> @@ -181,6 +184,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>>>  {
>>>       void __iomem *desc_addr = pci_msix_desc_addr(desc);
>>>
>>> +     if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>> +             return;
>>> +
>>>       writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>  }
>> I have similar reservations for this one.
> The problem here is some of the changes in commit 446a98b19fd6
> ("PCI/MSI: Use new mask/unmask functions") bypass the checks in
> __pci_msi_mask_desc/__pci_msi_unmask_desc.  I've wondered if it would
> be cleaner to push all the `if (pci_msi_ignore_mask)` checks down to
> the place of the writes.  That keeps dropping the write local to the
> write and leaves the higher level code consistent between the regular
> and Xen PV cases.  I don't know where checking
> desc->msi_attrib.is_virtual is appropriate.
>
> Regards,
> Jason

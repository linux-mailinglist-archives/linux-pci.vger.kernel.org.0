Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D3438B91
	for <lists+linux-pci@lfdr.de>; Sun, 24 Oct 2021 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhJXS5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 14:57:34 -0400
Received: from office.oderland.com ([91.201.60.5]:53596 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXS5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Oct 2021 14:57:33 -0400
Received: from [193.180.18.161] (port=37118 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1meieD-009vkr-TP; Sun, 24 Oct 2021 20:55:09 +0200
Message-ID: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
Date:   Sun, 24 Oct 2021 20:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
From:   Josef Johansson <josef@oderland.se>
To:     Marc Zyngier <maz@kernel.org>, Jason Andryuk <jandryuk@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20211019202906.GA2397931@bhelgaas>
 <5f050b30-fa1c-8387-0d6b-a667851b34b0@oderland.se>
 <877de7dfl2.wl-maz@kernel.org>
 <CAKf6xpt=ZYGyJXMwM7ccOWkx71R0O-QeLjkBF-LtdDcbSnzHsA@mail.gmail.com>
 <3434cb2d-4060-7969-d4c4-089c68190527@oderland.se>
Content-Language: en-US
Subject: Re: [PATCH v2] PCI/MSI: Re-add checks for skip masking MSI-X on Xen
 PV
In-Reply-To: <3434cb2d-4060-7969-d4c4-089c68190527@oderland.se>
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

On 10/21/21 10:25, Josef Johansson wrote:
> On 10/20/21 16:03, Jason Andryuk wrote:
>> Hi, Marc,
>>
>> Adding Juergen and Boris since this involves Xen.
>>
>> On Wed, Oct 20, 2021 at 8:51 AM Marc Zyngier <maz@kernel.org> wrote:
>>> On Tue, 19 Oct 2021 22:48:19 +0100,
>>> Josef Johansson <josef@oderland.se> wrote:
>>>> From: Josef Johansson <josef@oderland.se>
>>>>
>>>>
>>>> PCI/MSI: Re-add checks for skip masking MSI-X on Xen PV
>>>>
>>>> commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>>>> functions") introduce functions pci_msi_update_mask() and
>>>> pci_msix_write_vector_ctrl() that is missing checks for
>>>> pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
>>>> new mask/unmask functions"). Add them back since it is
>>>> causing severe lockups in amdgpu drivers under Xen during boot.
>>>>
>>>> As explained in commit 1a519dc7a73c ("PCI/MSI: Skip masking MSI-X
>>>> on Xen PV"), when running as Xen PV guest, masking MSI-X is a
>>>> responsibility of the hypervisor.
>>>>
>>>> Fixes: fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>>>> functions")
>>>> Suggested-by: Jason Andryuk <jandryuk@gmail.com>
>>>> Signed-off-by: Josef Johansson <josef@oderland.se>
>>>>
>>> [...]
>>>
>>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>>> index 0099a00af361..355b791e382f 100644
>>>> --- a/drivers/pci/msi.c
>>>> +++ b/drivers/pci/msi.c
>>>> @@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
>>>>       raw_spinlock_t *lock = &desc->dev->msi_lock;
>>>>       unsigned long flags;
>>>>
>>>> +     if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>>> +             return;
>>>> +
>>> I'd rather be consistent, and keep the check outside of
>>> pci_msi_update_mask(), just like we do in __pci_msi_mask_desc().
>>> Something like this instead:
>>>
>>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>>> index 0099a00af361..6c69eab304ce 100644
>>> --- a/drivers/pci/msi.c
>>> +++ b/drivers/pci/msi.c
>>> @@ -420,7 +420,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
>>>         arch_restore_msi_irqs(dev);
>>>
>>>         pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>>> -       pci_msi_update_mask(entry, 0, 0);
>>> +       if (!(pci_msi_ignore_mask || desc->msi_attrib.is_virtual))
>>> +               pci_msi_update_mask(entry, 0, 0);
>>>         control &= ~PCI_MSI_FLAGS_QSIZE;
>>>         control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
>>>         pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
>>>
>>> But the commit message talks about MSI-X, and the above is MSI
>>> only. Is Xen messing with the former, the latter, or both?
>> My understanding is pci_msi_ignore_mask covers both MSI and MSI-X for Xen.
> Please let me know if I should go ahead and try it out and send in a v3
> of the patch.
>
> I'm watching for further discussion right now, just to be clear.

Hi,

I ended up with this patch, I also masked pci_set_mask and
pci_set_unmask, even though patching __pci_restore_msi_state and
__pci_restore_msi_state solved this problem, I found that it did not
properly make the system be able to survive flip_done timeout related
problems during suspend/resume. Would this be something you had in mind
Marc? I will make one more try with just patching
__pci_restore_msi_state and __pci_restore_msix_state just to make sure.
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index
4b4792940e86..0b2225066778 100644 --- a/drivers/pci/msi.c +++
b/drivers/pci/msi.c @@ -420,7 +420,8 @@ static void
__pci_restore_msi_state(struct pci_dev *dev) arch_restore_msi_irqs(dev);
pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control); -
pci_msi_update_mask(entry, 0, 0); + if (!(pci_msi_ignore_mask ||
entry->msi_attrib.is_virtual)) + pci_msi_update_mask(entry, 0, 0);
control &= ~PCI_MSI_FLAGS_QSIZE; control |= (entry->msi_attrib.multiple
<< 4) | PCI_MSI_FLAGS_ENABLE; pci_write_config_word(dev, dev->msi_cap +
PCI_MSI_FLAGS, control); @@ -450,8 +451,9 @@ static void
__pci_restore_msix_state(struct pci_dev *dev) PCI_MSIX_FLAGS_ENABLE |
PCI_MSIX_FLAGS_MASKALL); arch_restore_msi_irqs(dev); -
for_each_pci_msi_entry(entry, dev) - pci_msix_write_vector_ctrl(entry,
entry->msix_ctrl); + if (!(pci_msi_ignore_mask ||
entry->msi_attrib.is_virtual)) + for_each_pci_msi_entry(entry, dev) +
pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0); } @@ -546,7
+548,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
return -ENOMEM; /* All MSIs are unmasked by default; mask them all */ -
pci_msi_mask(entry, msi_multi_mask(entry)); + if (!pci_msi_ignore_mask)
+ pci_msi_mask(entry, msi_multi_mask(entry));
list_add_tail(&entry->list, dev_to_msi_list(&dev->dev)); @@ -577,7
+580,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
return 0; err: - pci_msi_unmask(entry, msi_multi_mask(entry)); + if
(!pci_msi_ignore_mask) + pci_msi_unmask(entry, msi_multi_mask(entry));
free_msi_irqs(dev); return ret; } @@ -865,7 +868,8 @@ static void
pci_msi_shutdown(struct pci_dev *dev) dev->msi_enabled = 0; /* Return
the device with MSI unmasked as initial states */ - pci_msi_unmask(desc,
msi_multi_mask(desc)); + if (!pci_msi_ignore_mask) +
pci_msi_unmask(desc, msi_multi_mask(desc)); /* Restore dev->irq to its
default pin-assertion IRQ */ dev->irq = desc->msi_attrib.default_irq; @@
-950,8 +954,9 @@ static void pci_msix_shutdown(struct pci_dev *dev) } /*
Return the device with MSI-X masked as initial states */ -
for_each_pci_msi_entry(entry, dev) - pci_msix_mask(entry); + if
(!pci_msi_ignore_mask) + for_each_pci_msi_entry(entry, dev) +
pci_msix_mask(entry); pci_msix_clear_and_set_ctrl(dev,
PCI_MSIX_FLAGS_ENABLE, 0); pci_intx_for_msi(dev, 1);


>>>>       raw_spin_lock_irqsave(lock, flags);
>>>>       desc->msi_mask &= ~clear;
>>>>       desc->msi_mask |= set;
>>>> @@ -181,6 +184,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>>>>  {
>>>>       void __iomem *desc_addr = pci_msix_desc_addr(desc);
>>>>
>>>> +     if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
>>>> +             return;
>>>> +
>>>>       writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>>>  }
>>> I have similar reservations for this one.
>> The problem here is some of the changes in commit 446a98b19fd6
>> ("PCI/MSI: Use new mask/unmask functions") bypass the checks in
>> __pci_msi_mask_desc/__pci_msi_unmask_desc.  I've wondered if it would
>> be cleaner to push all the `if (pci_msi_ignore_mask)` checks down to
>> the place of the writes.  That keeps dropping the write local to the
>> write and leaves the higher level code consistent between the regular
>> and Xen PV cases.  I don't know where checking
>> desc->msi_attrib.is_virtual is appropriate.

This makes sense the patch would be like so, I'm testing this out now
hoping it will

perform as good. Now the check is performed in four places

* pci_msi_update_mask

* pci_msix_mask

* pci_msix_unmask

* msix_mask_all

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4b4792940e86..6fa60ad9cba2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
 
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
 	raw_spin_lock_irqsave(lock, flags);
 	desc->msi_mask &= ~clear;
 	desc->msi_mask |= set;
@@ -186,6 +189,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
 	desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
 	/* Flush write to device */
@@ -194,15 +200,15 @@ static inline void pci_msix_mask(struct msi_desc *desc)
 
 static inline void pci_msix_unmask(struct msi_desc *desc)
 {
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
 	desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
 }
 
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_mask(desc);
 	else if (desc->msi_attrib.maskbit)
@@ -211,9 +217,6 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_unmask(desc);
 	else if (desc->msi_attrib.maskbit)



That leaves me with a though, will this set masked, and should be checked as well?

void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
{
        struct pci_dev *dev = msi_desc_to_pci_dev(entry);

        if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
                /* Don't touch the hardware now */
        } else if (entry->msi_attrib.is_msix) {
                void __iomem *base = pci_msix_desc_addr(entry);
                u32 ctrl = entry->msix_ctrl;
                bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);

                if (entry->msi_attrib.is_virtual)
                        goto skip;

                /*
                 * The specification mandates that the entry is masked
                 * when the message is modified:
                 *
                 * "If software changes the Address or Data value of an
                 * entry while the entry is unmasked, the result is
                 * undefined."
                 */
                if (unmasked)
>>>                     pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);

>> Regards,
>> Jason

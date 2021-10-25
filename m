Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD39439FEF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhJYTZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 15:25:46 -0400
Received: from office.oderland.com ([91.201.60.5]:48554 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhJYTYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 15:24:01 -0400
Received: from [193.180.18.161] (port=36290 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mf5XM-008zcq-FS; Mon, 25 Oct 2021 21:21:36 +0200
Message-ID: <c4d27d67-1027-e72b-c5bf-5546c5b0e2e9@oderland.se>
Date:   Mon, 25 Oct 2021 21:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>, Marc Zyngier <maz@kernel.org>
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
 <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <CAKf6xpvZ8fxuBY4BZ51UZzF92zDUcvfav9_pOT7F3w-Bc8YkwA@mail.gmail.com>
From:   Josef Johansson <josef@oderland.se>
Subject: Re: [PATCH v2] PCI/MSI: Re-add checks for skip masking MSI-X on Xen
 PV
In-Reply-To: <CAKf6xpvZ8fxuBY4BZ51UZzF92zDUcvfav9_pOT7F3w-Bc8YkwA@mail.gmail.com>
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

On 10/25/21 03:25, Jason Andryuk wrote:
> On Sun, Oct 24, 2021 at 2:55 PM Josef Johansson <josef@oderland.se> wrote:
>
>> I ended up with this patch, I also masked pci_set_mask and
>> pci_set_unmask, even though patching __pci_restore_msi_state and
>> __pci_restore_msi_state solved this problem, I found that it did not
>> properly make the system be able to survive flip_done timeout related
>> problems during suspend/resume. Would this be something you had in mind
>> Marc? I will make one more try with just patching
>> __pci_restore_msi_state and __pci_restore_msix_state just to make sure.
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index
>> 4b4792940e86..0b2225066778 100644 --- a/drivers/pci/msi.c +++
>> b/drivers/pci/msi.c @@ -420,7 +420,8 @@ static void
>> __pci_restore_msi_state(struct pci_dev *dev) arch_restore_msi_irqs(dev);
>> pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control); -
>> pci_msi_update_mask(entry, 0, 0); + if (!(pci_msi_ignore_mask ||
>> entry->msi_attrib.is_virtual)) + pci_msi_update_mask(entry, 0, 0);
>> control &= ~PCI_MSI_FLAGS_QSIZE; control |= (entry->msi_attrib.multiple
> This patch was mangled.
Thunderbird dislikes me plenty. Let's hope this turns out better.

I ended up with this patch, I also masked pci_set_mask and
pci_set_unmask, even though patching __pci_restore_msi_state and
__pci_restore_msi_state solved this problem, I found that it did not
properly make the system be able to survive flip_done timeout related
problems during suspend/resume. Would this be something you had in mind
Marc? I will make one more try with just patching
__pci_restore_msi_state and __pci_restore_msix_state just to make sure.


diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4b4792940e86..0b2225066778 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -420,7 +420,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	pci_msi_update_mask(entry, 0, 0);
+	if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
+		pci_msi_update_mask(entry, 0, 0);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -450,8 +451,9 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
+	if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
+		for_each_pci_msi_entry(entry, dev)
+			pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -546,7 +548,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		return -ENOMEM;
 
 	/* All MSIs are unmasked by default; mask them all */
-	pci_msi_mask(entry, msi_multi_mask(entry));
+	if (!pci_msi_ignore_mask)
+		pci_msi_mask(entry, msi_multi_mask(entry));
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 
@@ -577,7 +580,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	return 0;
 
 err:
-	pci_msi_unmask(entry, msi_multi_mask(entry));
+	if (!pci_msi_ignore_mask)
+		pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
 	return ret;
 }
@@ -865,7 +868,8 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	dev->msi_enabled = 0;
 
 	/* Return the device with MSI unmasked as initial states */
-	pci_msi_unmask(desc, msi_multi_mask(desc));
+	if (!pci_msi_ignore_mask)
+		pci_msi_unmask(desc, msi_multi_mask(desc));
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -950,8 +954,9 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	}
 
 	/* Return the device with MSI-X masked as initial states */
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_mask(entry);
+	if (!pci_msi_ignore_mask)
+		for_each_pci_msi_entry(entry, dev)
+			pci_msix_mask(entry);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);



>> This makes sense the patch would be like so, I'm testing this out now
>> hoping it will
>>
>> perform as good. Now the check is performed in four places
> Close.  I'll reply with my compiled, but untested patch of what I was thinking.
>> That leaves me with a though, will this set masked, and should be checked as well?
>>
>> void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>> {
>>         struct pci_dev *dev = msi_desc_to_pci_dev(entry);
>>
>>         if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
>>                 /* Don't touch the hardware now */
>>         } else if (entry->msi_attrib.is_msix) {
>>                 void __iomem *base = pci_msix_desc_addr(entry);
>>                 u32 ctrl = entry->msix_ctrl;
>>                 bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
>>
>>                 if (entry->msi_attrib.is_virtual)
>>                         goto skip;
>>
>>                 /*
>>                  * The specification mandates that the entry is masked
>>                  * when the message is modified:
>>                  *
>>                  * "If software changes the Address or Data value of an
>>                  * entry while the entry is unmasked, the result is
>>                  * undefined."
>>                  */
>>                 if (unmasked)
>>>>>                     pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
> My patch adds a check in pci_msix_write_vector_ctrl(), but the comment
> above means PV Xen's behavior may be incorrect if Linux is calling
> this function and modifying the message.
>
> Regards,
> Jason
Turns out it seems to mess things up. I'm compiling this patch right now
with config flags below ( for anyone trying the same ). It should
perform ok I hope.

CONFIG_AMD_PMC=y
#CONFIG_HSA_AMD is not set
#CONFIG_DRM_AMD_SECURE_DISPLAY is not set
#CONFIG_CRYPTO_DEV_CCP is not set

Moving checks pci_msix_mask/pci_msix_unmask to ensure that init/shutdown
gets the checks as well. Avoiding
pci_msix_write_vector_ctrl/__pci_write_msi_msg
since it seems to have odd effects, like the comment in __pci_write_msi_msg
tells us. Just applying checks in __pci_restore_msi_state and
__pci_restore_msix_state
did not do the trick.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4b4792940e86..acf14a4708e6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -186,6 +186,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
+	if (pci_msi_ignore_mask)
+		return;
+
 	desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
 	/* Flush write to device */
@@ -194,13 +197,16 @@ static inline void pci_msix_mask(struct msi_desc *desc)
 
 static inline void pci_msix_unmask(struct msi_desc *desc)
 {
+	if (pci_msi_ignore_mask)
+		return;
+
 	desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
 }
 
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+	if (desc->msi_attrib.is_virtual)
 		return;
 
 	if (desc->msi_attrib.is_msix)
@@ -211,7 +217,7 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+	if (desc->msi_attrib.is_virtual)
 		return;
 
 	if (desc->msi_attrib.is_msix)
@@ -420,7 +426,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	pci_msi_update_mask(entry, 0, 0);
+	if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
+		pci_msi_update_mask(entry, 0, 0);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -450,8 +457,9 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
+	if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
+		for_each_pci_msi_entry(entry, dev)
+			pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }

Please let me know if I should submit any of the two, or make changes to them.

Regards
- Josef


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20400439BFC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhJYQsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 12:48:46 -0400
Received: from office.oderland.com ([91.201.60.5]:45030 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhJYQsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 12:48:45 -0400
Received: from [193.180.18.161] (port=40536 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mf376-005OVn-VK; Mon, 25 Oct 2021 18:46:20 +0200
Message-ID: <b76373a7-1e1d-3aae-66ba-09221c752c11@oderland.se>
Date:   Mon, 25 Oct 2021 18:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel <xen-devel@lists.xenproject.org>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com>
 <CAKf6xptSbuj3VGxzed1uPx59cA_BRJY5FDHczX744rvnTHB8Lg@mail.gmail.com>
From:   Josef Johansson <josef@oderland.se>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
In-Reply-To: <CAKf6xptSbuj3VGxzed1uPx59cA_BRJY5FDHczX744rvnTHB8Lg@mail.gmail.com>
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

On 10/25/21 14:27, Jason Andryuk wrote:
> On Sun, Oct 24, 2021 at 9:26 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>> commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>> functions") introduce functions pci_msi_update_mask() and
>> pci_msix_write_vector_ctrl() that is missing checks for
>> pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
>> new mask/unmask functions").  The checks are in place at the high level
>> __pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
>> directly to the helpers.
>>
>> Push the pci_msi_ignore_mask check down to the functions that make
>> the actual writes.  This keeps the logic local to the writes that need
>> to be bypassed.
>>
>> With Xen PV, the hypervisor is responsible for masking and unmasking the
>> interrupts, which pci_msi_ignore_mask is used to indicate.
>>
>> This change avoids lockups in amdgpu drivers under Xen during boot.
>>
>> Fixes: commit 446a98b19fd6 ("PCI/MSI: Use new mask/unmask functions")
>> Reported-by: Josef Johansson <josef@oderland.se>
>> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>> ---
> I should have written that this is untested.  If this is the desired
> approach, Josef should test that it solves his boot hangs.
>
> Regards,
> Jason

I've tested this today, both the above patch, but also my own below
where I'm patching inside __pci_write_msi_msg,
which is the outcome of the patch above.

I found that both solves the boot hang, but both have severe effects
on suspends/resume later on. The below patch without patching
__pci_write_msi_msg seems to be ideal, solves boot problems but not
causing too much others. There seems to me that there's undocumented
dragons here. Doing more test later today.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4b4792940e86..e97eea1bc93a 100644
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
@@ -307,7 +310,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		 * entry while the entry is unmasked, the result is
 		 * undefined."
 		 */
-		if (unmasked)
+		if (unmasked && !pci_msi_ignore_mask)
 			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
@@ -450,8 +453,9 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
+	if (!(pci_msi_ignore_mask || entry->msi_attrib.is_virtual))
+		for_each_pci_msi_entry(entry, dev)
+			pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }


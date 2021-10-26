Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4008C43BC2F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbhJZVTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:19:48 -0400
Received: from office.oderland.com ([91.201.60.5]:59332 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhJZVTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 17:19:45 -0400
Received: from [193.180.18.161] (port=39964 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mfToo-00AHKb-4f; Tue, 26 Oct 2021 23:17:14 +0200
Message-ID: <ad39ee7a-3c50-58c1-6e8e-e384e4d054c6@oderland.se>
Date:   Tue, 26 Oct 2021 23:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
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
 <b76373a7-1e1d-3aae-66ba-09221c752c11@oderland.se>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
In-Reply-To: <b76373a7-1e1d-3aae-66ba-09221c752c11@oderland.se>
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

On 10/25/21 18:46, Josef Johansson wrote:
> On 10/25/21 14:27, Jason Andryuk wrote:
>> On Sun, Oct 24, 2021 at 9:26 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>>> commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
>>> functions") introduce functions pci_msi_update_mask() and
>>> pci_msix_write_vector_ctrl() that is missing checks for
>>> pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
>>> new mask/unmask functions").  The checks are in place at the high level
>>> __pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
>>> directly to the helpers.
>>>
>>> Push the pci_msi_ignore_mask check down to the functions that make
>>> the actual writes.  This keeps the logic local to the writes that need
>>> to be bypassed.
>>>
>>> With Xen PV, the hypervisor is responsible for masking and unmasking the
>>> interrupts, which pci_msi_ignore_mask is used to indicate.
>>>
>>> This change avoids lockups in amdgpu drivers under Xen during boot.
>>>
>>> Fixes: commit 446a98b19fd6 ("PCI/MSI: Use new mask/unmask functions")
>>> Reported-by: Josef Johansson <josef@oderland.se>
>>> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>>> ---
>> I should have written that this is untested.  If this is the desired
>> approach, Josef should test that it solves his boot hangs.
>>
>> Regards,
>> Jason
> I've tested this today, both the above patch, but also my own below
> where I'm patching inside __pci_write_msi_msg,
> which is the outcome of the patch above.
I tested a lot of kernels today. To create a good baseline I compiled
without any of our patches here
and with my config flags set.

CONFIG_AMD_PMC=y
# CONFIG_HSA_AMD is not set
# CONFIG_CRYPTO_DEV_CCP is not set

The kernel stopped as before, and hung.

Test number 2 was to boot with amdgpu.msi=0.
This still resulted in a bad boot since all the xhcd drivers complained.
We can be sure that it's not amdgpu per se.

Test number 3 was with Jason's patch. It worked, but suspend/resume is
not working well.
Generally it's not behaving like other kernels do, which makes it
actually change the behavior.
Now with test 4 I tried that thought, maybe this is still a good change?
I'm deprived of a good baseline in all this, so it's very hard to
navigate between all the variables.

Test number 4 was with Jason's patch plus the amdgpu-patch below.
It worked, even suspend/resume, 2 times, but then it all crashed and
burn with quite interesting stacktraces. Are amdgpu doing it wrong here
or is it just me nitpicking?

index cc2e0c9cfe0a..f125597eb991 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -279,17 +279,8 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 
 static void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
-	u16 ctrl;
-
-	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
-		return;
-
-	/* VF FLR */
-	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
-	ctrl |= PCI_MSIX_FLAGS_ENABLE;
-	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	// checks if msix is enabled also
+	pci_restore_msi_state(adev->pdev);
 }
 
 /**

During the tests I fiddled with dpm settings, and it does have an effect
one the graphical output during suspend/resume. So maybe there's
hardware problems at play here as well.

I also looked through the code before and after Thomas' changes, and I
can't see that
this patch should make any functional difference compared to before the
MSI series of patches.
It's even such that is_virtual should be checked withing vector_ctrl. I
find Jason's patch
quite nice since it really places the checks on few places making it
easier not to slip.
Compared to my attempt that even failed because I forgot one more place
to put the checks.

With that said I would really like some more tests on this with
different chipsets, on Xen.
Any takers?

What I'm seeing is that there's no readl() in pci_msix_unmask(), it was
one in the code path before.
I'm very much unsure if there should be one there though.

We can really do a better job at the documentation for
pci_msi_ignore_mask, at least in msi.c,
maybe that should be a different patch adding some comments such that
driver folks really see
the benefits of using the built in restore functions e.g.

This became so much bigger project than I thought, thanks all for
chiming in on it.

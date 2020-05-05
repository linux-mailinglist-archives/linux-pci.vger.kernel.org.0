Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC81C611F
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 21:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEETgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEETgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 15:36:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891EC061A0F;
        Tue,  5 May 2020 12:36:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jW3ML-0002IK-He; Tue, 05 May 2020 21:36:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 67F231001F5; Tue,  5 May 2020 21:36:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj\, Ashok" <ashok.raj@linux.intel.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <20200501184326.GA17961@araj-mobl1.jf.intel.com>
Date:   Tue, 05 May 2020 21:36:04 +0200
Message-ID: <878si6rx7f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

"Raj, Ashok" <ashok.raj@linux.intel.com> writes:
> On Tue, Mar 24, 2020 at 08:03:44PM +0100, Thomas Gleixner wrote:
>> Evan Green <evgreen@chromium.org> writes:
>> Well, the point is that we don't see a spurious interrupt on any
>> CPU. We added a traceprintk into do_IRQ() and that would immediately
>> tell us where the thing goes off into lala land. Which it didn't.
>
> Now that we don't have the torn write issue. We did an experiment 
> with legacy MSI, and no interrupt remap support. One of the thought
> process was, since we don't have a way to ensure that previous MSI writes
> are globally observed, a read from the device should flush any
> outstanidng writes correct? (according to PCI, not sure if we can
> depend on this.. or chipsets would take their own sweet time to push
> to CPU)

Aargh. Indeed.

> I'm not certain if such a read happens today? So to make it simple tried
> to force a retrigger. In the following case of direct update,
> even though the vector isn't changing a MSI write to the previous 
> destination could have been sent to the previous CPU right?

Just checked the pci msi write code and there is no read at the end
which would flush the darn posted write. Duh, I never noticed.

> With adding the forced retrigger in both places, the test didn't reveal any
> lost interrupt cases.

Not a surprise, but not what we really want.

> Now the second question with Interrupt Remapping Support:
>
> intel_ir_set_affinity->intel_ir_reconfigure_irte()-> modify_irte()
>
> The flush of Interrupt Entry Cache (IEC) should ensure, if any interrupts
> were in flight, they made it to the previous CPU, and any new interrupts
> must be delivered to the new CPU.
>
> Question is do we need a check similar to the legacy MSI handling
>
> 	if (lapic_vector_set_in_irr())
> 	    handle interrupt? 
>
> Is there a reason we don't check if the interrupt delivered to previous
> CPU in intel_ir_set_affinity()? Or is the send_cleanup_vector() sends
> an IPI to perform the cleanup?
>
> It appears that maybe send_cleanup_vector() sends IPI to the old cpu
> and that somehow ensures the device interrupt handler actually getting
> called? I lost my track somewhere down there :)

The way it works is:

    1) New vector on different CPU is allocated

    2) New vector is installed

    3) When the first interrupt on the new CPU arrives then the cleanup
       IPI is sent to the previous CPU which tears down the old vector

So if the interrupt is sent to the original CPU just before #2 then this
will be correctly handled on that CPU after the set affinity code
reenables interrupts.

Can you try the patch below?

Thanks,

        tglx

8<--------------
 drivers/pci/msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -323,6 +323,7 @@ void __pci_write_msi_msg(struct msi_desc
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+		readl(base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		int pos = dev->msi_cap;
 		u16 msgctl;
@@ -343,6 +344,7 @@ void __pci_write_msi_msg(struct msi_desc
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
 					      msg->data);
 		}
+		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	}
 
 skip:

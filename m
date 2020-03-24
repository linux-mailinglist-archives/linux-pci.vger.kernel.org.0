Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA791902D2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgCXAYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:24:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCXAYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2020 20:24:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGXMU-0001KP-Ci; Tue, 24 Mar 2020 01:24:07 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A4639100292; Tue, 24 Mar 2020 01:24:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evgreen@chromium.org>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>,
        x86@kernel.org
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com> <87d0974akk.fsf@nanos.tec.linutronix.de> <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com> <87r1xjp3gn.fsf@nanos.tec.linutronix.de> <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com>
Date:   Tue, 24 Mar 2020 01:24:05 +0100
Message-ID: <878sjqfvmi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> On 23.3.2020 16.10, Thomas Gleixner wrote:
>> 
>> thanks for providing the data. I think I decoded the issue. Can you
>> please test the patch below?
>
> Unfortunately it didn't help.

I did not expect that to help, simply because the same issue is caught
by the loop in fixup_irqs(). What I wanted to make sure is that there is
not something in between which causes the latter to fail.

So I stared at the trace data earlier today and looked at the xhci irq
events. They are following a more or less periodic schedule and the
forced migration on CPU hotplug hits definitely in the time frame where
the next interrupt should be raised by the device.

1) First off all I do not have to understand why new systems released
   in 2020 still use non-maskable MSI which is the root cause of all of
   this trouble especially in Intel systems which are known to have
   this disastrouos interrupt migration troubles.

   Please tell your hardware people to stop this. 
    
2) I have no idea why the two step mechanism fails exactly on this
   system. I tried the same test case on a skylake client and I can
   clearly see from the traces that the interrupt raised in the device
   falls exactly into the two step update and causes the IRR to be set
   which resolves the situation by IPI'ing the new target CPU.
    
   I have not found a single instance of IPI recovery in your
   traces. Instead of that your system stops working in exactly this
   situation.

   The two step mechanism tries to work around the fact that PCI does
   not support a 64bit atomic config space update. So we carefully avoid
   changing more than one 32bit value at a time, i.e. we change first
   the vector and then the destination ID (part of address_lo).  This
   ensures that the message is consistent all the time.

   But obviously on your system this does not work as expected. Why? I
   really can't tell.

   Please talk to your hardware folks.

And of course all of this is so well documented that all of us can
clearly figure out what's going on...

Thanks,

        tglx

    





Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820F6DC9F7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDJRZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDJRZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 13:25:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3B211C
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2023 10:25:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681147508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7yD9u6WzqmywpQebbNBs5+h7UWE5Mcpf9sd82hi1RE=;
        b=AJZ9MHjtQTw70b3tw+CyDL8SdISn4MVPPSHp3XG4C7MFfFMUDrjFTVGYUAk1Jk38IbI+D3
        94EE+nJdpmSidsrACuqK8odW8ByHqFHf3hkbRj5KpjwFFO0Lkj0pEZiu6EBGWU0Y4Wmid9
        gtQen7ehLl+czfBnB0HPZsHCZImC1Ecv2+oDcEsao8zXioZz68gPVrJHF8VkCrpGi9R7iz
        AGxA4eb+c6aeM8JwJii3SVNfP2TmwQdBIiAmS90QPi3NywAs0bm5UOj3mRKMJrYW/gg9z2
        MSp2ihmSX/7TKdyr1qWAaaRDpX37YT7VjAaHxKKV5JBuG5AAdoNVzztZSG+43g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681147508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7yD9u6WzqmywpQebbNBs5+h7UWE5Mcpf9sd82hi1RE=;
        b=tiyzgIVAXU5OjHW1HdqCo6bDrYPC8TGX/e8TMMSlptkcKOA5/PDo38emhn+QhECBsSzzfX
        awpMwEwup0Fl7GAw==
To:     David Laight <David.Laight@ACULAB.COM>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe cycle sequence when updating the msi-x table
In-Reply-To: <e11d35073f2145b8a9d5e9f4f12c0bb6@AcuMS.aculab.com>
References: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
 <87edovtqki.ffs@tglx> <ed0017284c324cf68f05a20ac86b7b35@AcuMS.aculab.com>
 <875ya4temr.ffs@tglx> <e11d35073f2145b8a9d5e9f4f12c0bb6@AcuMS.aculab.com>
Date:   Mon, 10 Apr 2023 19:25:07 +0200
Message-ID: <87y1mzsl8s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 10 2023 at 12:16, David Laight wrote:
> From: Thomas Gleixner
>> Sent: 10 April 2023 07:50
>> It's trivial enough to latch the message on unmask into a shadow
>> register set and let the state engine work from there.
>
> I could implement the memory block inside the MSI_X logic
> and then detect writes.
> Anything else uses a lot more fpga resource.

Whatever it takes there are enough ways to solve that.

>> And no, we are not adding random delays to that code just because.
>
> I was mostly suggesting one be moved.
> (Changing the address/data is hardly a hot path.)

There is _no_ delay to be moved. The read back is not a delay. It's a
functional requirement.

> Actually I'm trying to work out what the readbacks in the MSI-X
> code are actually for (apart from adding a 'random delay').

It's absolutely not random. It's to ensure that _all_ writes are visible
and effective in the device before the function returns. 

> Now I can't remember whether the data TLP for reads is allowed
> to overtake a posted write request, but it really doesn't matter.
> Even if the IRQ write arrives at the root hub before the
> read completion they then head off in different directions
> through the 'cpu' logic - so the read could easily complete
> well before the interrupt gets processed.

The kernel handles the case that an already pending interrupt comes in
on the original vector and CPU. But it must be guaranteed that any
interrupt raised _after_ the mask/update/unmask sequence will arrive at
the new destination.

> In fact an interrupt requested well before the mask bit is set
> could be pending in the ioapic waiting for the cpu to enable
> interrupts.

MSI-X interrupts are never pending in the IOAPIC.

> So I don't see any reason for those readbacks at all.

But you want new read backs or move the existing one, right? Can you
make your mind up?

> I've never looked at the cpu end of MSI-X, but I suspect that
> stop using an interrupts you need to mask it there first,
> then disable the hardware and later make sure you clear
> any lurking pending request (probably before unmasking for
> later use).

You can suspect what you want. The kernel can handle this perfectly
correctly without any of this:

     Startup:
        Assign vector $M on CPU $A in msi_entry
        Unmask in msi_entry

     Interrupt affinity change request:
        New target CPU mask is stored in the interrupt descriptor and
        affinity change request is queued. That's a pure kernel internal
        software operation and does not touch the device.

     Interrupt raised on CPU $A vector $M:
        Handle interrupt
        Mask in msi_entry
        Assign vector $N on CPU $B
        Unmask in msi_entry
        EOI

     Interrupt raised on CPU $B vector $N: 
        Handle interrupt
        Send IPI to CPU$A to cleanup vector $M
        EOI

Affinity for non-remapped MSI/MSI-X is always changed in context of an
interrupt being handled on the original target CPU/vector.

The whole mechanism relies on standard conform devices simply because
it's impossible to handle the following scenario:

     CPU A           Device                    CPU B
     write(entry->address_lo);
     (Changes the destination to CPU B)

                     Writes entry->data to entry->address_lo

                                               Gets a spurious interrupt
                                               on the original vector $N

As a consequence the interrupt would be lost and in the worst case the
device is not longer functional. CPU A cannot access the local APIC IRR
of CPU B to test for this. Even if it could, it would only observe it
when CPU B cannot handle it at that moment.

And no, we are not going to install a magic "maybe random PCIe device
misbehaves handler" on CPU B for doing so. We simply can't and it's not
necessary at all.

There is a "work around" for non-maskable MSI. See msi_set_affinity()
for the gory details. But also that requires that the writes are visible
in the device when the write_msg() function returns.

And no, we are not extending this to MSI-X simply because contrary to
MSI MSI-X is well defined. I'm dealing with MSI-X for 15+ years now and
there hasn't been a single device which violated the standard in that
regard. At least to my knowledge.

Please fix your hardware/firmware to be standard compliant. The kernel
is not there to proliferate sloppy hardware designs. We simply are not
opening that can of worms. Aside of that a device must be compliant to
work independent of the OS and other OSes are neither interested in
horrible hacks just to let hardware people do what they want. Standards
are there for a reason.

Just for the record. entry->address_hi is irrelvant in the above
scenario because address_hi is only in use when interrupt remapping is
enabled (at least on x86). If interrupt remapping is enabled, none of
the above matters as the affinity change happens at the remapping level
and the device MSI[-X] entries never change after setup. The remapping
unit has none of those problems at all.

Thanks,

        tglx

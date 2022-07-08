Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60256BA2A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiGHM51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiGHM5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 08:57:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136952B1A1;
        Fri,  8 Jul 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OrQOqSGinfnBh7tXyYimN2eCxNK2hBryYE62nGBz+Y4=; b=V8Jy94+yAKK5vE4VSykLYZyLoX
        4fhHT4pLFLk2/ch1DjE+RCEaUXmZEuK3b1YcVrz7r1zy28rFiNzxLjPtn4i9uTl382ia84/3UmxU0
        AiTD8fGu50rLwlVNc2ZkcVCV72TOQMhfLrlbc7gUsZkiQekefTAoBK/nEYFzjrpuy9CTTHMG3VOus
        ifPoOO1X4Pce1G4TcB3CAxe7memDNSHn1GHMz4HeptY3gxQuX97hC/VL+b3VSSp8gQNzk07xHQkuc
        KxO7+VzKAMx7mUXcTZSVcuUaO/PqCMY0blZtGmh2m7YiHpK4aI0TJFG8/qUTtHkdr8zn8tvRpW/iV
        l099tMUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9nXT-003Vk2-0s; Fri, 08 Jul 2022 12:56:55 +0000
Date:   Fri, 8 Jul 2022 13:56:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Message-ID: <YsgplrrJnk5Ly19z@casper.infradead.org>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 05:56:07AM +0000, Ajay Kaher wrote:
> 
> ﻿On 28/06/22, 11:39 PM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
> > [+cc Matthew]
> >
> > On Tue, Jun 28, 2022 at 09:59:21PM +0530, Ajay Kaher wrote:
> >> Port IO instructions (PIO) are less efficient than MMIO (memory
> >> mapped I/O). They require twice as many PCI accesses and PIO
> >> instructions are serializing. As a result, MMIO should be preferred
> >> when possible over PIO.
> >>
> >> Bare metal test result
> >> 1 million reads using raw_pci_read() took:
> >> PIO: 0.433153 Sec.
> >> MMIO: 0.268792 Sec.
> >>
> >> Virtual Machine test result
> >> 1 hundred thousand reads using raw_pci_read() took:
> >> PIO: 12.809 Sec.
> >> MMIO: took 8.517 Sec.

While this is true, we're talking about config space accesses.  These
should be rare.  What workload does this make any measurable difference
to?

And looking at the results above, it's not so much the PIO vs MMIO
that makes a difference, it's the virtualisation.  A mmio access goes
from 269ns to 85us.  Rather than messing around with preferring MMIO
over PIO for config space, having an "enlightenment" to do config
space accesses would be a more profitable path.

> >> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> >> ---
> >>  arch/x86/pci/common.c          |  8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> >> index 3507f456f..0b3383d9c 100644
> >> --- a/arch/x86/pci/common.c
> >> +++ b/arch/x86/pci/common.c
> >> @@ -40,20 +40,20 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
> >>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> >>                                               int reg, int len, u32 *val)
> >>  {
> >> +     if (raw_pci_ext_ops)
> >> +             return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> >>       if (domain == 0 && reg < 256 && raw_pci_ops)
> >>               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
> >> -     if (raw_pci_ext_ops)
> >> -             return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> >>       return -EINVAL;
> >
> > This organization of raw_pci_read() dates to b6ce068a1285 ("Change
> > pci_raw_ops to pci_raw_read/write"), by Matthew.  Cc'd him for
> > comment, since I think he considered the ordering at the time.
> 
> Thanks Bjorn for quick response.
> 
> Matthew, b6ce068a1285 is old commit. It will be very helpful if you could
> provide some detail on ordering as Bjorn mentioned above.

Sorry for the delay; this came in while I was on holiday.

I'll note that b6ce068a1285 does _not_ cause any changes in whether
MMIO or PIO is used for accesses below 256 bytes.  Yes, it introduces
this code, but it also removes lines like this:

-       if (reg < 256)
-               return pci_conf1_read(seg,bus,devfn,reg,len,value);

from the MMCONFIG accessors.

Those were introduced in a0ca99096094 by Ivan Kokshaysky.  But if you
look further back in the file history, you can find all kinds of nasty
bugs; broken BIOSes, resource conflicts, bleh.  You'd hope they've all
been fixed by now, but do you want to bet?

I still have a working machine here which hung when using MMCONFIG for all
accesses.  The problem lay in, IIRC, the graphics BAR.  When attempting
to size it (by writing all-ones to it and seeing what bits remained as
zero), it happens to overlay the MMCONFIG area.  That meant that the
subsequent attempt to write to the BAR actually ended up being a write
to graphics memory ... and so did all subsequent MMCONFIG accesses.

In short, here be dragons, and you need to move very VERY carefully to
avoid breaking peoples machines.

We do have the possibility of a white-list approach.  We can set
'raw_pci_ops' to NULL on machines which we're certain mmconfig works.
I still think you're better off having a special raw_pci_ops for vmware
than you are dinking about trying to save 50% of the time.  If any of
this is really worth it at all, which I doubt.

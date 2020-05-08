Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042231CB52D
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEHQtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 12:49:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E748C061A0C;
        Fri,  8 May 2020 09:49:24 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX6BX-0005gy-W0; Fri, 08 May 2020 18:49:16 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4DCC9101175; Fri,  8 May 2020 18:49:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     "Raj\, Ashok" <ashok.raj@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <20200508160958.GA19631@otc-nc-03>
References: <20200508005528.GB61703@otc-nc-03> <87368almbm.fsf@nanos.tec.linutronix.de> <20200508160958.GA19631@otc-nc-03>
Date:   Fri, 08 May 2020 18:49:15 +0200
Message-ID: <87h7wqjrsk.fsf@nanos.tec.linutronix.de>
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

"Raj, Ashok" <ashok.raj@intel.com> writes:
> On Fri, May 08, 2020 at 01:04:29PM +0200, Thomas Gleixner wrote:
>> TBH, I can't see anything what's wrong here from the kernel side and as
>> this is new silicon and you're the only ones reporting this it seems
>> that this is something which is specific to that particular
>> hardware. Have you talked to the hardware people about this?
>> 
>
> After chasing it, I'm also trending to think that way. We had a question
> about the moderation timer and how its affecting this behavior.
> Mathias tried to turn off the moderation timer, and we are still able to 
> see this hang. We are reaching out to the HW folks to get a handle on this.
>
> With legacy MSI we can have these races and kernel is trying to do the
> song and dance, but we see this happening even when IR is turned on.
> Which is perplexing. I think when we have IR, once we do the change vector 
> and flush the interrupt entry cache, if there was an outstandng one in 
> flight it should be in IRR. Possibly should be clearned up by the
> send_cleanup_vector() i suppose.

Ouch. With IR this really should never happen and yes the old vector
will catch one which was raised just before the migration disabled the
IR entry. During the change nothing can go wrong because the entry is
disabled and only reenabled after it's flushed which will send a pending
one to the new vector.

But if you see the issue with IR as well, then there is something wrong
with the local APICs in that CPU.

Thanks,

        tglx

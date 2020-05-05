Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E74C1C6361
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 23:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgEEVre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEEVrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 17:47:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24BC061A0F;
        Tue,  5 May 2020 14:47:33 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jW5PT-0005g4-5n; Tue, 05 May 2020 23:47:27 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9B1FE1001F5; Tue,  5 May 2020 23:47:26 +0200 (CEST)
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
In-Reply-To: <20200505201616.GA15481@otc-nc-03>
References: <20200501184326.GA17961@araj-mobl1.jf.intel.com> <878si6rx7f.fsf@nanos.tec.linutronix.de> <20200505201616.GA15481@otc-nc-03>
Date:   Tue, 05 May 2020 23:47:26 +0200
Message-ID: <875zdarr4h.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 05, 2020 at 09:36:04PM +0200, Thomas Gleixner wrote:
>> The way it works is:
>> 
>>     1) New vector on different CPU is allocated
>> 
>>     2) New vector is installed
>> 
>>     3) When the first interrupt on the new CPU arrives then the cleanup
>>        IPI is sent to the previous CPU which tears down the old vector
>> 
>> So if the interrupt is sent to the original CPU just before #2 then this
>> will be correctly handled on that CPU after the set affinity code
>> reenables interrupts.
>
> I'll have this test tried out.. but in msi_set_affinity() the check below
> for lapic_vector_set_in_irr(cfg->vector), this is the new vector correct? 
> don't we want to check for old_cfg.vector instead?
>
> msi_set_affinit ()
> {
> ....
>         unlock_vector_lock();
>
>         /*
>          * Check whether the transition raced with a device interrupt and
>          * is pending in the local APICs IRR. It is safe to do this outside
>          * of vector lock as the irq_desc::lock of this interrupt is still
>          * held and interrupts are disabled: The check is not accessing the
>          * underlying vector store. It's just checking the local APIC's
>          * IRR.
>          */
>         if (lapic_vector_set_in_irr(cfg->vector))
>                 irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);

No. This catches the transitional interrupt to the new vector on the
original CPU, i.e. the one which is running that code.

Again the steps are:

 1) Allocate new vector on new CPU

 2) Set new vector on original CPU

 3) Set new vector on new CPU

So we have 3 points where an interrupt can fire:

 A) Before #2

 B) After #2 and before #3

 C) After #3

#A is hitting the old vector which is still valid on the old CPU and
   will be handled once interrupts are enabled with the correct irq
   descriptor - Normal operation (same as with maskable MSI)

#B This must be checked in the IRR because the there is no valid vector
   on the old CPU.

#C is handled on the new vector on the new CPU

Thanks,

        tglx

 


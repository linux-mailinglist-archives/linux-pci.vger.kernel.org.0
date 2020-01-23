Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938091468B2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 14:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWNJF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 23 Jan 2020 08:09:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39975 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgAWNJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 08:09:05 -0500
Received: from [5.158.153.53] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iucEA-00006a-Ow; Thu, 23 Jan 2020 14:08:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 692DD1017FA; Thu, 23 Jan 2020 14:08:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     sean.v.kelley@linux.intel.com, Kar Hin Ong <kar.hin.ong@ni.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: RE: Re: "oneshot" interrupt causes another interrupt to be fired erroneously in Haswell system
In-Reply-To: <8f1e5981b519acb5edf53b5392c81ef7cbf6a3eb.camel@linux.intel.com>
References: <20191031230532.GA170712@google.com> <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de> <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com> <87a76oxqv1.fsf@nanos.tec.linutronix.de> <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com> <87muanwwhb.fsf@nanos.tec.linutronix.de> <8f1e5981b519acb5edf53b5392c81ef7cbf6a3eb.camel@linux.intel.com>
Date:   Thu, 23 Jan 2020 14:08:54 +0100
Message-ID: <87muaetj4p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sean,

Sean V Kelley <sean.v.kelley@linux.intel.com> writes:
> I looked into it Thomas.  The issue is as you suggested early in the
> thread.  If an IRQ arrives at line N of a non-primary IO-APIC and that
> line is masked, a new IRQ is generated on the primary IO-APIC/PIC.  
>
> The BIOS setting to address this forwarding is as above Disable INTx
> Route to PCH/ICH/SouthBridge. When this bit is set, local INTx messages
> received from the PCI-E ports are not routed to legacy PCH - they are
> either converted into MSI via the integrated I/OxAPIC (if the I/OxAPIC
> mask bit is clear in the appropriate entries) or cause no further
> action (when mask bit is set).
>
> This capability is tested and supported fully on Intel platforms.

Thanks for the confirmation.

> Once you get to SKX/CLX things change and integrated IOxAPICs in the
> IIO module convert legacy PCI Express interrupt messages into MSI
> interrupts directly.  Beyond SKX/CLX there are no longer IOxAPICs in
> IIO. IOxAPIC is only in the PCH. Devices connected to the
> IIO will use native MSI/MSI-x mechanisms.
>
> The problem is with the absolute lack of useful documentation.  That’s
> not acceptable.

Yeah.

> You recall the work Olaf and Stefan did at SuSE ten years ago (?) on
> boot irq quirks and the amount of research they had to do it learn
> about the behavior.[4]

Oh yes.

> From a Real-Time Linux perspective this is really important to me.  As
> we get closer to fully mainlined we need to have this information
> readily available with greater usage of threaded irqs in combination
> with legacy interrupts on the older platforms.
>
> So I will ensure we actually create useful information pointing to this
> behavior either in kernel docs or online as in a white paper or both.

Great.

>> As we have already quirks in drivers/pci/quirks.c which handle the
>> same issue on older chipsets, we really should add one for these kind
>> of systems to avoid fiddling with the BIOS (which you can, but most
>> people cannot).

> Agreed, and I will follow-up with Kar Hin Ong to get them added.

Much appreciated.

Thanks,

        tglx

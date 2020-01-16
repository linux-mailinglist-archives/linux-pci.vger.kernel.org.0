Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504AE13D76B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 11:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgAPKCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 05:02:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51044 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbgAPKCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 05:02:03 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is1yK-0003KK-V9; Thu, 16 Jan 2020 11:01:53 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6AE3E100C1E; Thu, 16 Jan 2020 11:01:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kar Hin Ong <kar.hin.ong@ni.com>,
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
Subject: RE: RE: Re: "oneshot" interrupt causes another interrupt to be fired erroneously in Haswell system
In-Reply-To: <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com>
References: <20191031230532.GA170712@google.com> <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de> <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com> <87a76oxqv1.fsf@nanos.tec.linutronix.de> <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com>
Date:   Thu, 16 Jan 2020 11:01:52 +0100
Message-ID: <87muanwwhb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kar Hin Ong <kar.hin.ong@ni.com> writes:
>> I don't have access to the document you mentioned, but I know that chipsets
>> have a knob to control that behaviour. Just checked a few chipset docs and they
>> contain the same sentence, but then in the next paragraph they say:
>> 
>>  "If the I/OxAPIC entry is masked (via the mask bit in the corresponding
>>   Redirection Table Entry), then the corresponding PCI Express
>>   interrupt(s) is forwarded to the legacy ICH, provided the Disable PCI
>>   INTx Routing to ICH bit is clear, Section 19.10.2.27, QPIPINTRC: Intel
>>   QuickPath Interconnect Protocol Interrupt Control."
>> 
>> That control bit is 0 after reset, so the legacy forwarding works.
>
> Intel support engineer do provide similar advice to us as a workaround
> to the CPU behaviour.  They said we could enable the "Don'tRouteToPCH"
> bit in the BIOS to block the interrupt from propagating to PCH.  This
> bit is located at "Coherent Interface Protocol Interrupt Control
> (cipintrc)" register of "Virtualization" device (Bus 0, Device 5,
> Function 0, Offset 0x14C).
>
> With the help of our BIOS engineer, after setting this bit in BIOS
> does prevent the interrupt forwarding.
>
> However, Intel told us that this workaround is not validated, i.e. the
> side effect of setting this bit is unknown.

What? That's ridiculous.

That bit is documented in various chipset documents and that legacy
rerouting is really just there to support OSes which do not support
multiple IO-APICs properly.

If setting this bit has unknown side effects then someone at Intel
should have a close look and fix their documentation.

Can the Intel people on Cc please take care of this?

As we have already quirks in drivers/pci/quirks.c which handle the same
issue on older chipsets, we really should add one for these kind of
systems to avoid fiddling with the BIOS (which you can, but most people
cannot).

Thanks,

        tglx


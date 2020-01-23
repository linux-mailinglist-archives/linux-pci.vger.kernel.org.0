Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D582146068
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 02:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAWBhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 20:37:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:13999 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWBhe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 20:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 17:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,352,1574150400"; 
   d="scan'208";a="250817035"
Received: from zdeng-mobl.gar.corp.intel.com (HELO arch-ashland-svkelley) ([10.254.47.109])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2020 17:37:31 -0800
Message-ID: <8f1e5981b519acb5edf53b5392c81ef7cbf6a3eb.camel@linux.intel.com>
Subject: Re: RE: Re: "oneshot" interrupt causes another interrupt to be
 fired erroneously in Haswell system
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
Reply-To: sean.v.kelley@linux.intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kar Hin Ong <kar.hin.ong@ni.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Keng Soon Cheah <keng.soon.cheah@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 22 Jan 2020 17:37:31 -0800
In-Reply-To: <87muanwwhb.fsf@nanos.tec.linutronix.de>
References: <20191031230532.GA170712@google.com>
         <alpine.DEB.2.21.1911050017410.17054@nanos.tec.linutronix.de>
         <MN2PR04MB625594021250E0FB92EC955DC3780@MN2PR04MB6255.namprd04.prod.outlook.com>
         <87a76oxqv1.fsf@nanos.tec.linutronix.de>
         <MN2PR04MB62551D8B240966B02ED71516C3360@MN2PR04MB6255.namprd04.prod.outlook.com>
         <87muanwwhb.fsf@nanos.tec.linutronix.de>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-01-16 at 11:01 +0100, Thomas Gleixner wrote:
> Kar Hin Ong <kar.hin.ong@ni.com> writes:
> > > I don't have access to the document you mentioned, but I know
> > > that chipsets
> > > have a knob to control that behaviour. Just checked a few chipset
> > > docs and they
> > > contain the same sentence, but then in the next paragraph they
> > > say:
> > > 
> > >  "If the I/OxAPIC entry is masked (via the mask bit in the
> > > corresponding
> > >   Redirection Table Entry), then the corresponding PCI Express
> > >   interrupt(s) is forwarded to the legacy ICH, provided the
> > > Disable PCI
> > >   INTx Routing to ICH bit is clear, Section 19.10.2.27,
> > > QPIPINTRC: Intel
> > >   QuickPath Interconnect Protocol Interrupt Control."
> > > 
> > > That control bit is 0 after reset, so the legacy forwarding
> > > works.
> > 
> > Intel support engineer do provide similar advice to us as a
> > workaround
> > to the CPU behaviour.  They said we could enable the
> > "Don'tRouteToPCH"
> > bit in the BIOS to block the interrupt from propagating to
> > PCH.  This
> > bit is located at "Coherent Interface Protocol Interrupt Control
> > (cipintrc)" register of "Virtualization" device (Bus 0, Device 5,
> > Function 0, Offset 0x14C).
> > 
> > With the help of our BIOS engineer, after setting this bit in BIOS
> > does prevent the interrupt forwarding.
> > 
> > However, Intel told us that this workaround is not validated, i.e.
> > the
> > side effect of setting this bit is unknown.
> 
> What? That's ridiculous.
> 
> That bit is documented in various chipset documents and that legacy
> rerouting is really just there to support OSes which do not support
> multiple IO-APICs properly.
> 
> If setting this bit has unknown side effects then someone at Intel
> should have a close look and fix their documentation.
> 
> Can the Intel people on Cc please take care of this?


I looked into it Thomas.  The issue is as you suggested early in the
thread.  If an IRQ arrives at line N of a non-primary IO-APIC and that
line is masked, a new IRQ is generated on the primary IO-APIC/PIC.  

The BIOS setting to address this forwarding is as above Disable INTx
Route to PCH/ICH/SouthBridge. When this bit is set, local INTx messages
received from the PCI-E ports are not routed to legacy PCH - they are
either converted into MSI via the integrated I/OxAPIC (if the I/OxAPIC
mask bit is clear in the appropriate entries) or cause no further
action (when mask bit is set).

This capability is tested and supported fully on Intel platforms.

For example, 5520 [1], Xeon E5 4600  [2] , Xeon E7 [3], and so on
include this bit :
 
[1] 
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/5520-5500-chipset-ioh-datasheet.pdf
page 139
[2] 
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-1600-2600-vol-2-datasheet.pdf
, page 280
[3] 
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e7-v2-datasheet-vol-2.pdf
, page 373
etc..

Once you get to SKX/CLX things change and integrated IOxAPICs in the
IIO module convert legacy PCI Express interrupt messages into MSI
interrupts directly.  Beyond SKX/CLX there are no longer IOxAPICs in
IIO. IOxAPIC is only in the PCH. Devices connected to the
IIO will use native MSI/MSI-x mechanisms.

The problem is with the absolute lack of useful documentation.  That’s
not acceptable.  

You recall the work Olaf and Stefan did at SuSE ten years ago (?) on
boot irq quirks and the amount of research they had to do it learn
about the behavior.[4]

[4]
http://lkml.iu.edu/hypermail/linux/kernel/0807.1/3160.html
 
From a Real-Time Linux perspective this is really important to me.  As
we get closer to fully mainlined we need to have this information
readily available with greater usage of threaded irqs in combination
with legacy interrupts on the older platforms.

So I will ensure we actually create useful information pointing to this
behavior either in kernel docs or online as in a white paper or both.


> As we have already quirks in drivers/pci/quirks.c which handle the
> same
> issue on older chipsets, we really should add one for these kind of
> systems to avoid fiddling with the BIOS (which you can, but most
> people
> cannot).

Agreed, and I will follow-up with Kar Hin Ong to get them added.

Thanks,

Sean


> 
> 
> Thanks,
> 
>         tglx
> 


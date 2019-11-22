Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A1107209
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKVMQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 07:16:04 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38690 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVMQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 07:16:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id a14so6299468oid.5;
        Fri, 22 Nov 2019 04:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQHNnuoOQnLpcapdvCKakorWZ7TP7hEo0W29cllI7Qc=;
        b=hPJELbBiPeQiJ31bPAXw0pJ//OnLfg1U0tk1dYcmK1KnYpHQA13xEmrEhW1fCO/D9+
         H93H5LaCS/eTVAE0v/m6CxH7I+Lt9E/E5k+VodXadkYx804YnN0KNYK8AB3SQUTze3CA
         +uVzAZ08WZdx09fn/btLH3RNyGXbUR9T79h2i1LLA5rKywAP/UnEVIveCgpJuiLmjYGN
         XotvbNY6SZpR7v8PU6o6b+4FD4cDCDQ+fQRiuiQcSf9K56jyXgNiTKtHM4ZHvPeAk7iy
         CpfQ9nhvFICxTiMWHADVmS811xYDsn37N77S/UXxQYddIs3+nCeCkPWjCA47kfoef/iz
         w6hA==
X-Gm-Message-State: APjAAAVYaaqCjDVsCfM5gbIBXx4LZVCBXPJq2d5vxXqR6Ye19mHCaFZF
        1/9WiTl2a7F6vJkQA/rYWf4oB0EuxNze9vDPrqs=
X-Google-Smtp-Source: APXvYqxHo926KeaIbrfShZpxhqANPkGIke2PeeiFN2YMRaOSGngTdr0+do9j+cdfyP1X0m0d/eGn2nXmRVmin4QbCek=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr11582452oig.68.1574424962548;
 Fri, 22 Nov 2019 04:16:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <20191122103637.GA11621@lahna.fi.intel.com> <CAJZ5v0gifnGZcKr6mgc6C2EfqX13OyJnOac0uDxYNKN=A0cgMg@mail.gmail.com>
 <20191122115214.GH11621@lahna.fi.intel.com>
In-Reply-To: <20191122115214.GH11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 13:15:50 +0100
Message-ID: <CAJZ5v0h+x6C4iGS4gH=auLtQRgicjrLejaSQjsigKwgZPMtjpg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 12:52 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>

[cut]

[I'm really running out of time for today, unfortunately.]

> > > > The current design is mostly based on the PCI PM Spec 1.2, so it would
> > > > be consequent to follow system-wide suspend in PM-runtime and avoid
> > > > putting PCIe ports holding devices in D0 into any low-power states.
> > > > but that would make the approach in the $subject patch ineffective.
> > > >
> > > > Moreover, the fact that there are separate branches for "Windows 7"
> > > > and "Windows 8+" kind of suggest a change in the expected behavior
> > > > between Windows 7 and Windows 8, from the AML perspective.  I would
> > > > guess that Windows 7 followed PCI PM 1.2 and Windows 8 (and later)
> > > > does something else.
> > >
> > > My understanding (which may not be correct) is that up to Windows 7 it
> > > never put the devices into D3cold runtime. Only when the system entered
> > > Sx states it evaluated the _OFF methods.
> >
> > I see.

I think I have misunderstood what you said.

I also think that Windows 7 and before didin't do RTD3, but it did PCI
PM nevertheless and platform firmware could expect it to behave in a
specific way in that respect.  That expected behavior seems to have
changed in the next generations of Windows, as reflected by the OS
version and _REV checks in ASL.

> > > Starting from Windows 8 it started doing this runtime so devices can
> > > enter D3cold even when system is in S0.
> >
> > Hmm.  So by setting _REV to 5 we effectively change the _OFF into a NOP?
>
> No, there are two paths in the _OFF() and them some common code such as
> removing power etc.
>
> What the _REV 5 did is that it went into path where the AML seemed to
> directly disable the link.
>
> The other path that is taken with Windows 8+ does not disable the link
> but instead it puts it to low power L2 or L3 state (I suppose L3 since
> it removes the power and the GPU probably does not support wake).

OK, so the very existence of the two paths means that the OS behavior
expected by the firmware in the two cases represented by them is
different.  Presumably, the expected hardware configuration in which
the AML runs also is different in these two cases.

> The ASL code is below. PGOF() gets called from the power resource
> _OFF():

I'll look at it in detail when I have some more time later.

>         Method (PGOF, 1, Serialized)
>         {
>             PIOF = Arg0
>             If ((PIOF == Zero))
>             {
>                 If ((SGGP == Zero))
>                 {
>                     Return (Zero)
>                 }
>             }
>             ElseIf ((PIOF == One))
>             {
>                 If ((P1GP == Zero))
>                 {
>                     Return (Zero)
>                 }
>             }
>             ElseIf ((PIOF == 0x02))
>             {
>                 If ((P2GP == Zero))
>                 {
>                     Return (Zero)
>                 }
>             }
>
>             PEBA = \XBAS /* External reference */
>             PDEV = GDEV (PIOF)
>             PFUN = GFUN (PIOF)
>             Name (SCLK, Package (0x03)
>             {
>                 One,
>                 0x80,
>                 Zero
>             })
>             If ((CCHK (PIOF, Zero) == Zero))
>             {
>                 Return (Zero)
>             }
>
>             \_SB.PCI0.PEG0.PEGP.LTRE = \_SB.PCI0.PEG0.LREN
>             If ((Arg0 == Zero))
>             {
>                 ELC0 = LCT0 /* \_SB_.PCI0.LCT0 */
>                 H0VI = S0VI /* \_SB_.PCI0.S0VI */
>                 H0DI = S0DI /* \_SB_.PCI0.S0DI */
>                 ECP0 = LCP0 /* \_SB_.PCI0.LCP0 */
>             }
>             ElseIf ((Arg0 == One))
>             {
>                 ELC1 = LCT1 /* \_SB_.PCI0.LCT1 */
>                 H1VI = S1VI /* \_SB_.PCI0.S1VI */
>                 H1DI = S1DI /* \_SB_.PCI0.S1DI */
>                 ECP1 = LCP1 /* \_SB_.PCI0.LCP1 */
>             }
>             ElseIf ((Arg0 == 0x02))
>             {
>                 ELC2 = LCT2 /* \_SB_.PCI0.LCT2 */
>                 H2VI = S2VI /* \_SB_.PCI0.S2VI */
>                 H2DI = S2DI /* \_SB_.PCI0.S2DI */
>                 ECP2 = LCP2 /* \_SB_.PCI0.LCP2 */
>             }
>
>             If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV ==
>                 0x05))))
>             {
>                 If ((PIOF == Zero))
>                 {
>                     P0LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P0LT == 0x08))
>                         {
>                             Break
>                         }
>
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
>
>                     P0RM = One
>                     P0AP = 0x03
>                 }
>                 ElseIf ((PIOF == One))
>                 {
>                     P1LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P1LT == 0x08))
>                         {
>                             Break
>                         }
>
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
>
>                     P1RM = One
>                     P1AP = 0x03
>                 }
>                 ElseIf ((PIOF == 0x02))
>                 {
>                     P2LD = One
>                     TCNT = Zero
>                     While ((TCNT < LDLY))
>                     {
>                         If ((P2LT == 0x08))
>                         {
>                             Break
>                         }
>
>                         Sleep (0x10)
>                         TCNT += 0x10
>                     }
>
>                     P2RM = One
>                     P2AP = 0x03
>                 }
>
>                 If ((PBGE != Zero))
>                 {
>                     If (SBDL (PIOF))
>                     {
>                         MBDL = GMXB (PIOF)
>                         PDUB (PIOF, MBDL)
>                     }
>                 }
>             }
>             Else
>             {
>                 LKDS (PIOF)
>             }
>
>             If ((DerefOf (SCLK [Zero]) != Zero))
>             {
>                 PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
>                 Sleep (0x10)
>             }
>
>             GPPR (PIOF, Zero)
>             If ((OSYS != 0x07D9))
>             {
>                 DIWK (PIOF)
>             }
>
>             \_SB.SGOV (0x01010004, Zero)
>             Sleep (0x14)
>             Return (Zero)
>         }
>
> > > > Now, the structure of the "Windows 8+" branch
> > > > described by you suggests that, at least in the cases when it is going
> > > > to remove power from the port eventually, it goes straight for the
> > > > link preparation (the L2/L3 Ready transition) and power removal
> > > > without bothering to program the downstream device and port into D3hot
> > > > (because that's kind of redundant).
> > > >
> > > > That hypothetical "Windows 8+" approach may really work universally,
> > > > because it doesn't seem to break any rules (going straight from D0 to
> > > > D3cold is not disallowed and doing that for both a port and a
> > > > downstream device at the same time is kind of OK either, as long as
> > > > the link is ready for that).
> > >
> > > I guess it depends on how you interpret the specs ;-) From PCIe 5.0 sec
> > > 5.8 we can see the supported PM state transitions and it shows that you
> > > get to D3cold through D3hot. Of course the device goes into D3cold if
> > > you simply remove its power so I agree with you as well. However, if
> > > there is _PS3 method we can't skip the D3hot phase.
> >
> > That's my understanding too, but I'm wondering about direct PMCSR
> > writes.  It is unclear to me if they are necessary, or more precisely,
> > whether or not Windows 10, say, carries them out if ACPI PM is going
> > to be applied.
>
> According to this:
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/pci-power-management-and-device-drivers#scenario-1-turning-off-a-device
>
> it does write PMCSR.

But I don't think that the case at hand is covered by this at all.

In the "generic" case covered by the doc, the world is simple: the
device has a PMCSR and some AML, possibly to support D3cold.  You use
both and are happy.  And you don't care about the upstream PCIe port
at all.

In the case at had you need a power resource at the PCIe port level to
put the downstream device into D3cold (BTW, I'm not even sure if the
port really is power managed by this at all), so they both are treated
kind of as a combo.  Quite a bit more complicated in my view.

> > Maybe I'm going too far with my conclusions, but please let me know
> > what you think about the approach proposed at the end of
> > https://lore.kernel.org/linux-pm/CAJZ5v0iQttGB4m5TbzCtjp2C1j5qEkUhqhpWb++LhSk3mbW=Lw@mail.gmail.com/T/#t
> > ?
>
> Yes, I think that is better approach.

OK, thanks!

If I have the time next week, I'll try to prototype patch to implement
this idea.

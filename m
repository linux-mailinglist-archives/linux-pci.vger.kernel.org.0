Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC85A1071B9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKVLwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:52:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:49387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKVLwY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 06:52:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 03:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="216351746"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Nov 2019 03:52:16 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Nov 2019 13:52:15 +0200
Date:   Fri, 22 Nov 2019 13:52:14 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
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
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191122115214.GH11621@lahna.fi.intel.com>
References: <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com>
 <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com>
 <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com>
 <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <20191122103637.GA11621@lahna.fi.intel.com>
 <CAJZ5v0gifnGZcKr6mgc6C2EfqX13OyJnOac0uDxYNKN=A0cgMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gifnGZcKr6mgc6C2EfqX13OyJnOac0uDxYNKN=A0cgMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 12:30:20PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 22, 2019 at 11:36 AM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 11:39:23PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 21, 2019 at 8:49 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Thu, Nov 21, 2019 at 04:43:24PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Nov 21, 2019 at 1:52 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 21, 2019 at 01:46:14PM +0200, Mika Westerberg wrote:
> > > > > > > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > > > > > > > Express Root Port" (name from lspci) and on those systems all of that
> > > > > > > > > > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > > > > > > > > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > > > > > > > > > never get populated under this particular bridge controller, but under
> > > > > > > > > > > those "Root Port"s
> > > > > > > > > >
> > > > > > > > > > It always is a PCIe port, but its location within the SoC may matter.
> > > > > > > > >
> > > > > > > > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > > > > > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> > > > > > > > > still the same.
> > > > > > > > >
> > > > > > > > > > Also some custom AML-based power management is involved and that may
> > > > > > > > > > be making specific assumptions on the configuration of the SoC and the
> > > > > > > > > > GPU at the time of its invocation which unfortunately are not known to
> > > > > > > > > > us.
> > > > > > > > > >
> > > > > > > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > > > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > > > > > > > that point, so it looks like that AML tries to access device memory on
> > > > > > > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > > > > > > accessible in PCI power states below D0.
> > > > > > > > >
> > > > > > > > > Or the PCI config space of the GPU when the parent root port is in D3hot
> > > > > > > > > (as it is the case here). Also then the GPU config space is not
> > > > > > > > > accessible.
> > > > > > > >
> > > > > > > > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > > > > > > > a suspend ordering violation?
> > > > > > >
> > > > > > > No. We put the GPU into D3hot first,
> > > > >
> > > > > OK
> > > > >
> > > > > Does this involve any AML, like a _PS3 under the GPU object?
> > > >
> > > > I don't see _PS3 (nor _PS0) for that object. If I read it right the GPU
> > > > itself is not described in ACPI tables at all.
> > >
> > > OK
> > >
> > > > > > > then the root port and then turn
> > > > > > > off the power resource (which is attached to the root port) resulting
> > > > > > > the topology entering D3cold.
> > > > > >
> > > > > > I don't see that happening in the AML though.
> > > > >
> > > > > Which AML do you mean, specifically?  The _OFF method for the root
> > > > > port's _PR3 power resource or something else?
> > > >
> > > > The root port's _OFF method for the power resource returned by its _PR3.
> > >
> > > OK, so without the $subject patch we (1) program the downstream
> > > component (GPU) into D3hot, then we (2) program the port holding it
> > > into D3hot and then we (3) let the AML (_OFF for the power resource
> > > listed by _PR3 under the port object) run.
> > >
> > > Something strange happens at this point (and I guess that _OFF doesn't
> > > even reach the point where it removes power from the port which is why
> > > we see a lock-up).
> >
> > It does not necessary lead to lock-up. Here is dmesg from Karol's
> > system:
> >
> >   https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> >
> > what seems to happen is that the GPU never "comes back" from D3cold so
> > the driver starts breaking apart as the hardware is gone now.
> 
> I meant a lock-up in hardware to be precise, that causes it to stop to
> respond (which causes it to appear to be permanently in D3cold).
> 
> I wonder if the port accepts PCI config space writes then.
> 
> > > We know that skipping (1) makes things work and we kind of suspect
> > > that skipping (3) would make things work either, but what about doing
> > > (1) and (3) without (2)?
> >
> > You mean in this particular case or in general?
> 
> In this case in particular to start with.  Just do an experiment to
> see what happens if we skip pci_raw_set_power_state() for the port
> instead of skipping it for the downstream device.
> 
> > Because if the port has _PSx methods we need to put it into D3hot AFAIK.
> 
> Yes, we need to run _PS3 then, but maybe we don't need to write to its
> PMCSR directly.
> 
> > > > > > Basically the difference is that when Windows 7 or Linux (the _REV==5
> > > > > > check) then we directly do link disable whereas in Windows 8+ we invoke
> > > > > > LKDS() method that puts the link into L2/L3. None of the fields they
> > > > > > access seem to touch the GPU itself.
> > > > >
> > > > > So that may be where the problem is.
> > > > >
> > > > > Putting the downstream component into PCI D[1-3] is expected to put
> > > > > the link into L1, so I'm not sure how that plays with the later
> > > > > attempt to put it into L2/L3 Ready.
> > > >
> > > > That should be fine. What I've seen the link goes into L1 when
> > > > downstream component is put to D-state (not D0) and then it is put back
> > > > to L0 when L2/3 ready is propagated. Eventually it goes into L2 or L3.
> > >
> > > Well, that's the expected behavior, but the observed behavior isn't as
> > > expected. :-)
> >
> > Right :)
> >
> > > > > Also, L2/L3 Ready is expected to be transient, so finally power should
> > > > > be removed somehow.
> > > >
> > > > There is GPIO for both power and PERST, I think the line here:
> > > >
> > > >   \_SB.SGOV (0x01010004, Zero)
> > > >
> > > > is the one that removes power.
> > >
> > > OK
> > >
> > > > > > LKDS() for the first PEG port looks like this:
> > > > > >
> > > > > >    P0L2 = One
> > > > > >    Sleep (0x10)
> > > > > >    Local0 = Zero
> > > > > >    While (P0L2)
> > > > > >    {
> > > > > >         If ((Local0 > 0x04))
> > > > > >         {
> > > > > >             Break
> > > > > >         }
> > > > > >
> > > > > >         Sleep (0x10)
> > > > > >         Local0++
> > > > > >    }
> > > > > >
> > > > > > One thing that comes to mind is that the loop can end even if P0L2 is
> > > > > > not cleared as it does only 5 iterations with 16 ms sleep between. Maybe
> > > > > > Sleep() is implemented differently in Windows? I mean Linux may be
> > > > > > "faster" here and return prematurely and if we leave the port into D0
> > > > > > this does not happen, or something. I'm just throwing out ideas :)
> > > > >
> > > > > But this actually works for the downstream component in D0, doesn't it?
> > > >
> > > > It does and that leaves the link in L0 so it could be that then the
> > > > above AML works better or something.
> > >
> > > That would be my guess.
> > >
> > > > That reminds me, ASPM may have something to do with this as well.
> > >
> > > Not really if D-states are involved.
> > >
> > > > > Also, if the downstream component is in D0, the port actually should
> > > > > stay in D0 too, so what would happen with the $subject patch applied?
> > > >
> > > > Parent port cannot be lower D-state than the child so I agree it should
> > > > stay in D0 as well. However, it seems that what happens is that the
> > > > issue goes away :)
> > >
> > > Well, at least this is kind of out of the spec.
> > >
> > > Note that pci_pm_suspend_noirq() won't let the port go into D3 if the
> > > downstream device is in D0, so the $subject patch will not work as
> > > expected in the suspend-to-idle case.
> > >
> > > Also we really should make up our minds on whether or not to force
> > > PCIe ports to stay in D0 when downstream devices are in D0 and be
> > > consequent about that.  Right now we do one thing during system-wide
> > > suspend and the other one in PM-runtime, which is confusing.
> > >
> > > The current design is mostly based on the PCI PM Spec 1.2, so it would
> > > be consequent to follow system-wide suspend in PM-runtime and avoid
> > > putting PCIe ports holding devices in D0 into any low-power states.
> > > but that would make the approach in the $subject patch ineffective.
> > >
> > > Moreover, the fact that there are separate branches for "Windows 7"
> > > and "Windows 8+" kind of suggest a change in the expected behavior
> > > between Windows 7 and Windows 8, from the AML perspective.  I would
> > > guess that Windows 7 followed PCI PM 1.2 and Windows 8 (and later)
> > > does something else.
> >
> > My understanding (which may not be correct) is that up to Windows 7 it
> > never put the devices into D3cold runtime. Only when the system entered
> > Sx states it evaluated the _OFF methods.
> 
> I see.
> 
> > Starting from Windows 8 it started doing this runtime so devices can
> > enter D3cold even when system is in S0.
> 
> Hmm.  So by setting _REV to 5 we effectively change the _OFF into a NOP?

No, there are two paths in the _OFF() and them some common code such as
removing power etc.

What the _REV 5 did is that it went into path where the AML seemed to
directly disable the link.

The other path that is taken with Windows 8+ does not disable the link
but instead it puts it to low power L2 or L3 state (I suppose L3 since
it removes the power and the GPU probably does not support wake).

The ASL code is below. PGOF() gets called from the power resource
_OFF():

        Method (PGOF, 1, Serialized)
        {
            PIOF = Arg0
            If ((PIOF == Zero))
            {
                If ((SGGP == Zero))
                {
                    Return (Zero)
                }
            }
            ElseIf ((PIOF == One))
            {
                If ((P1GP == Zero))
                {
                    Return (Zero)
                }
            }
            ElseIf ((PIOF == 0x02))
            {
                If ((P2GP == Zero))
                {
                    Return (Zero)
                }
            }

            PEBA = \XBAS /* External reference */
            PDEV = GDEV (PIOF)
            PFUN = GFUN (PIOF)
            Name (SCLK, Package (0x03)
            {
                One, 
                0x80, 
                Zero
            })
            If ((CCHK (PIOF, Zero) == Zero))
            {
                Return (Zero)
            }

            \_SB.PCI0.PEG0.PEGP.LTRE = \_SB.PCI0.PEG0.LREN
            If ((Arg0 == Zero))
            {
                ELC0 = LCT0 /* \_SB_.PCI0.LCT0 */
                H0VI = S0VI /* \_SB_.PCI0.S0VI */
                H0DI = S0DI /* \_SB_.PCI0.S0DI */
                ECP0 = LCP0 /* \_SB_.PCI0.LCP0 */
            }
            ElseIf ((Arg0 == One))
            {
                ELC1 = LCT1 /* \_SB_.PCI0.LCT1 */
                H1VI = S1VI /* \_SB_.PCI0.S1VI */
                H1DI = S1DI /* \_SB_.PCI0.S1DI */
                ECP1 = LCP1 /* \_SB_.PCI0.LCP1 */
            }
            ElseIf ((Arg0 == 0x02))
            {
                ELC2 = LCT2 /* \_SB_.PCI0.LCT2 */
                H2VI = S2VI /* \_SB_.PCI0.S2VI */
                H2DI = S2DI /* \_SB_.PCI0.S2DI */
                ECP2 = LCP2 /* \_SB_.PCI0.LCP2 */
            }

            If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 
                0x05))))
            {
                If ((PIOF == Zero))
                {
                    P0LD = One
                    TCNT = Zero
                    While ((TCNT < LDLY))
                    {
                        If ((P0LT == 0x08))
                        {
                            Break
                        }

                        Sleep (0x10)
                        TCNT += 0x10
                    }

                    P0RM = One
                    P0AP = 0x03
                }
                ElseIf ((PIOF == One))
                {
                    P1LD = One
                    TCNT = Zero
                    While ((TCNT < LDLY))
                    {
                        If ((P1LT == 0x08))
                        {
                            Break
                        }

                        Sleep (0x10)
                        TCNT += 0x10
                    }

                    P1RM = One
                    P1AP = 0x03
                }
                ElseIf ((PIOF == 0x02))
                {
                    P2LD = One
                    TCNT = Zero
                    While ((TCNT < LDLY))
                    {
                        If ((P2LT == 0x08))
                        {
                            Break
                        }

                        Sleep (0x10)
                        TCNT += 0x10
                    }

                    P2RM = One
                    P2AP = 0x03
                }

                If ((PBGE != Zero))
                {
                    If (SBDL (PIOF))
                    {
                        MBDL = GMXB (PIOF)
                        PDUB (PIOF, MBDL)
                    }
                }
            }
            Else
            {
                LKDS (PIOF)
            }

            If ((DerefOf (SCLK [Zero]) != Zero))
            {
                PCRO (0xDC, 0x100C, DerefOf (SCLK [One]))
                Sleep (0x10)
            }

            GPPR (PIOF, Zero)
            If ((OSYS != 0x07D9))
            {
                DIWK (PIOF)
            }

            \_SB.SGOV (0x01010004, Zero)
            Sleep (0x14)
            Return (Zero)
        }

> > > Now, the structure of the "Windows 8+" branch
> > > described by you suggests that, at least in the cases when it is going
> > > to remove power from the port eventually, it goes straight for the
> > > link preparation (the L2/L3 Ready transition) and power removal
> > > without bothering to program the downstream device and port into D3hot
> > > (because that's kind of redundant).
> > >
> > > That hypothetical "Windows 8+" approach may really work universally,
> > > because it doesn't seem to break any rules (going straight from D0 to
> > > D3cold is not disallowed and doing that for both a port and a
> > > downstream device at the same time is kind of OK either, as long as
> > > the link is ready for that).
> >
> > I guess it depends on how you interpret the specs ;-) From PCIe 5.0 sec
> > 5.8 we can see the supported PM state transitions and it shows that you
> > get to D3cold through D3hot. Of course the device goes into D3cold if
> > you simply remove its power so I agree with you as well. However, if
> > there is _PS3 method we can't skip the D3hot phase.
> 
> That's my understanding too, but I'm wondering about direct PMCSR
> writes.  It is unclear to me if they are necessary, or more precisely,
> whether or not Windows 10, say, carries them out if ACPI PM is going
> to be applied.

According to this:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/pci-power-management-and-device-drivers#scenario-1-turning-off-a-device

it does write PMCSR.

> Maybe I'm going too far with my conclusions, but please let me know
> what you think about the approach proposed at the end of
> https://lore.kernel.org/linux-pm/CAJZ5v0iQttGB4m5TbzCtjp2C1j5qEkUhqhpWb++LhSk3mbW=Lw@mail.gmail.com/T/#t
> ?

Yes, I think that is better approach.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5710389A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKTLWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:22:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:11309 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfKTLWT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 06:22:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 03:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215765679"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 03:22:13 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 13:22:12 +0200
Date:   Wed, 20 Nov 2019 13:22:12 +0200
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
Message-ID: <20191120112212.GA11621@lahna.fi.intel.com>
References: <20191017121901.13699-1-kherbst@redhat.com>
 <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com>
 <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > Hi Karol,
> >
> > On Tue, Nov 19, 2019 at 11:26:45PM +0100, Karol Herbst wrote:
> > > On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Dave]
> > > >
> > > > On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > > > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > > > states.
> > > > >
> > > > > v2: convert to pci_dev quirk
> > > > >     put a proper technical explanation of the issue as a in-code comment
> > > > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > > > v4: simplify quirk by setting flag on the GPU itself
> > > >
> > > > I have zero confidence that we understand the real problem, but we do
> > > > need to do something with this.  I'll merge it for v5.5 if we get the
> > > > minor procedural stuff below straightened out.
> > > >
> > >
> > > Thanks, and I agree with your statement, but at this point I think
> > > only Intel can help out digging deeper as I see no way to debug this
> > > further.
> >
> > I don't have anything against this patch, as long as the quirk stays
> > limited to the particular root port leading to the NVIDIA GPU. The
> > reason why I think it should to be limited is that I'm pretty certain
> > the problem is not in the root port itself. I have here a KBL based
> > Thinkpad X1 Carbon 6th gen that can put the TBT controller into D3cold
> > (it is connected to PCH root port) and it wakes up there just fine, so
> > don't want to break that.
> >
> > Now, PCIe devices cannot go into D3cold all by themselves. They always
> > need help from the platform side which is ACPI in this case. This is
> > done by having the device to have _PR3 method that returns one or more
> > power resources that the OS is supposed to turn off when the device is
> > put into D3cold. All of that is implemented as form of ACPI methods that
> > pretty much do the hardware specific things that are outside of PCIe
> > spec to get the device into D3cold. At high level the _OFF() method
> > causes the root port to broadcast PME_Turn_Off message that results the
> > link to enter L2/3 ready, it then asserts PERST, configures WAKE (both
> > can be GPIOs) and finally removes power (if the link goes into L3,
> > otherwise it goes into L2).
> >
> > I think this is where the problem actually lies - the ASL methods that
> > are used to put the device into D3cold and back. We know that in Windows
> > this all works fine so unless Windows quirks the root port the same way
> > there is another reason behind this.
> >
> > In case of Dell XPS 9560 (IIRC that's the machine you have) the
> > corresponding power resource is called \_SB.PCI0.PEG0.PG00 and its
> > _ON/_OFF methods end up calling PGON()/PGOF() accordingly. The methods
> > itself do lots of things and it is hard to follow the dissassembled
> > ASL which does not have any comments but there are couple of things that
> > stand out where we may go into a different path. One of them is this in
> > the PGOF() method:
> >
> >    If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 0x05))))
> >
> > The ((OSYS == 0x07DF) && (_REV == 0x05)) checks specifically for Linux
> > (see [1] and 18d78b64fddc ("ACPI / init: Make it possible to override
> > _REV")) so it might be that Dell people tested this at some point in
> > Linux as well. Added Mario in case he has any ideas.
> >
> > Previously I suggested you to try the ACPI method tracing to see what
> > happens inside PGOF(). Did you have time to try it? It may provide more
> > information about that is happening inside those methods and hopefully
> > point us to the root cause.
> >
> > Also if you haven't tried already passing acpi_rev_override in the
> > command line makes the _REV to return 5 so it should go into the "Linux"
> > path in PGOF().
> 
> Oh, so does it look like we are trying to work around AML that tried
> to work around some problematic behavior in Linux at one point?

Yes, it looks like so if I read the ASL right. The whole method looks
like below (the full acpidump was shared by Karol in v3 thread) and
there is similar check in the _ON (PGON) method:

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

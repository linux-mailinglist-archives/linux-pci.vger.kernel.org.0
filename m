Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1904010374C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 11:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfKTKSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 05:18:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:42704 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfKTKSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 05:18:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 02:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215747198"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 02:18:17 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 12:18:16 +0200
Date:   Wed, 20 Nov 2019 12:18:16 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>, Mario.Limonciello@dell.com
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191120101816.GX11621@lahna.fi.intel.com>
References: <20191017121901.13699-1-kherbst@redhat.com>
 <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Karol,

On Tue, Nov 19, 2019 at 11:26:45PM +0100, Karol Herbst wrote:
> On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Dave]
> >
> > On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > states.
> > >
> > > v2: convert to pci_dev quirk
> > >     put a proper technical explanation of the issue as a in-code comment
> > > v3: disable it only for certain combinations of intel and nvidia hardware
> > > v4: simplify quirk by setting flag on the GPU itself
> >
> > I have zero confidence that we understand the real problem, but we do
> > need to do something with this.  I'll merge it for v5.5 if we get the
> > minor procedural stuff below straightened out.
> >
> 
> Thanks, and I agree with your statement, but at this point I think
> only Intel can help out digging deeper as I see no way to debug this
> further.

I don't have anything against this patch, as long as the quirk stays
limited to the particular root port leading to the NVIDIA GPU. The
reason why I think it should to be limited is that I'm pretty certain
the problem is not in the root port itself. I have here a KBL based
Thinkpad X1 Carbon 6th gen that can put the TBT controller into D3cold
(it is connected to PCH root port) and it wakes up there just fine, so
don't want to break that.

Now, PCIe devices cannot go into D3cold all by themselves. They always
need help from the platform side which is ACPI in this case. This is
done by having the device to have _PR3 method that returns one or more
power resources that the OS is supposed to turn off when the device is
put into D3cold. All of that is implemented as form of ACPI methods that
pretty much do the hardware specific things that are outside of PCIe
spec to get the device into D3cold. At high level the _OFF() method
causes the root port to broadcast PME_Turn_Off message that results the
link to enter L2/3 ready, it then asserts PERST, configures WAKE (both
can be GPIOs) and finally removes power (if the link goes into L3,
otherwise it goes into L2).

I think this is where the problem actually lies - the ASL methods that
are used to put the device into D3cold and back. We know that in Windows
this all works fine so unless Windows quirks the root port the same way
there is another reason behind this.

In case of Dell XPS 9560 (IIRC that's the machine you have) the
corresponding power resource is called \_SB.PCI0.PEG0.PG00 and its
_ON/_OFF methods end up calling PGON()/PGOF() accordingly. The methods
itself do lots of things and it is hard to follow the dissassembled
ASL which does not have any comments but there are couple of things that
stand out where we may go into a different path. One of them is this in
the PGOF() method:

   If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 0x05))))

The ((OSYS == 0x07DF) && (_REV == 0x05)) checks specifically for Linux
(see [1] and 18d78b64fddc ("ACPI / init: Make it possible to override
_REV")) so it might be that Dell people tested this at some point in
Linux as well. Added Mario in case he has any ideas.

Previously I suggested you to try the ACPI method tracing to see what
happens inside PGOF(). Did you have time to try it? It may provide more
information about that is happening inside those methods and hopefully
point us to the root cause.

Also if you haven't tried already passing acpi_rev_override in the
command line makes the _REV to return 5 so it should go into the "Linux"
path in PGOF().

[1] https://www.kernel.org/doc/html/latest/firmware-guide/acpi/osi.html#do-not-use-rev

> > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: nouveau@lists.freedesktop.org
> > > ---
> > >  drivers/pci/pci.c    |  7 ++++++
> > >  drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci.h  |  1 +
> > >  3 files changed, 61 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b97d9e10c9cc..02e71e0bcdd7 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> > >          || (state == PCI_D2 && !dev->d2_support))
> > >               return -EIO;
> > >
> > > +     /*
> > > +      * check if we have a bad combination of bridge controller and nvidia
> > > +         * GPU, see quirk_broken_nv_runpm for more info
> >
> > Whitespace damage.  Capitalized incorrectly (see other comments
> > nearby).
> >
> > > +      */
> > > +     if (state != PCI_D0 && dev->broken_nv_runpm)
> > > +             return 0;
> > > +
> > >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > >
> > >       /*
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 44c4ae1abd00..0006c9e37b6f 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> > >  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> > >                             PCI_CLASS_DISPLAY_VGA, 8,
> > >                             quirk_reset_lenovo_thinkpad_p50_nvgpu);
> > > +
> > > +/*
> > > + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
> > > + * those were put into D3cold state if they were put into a non D0 PCI PM
> > > + * device state before doing so.
> >
> > A device in D3cold is off the bus by definition.
> >
> > IIUC the problem is that the sequence D0 -> D3hot -> D3cold -> D0 for
> > the GPU fails in the transition back to D0, while D0 -> D3cold -> D0
> > works fine.
> >
> > So I guess the problem is that we can put the device in D3cold with no
> > problem, but if we put in D3hot before going to D3cold, the device
> > never comes back to D0.  Right?
> >
> 
> correct. It By the way, it doesn't matter if I put the device into D1
> instead, as long as the device is not in D0 state before putting it
> into D3cold, it fails.
> 
> > > + * This leads to various issue different issues which all manifest differently,
> >
> > s/issue different//
> >
> > Actually, I think there's only one underlying issue with several
> > manifestations.
> >
> > > + * but have the same root cause:
> > > + *  - AIML code execution hits an infinite loop (as the coe waits on device
> > > + *    memory to change).
> >
> > s/AIML/AML/
> > s/coe/code/
> >
> > > + *  - kernel crashes, as all pci reads return -1, which most code isn't able
> > > + *    to handle well enough.
> >
> > s/pci/PCI/
> >
> > More details about these crashes would be useful as we look at places
> > that *should* be able to handle errors like this.
> >
> 
> makes sense, I could ,orthogonal to this, make the code more robust if
> we hit issues like this in the future. What I am mostly wondering
> about is, why pci core doesn't give up if the device doesn't come back
> from D3cold? It sounds like, that the most sane thing to do here is to
> just give up and fail runtime_resume and report errors back to
> userspace trying to make use of the devices.
> 
> > > + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> > > + *    userspace tries to access the GPU.
> >
> > This doesn't fit with the others and more details might be
> > informative here as well.
> >
> 
> yeah.. I try to get more infos on that. But at least for me (and it
> might be a distribution thing) if I execute lspci, the system shuts
> down, or at least tries to and might fail.
> 
> > > + * In all cases dmesg will contain at least one line like this:
> > > + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> > > + * followed by a lot of nouveau timeouts.
> > > + *
> > > + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
> > > + * PCIe bridge controller in order to power down the GPU.
> > > + * Nonetheless, there are other code paths inside the ACPI firmware which use
> > > + * other registers, which seem to work fine:
> > > + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> > > + *  - 0xb0 bit 0x10 (link disable)
> >
> > All these register addresses are device-specific, so they're useless
> > without identifying the device.  "lspci -vvnn" output would let us at
> > least connect this with something.  It would be nice to have that info
> > archived along with your acpidump and python repro scripts in a
> > bugzilla with the URL in the commit log.
> >
> > These are likely in PCI capabilities.  If I make the leap of assuming
> > the "link disable" bit is PCI_EXP_LNKCTL_LD, that would mean the Link
> > Control register is at 0xb0 and the register at 0xbc would be the Root
> > Control register, and indeed 0x20 in Root Control is reserved.
> >
> > I don't know what the relevance of all this is, though.  It's not
> > remarkable that accesses to these registers work.
> >
> 
> those are registers on the bridge controller and are using inside ACPI
> to power down the link. Depending on the OS detected other methods are
> used afaik.
> 
> > Unless you mean you can access these registers *after* trying to put
> > the device back in D0, but other accesses to the device fail.  That
> > would indeed be very interesting.
> >
> > > + * Changing the conditions inside the firmware by poking into the relevant
> > > + * addresses does resolve the issue, but it seemed to be ACPI private memory
> > > + * and not any device accessible memory at all, so there is no portable way of
> > > + * changing the conditions.
> > > + *
> > > + * The only systems where this behavior can be seen are hybrid graphics laptops
> > > + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
> > > + * only occurs in combination with listed Intel PCIe bridge controllers and
> > > + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> > > + *
> > > + * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
> > > + * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
> > > + * in the bridge controller rather than in the GPU.
> >
> > I don't think we can conclude anything about where the defect is and I
> > don't think speculating here will help future readers of this code.
> >
> > I *would* still like to see a bugzilla listing the systems where this
> > problem has been seen with the "lspci -vvnn", dmesg logs, and at least
> > one acpidump.  I think there's more to this story, and I suspect we
> > may be revisiting this in the future.
> >
> 
> one big one is https://bugzilla.kernel.org/show_bug.cgi?id=156341 but
> it's filled with a lot of different reports, but I am sure most of
> them point to this very issue.
> 
> Sadly nobody thought of checking lspci with runpm disabled.. but I
> could check for other bugs.
> 
> > > + * This issue was not able to be reproduced on non laptop systems.
> > > + */
> > > +
> > > +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> > > +{
> > > +     struct pci_dev *bridge = pci_upstream_bridge(dev);
> > > +
> > > +     if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> > > +         bridge->device == 0x1901)
> >
> > pci_upstream_bridge() may return NULL, so you need
> >
> >   if (bridge && bridge->vendor == PCI_VENDOR_ID_INTEL ...
> >
> > https://lore.kernel.org/r/20190927144421.22608-1-kherbst@redhat.com
> > says Skylake and Kaby Lake SoCs are affected.  But here you only check
> > for one Device ID?
> >
> 
> yes, I found this bridge controllers on skylake and kaby lake SoCs,
> but I could verify there are systems with a different architecture
> (using the "PCI Express Root Port" devices instead of "Processor PCIe
> Controller") do not show this issue, so I think it might indeed be
> just this one bridge controller. I couldn't verify this issue on any
> other so far.
> 
> But I could verify this issue with this one bridge controller in
> combination with Maxwell, Pascal and Turing Nvidia GPUs.
> 
> > > +             dev->broken_nv_runpm = 1;
> > > +}
> > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> > > +                           PCI_BASE_CLASS_DISPLAY, 16,
> > > +                           quirk_broken_nv_runpm);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index ac8a6c4e1792..903a0b3a39ec 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -416,6 +416,7 @@ struct pci_dev {
> > >       unsigned int    __aer_firmware_first_valid:1;
> > >       unsigned int    __aer_firmware_first:1;
> > >       unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> > > +     unsigned int    broken_nv_runpm:1;      /* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
> > >       unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
> > >       unsigned int    irq_managed:1;
> > >       unsigned int    has_secondary_link:1;
> > > --
> > > 2.21.0
> > >
> >
> 
> Will send out a v5 later addressing you review. Thanks!

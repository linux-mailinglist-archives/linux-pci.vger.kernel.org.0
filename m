Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBA79ED76
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjIMPl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIMPlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 11:41:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73C2101;
        Wed, 13 Sep 2023 08:40:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B39C433C7;
        Wed, 13 Sep 2023 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619637;
        bh=Ms58LN0GBLr340jo8wP//kFzSCCIYQXyYxxTf40U+ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FyUO8ZaQy/4R06o3DKQkmH/0suhok3WzwxgmcXa7qxPYTSZI8CoEGNh1x6H9ETNSv
         /NIafA6aATJBqprLJSBysL3oJx3HBA64z98Ot6U/Y5VQv8YMg6LwNc4pi2+idH70cJ
         sxI1AqxcxZOhFBDa2Qj7brF0Lls+mHRFmLbyra43V0F7RYCLe5tzw2rVniJipl7V9A
         n7U/dUj4dqYo5eJfYtf3yHjxPZq2oFjD17Y/KtAn0BIkX5kPvdN5lh2sDC5K1slLFH
         7SMWIi0xheaiPQ8z3JRfkOtZzFiTZSij/Gd/PAfWVqUW6bOArB18d4n/tvadRhOSq9
         k+K5KjL2JCmQw==
Date:   Wed, 13 Sep 2023 10:40:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230913154036.GA433234@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jtn_ak5OyTJ3oxnCjKHhLXCoth+pDYhfLw0didoEAcqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 12:20:14PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 13, 2023 at 6:11 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Iain reports that USB devices can't be used to wake a Lenovo Z13
> > from suspend. This is because the PCIe root port has been put
> > into D3hot and AMD's platform can't handle USB devices waking the
> > platform from a hardware sleep state in this case.
> 
> It would be good to mention the PMC involvement, because it is
> necessary to trigger the issue IIUC.
> 
> Apparently, if a Root Port is in D3hot at the time the PMC is called
> to reduce the platform power, the PMC takes that as a license to do
> something that prevents wakeup signaling from working.

This absolutely needs to be part of the commit log and the patch.

If the device advertises PME_Support for D3hot or D3cold, but we don't
actually get those PMEs after putting it in D3hot or D3cold, that's a
bug in the device.  "AMD's platform can't handle devices waking from
hardware sleep" isn't specific enough to help future PCI maintenance
because "hardware sleep state" is not a PCI concept.

> > This problem only occurs on Linux, when waking from a platform hardware
> > sleep state. Comparing the behavior on Windows and Linux, Windows
> > doesn't put the root ports into D3.
> >
> > In Windows systems that support Modern Standby specify hardware
> > pre-conditions for the SoC to achieve the lowest power state by device
> > constraints in a SOC specific "Power Engine Plugin" (PEP) [1] [2].
> > They can be marked as disabled or enabled and when enabled can specify
> > the minimum power state required for an ACPI device.
> >
> > The policy on Linux does not take constraints into account to decide what
> > state to put the device into at suspend like Windows does.
> 
> I'm not sure whether or not it is really clear what happens in Windows
> nor whether it is relevant for this patch.
> 
> The relevant information is that Windows keeps these ports in D0 and
> that demonstrably prevents the PMC from using a platform state in
> which PCIe wakeup doesn't work.  Therefore Linux needs to do the same
> thing, but only if system wakeup is enabled for them (or the devices
> underneath).

So it sounds like either of these scenarios would work:

  A) Root Port stays in D0, PMC selects platform state X, wakeups still
     work

  B) Root Port in D3hot, PMC selects platform state Y that doesn't
     break wakeups, so wakeups still work

PCI isn't in a position to pick one over the other because it has no
idea what the tradeoffs are.

IIUC, this quirk basically forces scenario A (although a naive reading
would suggest that we could still put the Root Port in D1 or D2, since
the quirk only mentions D3).

> > Rather for
> > devices that support D3, the target state is selected by this policy:
> > 1. If platform_pci_power_manageable():
> >    Use platform_pci_choose_state()
> > 2. If the device is armed for wakeup:
> >    Select the deepest D-state that supports a PME.
> > 3. Else:
> >    Use D3hot.
> >
> > Devices are considered power manageable by the platform when they have
> > one or more objects described in the table in section 7.3 of the ACPI 6.5
> > specification [3].
> >
> > If devices are not considered power manageable; specs are ambiguous as
> > to what should happen.  In this situation Windows 11 leaves PCIe
> > ports in D0 while Linux puts them into D3 due to the policy introduced by
> > commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").
> >
> > As the Windows PEP driver uses constraints to express the desired state
> > that should be selected for suspend  but Linux doesn't introduce a quirk
> > for the problematic root ports.
> 
> I would say "but Linux doesn't do that, so ...", because it currently
> reads like the quirk was not present which is slightly confusing.
> 
> > When selecting a target state specifically for sleep in
> > `pci_prepare_to_sleep` this quirk will prevent the root ports from
> > selecting D3hot or D3cold if they have been configured as a wakeup source.
> >
> > Cc: stable@vger.kernel.org
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
> > Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
> > Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [3]
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > The same PCI ID is used for multiple different root ports.  This problem
> > only affects the root port that the USB4 controller is connected to.

If true, this seems important, not something to discard because it's
after "---".

> >  drivers/pci/pci.c    |  5 +++++
> >  drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
> >  include/linux/pci.h  |  2 ++
> >  3 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 59c01d68c6d5..a113b8941d09 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
> >         if (target_state == PCI_POWER_ERROR)
> >                 return -EIO;
> >
> > +       /* quirk to avoid setting D3 */
> > +       if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&

Why did you pick dev_flags?  If there's not a reason to prefer that,
I'd just add a 1-bit bitfield because that doesn't require a new
#define.

> > +          (target_state == PCI_D3hot || target_state == PCI_D3cold))
> > +               target_state = PCI_D0;
> > +
> >         pci_enable_wake(dev, target_state, wakeup);
> >
> >         error = pci_set_power_state(dev, target_state);

> > + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3 power
> > + * states may cause problems when the system attempts wake up from s2idle.
> > + *
> > + * This manifests as a missing wakeup interrupt on the following systems:
> > + * Family 19h model 44h (PCI 0x14b9)
> > + * Family 19h model 74h (PCI 0x14eb)
> > + * Family 19h model 78h (PCI 0x14eb)
> > + *
> > + * Add a quirk to the root port if a USB4 controller is connected to it
> > + * to avoid D3 power states.

I want to know whether this is D3hot, D3cold, or both.  Also in the
pci_info() below.

Also, do we have some indication that this is specific to Ryzen?  If
not, I assume this is an ongoing issue, and matching on Device IDs
just means we'll have to debug the same problem again and add more
IDs.

> > +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev *child = NULL;
> > +
> > +       while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
> > +               if (pci_upstream_bridge(child) != pdev)
> > +                       continue;
> > +               pdev->dev_flags |= PCI_DEV_FLAGS_NO_WAKE_D3;
> > +               pci_info(pdev, "quirk: disabling D3 for wakeup\n");

I don't remember seeing any evidence that this is a USB4-specific
issue.  My guess is that it affects wakeups from *any* device below
these Root Ports, since I assume the PMEs are bog standard PCIe
events, not anything special about USB4.

It sounds like this is only an issue when amd_pmc_s2idle_prepare() is
involved, right?  The PMEs and wakeups work as expected until we tell
the PMC to do its magic thing?

If so, shouldn't this be conditional on something in amd/pmc.c to
connect these pieces together?  Looks like amd/pmc.c only works if
the platform provides an AMDI0005, AMDI0006, etc., ACPI device?

I think it'd be nice if amd_pmc_probe() logged a hint about it being
activated.  AFAICS it only logs something on errors.  This has been
incredibly painful to debug.  It looks like the PMCs do very subtle
power management things, and it'd be nice to have a hint that there's
really fancy stuff going on in the background.

Bjorn

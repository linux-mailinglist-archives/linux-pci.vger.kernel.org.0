Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D92D77ED47
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbjHPWi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347039AbjHPWip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 18:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F832D4D;
        Wed, 16 Aug 2023 15:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0FB61FFD;
        Wed, 16 Aug 2023 22:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547F7C433C7;
        Wed, 16 Aug 2023 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692225513;
        bh=dfusznejraBYL55fNLrDOdbRLonVUzr+heP3BBYPRag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ivd1Qgvk5G2qtd0/i5ApAiqQjUiXKSPgUm9JVk5moGOgTuR8HG0wJ3z+K4DPJGcUA
         PW5fCU6OYQVtFqvln1U/JirAylOT9OqVjP0oXMOtDBEoMQw+ItTse/7A2lsthzXkg4
         LOmkOxMOZ9AMiPveXM9LwoaI/LKDeDacpqL6i00nKSPlgkLxwT2qsC85Cwb/To4sgr
         wyGfN7+B9jw14+2focHDbjkbdlHpzyCwHCFJO3y71HcEtEUcOeizmZo+0njig2hTl4
         wysL0BAcjwDMS5z8vwIiCwATNJSVjcqkJjVQNApCADc6ViqxAQwRW133jGSQt4FlI6
         P2kbGdAfe+DAQ==
Date:   Wed, 16 Aug 2023 17:38:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
Message-ID: <20230816223831.GA291481@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8e6892-7b05-459b-8c32-858deaa923f0@amd.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[I see that you just posted a v12 that doesn't touch drivers/pci at
all.  I haven't looked at it yet, so maybe my questions/comments below
are no longer relevant.]

On Wed, Aug 16, 2023 at 07:57:52AM -0500, Limonciello, Mario wrote:
> On 8/15/2023 6:48 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 09, 2023 at 01:54:53PM -0500, Mario Limonciello wrote:
> > > Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> > > storing a value to the `bridge_d3` variable in the `struct pci_dev`
> > > structure.
> > > 
> > > pci_power_manageable() uses this variable to indicate a PCIe port can
> > > enter D3.
> > > pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> > > decide whether to try to put a device into its target state for a sleep
> > > cycle via pci_prepare_to_sleep().
> > > 
> > > For devices that support D3, the target state is selected by this policy:
> > > 1. If platform_pci_power_manageable():
> > >     Use platform_pci_choose_state()
> > > 2. If the device is armed for wakeup:
> > >     Select the deepest D-state that supports a PME.
> > > 3. Else:
> > >     Use D3hot.
> > > 
> > > Devices are considered power manageable by the platform when they have
> > > one or more objects described in the table in section 7.3 of the ACPI 6.5
> > > specification.
> > > 
> > > When devices are not considered power manageable; specs are ambiguous as
> > > to what should happen.  In this situation Windows 11 leaves PCIe
> > > ports in D0 while Linux puts them into D3 due to the above mentioned
> > > commit.
> > 
> > Why would we not use the same policy as Windows 11?
> 
> That's what I'm aiming to do with my patch series.

OK, help me out because I think I have a hint of how this works, but
I'm still really confused.  Here's the sort of commit log I envision
(but I know it's all wrong, so help me out):

  Iain reported that the Lenovo Thinkpad Z13 suspends but activity on
  plugged-in USB devices will not cause a resume.  The resume failed
  because the Root Port leading to the USB adapter was in D3hot, and
  ... maybe firmware can't identify the wakeup source?  I dunno?

  The Z13 supplies an ACPI PNP0D80 System Power Management Controller
  with a "Get Device Constraints" _DSM method that says the Root Port
  should not be put into a lower power state than D0 ??

[This is one thing that seems completely wrong.  The _DSM spec says
the device must be in the specified or DEEPER D-state to achieve the
lowest power platform idle state.  That seems backwards.]

  For power-manageable devices (those with _PS0 or _PR0, per ACPI
  r6.5, sec 7.3), platform_pci_choose_state() selects the low-power
  state based on the device's _SxW, _SxD, and _PRW methods.

  For non-power manageable devices (those without _PS0 or _PR0), ACPI
  doesn't help decide the low-power state.

[This confuses me too.  Even here pci_set_power_state() uses
pci_platform_power_transition(), i.e., ACPI, but I guess this only
uses _OFF/_ON and doesn't count as "power managed"?

Maybe that makes sense since _OFF/_ON are part of sec 7.2 ("Declaring
a Power Resource Object", which is separate from *7.3* ("Device Power
Management Objects") where _PR0, _PS0, _PRW, _SxD, _SxW, etc are.]

  However, extensions like the ACPI PNP0D80 System Power Management
  Controller device can provide constraints on the allowable low-power
  states.

  Add platform_get_constraint() so pci_target_state() can discover
  constraints from these extensions and avoid choosing a deeper
  low-power state than the platform allows.

[Again, this *seems* backwards to how that _DSM is documented.]

> > > In Windows systems that support Modern Standby specify hardware
> > > pre-conditions for the SoC to achieve the lowest power state by device
> > > constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
> > > They can be marked as disabled or enabled and when enabled can specify
> > > the minimum power state required for an ACPI device.
> > > 
> > > When it is ambiguous what should happen, adjust the logic for
> > > pci_target_state() to check whether a device constraint is present
> > > and enabled.
> > > * If power manageable by ACPI use this to get to select target state
> > > * If a device constraint is present but disabled then choose D0
> > > * If a device constraint is present and enabled then use it
> > > * If a device constraint is not present, then continue to existing
> > > logic (if marked for wakeup use deepest state that PME works)
> > > * If not marked for wakeup choose D3hot
> > 
> > Apparently this is based on constraints from the _DSM method of a
> > PNP0D80 device (and Intel x86 and AMD have different _DSM methods)?
> > 
> > Isn't this something that needs to be part of the ACPI spec?  I
> > don't see PNP0D80 mentioned there.
> 
> So PNP0D80 is a "Windows-compatible system power management controller"
> See https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-management-namespace-objects#compatible-id-_cid
> 
> > Obviously we also have ARM64 and other arches now using ACPI
> 
> Let me quote a few select sections of [4] that I want to draw attention to:
> 
> "Devices that are integrated into the SoC can be power-managed through the
> Windows Power Framework (PoFx). These framework-integrated devices are
> power-managed by PoFx through a SoC-specific power engine plug-in (microPEP)
> that knows the specifics of the SoC's power and clock controls.
> ...
> For peripheral devices that aren't integrated into the SoC, Windows uses
> ACPI Device Power Management.
> ...
> It is possible to, and some device stacks do, use ACPI Device Power
> Management alone, or in combination with the microPEP for on-SoC device
> power management.
> "
> 
> [4] https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-power-management#device-power-management-in-windows
> 
> In Linux we call the device that supports PNP0D80 the "LPS0 device", but in
> Windows they call it uPEP.  In Windows the SOC vendor provides this driver
> and it supports the _DSM calls for the vendor.
> 
> As part of going into Modern Standby on Windows that uPEP driver
> orchestrates the state of the devices mentioned by constraints.
> 
> I'd like to think that's exactly what this patch is doing; it's giving the
> ability to select the target state for SOC specified constraints to the LPS0
> driver.
> 
> Looking at the intertwined function calls again, I wonder if maybe it's
> better to move the constraint checking into pci_prepare_to_sleep().
> 
> That makes it explicitly clear that LPS0 constraints shouldn't be used for
> anything other than suspend rather than also having implications into
> runtime PM.
> 
> As for your comment for ARM64, I think if they use Windows uPEP constraints
> we can add an PNP0D80 compatible LPS0 driver for them too just the same.
> 
> > so I'm not really comfortable with these bits scrounged from
> > Microsoft and Intel white papers.  That seems hard to maintain in
> > the future, and this is hard enough now.
> 
> Remember this all comes back to a PCI root port in the SOC being put
> into an unexpected D-state over suspend.  The device is not ACPI
> power manageable so *that behavior* is up to the OSPM and is not
> grounded in any ACPI or PCI spec.
> 
> TBH I think the Microsoft documentation is the best we're going to
> get here for this case.  To be compatible with UEFI firmware
> designed for Windows machines you need to adopt some Windows-isms.
> 
> If this was coreboot, I would tell the coreboot developers to mark
> this root port as ACPI power manageable and adjust the _SxD and _SxW
> objects so that this root port couldn't get into D3.
> 
> > > Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
> > > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
> > > Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]

This covers the Intel PNP0D80 _DSM.  But
lpi_device_get_constraints_amd() implies that there's a similar but
different AMD version?  Is there a published spec for the AMD _DSM?

> > > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v10->v11:
> > >   * Fix kernel kernel build robot errors and various sparse warnings
> > >     related to new handling of pci_power_t.
> > >   * Use the new helpers introduced in previous patches
> > > ---
> > >   drivers/pci/pci-acpi.c | 12 ++++++++++++
> > >   drivers/pci/pci.c      | 17 ++++++++++++++++-
> > >   drivers/pci/pci.h      |  5 +++++
> > >   3 files changed, 33 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index b5b65cdfa3b8b..9f418ec87b6a5 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1081,6 +1081,18 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > >   	return false;
> > >   }
> > > +/**
> > > + * acpi_pci_device_constraint - return any PCI power state constraints
> > > + * @dev: PCI device to check
> > > + *
> > > + * Returns: Any valid constraint specified by platform for a device.
> > > + * Otherwise PCI_POWER_ERROR.
> > > + */
> > > +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
> > > +{
> > > +	return map_acpi_to_pci(acpi_get_lps0_constraint(&dev->dev));

The non-x86 acpi_get_lps0_constraint() stub returns -ENODEV, which
doesn't seem quite right because map_acpi_to_pci() assumes it gets
ACPI_STATE_D0, etc.

I think it happens to work out fine because if it gets something
that's not ACPI_STATE_*, map_acpi_to_pci() returns PCI_POWER_ERROR,
but that's unholy knowledge of the ACPI_STATE_* values.

> > > +}
> > > +
> > >   static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
> > >   {
> > >   	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 693f4ca90452b..567443726974b 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > >   	return acpi_pci_bridge_d3(dev);
> > >   }
> > > +static inline pci_power_t platform_get_constraint(struct pci_dev *dev)
> > > +{
> > > +	if (pci_use_mid_pm())
> > > +		return PCI_POWER_ERROR;
> > > +
> > > +	return acpi_pci_device_constraint(dev);
> > > +}
> > > +
> > >   /**
> > >    * pci_update_current_state - Read power state of given device and cache it
> > >    * @dev: PCI device to handle.
> > > @@ -2685,11 +2693,13 @@ static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
> > >    */
> > >   static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > >   {
> > > +	pci_power_t state;
> > > +
> > >   	if (platform_pci_power_manageable(dev)) {
> > >   		/*
> > >   		 * Call the platform to find the target state for the device.
> > >   		 */
> > > -		pci_power_t state = platform_pci_choose_state(dev);
> > > +		state = platform_pci_choose_state(dev);
> > >   		switch (state) {
> > >   		case PCI_POWER_ERROR:
> > > @@ -2715,6 +2725,11 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > >   	else if (!dev->pm_cap)
> > >   		return PCI_D0;
> > > +	/* if platform indicates preferred state device constraint, use it */
> > > +	state = platform_get_constraint(dev);
> > > +	if (state != PCI_POWER_ERROR)
> > > +		return state;
> > > +
> > >   	if (wakeup && dev->pme_support)
> > >   		return pci_get_wake_pme_state(dev);
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index a4c3974340576..410fca4b88837 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
> > >   int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
> > >   bool acpi_pci_power_manageable(struct pci_dev *dev);
> > >   bool acpi_pci_bridge_d3(struct pci_dev *dev);
> > > +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev);
> > >   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
> > >   pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
> > >   void acpi_pci_refresh_power_state(struct pci_dev *dev);
> > > @@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > >   {
> > >   	return false;
> > >   }
> > > +static inline pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
> > > +{
> > > +	return PCI_POWER_ERROR;
> > > +}
> > >   static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> > >   {
> > >   	return -ENODEV;
> > > -- 
> > > 2.34.1
> > > 

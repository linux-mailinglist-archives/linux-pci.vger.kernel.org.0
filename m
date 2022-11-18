Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E2C62FEBA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKRUXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKRUXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 15:23:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B111A19A;
        Fri, 18 Nov 2022 12:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5A962770;
        Fri, 18 Nov 2022 20:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFEEC433D6;
        Fri, 18 Nov 2022 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668803018;
        bh=lTift4Acmd8dZ7iTbGs6y5gGp11qamjJZuPERJwDGFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YmoAWeKmt0cFoRZbVHuI87D/iG17zgBNXDLHU49DiHbAN57WAYc+24AMnza1OvLRj
         Dp36Lh7o6zRjMaUJmf350Q4qKdG1eni7/kRzBqT19OL9etDH7LFYycRgfR+xHKRHdS
         5m3uWXJXkIqy76sj9ncIvl9s6c0WzdDt0u2Vk33Y07zDI6tzDI7mZBpqaiGAJm1rg1
         +KOo8YMsLJVPsVdtP0bwLNA5PqT9mdV8ZHkMR+l5ccMpSliQLVvnO/vMO2lISQ0YS3
         m0nwtsdcJij5jaI1ZmDtwvzd/+Xx1smk3rapciGlQItjhQRYZ74qw7XjI5HhP7d+FX
         DrbwuespOa/fg==
Date:   Fri, 18 Nov 2022 14:23:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221118202336.GA1271811@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i3LyfMLx8cuYMdRzJagW-d0Vz3PBVEtFGpDBD6+7VZHQ@mail.gmail.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

Sorry, I'm still confused (my perpetual state :)).

On Fri, Nov 18, 2022 at 02:16:17PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 17, 2022 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > > > > >
> > > > > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > > > > D3 if power managed by ACPI").
> > > > > > > > > > >
> > > > > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > > > > device contains power resources.
> > > > > > > >
> > > > > > > > Wait.  Is this as simple as just recognizing that:
> > > > > > > >
> > > > > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > > > > >   to use _S0W to learn the device's ability to wake itself.
> > > > > > >
> > > > > > > It is.
> > > > > >
> > > > > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > > > > web page [1] says it identifies Root Ports capable of handling hot
> > > > > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > > > > says "I can wake myself from D3hot and D3cold", how is that different
> > > > > > from "I can handle hotplug events in D3"?
> > > > >
> > > > > For native PME/hot-plug signaling there is no difference.  This is the
> > > > > same interrupt by the spec after all IIRC.
> > > > >
> > > > > For GPE-based signaling, though, there is a difference, because GPEs
> > > > > can only be used directly for wake signaling (this is related to
> > > > > _PRW).  In particular, the only provision in the ACPI spec for device
> > > > > hot-add are the Bus Check and Device Check notification values (0 and
> > > > > 1) which require AML to run and evaluate Notify() on specific AML
> > > > > objects.
> > > > >
> > > > > Hence, there is no spec-defined way to tell the OS that "something can
> > > > > be hot-added under this device while in D3 and you will get notified
> > > > > about that".
> > > >
> > > > So I guess acpi_pci_bridge_d3() looks for:
> > > >
> > > >   - "wake signaling while in D3" (_S0W) and
> > > >   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
> > > >
> > > > For Root Ports with both those abilities (or bridges below such Root
> > > > Ports), we allow D3, and this patch doesn't change that.
> > > >
> > > > What this patch *does* change is that all bridges with _PS0 or _PR0
> > > > previously could use D3, but now will only be able to use D3 if they
> > > > are also (or are below) a Root Port that can signal wakeup
> > > > (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
> > > >
> > > > And this fixes the Pink Sardine because it has Root Ports that do
> > > > Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> > > > they cannot wake from D3.  Previously we put those in D3, but they
> > > > couldn't wake up.  Now we won't put them in D3.
> > > >
> > > > I guess there's a possibility that this could break or cause higher
> > > > power consumption on systems that were fixed by c6e331312ebf
> > > > ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> > > > I don't know enough about that scenario.  Maybe Lukas will chime in.
> > >
> > > Well, it is possible that some of these systems will be affected.
> > >
> > > One of such cases is when the port in question has _S0W which says
> > > that wakeup from D3 is not supported.  In that case I think the kernel
> > > should honor the _S0W input, because there may be a good reason known
> > > to the platform integrator for it.
> > >
> > > The other case is when wakeup.flags.valid is unset for the port's ACPI
> > > companion which means that the port cannot signal wakeup through
> > > ACPI-related means at all and this may be problematic, especially in
> > > the system-wide suspend case in which the wakeup capability is not too
> > > relevant unless there is a system wakeup device under the port.
> > >
> > > I don't think that the adev->wakeup.flags.valid check has any bearing
> > > on the _S0W check - if there is _S0W and it says "no wakeup from D3",
> > > it should still be taken into account - so that check can be moved
> > > past the _S0W check.
> >
> > So if _S0W says it can wake from D3, but wakeup.flags is not valid,
> > it's still OK to use D3?
> 
> No, it isn't, as per the code today and I don't think that this
> particular part should be changed now.

But the current upstream code checks acpi_pci_power_manageable(dev)
first, so if "dev" has _PR0 or _PS0, we'll use D3 even if _S0W says it
can wake from D3 and wakeup.flags is not valid.

> _S0W may only cause acpi_pci_bridge_d3() to return false, it is not
> sufficient for true to be returned.
> 
> > I guess in this case we assume wakeup would
> > be via native PME/hotplug signaling?
> 
> This may be taken into consideration at one point, if need be, but not
> in this particular patch IMO.
> 
> > > Now, for compatibility with systems where ports have neither _S0W nor
> > > the HotPlugSupportInD3 property, the acpi_pci_power_manageable()
> > > return value should determine the outcome regardless of the
> > > adev->wakeup.flags.valid value, so the latter should only determine
> > > whether or not the HotPlugSupportInD3 property will be inspected
> > > (which may cause true to be returned before the "power manageable"
> > > check).
> > >
> > > IOW, something like this (after checking _S0W):
> > >
> > > if (adev->wakeup.flags.valid &&
> > >     !acpi_dev_get_property(adev, "HotPlugSupportInD3",
> > > ACPI_TYPE_INTEGER, &obj) &&
> > >     obj->integer.value == 1)
> > >         return true;
> > >
> > > return acpi_pci_power_manageable(dev);
> > >
> > > Where the if () condition basically means that wakeup signaling is
> > > supported (and there is no indication that it cannot be done from D3
> > > as per the previous _S0W check) and hotplug signaling from D3 is
> > > supported.
> > >
> > > > > > This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> > > > > > don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> > > > > > previously the fact that we checked for "HotPlugSupportInD3" meant the
> > > > > > device did NOT have _PS0 or _PR0.
> > > > > >
> > > > > > [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> >
> > I think you're suggesting the patch below, which will make
> > acpi_pci_bridge_d3(dev) return "true" if:
> >
> >   - Root Port can wake from D3hot or D3cold, has "HotPlugSupportInD3",
> >     and has wakeup.flags.valid, OR
> >
> >   - Root Port can wake from D3hot or D3cold, and "dev" has _PR0 or
> >     _PS0
> 
> Well, not exactly.  The second point should be
> 
>  - Root Port's ACPI companion ('dev') has _PR0 or _PS0.

With the patch below, the RP _S0W must either fail or return D3hot or
D3cold (this is what I meant by "RP can wake from D3hot or D3cold")
before we even look for _PR0/_PS0.

Maybe we're talking about two different things -- you suggest we
should check whether the *Root Port* has _PR0 or _PS0, but the current
code checks the bridge "dev", which might be *below* the Root Port
IIUC.

> > Previously, all bridges with _PR0 or _PS0 could use D3; now we also
> > require that the Root Port's _S0W says it can wake from at least
> > D3hot.
> 
> Yes, if _S0W is present and it evaluates successfully, then it is
> required to confirm that wakeup signaling from at least D3hot is
> supported for 'true' to be returned (but it is not sufficient for that
> by itself).

Hmm.  In the case where _S0W is present and says at least D3hot but
wakeup.flags is not valid, the patch below returns 'true' if "dev"
has _PR0 or _PS0.

> That's the only functional change made by that patch and yes, the
> patch below is what I mean.

> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a46fec776ad7..66c9ae1dc5da 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> >                 return false;
> >
> > -       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> > -       if (acpi_pci_power_manageable(dev))
> > -               return true;
> > -
> >         rpdev = pcie_find_root_port(dev);
> >         if (!rpdev)
> >                 return false;
> > @@ -996,14 +992,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         if (!adev)
> >                 return false;
> >
> > -       /*
> > -        * If the Root Port cannot signal wakeup signals at all, i.e., it
> > -        * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
> > -        * events from low-power states including D3hot and D3cold.
> > -        */
> > -       if (!adev->wakeup.flags.valid)
> > -               return false;
> > -
> >         /*
> >          * If the Root Port cannot wake itself from D3hot or D3cold, we
> >          * can't use D3.
> > @@ -1014,16 +1002,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >
> >         /*
> >          * The "HotPlugSupportInD3" property in a Root Port _DSD indicates
> > -        * the Port can signal hotplug events while in D3.  We assume any
> > -        * bridges *below* that Root Port can also signal hotplug events
> > -        * while in D3.
> > +        * the Port can signal hotplug events while in D3.  This differs
> > +        * from _S0W because _S0W may rely on GPEs, which can only be used
> > +        * directly for wake signaling, not hotplug events.
> > +        *
> > +        * We assume any bridges *below* that Root Port can also signal
> > +        * hotplug events while in D3.
> >          */
> > -       if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
> > +       if (adev->wakeup.flags.valid &&
> > +           !acpi_dev_get_property(adev, "HotPlugSupportInD3",
> >                                    ACPI_TYPE_INTEGER, &obj) &&
> >             obj->integer.value == 1)
> >                 return true;
> >
> > -       return false;
> > +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> > +       return acpi_pci_power_manageable(dev);
> >  }
> >
> >  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> 
> Note that the adev->wakeup.flags.valid is still necessary in the cases
> when _S0W is not present, because in those cases wakeup support
> implies that it is supported in all D-states.  It is sort of redundant
> when _S0W is present, but the current code has it and this particular
> patch doesn't (or even shouldn't) change that.

In the current patch, wakeup.flags is only relevant if the RP has
"HotPlugSupportInD3".  If "dev" has _PR0 or _PS0, we'll return 'true'
even if wakeup.flags is not valid.  Maybe that's wrong?

Bjorn

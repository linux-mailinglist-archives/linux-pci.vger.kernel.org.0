Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BA632FA8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 23:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiKUWSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 17:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiKUWRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 17:17:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502DA184;
        Mon, 21 Nov 2022 14:17:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B425614C1;
        Mon, 21 Nov 2022 22:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CF2C433D6;
        Mon, 21 Nov 2022 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669069064;
        bh=YcA4HOQd/YW4DRhi+HZuV7MPBWmmAJci1dQJmfaijMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dvFsHx+IkXfwwa2EPFunqx3FsaHNGThrwG+j1SJ7O6jecPQ4rTVIQ5BY8MUxt5VeQ
         oSXDRvpVSP8RWxkZXlD5qiXPdH+bkJE4PjmhjRD6gR33StgcGXHuBo/0xze7RhHLrE
         ZYJLYQ2AL1b9V8GKeuVRCcEq5Eg7ztOhKcuyOs8HXdECmmkMz9FUJqH7lwYS/yMFeF
         Q+uhDyBQ4O+ifjPo5SmmeGnUDcmix91c8t252pETUAMT+io9MRcZDQq93XmgQqrVhe
         qxUmrnmCr/U7htXMzOPZp6w9KMKmu6KqgPFoHMMpbnowXU1Vc37vILrc5mYSsW0Nzx
         KtucTwTterp/w==
Date:   Mon, 21 Nov 2022 16:17:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20221121221742.GA137841@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4448186.LvFx2qVVIh@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 03:33:00PM +0100, Rafael J. Wysocki wrote:
> On Friday, November 18, 2022 10:13:39 PM CET Rafael J. Wysocki wrote:
> > On Fri, Nov 18, 2022 at 9:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > Sorry, I'm still confused (my perpetual state :)).
> > 
> > No worries, doing my best to address that.
> > 
> > > On Fri, Nov 18, 2022 at 02:16:17PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 17, 2022 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, Nov 17, 2022 at 06:01:26PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Nov 17, 2022 at 12:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Wed, Nov 16, 2022 at 01:00:36PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > > > > > > > > > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > > > > > > > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > > > > > > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > > > > > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > > > > > > > > > devices can support D3 by a combination of the value returned by
> > > > > > > > > > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > > > > > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > > > > > > > > > device it's associated with can support D3.  This was introduced
> > > > > > > > > > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > > > > > > > > > D3 if power managed by ACPI").
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > > > > > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > > > > > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > > > > > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > > > > > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > > > > > > > > > device contains power resources.
> > > > > > > > > > >
> > > > > > > > > > > Wait.  Is this as simple as just recognizing that:
> > > > > > > > > > >
> > > > > > > > > > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > > > > > > > > > >   mean the device can wake itself from a low-power state.  The OS has
> > > > > > > > > > >   to use _S0W to learn the device's ability to wake itself.
> > > > > > > > > >
> > > > > > > > > > It is.
> > > > > > > > >
> > > > > > > > > Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> > > > > > > > > web page [1] says it identifies Root Ports capable of handling hot
> > > > > > > > > plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> > > > > > > > > says "I can wake myself from D3hot and D3cold", how is that different
> > > > > > > > > from "I can handle hotplug events in D3"?
> > > > > > > >
> > > > > > > > For native PME/hot-plug signaling there is no difference.  This is the
> > > > > > > > same interrupt by the spec after all IIRC.
> > > > > > > >
> > > > > > > > For GPE-based signaling, though, there is a difference, because GPEs
> > > > > > > > can only be used directly for wake signaling (this is related to
> > > > > > > > _PRW).  In particular, the only provision in the ACPI spec for device
> > > > > > > > hot-add are the Bus Check and Device Check notification values (0 and
> > > > > > > > 1) which require AML to run and evaluate Notify() on specific AML
> > > > > > > > objects.
> > > > > > > >
> > > > > > > > Hence, there is no spec-defined way to tell the OS that "something can
> > > > > > > > be hot-added under this device while in D3 and you will get notified
> > > > > > > > about that".
> > > > > > >
> > > > > > > So I guess acpi_pci_bridge_d3() looks for:
> > > > > > >
> > > > > > >   - "wake signaling while in D3" (_S0W) and
> > > > > > >   - "notification of hotplug while in D3" ("HotPlugSupportInD3")
> > > > > > >
> > > > > > > For Root Ports with both those abilities (or bridges below such Root
> > > > > > > Ports), we allow D3, and this patch doesn't change that.
> > > > > > >
> > > > > > > What this patch *does* change is that all bridges with _PS0 or _PR0
> > > > > > > previously could use D3, but now will only be able to use D3 if they
> > > > > > > are also (or are below) a Root Port that can signal wakeup
> > > > > > > (wakeup.flags.valid) and can wakeup from D3hot or D3cold (_S0W).
> > > > > > >
> > > > > > > And this fixes the Pink Sardine because it has Root Ports that do
> > > > > > > Thunderbolt tunneling, and they have _PS0 or _PR0 but their _S0W says
> > > > > > > they cannot wake from D3.  Previously we put those in D3, but they
> > > > > > > couldn't wake up.  Now we won't put them in D3.
> > > > > > >
> > > > > > > I guess there's a possibility that this could break or cause higher
> > > > > > > power consumption on systems that were fixed by c6e331312ebf
> > > > > > > ("PCI/ACPI: Whitelist hotplug ports for D3 if power managed by ACPI").
> > > > > > > I don't know enough about that scenario.  Maybe Lukas will chime in.
> > > > > >
> > > > > > Well, it is possible that some of these systems will be affected.
> > > > > >
> > > > > > One of such cases is when the port in question has _S0W which says
> > > > > > that wakeup from D3 is not supported.  In that case I think the kernel
> > > > > > should honor the _S0W input, because there may be a good reason known
> > > > > > to the platform integrator for it.
> > > > > >
> > > > > > The other case is when wakeup.flags.valid is unset for the port's ACPI
> > > > > > companion which means that the port cannot signal wakeup through
> > > > > > ACPI-related means at all and this may be problematic, especially in
> > > > > > the system-wide suspend case in which the wakeup capability is not too
> > > > > > relevant unless there is a system wakeup device under the port.
> > > > > >
> > > > > > I don't think that the adev->wakeup.flags.valid check has any bearing
> > > > > > on the _S0W check - if there is _S0W and it says "no wakeup from D3",
> > > > > > it should still be taken into account - so that check can be moved
> > > > > > past the _S0W check.
> > > > >
> > > > > So if _S0W says it can wake from D3, but wakeup.flags is not valid,
> > > > > it's still OK to use D3?
> > > >
> > > > No, it isn't, as per the code today and I don't think that this
> > > > particular part should be changed now.
> > >
> > > But the current upstream code checks acpi_pci_power_manageable(dev)
> > > first, so if "dev" has _PR0 or _PS0, we'll use D3 even if _S0W says it
> > > can wake from D3 and wakeup.flags is not valid.
> > 
> > Yes, the current code will return 'true' if _PR0 or _PS0 is present
> > for dev regardless of anything else.
> > 
> > The proposed change is to make that conditional on whether or not _S0W
> > for the root port says that wakeup from D3 is supported (or it is not
> > present or unusable).
> > 
> > I see that I've missed one point now which is when the root port
> > doesn't have an ACPI companion, in which case we should go straight
> > for the "dev is power manageable" check.
> 
> Moreover, it is possible that the bridge passed to acpi_pci_bridge_d3() has its
> own _S0W or a wakeup GPE if it is power-manageable via ACPI.  In those cases
> it is not necessary to ask the Root Port's _S0W about wakeup from D3, so overall
> I would go for the patch like the below (not really tested).
> 
> This works in the same way as the current code (unless I have missed anything)
> except for the case when the "target" bridge is power-manageable via ACPI, but
> it cannot signal wakeup via ACPI and has no _S0W.  In that case it will consult
> the upstream Root Port's _S0W to check whether or not wakeup from D3 is
> supported.
> 
> [Note that if dev_has_acpi_pm is 'true', it is kind of pointless to look for the
> "HotPlugSupportInD3" property of the Root Port, because the function is going to
> return 'true' regardless, but I'm not sure if adding an extra if () for handling
> this particular case is worth the hassle.]

I think this has a lot of potential.  I haven't tried it, but I wonder
if splitting out the Root Port-specific parts to a separate function
would be helpful, if only to make it more obvious that there may be
two different devices involved.

If there are two devices ("dev" is a bridge below a Root Port), I
guess support in the Root Port is not necessarily required?  E.g.,
could "dev" assert a wakeup GPE that's not routed through the Root
Port?  If Root Port support *is* required, maybe it would read more
clearly to test that first, before looking at the downstream device.

> ---
>  drivers/pci/pci-acpi.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -975,6 +975,7 @@ bool acpi_pci_power_manageable(struct pc
>  
>  bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
> +	bool dev_has_acpi_pm = false;
>  	struct pci_dev *rpdev;
>  	struct acpi_device *adev;
>  	acpi_status status;
> @@ -984,17 +985,34 @@ bool acpi_pci_bridge_d3(struct pci_dev *
>  	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>  		return false;
>  
> -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> -	if (acpi_pci_power_manageable(dev))
> -		return true;
> +	adev = ACPI_COMPANION(&dev->dev);
> +	if (adev && acpi_device_power_manageable(adev)) {
> +		/*
> +		 * Let the bridge go into D3 if it can signal wakeup from these
> +		 * states (i.e. it has _S0W which says so or it can signal
> +		 * wakeup via ACPI).
> +		 */
> +		status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
> +		if (ACPI_SUCCESS(status)) {
> +			if (state >= ACPI_STATE_D3_HOT)
> +				return true;
> +		} else if (adev->wakeup.flags.valid) {
> +			return true;
> +		}
> +		/*
> +		 * If the bridge is power-manageable by ACPI, let it go into D3
> +		 * by default.
> +		 */
> +		dev_has_acpi_pm = true;
> +	}
>  
>  	rpdev = pcie_find_root_port(dev);
>  	if (!rpdev)
> -		return false;
> +		return dev_has_acpi_pm;
>  
>  	adev = ACPI_COMPANION(&rpdev->dev);
>  	if (!adev)
> -		return false;
> +		return dev_has_acpi_pm;
>  
>  	/*
>  	 * If the Root Port cannot signal wakeup signals at all, i.e., it
> @@ -1002,7 +1020,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *
>  	 * events from low-power states including D3hot and D3cold.
>  	 */
>  	if (!adev->wakeup.flags.valid)
> -		return false;
> +		return dev_has_acpi_pm;
>  
>  	/*
>  	 * If the Root Port cannot wake itself from D3hot or D3cold, we
> @@ -1023,7 +1041,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *
>  	    obj->integer.value == 1)
>  		return true;
>  
> -	return false;
> +	return dev_has_acpi_pm;
>  }
>  
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> 
> 
> 

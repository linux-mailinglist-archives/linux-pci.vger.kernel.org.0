Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21614626092
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKRlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 12:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKRlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 12:41:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B1623B2;
        Fri, 11 Nov 2022 09:41:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D08F961EF1;
        Fri, 11 Nov 2022 17:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DC8C433D7;
        Fri, 11 Nov 2022 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668188463;
        bh=h0amQIIU7hED/32DFMcXw4epT9dOxlQO8lA1tG9vlT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rNJfBnDLMw+Gyy5dhe+jL1zlotxE1AreN70AKPHSP5ubJfTNcOCXse+Ierwr0yPZQ
         31p1kr2SF4HooALu32k07NVWK91tpazAni/v/bMsFOo4L2vLUM43+Ugtx4ylUWk6A5
         pOPxQMHOimhsrG/GucAc36pDuUK8JMO2kVjVj7ZhPsDyZqWH6F86ZVs9KrV/9NALgu
         gvP+eDQWVyrEXKX7waWTtXPu+kLdmgpUjFH3SLYSLT2Vu6AkKuTMiOdoLv6YNtUw98
         V7wNLil+U7oJzD0yJC4zgko03CnKJi20ggmBxb4nhe69hkYa8nX35oThu0GpckRrJR
         eLY9Vkx4h07Gg==
Date:   Fri, 11 Nov 2022 11:41:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20221111174101.GA729137@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031223356.32570-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> Firmware typically advertises that ACPI devices that represent PCIe
> devices can support D3 by a combination of the value returned by
> _S0W as well as the HotPlugSupportInD3 _DSD [1].
> 
> `acpi_pci_bridge_d3` looks for this combination but also contains
> an assumption that if an ACPI device contains power resources the PCIe
> device it's associated with can support D3.  This was introduced
> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> D3 if power managed by ACPI").
> 
> Some firmware configurations for "AMD Pink Sardine" do not support
> wake from D3 in _S0W for the ACPI device representing the PCIe root
> port used for tunneling. The PCIe device will still be opted into
> runtime PM in the kernel [2] because of the logic within
> `acpi_pci_bridge_d3`. This currently happens because the ACPI
> device contains power resources.
> 
> When the thunderbolt driver is loaded two device links are created:
> * USB4 router <- PCIe root port for tunneling
> * USB4 router <- XHCI PCIe device
> 
> These device links are created because the ACPI devices declare the
> `usb4-host-interface` _DSD [3]. For both links the USB4 router is the
> supplier and these other devices are the consumers.
> Here is a demonstration of this topology that occurs:
> 
> |
> ├─ 00:03.1
> |       | "PCIe root port used for tunneling"
> |       | ACPI Path: \_SB_.PCI0.GP11
> |       | ACPI Power Resources: Yes

I guess this means it has _PR0 and/or _PS0?  (same for devices below)

> |       | ACPI _S0W return value: 0
> |       | Device Links: supplier:pci:0000:c4:00.5
> |       └─ PCIe Power state: D0

What bus does 00:03.1 lead to?  I guess it doesn't lead to any of the
devices below?

> └─ 00:08.3
>         | ACPI Path: \_SB_.PCI0.GP19
>         ├─ PCIe Power state: D0

I guess 00:08.3 is a Root Port leading to bus c4?

>         ├─ c4:00.3
>         |       | "XHCI PCIe device used for tunneling"
>         |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
>         |       | ACPI Power Resources: Yes
>         |       | ACPI _S0W return value: 4
>         |       | Device Links: supplier:pci:0000:c4:00.5
>         |       └─ PCIe Power state: D3cold
>         └─ c4:00.5
>                 | "USB4 Router"
>                 | ACPI Path: \_SB_.PCI0.GP19.NHI0
>                 | ACPI Power Resources: Yes
>                 | ACPI _S0W return value: 4
>                 | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
>                 └─ PCIe Power state: D3cold

I'm reading the excellent Documentation/driver-api/device_link.rst and
trying to match up with this topology.  This is a case where 00:03.1
is a consumer of c4:00.5.  The driver core automatically enforces that
children are suspended before parents, but since 00:03.1 is an aunt
(not a child) of c4:00.5, the device link enforces the requirement
that 00:03.1 be suspended before c4:00.5.  Right?

Is c4:00.5 an NHI?

The PCI power states shown above are the failure case?  c4:00.5
*should* remain in D0 as long as 00:03.1 is in D0, but was instead put
in D3cold?

> Currently runtime PM is allowed for all of these devices.

This is because they all have _PR0 and/or _PS0?  (Diagram doesn't show
that for 00:08.3, but I assume it must?)

And I guess they all must have dev->is_hotplug_bridge set?

> This means that
> when all consumers are idle long enough, they will runtime suspend to
> enter their deepest allowed sleep state. Once all consumers are in their
> deepest allowed sleep state the suppliers will enter the deepest sleep
> state as well.
> 
> * The PCIe root port for tunneling doesn't support waking from D3hot or
>   D3cold so although runtime suspended it stays in D0.
> * The XHCI PCIe device supports wakeup from D3cold so it runtime suspends
>   to D3cold.
> * Both consumers are in their deepest state and the USB4 router supports
>   wakeup from D3cold, so it runtime suspends into this state.
> 
> At least for AMD's case the hardware designer's expectation is the USB4
> router should have also remained in D0 since the PCIe root port for
> tunneling remained in D0 and a device link exists between the two devices.
> The current Linux behavior is undefined.

Is the requirement that the supplier can never be in a lower-power
state than the consumer?

I guess that's *not* actually a requirement even though that's the
effect of this patch in this situation.  If it *were* that simple, we
would just check the supplier and consumer power states instead of
looking at all these ACPI properties.

> Instead of making the assertion that the device can support D3 (and thus
> runtime PM) solely from the presence of ACPI power resources, move the check
> to later on in the function, which will have validated that the ACPI device
> supports wake from D3hot or D3cold.
> 
> This fix prevents the USB4 router being put into D3 when the firmware
> says that ACPI device representing the PCIe root port for tunneling can't
> handle it while still allowing ACPI devices that don't have the
> HotplugSupportInD3 _DSD to also enter D3 if they have power resources that
> can wake from D3.

So I guess this changes what acpi_pci_bridge_d3() returns for 00:03.1?
Previously it returned "true" because it has _PR0/_PS0 (so
acpi_pci_power_manageable() is true), but now it will return "false"
because _S0W says it can only wake from D0?

> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3 [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv_pci.c?id=v6.0#n126 [2]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/acpi.c?id=v6.0#n29 [3]
> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Update github->git.kernel.org
>  * Correct arrow direction
>  * Clarify some commit message comments from Lukas' feedback.
> v3->v4:
>  * Pick up tags
>  * Add more details to the commit message
> v2->v3:
>  * Reword commit message
> v1->v2:
>  * Just return value of acpi_pci_power_manageable (Rafael)
>  * Remove extra word in commit message
> ---
>  drivers/pci/pci-acpi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a46fec776ad77..8c6aec50dd471 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>  		return false;
>  
> -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> -	if (acpi_pci_power_manageable(dev))
> -		return true;
> -
>  	rpdev = pcie_find_root_port(dev);
>  	if (!rpdev)
>  		return false;
> @@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	    obj->integer.value == 1)
>  		return true;
>  
> -	return false;
> +	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> +	return acpi_pci_power_manageable(dev);
>  }
>  
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> -- 
> 2.34.1
> 

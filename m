Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8660E8C3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiJZTMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiJZTLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 15:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC014004;
        Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F8C61FFC;
        Wed, 26 Oct 2022 19:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C8BC433C1;
        Wed, 26 Oct 2022 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666811351;
        bh=/fdvyOuxriZCTo4/omFeu+t2ofOhRYzOVYhXMaigN7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YPsrOd3xIrqzAB/9WN4KNPYFOUAZ9WkbOej5OJANWaw9wjfAg5fG2HwTCPV1nPSXc
         UOuXXMzkVmH19oaROznmUXfxTtbJvfhjQmzGxbT0hdC8BGDojueKz+FozIKjKA0HUI
         I3GuRa0JxqqhvjzzyP3Cy3az9pNdTVXbG433NrEVibyPQ3QfrL/W/B6WwPWlsdrZU7
         s5lio2YqvYf7ElciW4Vt1HkY9UlBZQtm38JTQ9wM91lxy4avfBz2bNdWbg82bDXvWJ
         cVXCgwm1pkvm9bSQFeQT4pTd5cBnYDA8YAXy6+X570j2cHC94xjfwQGMulvCOCOc9I
         YF0/Iw49B5Obg==
Date:   Wed, 26 Oct 2022 14:09:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221026190909.GA760069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025221054.12377-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

Thanks for expanding the commit log.  I'm sure this patch is the right
thing to do; I just want to connect a few more dots to make it less
likely that we'll break this in the future.

On Tue, Oct 25, 2022 at 05:10:54PM -0500, Mario Limonciello wrote:
> Firmware typically advertises that PCIe devices can support D3
> by a combination of the value returned by _S0W as well as the
> HotPlugSupportInD3 _DSD.

All PCI devices are required to support both D3hot and D3cold (PCIe
r6.0, sec 5.3.1.4), so I think what's being advertised here is about
what firmware can do (which of course implicitly depends on controls
provided by the platform hardware), not what the *device* supports.

The OS can put a device in D3hot by itself with the PM Control
register, so I assume the important thing here is whether firmware has
interfaces to put a device in D3cold and bring it back to D0.

I know we only get to acpi_pci_bridge_d3() for PCIe devices, but when
the device properties and ACPI interfaces are not PCIe-specific, I
don't think we should restrict it by saying "PCIe".

> `acpi_pci_bridge_d3` looks for this combination but also contains
> an assumption that if a device contains power resources it can support
> D3.  This was introduced from commit c6e331312ebf ("PCI/ACPI: Whitelist
> hotplug ports for D3 if power managed by ACPI").
> 
> On some firmware configurations for "AMD Pink Sardine" D3 is not
> supported for wake in _S0W for the PCIe root port for tunneling.
> However the device will still be opted into runtime PM since
> `acpi_pci_bridge_d3` returns since the ACPI device contains power
> resources.
> 
> When the thunderbolt driver is loaded a device link between the USB4
> router and the PCIe root port for tunneling is created where the PCIe
> root port for tunneling is the consumer and the USB4 router is the
> supplier.  Here is a demonstration of this topology that occurs:
>
> ├─ 0000:00:03.1
> |       | ACPI Path: \_SB_.PCI0.GP11 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.5
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:04.1
> |       | ACPI Path: \_SB_.PCI0.GP12 (Supports "0" in _S0W)
> |       | Device Links: supplier:pci:0000:c4:00.6
> |       └─ D0 (Runtime PM enabled)
> ├─ 0000:00:08.3
> |       | ACPI Path: \_SB_.PCI0.GP19
> |       ├─ D0 (Runtime PM disabled)
> |       ├─ 0000:c4:00.3
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
> |       |       | Device Links: supplier:pci:0000:c4:00.5
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.4
> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC4
> |       |       | Device Links: supplier:pci:0000:c4:00.6
> |       |       └─ D3cold (Runtime PM enabled)
> |       ├─ 0000:c4:00.5
> |       |       | ACPI Path: \_SB_.PCI0.GP19.NHI0 (Supports "4" in _S0W)
> |       |       | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
> |       |       └─ D3cold (Runtime PM enabled)
> |       └─ 0000:c4:00.6
> |               | ACPI Path: \_SB_.PCI0.GP19.NHI1 (Supports "4" in _S0W)
> |               | Device Links: consumer:pci:0000:c4:00.4 consumer:pci:0000:00:04.1
> |               └─ D3cold (Runtime PM enabled)

Can you label the devices above to correspond with the preceding
paragraph?  I assume one of the XHC devices is the USB4 router, but I
don't know which is the Root Port.

Are all the devices relevant to the problem?  If not, prune the ones
that don't matter.  It looks like the domain ("0000") could also be
pruned out.

If you also include the _PR0 and/or _PS0 methods, we'll be able to see
why the current code doesn't do what we want and why the new code
will.

What determines the device links?  I assume there's some ACPI
information that connects the USB4 router with the Root Port?

What are the "D0" and "D3cold" annotations telling me?  What does
"runtime PM enabled" mean?  Is that determined based on some ACPI
methods?

> Allowing the PCIe root port for tunneling to go into runtime PM (even if
> it doesn't support D3) allows the USB4 router to also go into runtime PM.
> The PCIe root port for tunneling stays in D0 but is in runtime PM. Due to
> the device link the USB4 router transitions to D3cold when this happens.

It's probably obvious to PM folks what "going into runtime PM" means,
but it would help me out to describe it in terms of the hardware state
of the device, e.g., D3hot or whatever.

> The expectation is the USB4 router should have also remained in D0 since
> the PCIe root port for tunneling remained in D0.
> 
> Instead of making this assertion from the power resources check
> immediately, move the check to later on, which will have validated
> that the device supports wake from D3hot or D3cold.
> 
> This fix prevents the USB4 router going into D3 when the firmware says that
> the PCIe root port for tunneling can't handle it while still allowing
> system that don't have the HotplugSupportInD3 _DSD to also enter D3 if they
> have power resources that can wake from D3.

I guess there's a theme here of looking for concrete terms that I can
connect directly to the spec vs abstract things like "going into
runtime PM" or "root port can't handle D3" (which I think is actually
saying something about what *firmware* can do).

> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
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

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105E608EC8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJVRUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Oct 2022 13:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVRUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Oct 2022 13:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D75AA0B;
        Sat, 22 Oct 2022 10:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEB1E6098A;
        Sat, 22 Oct 2022 17:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011ABC433C1;
        Sat, 22 Oct 2022 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666459207;
        bh=RJ1xIcUnAPVVHdSTPRNEDx0prZV40DFafeYZNSpgeqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pyepfrxCi11xg4UElYMhfcJzhE7NUckpxB8nZ0zHXUwhO0nvw7FtQOQrvnRKiaGAl
         tB3gOFb13ejCAde2h+3uRZlXbAXE2M4kUWdKnX9Pgl2XiKlmi1cQ5ui2CSndL2Vngy
         uHF+IcHZg2e3MOu0pGEEe7Yrz8Wyria0ZUdRyulheeoYCr8LOitbWdrazChYILlMvA
         DJlWKEsdEfuq/uFi7lZ9HMVqv61Gx0GW103L7PT0iWC3v5z5CaiA5ZGRaaqARU8QIF
         ykqf9HrD99pP+RQ8MFNU09TzrfGUYRZFjCvCgtaV0S16Yj5IEgtenoVtreiQIJX+Zc
         vcv10mYh+5GfQ==
Date:   Sat, 22 Oct 2022 12:20:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/ACPI: Don't assume D3 support if a device is
 power manageable
Message-ID: <20221022172005.GA456826@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020201111.22861-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, in case you have comment on acpi_pci_power_manageable()]

There's a little bit of cognitive dissonance between the subject and
the comment line:

  PCI/ACPI: Don't assume D3 support if a device is power manageable
  +	/* Assume D3 support if the bridge is power-manageable by ACPI. */

I suggest tweaking the subject to mention the actual issue here.  It
looks like it might be something to do with _S0W?

On Thu, Oct 20, 2022 at 03:11:11PM -0500, Mario Limonciello wrote:
> On some firmware configurations where D3 is not supported for
> "AMD Pink Sardine" the PCIe root port for tunneling will still be
> opted into runtime PM since `acpi_pci_bridge_d3` returns true.

This paragraph sounds like it describes where you found the problem,
but I don't think it helps us understand what the problem *is* or how
to make sure the patch will work on other systems.

> This later causes the device link between the USB4 router and the
> PCIe root port for tunneling to misbehave.  The USB4 router may
> enter D3 via runtime PM, but the PCIe root port for tunneling
> remains in D0.  The expectation is the USB4 router should also
> remain in D0 since the PCIe root port for tunneling remained in D0.

I'm not very familiar with device links.  How does the link misbehave?
Is the link doing something wrong, or is it just that we're putting
one of the devices in the wrong power state?

I assume the USB4 router would be a descendant of the Root Port.
Generally descendants can be in lower-power states than their parents.
What expresses the constraint that the router must stay in D0 because
its parent is in D0?

> `acpi_pci_bridge_d3` has a number of checks, but starts out with an
> assumption that if a device is power manageable introduced from
> commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if power
> managed by ACPI") that it will support D3.  This is not a valid
> assumption, as the PCIe root port for tunneling has power resources
> but does not support D3hot or D3cold.

It looks like acpi_pci_power_manageable(dev) means "the device has
_PS0 or _PR0".  Currently we assume that means we can put dev in D3.

And I think you're saying that assumption is a little bit too
aggressive because if _S0W says the device can't wake from D3hot or
D3cold, we should *not* use D3?

> Instead of making this assertion from the power resources check
> immediately, move the check to later on, which will have validated
> that D3hot or D3cold can actually be reached.

IIUC the intervening code doesn't check whether D3hot/D3cold can be
*reached*, but whether the device can *wake* from D3hot/D3cold.

> This fixes the USB4 router going into D3 when the firmware says that
> the PCIe root port for tunneling can't handle it.

For maintenance purposes, I think it will be helpful to know
specifically which devices are involved (e.g., the PCI bus/device/fns
would show the PCI relationship) and how the firmware says the Root
Port can't handle D3.  I assume this would be _S0W?

Maybe even a pidgin example of the ACPI pieces involved here, e.g.,

  RP01._PR0
  RP01._S0W (0x0)    # in S0, can wake from D0 only

> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Just return value of acpi_pci_power_manageable
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

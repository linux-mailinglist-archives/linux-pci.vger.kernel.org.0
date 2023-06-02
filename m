Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17358720BD5
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 00:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjFBWUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjFBWUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 18:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCE1BB;
        Fri,  2 Jun 2023 15:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1E161EF1;
        Fri,  2 Jun 2023 22:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE4C433D2;
        Fri,  2 Jun 2023 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685744433;
        bh=ARyPoi7kYarpVw7JYT8TRHRJ03CAZL5ro3FtDi8lX58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=epc/06WTuFNz6XULfL2XX0PsRI7mMHpwrvq9vk/lI9/Ap4q6iEOtMrFkojjUcelfR
         5ceSMIgZdv07ut21nQw8DZLQQsnPfUF7FufXmCYhTXx7e0Ll6CtMLx3cViEkiJTCn1
         USlkzO0tO8ptJvrr+0DBbmWBRYCMLLA/+zb/6lXppzCcxI4X6gZLjcCb+DfEWA9N0J
         6kH2V38VXgpTyKs4bVD9lr+5a+F0COuf94Vu1FLvG5g8nwBsCJMkQY7Idl2h+Kqi29
         cLts9IDmtU2zYPPAKm4ix7Evpv2svgnBAStyHAkozZ9IyCrg5x6a4ymMjZDp9qfCAe
         slU6E11r5hyyA==
Date:   Fri, 2 Jun 2023 17:20:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Message-ID: <ZHprL3oavxW+tUsX@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163947.230418-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

The patch itself looks fine, but since I don't have all the power
management details in my head, it would help me a lot to make the
description more concrete.

On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> that xHCI device is connected to a USB-C port for an AMD USB4 router.

It sounds like the real issue is that "Root Ports in D3hot/D3cold may
not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
are probably not really relevant.  And hopefully even the "AMD
platforms" mentioned below is not relevant.

> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> all PCIe ports go into D3 during s2idle.
> 
> When specific root ports are put into D3 over s2idle on some AMD platforms
> it is not possible for the platform to properly identify wakeup sources.
> This happens whether the root port goes into D3hot or D3cold.

Can we connect this to a spec so it's not just the empirical "some AMD
platforms work like X" observation?

"s2idle" is meaningful on the power management side of the house, but
it doesn't appear in PCI or ACPI specs, so I don't know what it means
here.  I assume the D3hot/D3cold state of the Root Port is the
critical factor, regardless of how it got there.

> Comparing registers between Linux and Windows 11 this behavior to put
> these specific root ports into D3 at suspend is unique to Linux. On an
> affected system Windows does not put those specific root ports into D3
> over Modern Standby.
> 
> Windows avoids putting Root Ports that are not power manageable (e.g do
> not have platform firmware support) into low power states.

The Windows behavior was probably useful to you in debugging, but I
don't really care about these Windows details because I don't think
they help us maintain this in the future.

> Linux shouldn't assume root ports support D3 just because they're on a
> machine newer than 2015, the ports should also be deemed power manageable.
> Add an extra check explicitly for root ports to ensure D3 isn't selected
> for them if they are not power-manageable through platform firmware.

But I *would* like to know specifically what "power manageable" means
here.  I might naively assume that a device with the PCI Power
Management Capability is "power manageable", and that if PME_Support
includes D3hot and D3cold, we're good to go.  But obviously it's more
complicated than that, and I'd like to cite the spec that mentions the
actual things we need here.

> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Add tags
>  * Fix title
>  * Adjust commit message
> v3->v4:
>  * Move after refactor
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1fa040bcea7..d293db963327 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  	if (dmi_check_system(bridge_d3_blacklist))
>  		return false;
>  
> +	/*
> +	 * It's not safe to put root ports that don't support power
> +	 * management into D3.

I assume "it's not safe" really means "Root Ports in D3hot/D3cold may
not be able to signal PME interrupts unless ... <mumble> platform
firmware <mumble> e.g., ACPI method <mumble> ..."

Can we include some of those hints here?

> +	 */
> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    !platform_pci_power_manageable(bridge))
> +		return false;
> +
>  	/*
>  	 * It should be safe to put PCIe ports from 2015 or newer
>  	 * to D3.
> -- 
> 2.34.1
> 

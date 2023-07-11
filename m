Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861E74FAC6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 00:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGKWOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjGKWOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 18:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF510DD;
        Tue, 11 Jul 2023 15:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6376162D;
        Tue, 11 Jul 2023 22:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58897C433C8;
        Tue, 11 Jul 2023 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113669;
        bh=mtQRBFqPZqhB1NU4Cy2LdD6e119wMclsqM9gkZvti8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rNl7CLezXw3/JUmOr0a8JbgidThlu5VFqtBzEhNr1EZ/0tbhajAIa4OouRYdQJirN
         snngw49Dd0yCUkSfuUMqocfWFmcgY6xXRo63EgaJsAAROJtdL/WKnzvE5TWyb5GVHd
         KHSdBXqMAuJb2CdbeRxn1BNIp9x4meDiQZ5YXi5qBeV3RjBcJ3b7RMIT7yBAcE9Ly2
         9xtj3THhr/LxXjVSenXEP45l2u04t5J7MWgXp6UN1dqOLH5A3KJqcXi2lf4gq4kvUG
         t4H5dhgFztruRBMbBT2mAaJ3AID060UbpyRclpMOxf7xhehyw6T4NPPMN4UcifyUwu
         /Eg3dflxEupKQ==
Date:   Tue, 11 Jul 2023 17:14:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Message-ID: <20230711221427.GA250962@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711005325.1499-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andy, Intel MID stuff]

On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> PCIe ports from modern machines (>2015) are allowed to be put into D3 by
> storing a flag in the `struct pci_dev` structure.

It looks like >= 2015 (not >2015).  I think "a flag" refers to
"bridge_d3".

> pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> decide whether to try to put a device into its target state for a sleep
> cycle via pci_prepare_to_sleep().
> 
> For devices that support D3, the target state is selected by this policy:
> 1. If platform_pci_power_manageable():
>    Use platform_pci_choose_state()
> 2. If the device is armed for wakeup:
>    Select the deepest D-state that supports a PME.
> 3. Else:
>    Use D3hot.
> 
> Devices are considered power manageable by the platform when they have
> one or more objects described in the table in section 7.3 of the ACPI 6.4
> specification.

No point in citing an old version, so please cite ACPI r6.5, sec 7.3.

The spec claims we only need one object from the table for a device to
be "power-managed", but in reality, it looks like the only things that
actually *control* power are _PRx (the _ON/_OFF methods of Power
Resources) and _PSx (ironically only mentioned parenthically).

This matches up well with acpi_pci_power_manageable(), which returns
true if a device has either _PR0 or _PS0.

  Per ACPI r6.5, sec 7.3, ACPI control of device power states uses
  Power Resources (i.e., the _ON/_OFF methods of _PRx) or _PSx
  methods.  Hence acpi_pci_power_manageable() checks for the presence
  of _PR0 or _PS0.

Tangent unrelated to *this* patch: I don't know how to think about the
pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
claim *all* PCI devices, even external ones, are power manageable by
the platform, which doesn't seem right.

> At suspend Linux puts PCIe root ports that are not power manageable by
> the platform into D3hot. Windows only puts PCIe root ports into D3 when
> they are power manageable by the platform.
> 
> The policy selected for Linux to put non-power manageable PCIe root ports
> into D3hot at system suspend doesn't match anything in the PCIe or ACPI
> specs.
> 
> Linux shouldn't assume PCIe root ports support D3 just because
> they're on a machine newer than 2015, the ports should also be considered
> power manageable by the platform.
> 
> Add an extra check for PCIe root ports to ensure D3 isn't selected for
> them if they are not power-manageable through platform firmware.
> This will avoid pci_pm_suspend_noirq() changing the power state
> via pci_prepare_to_sleep().
> 
> The check is focused on PCIe root ports because they are part of
> the platform.  Other PCIe bridges may be connected externally and thus
> cannot impose platform specific limitations.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6->v7:
> * revert back to v5 code, rewrite commit message to specific examples
>   and be more generic
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f916fd76eba79..4be8c6f8f4ebe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  	if (dmi_check_system(bridge_d3_blacklist))
>  		return false;
>  
> +	/*
> +	 * It's not safe to put root ports that aren't power manageable
> +	 * by the platform into D3.

Does this refer specifically to D3cold?

I assume that if we were talking about D3hot, we wouldn't need to
check for ACPI support because D3hot behavior should be fully covered
by the PCIe spec.

Let's be specific about D3hot vs D3cold whenever possible.

> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    !platform_pci_power_manageable(bridge))
> +		return false;

If ACPI says a device is not power-manageable, i.e., ACPI doesn't know
how to put it in D0, it makes sense to return "false" here so we don't
try to put it in D3cold.

But I don't understand the ROOT_PORT check.  We may have a Switch
described via ACPI, and the ROOT_PORT check means we can return "true"
(it's OK to use D3cold) even if the Switch Port is not power-manageable
via ACPI.

>  	/*
>  	 * It should be safe to put PCIe ports from 2015 or newer
>  	 * to D3.
> -- 
> 2.34.1
> 

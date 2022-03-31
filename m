Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819DB4EE39D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiCaV7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiCaV7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 17:59:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66A243702;
        Thu, 31 Mar 2022 14:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05445B82256;
        Thu, 31 Mar 2022 21:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D07CC340ED;
        Thu, 31 Mar 2022 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648763840;
        bh=Zb+U9RFZbesFveucEGN5xYerY69ut491T1TB9y+Q8tI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z6ztIPgXXwcsdnKhOzupVpmZejIJQRW6H7Maubf+hIQILhUQrPMqXy6yn0BUW4YEs
         LJ6jx5NzgN44PuiQirfYBs7vkz3slGoqFPIZfuBEPdeATx7zqacrPTJhjg9EgvPqN1
         27oKqvOtnQWIR0yRpGRKatOfuUADpjLNh81TA24wu8EJ4TDWd+M/4ss8FKPDSlExis
         QXAqkkSdGPrjxuFJ3Nmg09szZmsJDa9x3HH29AxbToLJKkclSCHAw7cN830LsH62/I
         N/rJUIYas8GZgWe283X9B2xB7WqQ46e0wWA4efcoXUfx+/3mtaRApSoAqC/qKgE/27
         +i5IpG19CfegA==
Date:   Thu, 31 Mar 2022 16:57:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
Message-ID: <20220331215716.GA27368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11980172.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If one of the PCIe root ports on Elo i2 is put into D3cold and then
> back into D0, the downstream device becomes permanently inaccessible,
> so add a bridge D3 DMI quirk for that system.
> 
> This was exposed by commit 14858dcc3b35 ("PCI: Use
> pci_update_current_state() in pci_enable_device_flags()"), but before
> that commit the root port in question had never been put into D3cold
> for real due to a mismatch between its power state retrieved from the
> PCI_PM_CTRL register (which was accessible even though the platform
> firmware indicated that the port was in D3cold) and the state of an
> ACPI power resource involved in its power management.

In the bug report you suspect a firmware issue.  Any idea what that
might be?  It looks like a Gemini Lake Root Port, so I wouldn't think
it would be a hardware issue.

Weird how things come in clumps.  Was just looking at Mario's patch,
which also has to do with bridges and D3.

Do we need a Fixes line?  E.g.,

  Fixes: 14858dcc3b35 ("PCI: Use pci_update_current_state() in pci_enable_device_flags()")

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> Reported-by: Stefan Gottwald <gottwald@igel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
>  			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>  			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
>  		},
> +		/*
> +		 * Downstream device is not accessible after putting a root port
> +		 * into D3cold and back into D0 on Elo i2.
> +		 */
> +		.ident = "Elo i2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> +		},

Is this bridge_d3_blacklist[] similar to the PCI_DEV_FLAGS_NO_D3 bit?
Could they be folded together?  We have a lot of bits that seem
similar but maybe not exactly the same (dev->bridge_d3,
dev->no_d3cold, dev->d3cold_allowed, dev->runtime_d3cold,
PCI_DEV_FLAGS_NO_D3, pci_bridge_d3_force, etc.)  Ugh.

bridge_d3_blacklist[] itself was added by 85b0cae89d52 ("PCI:
Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports"),
which honestly looks kind of random, i.e., it doesn't seem to be
working around a hardware or even a firmware defect.

Apparently the X299 issue is that 00:1c.4 is connected to a
Thunderbolt controller, and the BIOS keeps the Thunderbolt controller
powered off unless something is attached to it?  At least, 00:1c.4
leads to bus 05, and in the dmesg log attached to [1] shows no devices
on bus 05.

It also says the platform doesn't support PCIe native hotplug, which
matches what Mika said about it using ACPI hotplug.  If a system is
using ACPI hotplug, it seems like maybe *that* should prevent us from
putting things in D3cold?  How can we know whether ACPI hotplug
depends on a certain power state?

Bjorn

[1] https://bugzilla.kernel.org/show_bug.cgi?id=202031

>  	},
>  #endif
>  	{ }
> 
> 
> 

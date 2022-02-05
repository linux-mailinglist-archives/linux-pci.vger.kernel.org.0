Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DADC4AA7F0
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356871AbiBEJjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 04:39:35 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40639 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiBEJjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Feb 2022 04:39:35 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8C84B100D9411;
        Sat,  5 Feb 2022 10:39:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6D41B2E5C36; Sat,  5 Feb 2022 10:39:33 +0100 (CET)
Date:   Sat, 5 Feb 2022 10:39:33 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] pci: mark USB4 devices as "is_thunderbolt"
Message-ID: <20220205093933.GA29773@wunner.de>
References: <20220204182820.130339-3-mario.limonciello@amd.com>
 <20220204222956.GA220908@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204222956.GA220908@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 04, 2022 at 04:29:56PM -0600, Bjorn Helgaas wrote:
> I've never liked "is_thunderbolt" because it tells us nothing about
> what functionality is of interest, so it's an unmaintainable mess.
> 
> Right now:
> 
>   - We assume Root Ports and Switch Ports marked "is_thunderbolt"
>     support D3 (pci_bridge_d3_possible()).

We don't allow D3 on hotplug bridges because:

		/*
		 * Hotplug ports handled natively by the OS were not validated
		 * by vendors for runtime D3 at least until 2018 because there
		 * was no OS support.
		 */
		if (bridge->is_hotplug_bridge)
			return false;

And we don't allow D3 on older non-hotplug bridges because:

		/*
		 * It should be safe to put PCIe ports from 2015 or newer
		 * to D3.
		 */
		if (dmi_get_bios_year() >= 2015)
			return true;

However we must allow D3 on *Thunderbolt* bridges to take advantage
of power savings.  So the following check is an exception of the
above-stated rules:

		/* Even the oldest 2010 Thunderbolt controller supports D3. */
		if (bridge->is_thunderbolt)
			return true;

This is most likely necessary for AMD Thunderbolt as well, but
could be achieved by adding another check to pci_bridge_d3_possible()
which returns true for the USB4 class.


>   - Downstream Ports marked "is_thunderbolt" don't support native
>     hotplug Command Completed events, even if they claim they do
>     (pcie_init()).

That's a quirk needed for older Thunderbolt controllers.  It could be
replaced by a check for the device IDs listed in 493fb50e958c.

It most likely does not affect AMD Thunderbolt.


>   - Apparently, if *any* device in the system is marked
>     "is_thunderbolt", a GPU external DP port is not fully switchable
>     because ? (gmux_probe()).

This could be replaced by a DMI check for the affected MacBook Pro
models.  Those happen not to possess a Thunderbolt controller,
so checking for Thunderbolt presence seemed simpler and more clever
at the time...

I can produce a list of affected models if you want.

This does not affect AMD Thunderbolt.


>   - Whether an AMD GPU is attached via Thunderbolt tells us something
>     about what sort of power control and runtime power management we
>     can do (amdgpu_driver_load_kms(), radeon_driver_load_kms()).

External eGPUs are not supposed to be managed by vga_switcheroo
(which is only responsible for switching between a chipset-integrated iGPU
and an on-board discrete dGPU), that's what these checks are for.

This does affect AMD Thunderbolt.


>   - We don't register Thunderbolt eGPU devices with VGA switcheroo
>     because ? (nouveau_vga_init(), radeon_device_init()).

Same as above.


>   - If an AMD GPU is attached via Thunderbolt, we program different
>     ASPM time values because ? (nbio_v2_3_enable_aspm()).

That wasn't introduced by me, so not sure what the rationale is.

Let me know if I can help clarify things further so that we can
find a solution that you feel more comfortable with.

Thanks,

Lukas

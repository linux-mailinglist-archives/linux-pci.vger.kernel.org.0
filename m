Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99D54B3A8B
	for <lists+linux-pci@lfdr.de>; Sun, 13 Feb 2022 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiBMJT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 04:19:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiBMJT3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 04:19:29 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA55C344;
        Sun, 13 Feb 2022 01:19:23 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 05A4D2800B3D2;
        Sun, 13 Feb 2022 10:19:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E8C26294C60; Sun, 13 Feb 2022 10:19:20 +0100 (CET)
Date:   Sun, 13 Feb 2022 10:19:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 03/12] PCI: Move check for old Apple Thunderbolt
 controllers into a quirk
Message-ID: <20220213091920.GA15535@wunner.de>
References: <20220211193250.1904843-1-mario.limonciello@amd.com>
 <20220211193250.1904843-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211193250.1904843-4-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 01:32:41PM -0600, Mario Limonciello wrote:
> `pci_bridge_d3_possible` currently checks explicitly for a Thunderbolt
> controller to indicate that D3 is possible.  As this is used solely
> for older Apple systems, move it into a quirk that enumerates across
> all Intel TBT controllers.

I'm not so sure if it is only needed on Apple systems.


> @@ -2954,10 +2960,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_force)
>  			return true;
>  
> -		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> -		if (bridge->is_thunderbolt)
> -			return true;
> -
>  		/* Platform might know better if the bridge supports D3 */
>  		if (platform_pci_bridge_d3(bridge))
>  			return true;

The fact that Thunderbolt PCIe ports support D3 is a property of those
devices.  It's not a property of the platform or a quirk of a particular
vendor.

Hence in my view the current location of the check (pci_bridge_d3_possible())
makes sense wheras the location you're moving it to does not.


> +/* Apple machines as old as 2010 can do D3 with Thunderbolt controllers, but don't specify
> + * it in the ACPI tables
> + */

Apple started shipping Thunderbolt in 2011.
Intel brought the first chips to market in 2010.

The date is meaningful at the code's current location in
pci_bridge_d3_possible() because a few lines further down
there's a 2015 BIOS cut-off date.

Microsoft came up with an ACPI property that BIOS vendors may set
so that Windows knows it may put a Thunderbolt controller into D3cold.
I'm not even sure if that property was ever officially adopted by the
ACPI spec or if it's just a Microsoft-defined "standard".

Apple had been using its own scheme to put Thunderbolt controllers
into D3cold when nothing is plugged in, about a decade before Microsoft
defined the ACPI property.

I'm not sure if other vendors came up with their own schemes to
power-manage Thunderbolt.  We may regress those with the present
patch.

Thanks,

Lukas

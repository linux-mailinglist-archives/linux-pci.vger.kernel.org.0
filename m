Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD84C4CC6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiBYRnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 12:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiBYRnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 12:43:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103747041;
        Fri, 25 Feb 2022 09:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9994AB832D3;
        Fri, 25 Feb 2022 17:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E00C340F0;
        Fri, 25 Feb 2022 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645810946;
        bh=jfHP8ngKi4vi3hByTlvRBRmGbm9iwkShUz8a4jmfoDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n2kvSfc3paE5uL2pMwk1S162tbwbF/72CqdijVqlJrce7vDG9FBy+jqWdaH3istvR
         2VesiPVL/8aE4R3giOSVzAO3EKj1IW4CBrkRgRVWZUgaPbu2sjnyywLMoyrEhhh/TT
         zw93DjlZXGL6IS86ZJmESPcGTiOrZ1UKeC/qikGAW6KDolKQLXnQk3VZRi9Nm7YwsN
         77Y4nmToTJnrlcd410RW94elR9bPMNuiu9cAxoeXUzKhtmgwO0hIEnaa9VldTHz8oU
         5dO9RyjQ6SfjzB9pw3qppG5X0senYPvCFW87hoxmezrQuSXbHr6+RiZZim0B2saAMx
         KriJ61n3uN8fw==
Date:   Fri, 25 Feb 2022 11:42:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 3/7] PCI: Drop the `is_thunderbolt` attribute from PCI
 core
Message-ID: <20220225174224.GA366735@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224215116.7138-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:12PM -0600, Mario Limonciello wrote:
> The `is_thunderbolt` attribute originally had a well defined list of
> quirks that it existed for, but it has been overloaded with more
> meaning.
> 
> Instead use the driver core removable attribute to indicate the
> detail a device is attached to a thunderbolt or USB4 chain.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c               | 2 +-
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  include/linux/pci.h               | 5 ++---
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..1b752d425c47 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1584,7 +1584,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	/* Is the device part of a Thunderbolt controller? */
>  	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
>  	if (vsec)
> -		dev->is_thunderbolt = 1;
> +		dev->external_facing = true;
>  }
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 57553f9b4d1d..4444da0c39b0 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return to_pci_dev(dev)->is_thunderbolt;
> +	return to_pci_dev(dev)->external_facing;
>  }
>  
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1e5b769e42fc..d9719eb14654 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -442,7 +442,6 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
> -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>  	unsigned int	no_cmd_complete:1;	/* Lies about command completed events */
>  
>  	/*
> @@ -2447,11 +2446,11 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  {
>  	struct pci_dev *parent = pdev;
>  
> -	if (pdev->is_thunderbolt)
> +	if (dev_is_removable(&pdev->dev))
>  		return true;
>  
>  	while ((parent = pci_upstream_bridge(parent)))
> -		if (parent->is_thunderbolt)
> +		if (dev_is_removable(&parent->dev))
>  			return true;
>  
>  	return false;

Since you remove this function entirely later, it seems like you might
as well push this to the end of the series, so you won't have to
change it before removing it.

That would just leave the "PCI_VSEC_ID_INTEL_TBT implies external-facing"
assumption above.  Not having a Thunderbolt spec, I have no idea how
you deal with that.

But it is definitely not the case that "dev_is_removable() implies
device is Thunderbolt", so I don't think this last hunk can work.

Bjorn

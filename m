Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460134C3AD5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiBYBYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 20:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiBYBYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 20:24:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6244C225008;
        Thu, 24 Feb 2022 17:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE18DCE21CE;
        Fri, 25 Feb 2022 01:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC8C340E9;
        Fri, 25 Feb 2022 01:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645752229;
        bh=WT9Bxm8hy9Zx9+4uOpWY97MNM6hQYpRoQq/T1hnrs4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C50+Ss5Q8B6EjURcCBRIy/cJHNllf+HiDwblGn44q80pk/g8LPFXaGsNp1Ms+hMwb
         e9WEtVvnwLxTu8UArBuZa6jBZ/ajgdf0E4OiqkEGfVcrehsXRaXRznQQBdpKktAKJd
         n/qT1+2TyV0A9k7thsT6KGnXHzdQr9qHHvxP2xLIix2uC9Yh87yTjFXXP1x2ChiIna
         3VYSqX8pIMhrJerZekdFP9Ml8M+gf15kzW8NffwXIuRhpqnskM3BsVX+dXp8II/J8Q
         u0S0kJI76PBA2395AP3dDfni+E2pF+qYp6kQiJYZvL5lWHP2IlqDfI1Eygmz/NTLP5
         D1apyl5izGSPw==
Date:   Thu, 24 Feb 2022 19:23:46 -0600
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
Message-ID: <20220225012346.GA317859@bhelgaas>
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

I assume there's a spec for the PCI_VSEC_ID_INTEL_TBT Capability.  Is
that public?  Does the spec say that a device with that capability
must be external-facing?

Even if it's not public, I think a citation (name, revision, section)
would be useful.

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

This looks ... sort of weird.  I don't know anything about
apple-gmux.c, so I guess I don't care, but assuming any
external-facing device must be a Thunderbolt device seems like a
stretch.

Ugh.  This is used via "bus_for_each_dev(&pci_bus_type)", which means
it's not hotplug-safe.  I'm sure we "know" implicitly that hotplug
isn't an issue in apple-gmux, but it's better not to have examples
that get copied to places where it *is* an issue.

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

I don't get this.  Plain old PCI devices can be removable, too.

pci_is_thunderbolt_attached() is only used by GPU drivers.  What
property of Thunderbolt do they care about?

nouveau_vga_init() and radeon_device_init() use it to decide to
register with vga_switcheroo.  So maybe that's something to do with
removability?  Of course, that's not specific to Thunderbolt, because
garden-variety PCIe devices are removable.

amdgpu_driver_load_kms() and radeon_driver_load_kms() apparently use
it for something related to power control.  I don't know what the
Thunderbolt connection is.

nbio_v2_3_enable_aspm() looks like it uses it to change some ASPM
parameters.  Seems like potentially a device erratum or quirk
material?

If these things are not specifically related to Thunderbolt, I'd
prefer to get rid of pci_is_thunderbolt_attached() and see if we can
help the GPU folks figure out what they really need.

>  	return false;
> -- 
> 2.34.1
> 

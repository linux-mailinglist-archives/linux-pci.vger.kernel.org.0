Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246E7E21F5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 13:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKFMmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 07:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 07:42:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB3AAD;
        Mon,  6 Nov 2023 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699274530; x=1730810530;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cpxdEtpcZ2PUz94OUq3gxytopBJ1J624EoZVZJrzV38=;
  b=K5eix7OYwMOvydPS7YRFXGUv7pyNjJpXMcmYx/ELWSg4jqsneW1/1APa
   8nZzqSnG49cUKfFNDPvnSHtakpgDE4xXZDLOQO1CnAqhimaNtSlzvymXu
   O9TbuwAdXAYqUXMabDsvts3l7zbTbA6WSR32O1HUSL8se1FpLC+hbtd5a
   tAXndSyvSFRdbwUl0wYvgEizx1qds5EeoqySOrYiU0ukexkbrbZpCMAfc
   5KLIJgDZFhr6NJVLY77N4k5L9ORaacvs+embgXXNTB1D0T64bG4cWOyRe
   4hX/C04xf7FEdYR1m1U1/YkJHxpNr9YZdZce8FQXxwDqOvvkKctiez7CR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392132892"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="392132892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797295909"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="797295909"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:42:01 -0800
Date:   Mon, 6 Nov 2023 14:41:58 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] PCI: pciehp: Move check for is_thunderbolt into
 a quirk
In-Reply-To: <20231103190758.82911-6-mario.limonciello@amd.com>
Message-ID: <e0a74b28-e862-202e-328-9eca3cb622f@linux.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com> <20231103190758.82911-6-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023, Mario Limonciello wrote:

> commit 493fb50e958c ("PCI: pciehp: Assume NoCompl+ for Thunderbolt
> ports") added a check into pciehp code to explicitly set NoCompl+
> for all Intel Thunderbolt controllers, including those that don't
> need it.
> 
> This overloaded the purpose of the `is_thunderbolt` member of
> `struct pci_device` because that means that any controller that
> identifies as thunderbolt would set NoCompl+ even if it doesn't
> suffer this deficiency. As that commit helpfully specifies all the
> controllers with the problem, move them into a PCI quirk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |  6 +-----
>  drivers/pci/quirks.c             | 20 ++++++++++++++++++++
>  include/linux/pci.h              |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fd713abdfb9f..23a92d681d1c 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -991,11 +991,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>  	if (pdev->hotplug_user_indicators)
>  		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
>  
> -	/*
> -	 * We assume no Thunderbolt controllers support Command Complete events,
> -	 * but some controllers falsely claim they do.
> -	 */
> -	if (pdev->is_thunderbolt)
> +	if (pdev->no_command_complete)
>  		slot_cap |= PCI_EXP_SLTCAP_NCCS;
>  
>  	ctrl->slot_cap = slot_cap;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..4bbf6e33ca11 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3807,6 +3807,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
>  			quirk_thunderbolt_hotplug_msi);
>  
> +/*
> + * We assume no Thunderbolt controllers support Command Complete events,
> + * but some controllers falsely claim they do.

IMO, this wording makes little sense with the new code. How about taking 
some text from the original commit's changelog:

/*
 * Certain Thunderbolt 1 controllers falsely claim to support Command 
 * Completed events.
 */

The code change looks fine.

-- 
 i.

> + */
> +static void quirk_thunderbolt_command_complete(struct pci_dev *pdev)
> +{
> +	pdev->no_command_complete = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
> +			quirk_thunderbolt_command_complete);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EAGLE_RIDGE,
> +			quirk_thunderbolt_command_complete);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_PEAK,
> +			quirk_thunderbolt_command_complete);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
> +			quirk_thunderbolt_command_complete);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_2C,
> +			quirk_thunderbolt_command_complete);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
> +			quirk_thunderbolt_command_complete);
>  #ifdef CONFIG_ACPI
>  /*
>   * Apple: Shutdown Cactus Ridge Thunderbolt controller.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 530b0a360514..439c2dac8a3e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -441,6 +441,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	no_command_complete:1;	/* No command completion */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> 


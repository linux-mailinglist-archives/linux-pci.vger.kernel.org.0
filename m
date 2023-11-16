Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F47EE0B1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 13:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjKPMao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 07:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbjKPMam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 07:30:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252ECD4B;
        Thu, 16 Nov 2023 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700137838; x=1731673838;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Zb8EkOCoEXSVYt6JBVTP/C88txRSmKBaT8vzI6Rweaw=;
  b=CXEf3kVFbyCfn2/Npb9aQwtAyGEoZnu09487ec8dN4o0ASVj4sYa714V
   xj54azKzxiILd3rc0TXAHRtDErwby/VtKiIcIOeaZ4dPu6elXG+RvVjX3
   hxPZH/cqZYpNhse8Y/swYaOrmaS7McNo8n0PR6YhMqwC+BgElenGz4AT4
   +FWvtq3So/sptLGoqfIAb6yDRcPLaHWIaUixbCJKYovJrstkbT92XL5iP
   p/PA4b7QJraXAnVXWf0kuODgSZzvUSCb/AFSF+vy047CqCVZo06rb03Vk
   Oxnh3f58rqlBCeyGtE9U1iOlyLdUaclPIVG7x6XHuveb2hGFv0p4zeELZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393930201"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="393930201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="835736305"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="835736305"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:30:31 -0800
Date:   Thu, 16 Nov 2023 14:30:28 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] PCI: pciehp: Move check for is_thunderbolt into
 a quirk
In-Reply-To: <20231114200755.14911-5-mario.limonciello@amd.com>
Message-ID: <8ade60ab-881b-8046-5d3a-ad82fe16d49@linux.intel.com>
References: <20231114200755.14911-1-mario.limonciello@amd.com> <20231114200755.14911-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-35208055-1700137836=:1886"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-35208055-1700137836=:1886
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2023, Mario Limonciello wrote:

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
> v2->v3:
>  * Reword commit message
>  * Update comments
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |  6 +-----
>  drivers/pci/quirks.c             | 20 ++++++++++++++++++++
>  include/linux/pci.h              |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index b1d0a1b3917d..40f7a26fb98f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -992,11 +992,7 @@ struct controller *pcie_init(struct pcie_device *dev)
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
> index ea476252280a..fa9b82cd7b3b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3809,6 +3809,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
>  			quirk_thunderbolt_hotplug_msi);
>  
> +/*
> + * Certain Thunderbolt 1 controllers falsely claim to support Command
> + * Completed events.
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
> index 1fbca2bd92e8..20a6e4fc3060 100644
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-35208055-1700137836=:1886--

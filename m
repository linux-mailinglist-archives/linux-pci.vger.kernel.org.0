Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457077FFEA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355358AbjHQVau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 17:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355352AbjHQVaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 17:30:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF0E55
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307820; x=1723843820;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=4nQJLbrLCKBZH8pX5WUv14hyFjbYnktS62hlNy8+X78=;
  b=JAUcaIqT2p3qHVucE54YBFDyC8Md8MPD+xooIV6XawvgVEqniacarpst
   ha1GWX5eTf1LEJdhYzwiZTtIICCxudB2lgXnjHNz866iJnh/fVA2pSXzz
   yNUIiwgHAmHE5UArNCKHiZPJkSr1vtDVb9xalJ0aFzsCEBSsvrroW6UJd
   XNaTGf2tYgtk6SsjfGlIibUFNjGrbMFZoXiPfB9uHe0ZlGA4G//PJfzUd
   fGUZg3amI5DgRc6ylY8CITXYdmSKEnrZkeu3+DM81b5vGQpGnn9NplFwU
   sv/GcHMDggFYnNtqWKvQ4gp6liQU/+pplHKuvUDY/6Bo2AHyNTR/dlCW/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352523327"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="352523327"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737863785"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="737863785"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.53]) ([10.78.16.53])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:30:19 -0700
Message-ID: <bd274253-636a-4868-b4d0-bad80bdd0a48@linux.intel.com>
Date:   Thu, 17 Aug 2023 14:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Do not change the Hotplug setting on VMD
 rootports
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
Content-Language: en-US
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/24/2023 8:54 PM, Nirmal Patel wrote:
> The hotplug functionality is broken in various combinations of guest
> OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.
>
> During the VMD rootport creation, VMD honors ACPI settings and assigns
> respective values to Hotplug, AER, DPC, PM etc which works in case of
> Host OS. But these have been restored back to the power on default
> state in Guest OSes, which puts the root port hot plug enable to
> default OFF.
>
> When BIOS boots, all root ports under VMD is inaccessible by BIOS and
> they maintain their power on default states. The VMD UEFI driver loads
> and configure all devices under VMD. This is how AER, power management,
> DPC and hotplug gets enabled in UEFI, since the BIOS pci driver cannot
> access the root ports. With the absence of VMD UEFI driver in Guest,
> Hotplug stays Disabled.
>
> This change will  cause the hot plug to start working again in guest,
> as the settings implemented by the UEFI VMD DXE driver will remain in
> effect in the Guest OS.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..52c2461b4761 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  				       struct pci_host_bridge *vmd_bridge)
>  {
> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>  	vmd_bridge->native_aer = root_bridge->native_aer;
>  	vmd_bridge->native_pme = root_bridge->native_pme;
>  	vmd_bridge->native_ltr = root_bridge->native_ltr;

Gentle ping!

Thanks.


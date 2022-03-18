Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF94DD4E3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 07:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiCRGui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 02:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiCRGuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 02:50:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D917586B;
        Thu, 17 Mar 2022 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647586158; x=1679122158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYf7H+zfZsWDggOzPC1KjFaiFOBNQv1b5Be/sCd1Hl8=;
  b=emNnLO4Ox0tOJOCCeBN7arfEL/1RgKXC3fxI/ARsW9tfVgqdPz7oeoHY
   uCIRy3gxgv1KrrMsk/onIl+Ig0e+1MNpg77GI3NOJtbJ/+9SV5PCB9I+/
   t2uXPMLZHxuzxWVVixkBqxFhJvwMcNwMnC4M3jvEZ3arlT/rLUnyxOSN3
   AKvoxBUXIYXTJ2DoIxORrCKv20zJbIjaik7BarAVI3uEzehizDHU8TLAB
   vhFrwjyJaa21Y2TdnAtytP00KcR5l2GyGqGibMeYTt7pfpDRCxDG5dLc2
   pZr2EFzlaV7zLc975rWzOdmdfakUNCjnNW04fmPUkyWHYIK+4FdtKFhwD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239233969"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="239233969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:49:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="499128327"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:49:14 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 08:44:51 +0200
Date:   Fri, 18 Mar 2022 08:44:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjQqY/Nq0pgpcAaI@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin,

Thanks for working on this!

On Thu, Mar 17, 2022 at 04:17:07PM +0000, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. What
> actually matters is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.

We still want to know that DMAR_PLATFORM_OPT_IN is set by the firmware
because that tells us that none of the devices connected before OS got
control had the ability to perform DMA outside of the RMRR regions. If
they did then all this is pointless because they could have modified the
system memory as they wished.

> Avoid false positives by looking as close as possible to the same PCI
> topology that the IOMMU layer will consider once a Thunderbolt endpoint
> appears. Crucially, we can't assume that IOMMU translation being enabled
> for any reason is sufficient on its own; full (expensive) DMA protection
> will still only be imposed on untrusted devices.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This supersedes my previous attempt just trying to replace
> iommu_present() at [1], further to the original discussion at [2].
> 
> [1] https://lore.kernel.org/linux-iommu/BL1PR12MB515799C0BE396377DBBEF055E2119@BL1PR12MB5157.namprd12.prod.outlook.com/T/
> [2] https://lore.kernel.org/linux-iommu/202203160844.lKviWR1Q-lkp@intel.com/T/
> 
>  drivers/thunderbolt/domain.c | 12 +++---------
>  drivers/thunderbolt/nhi.c    | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..d5c825e84ac8 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +
> +	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);
>  }
>  static DEVICE_ATTR_RO(iommu_dma_protection);
>  
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index c73da0532be4..e12c2e266741 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> @@ -1102,6 +1103,39 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>  		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
>  }
>  
> +static void nhi_check_iommu(struct tb_nhi *nhi)
> +{
> +	struct pci_dev *pdev;
> +	bool port_ok = false;


So for here somewhere we should call dmar_platform_optin() first. I
think this is something we want to move inside the IOMMU API (alongside
with the below checks).

> +
> +	/*
> +	 * Check for sibling devices that look like they should be our
> +	 * tunnelled ports. We can reasonably assume that if an IOMMU is
> +	 * managing the bridge it will manage any future devices beyond it
> +	 * too. If firmware has described a port as external-facing as
> +	 * expected then we can trust the IOMMU layer to enforce isolation;
> +	 * otherwise even if translation is enabled for existing devices it
> +	 * may potentially be overridden for a future tunnelled endpoint.
> +	 */
> +	for_each_pci_bridge(pdev, nhi->pdev->bus) {
> +		if (!pci_is_pcie(pdev) ||
> +		    !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> +			continue;
> +
> +		if (!device_iommu_mapped(&pdev->dev))
> +			return;
> +
> +		if (!pdev->untrusted) {
> +			dev_info(&nhi->pdev->dev,
> +				 "Assuming unreliable Kernel DMA protection\n");
> +			return;
> +		}
> +		port_ok = true;
> +	}
> +	nhi->iommu_dma_protection = port_ok;
> +}
> +
>  static int nhi_init_msi(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *pdev = nhi->pdev;
> @@ -1219,6 +1253,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	nhi_check_quirks(nhi);
> +	nhi_check_iommu(nhi);
>  
>  	res = nhi_init_msi(nhi);
>  	if (res) {
> diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
> index 124e13cb1469..7a8ad984e651 100644
> --- a/include/linux/thunderbolt.h
> +++ b/include/linux/thunderbolt.h
> @@ -465,6 +465,7 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
>   * @msix_ida: Used to allocate MSI-X vectors for rings
>   * @going_away: The host controller device is about to disappear so when
>   *		this flag is set, avoid touching the hardware anymore.
> + * @iommu_dma_protection: An IOMMU will isolate external-facing ports.
>   * @interrupt_work: Work scheduled to handle ring interrupt when no
>   *		    MSI-X is used.
>   * @hop_count: Number of rings (end point hops) supported by NHI.
> @@ -479,6 +480,7 @@ struct tb_nhi {
>  	struct tb_ring **rx_rings;
>  	struct ida msix_ida;
>  	bool going_away;
> +	bool iommu_dma_protection;
>  	struct work_struct interrupt_work;
>  	u32 hop_count;
>  	unsigned long quirks;
> -- 
> 2.28.0.dirty

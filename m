Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECF4DD910
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 12:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiCRLjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiCRLjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 07:39:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8F3BA51;
        Fri, 18 Mar 2022 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647603513; x=1679139513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5FuuxYpqH/foZrUx6QBGb2sEHLyW+YILMLdMR3/lLY=;
  b=UdcHY4lFrc6YZ5buTbNuEZJKGDN+g+p2NlYtctdBIg8KU0HsH0MSMGcg
   CCT/rkcoqqzcgVmn7Pvuz8NoCPv8ujMRFSgfjnxM1bqV/Ca5hNYvoLl7H
   gBwuU97/rEt2DfMLQq1yl6VCZW+N8W3R9vKNOLBqIC3YIy6bENrG0D8sR
   KjfxUsIGG1bOJY47fFI5b4J3DewTZbNgtPK9lUWB/iHCYntFPOi5LTYCM
   fcUavqx8ZNxAxFL+2NpS0AHa6Q+UmiChAxzhCU+vFHzSQKUA0A0YgEeNb
   kL4dAjJZD30bRqg9DNz1kCe4m/Okg+kztKMRktIG+eeUDIDOeyKlnZNEE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237730982"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237730982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 04:38:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558393589"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 04:38:29 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 13:38:26 +0200
Date:   Fri, 18 Mar 2022 13:38:26 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjRvMk1kcbMwJvx+@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

On Thu, Mar 17, 2022 at 08:36:13PM +0000, Limonciello, Mario wrote:
> Here is a proposal on top of what you did for this.  
> The idea being check the ports right when the links are made if they exist 
> (all the new USB4 stuff) and then check all siblings on TBT3 stuff.
> 
> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
> index 79b5abf9d042..89432456dbea 100644
> --- a/drivers/thunderbolt/acpi.c
> +++ b/drivers/thunderbolt/acpi.c
> @@ -14,6 +14,7 @@
>  static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>                                     void **return_value)
>  {
> +       enum nhi_iommu_status iommu_status = IOMMU_UNKNOWN;
>         struct fwnode_reference_args args;
>         struct fwnode_handle *fwnode;
>         struct tb_nhi *nhi = data;
> @@ -91,6 +92,8 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>                 if (link) {
>                         dev_dbg(&nhi->pdev->dev, "created link from %s\n",
>                                 dev_name(&pdev->dev));
> +                       if (iommu_status != IOMMU_DISABLED)
> +                               iommu_status = nhi_check_iommu_for_port(pdev);
>                 } else {
>                         dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
>                                  dev_name(&pdev->dev));
> @@ -101,6 +104,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
> 
>  out_put:
>         fwnode_handle_put(args.fwnode);
> +       nhi->iommu_dma_protection = (iommu_status == IOMMU_ENABLED);
>         return AE_OK;
>  }
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index e12c2e266741..b5eb0cab392f 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1103,10 +1103,30 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>                 nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
>  }
> 
> +enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev)
> +{
> +       if (!pci_is_pcie(pdev) ||
> +           !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> +            pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +               return IOMMU_UNKNOWN;
> +       }
> +
> +       if (!device_iommu_mapped(&pdev->dev)) {
> +               return IOMMU_DISABLED;
> +       }
> +
> +       if (!pdev->untrusted) {
> +               dev_info(&pdev->dev,
> +                       "Assuming unreliable Kernel DMA protection\n");
> +               return IOMMU_DISABLED;
> +       }
> +       return IOMMU_ENABLED;
> +}
> +
>  static void nhi_check_iommu(struct tb_nhi *nhi)
>  {
> -       struct pci_dev *pdev;
> -       bool port_ok = false;
> +       enum nhi_iommu_status iommu_status = nhi->iommu_dma_protection ?
> +                                       IOMMU_ENABLED : IOMMU_UNKNOWN;
> 
>         /*
>          * Check for sibling devices that look like they should be our
> @@ -1117,23 +1137,13 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
>          * otherwise even if translation is enabled for existing devices it
>          * may potentially be overridden for a future tunnelled endpoint.
>          */
> -       for_each_pci_bridge(pdev, nhi->pdev->bus) {
> -               if (!pci_is_pcie(pdev) ||
> -                   !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> -                     pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> -                       continue;
> -
> -               if (!device_iommu_mapped(&pdev->dev))
> -                       return;
> -
> -               if (!pdev->untrusted) {
> -                       dev_info(&nhi->pdev->dev,
> -                                "Assuming unreliable Kernel DMA protection\n");
> -                       return;
> -               }
> -               port_ok = true;
> +       if (iommu_status == IOMMU_UNKNOWN) {
> +               struct pci_dev *pdev;
> +               for_each_pci_bridge(pdev, nhi->pdev->bus)
> +                       if (iommu_status != IOMMU_DISABLED)
> +                               iommu_status = nhi_check_iommu_for_port(pdev);
>         }
> -       nhi->iommu_dma_protection = port_ok;
> +       nhi->iommu_dma_protection = (iommu_status == IOMMU_ENABLED);
>  }
> 
>  static int nhi_init_msi(struct tb_nhi *nhi)
> 
> diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
> index 69083aab2736..1622d49b1763 100644
> --- a/drivers/thunderbolt/nhi.h
> +++ b/drivers/thunderbolt/nhi.h
> @@ -11,6 +11,13 @@
> 
>  #include <linux/thunderbolt.h>
> 
> +enum nhi_iommu_status {
> +       IOMMU_UNKNOWN,
> +       IOMMU_DISABLED,
> +       IOMMU_ENABLED,
> +};
> +enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev);
> +

This adds quite a lot code and complexity, and honestly I would like to
keep it as simple as possible (and this is not enough because we need to
make sure the DMAR bit is there so that none of the possible connected
devices were able to overwrite our memory already).

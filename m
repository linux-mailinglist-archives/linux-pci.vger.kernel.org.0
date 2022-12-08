Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA27646752
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 03:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLHC4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 21:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLHC4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 21:56:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E54B5B5AF;
        Wed,  7 Dec 2022 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670468201; x=1702004201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ghhfzdKqDWyzvVgFa6iLW+Gcu3nztPR5Gp+3f2Uy3a4=;
  b=HGUsViS4unm6huJZqZSuIXGlCaYN5Q8wTP4C4v3CWe/UTCzv13kU0gSq
   QMpotEfWhv+6l6R4B1klIILcBZD5un+bbMwF2Wl46wxgzOpYb7TlA5HxP
   OhEo4wdnLpqJAYxSxXS1p60Z/9T/bdY2SFlGi9FP0zXihODfG+m4VVdfO
   vfKfMT6fhLDI3quo63CM7w6eQMSQ3xY5FTEIMR0MwLiKoAAk+TJ9k0S0Q
   eHVoewcqygZMnSsuNigQuyN3X6+oZjyEvcVroVAno1ZhOWQ/VVqJvXKh8
   eq61Fi9pGcEbiUfXcc2awLrB4QcrTuBccohZsyGIHO1AHYdD1c/T3Xzcp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314704195"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="314704195"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:56:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975690055"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="975690055"
Received: from gjalliso-mobl.amr.corp.intel.com (HELO [10.212.135.231]) ([10.212.135.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:56:39 -0800
Message-ID: <4d0d03c0-2880-1b90-ea94-e36d581ca040@linux.intel.com>
Date:   Wed, 7 Dec 2022 18:56:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V9 2/4] PCI: vmd: Use PCI_VDEVICE in device list
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208023942.491721-1-david.e.box@linux.intel.com>
 <20221208023942.491721-3-david.e.box@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221208023942.491721-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/7/22 6:39 PM, David E. Box wrote:
> Refactor the PCI ID list to use PCI_VDEVICE.

Add some info about why it is done.

> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
>  V9 - No change
> 
>  V8 - No change
> 
>  V7 - New Patch. Separate patch suggested by Lorenzo
> 
>  drivers/pci/controller/vmd.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..9dedca714c18 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -994,33 +994,33 @@ static int vmd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>  
>  static const struct pci_device_id vmd_ids[] = {
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> +	{PCI_VDEVICE(INTEL, 0x467f),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> +	{PCI_VDEVICE(INTEL, 0x4c3d),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
> +	{PCI_VDEVICE(INTEL, 0xa77f),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7d0b),
> +	{PCI_VDEVICE(INTEL, 0x7d0b),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xad0b),
> +	{PCI_VDEVICE(INTEL, 0xad0b),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_OFFSET_FIRST_VECTOR,},

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

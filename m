Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23A630C3F
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 06:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiKSFrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 00:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKSFrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 00:47:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD186FFC;
        Fri, 18 Nov 2022 21:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668836849; x=1700372849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kUZ4ZpWSa5gxjteKneIYtC+SJvGoLa4/s6wBAZos9mU=;
  b=SgxJMs7ns5woJ3u/Vt0n7usU2Eo6I3DEARimSB4uN/h0wlnpf832dI/3
   uku+0/nDhsLO6lhO8K3saoztihnxckN6NHpzznnvI7bN3J4RVUq0tA3h9
   1vx5UldBSrELETa8UAvxP2dYrwN79mSX1WEYk0YhsCfm7DxNdpunrMMsv
   cnhuQeIQbsIafgDRmgctyHyn6QhqJYOuyUtSoeCgG3duk9XEbteloir0v
   jNkPePRBg+b8Rl9RV1Lb8njGk64uMT7h7RGcAArcgvbKIJ6qLtmMVz0cU
   L6WeROBsXgheVe87hC3VR1hAQz2r25Pcru6Ks9TsH/iwSPVawu+tUajA9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375440251"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375440251"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 21:47:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="673439851"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="673439851"
Received: from alsoller-mobl1.amr.corp.intel.com (HELO [10.212.166.83]) ([10.212.166.83])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 21:47:29 -0800
Message-ID: <a4671c99-4d7f-ca80-e3fd-2042de4fed62@linux.intel.com>
Date:   Fri, 18 Nov 2022 21:47:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH V8 RESEND 3/4] PCI: vmd: Create feature grouping for
 client products
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119021411.1383248-1-david.e.box@linux.intel.com>
 <20221119021411.1383248-4-david.e.box@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221119021411.1383248-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/18/22 6:14 PM, David E. Box wrote:
> Simplify the device ID list by creating a grouping of features shared by
> client products.
> 
> Suggested-by: Jon Derrick <jonathan.derrick@linux.dev>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  V8 - New patch.
> 
>  drivers/pci/controller/vmd.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9dedca714c18..86f3085db014 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -68,6 +68,10 @@ enum vmd_features {
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>  };
>  
> +#define VMD_FEATS_CLIENT	(VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |	\
> +				 VMD_FEAT_HAS_BUS_RESTRICTIONS |	\
> +				 VMD_FEAT_OFFSET_FIRST_VECTOR)
> +
>  static DEFINE_IDA(vmd_instance_ida);
>  
>  /*
> @@ -1001,29 +1005,17 @@ static const struct pci_device_id vmd_ids[] = {
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
>  	{PCI_VDEVICE(INTEL, 0x467f),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0x4c3d),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0xa77f),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0x7d0b),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0xad0b),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

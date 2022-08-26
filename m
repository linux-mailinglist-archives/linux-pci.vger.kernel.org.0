Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B305A23E7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHZJPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiHZJPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 05:15:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0BBC80F;
        Fri, 26 Aug 2022 02:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4D3CB8300D;
        Fri, 26 Aug 2022 09:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDAC433D6;
        Fri, 26 Aug 2022 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661505332;
        bh=9AhPT9k1tXyM7Ex7xX37h4PGpYHrw27Da5ufXwHFroQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SS0g6pAhDcUXmHDXUuoJYXQugRLhNxAMG6WUxEKoMfiYj4H/2RgjSNb6QOFeFnFhw
         L7JfOBe6T5v+oZLQT/NS5orBUq5XYZmC9A7GmaZBNooGrVXY+H0k9mcbRjS2rXeJbo
         Z9me7oyRPUUx8EccB/bxGq/fywc1z9imkivYBUSWOd/1nf7opx0xe9GAyXBoKyhX1a
         jPrSsY0ct+2jiSK3TXU8tRCLs6xtIDrQ/lFQ1d3byE2LthFwQ+F1nmllVK5LBznx9j
         T954/J5ApjbLVaEj5QqgxIcXBQ8YZmlyFCoholKjyeYQDVkFy/8wJT3IWsBsk2mTRB
         vWarelbCF+Flw==
Date:   Fri, 26 Aug 2022 11:15:24 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 2/3] PCI: vmd: Add vmd_device_data
Message-ID: <YwiPLH3ud/+bysi5@lpieralisi>
References: <20220301041943.2935892-1-david.e.box@linux.intel.com>
 <20220301041943.2935892-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301041943.2935892-3-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 08:19:42PM -0800, David E. Box wrote:
> Add vmd_device_data to allow adding additional info for driver data. Also
> refactor the PCI ID list to use PCI_VDEVICE.

I think this must be two patches, (1) conversion to PCI_VDEVICE
and (2) vmd_device_data.

Thanks,
Lorenzo

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  V6
>    - Inline the declarations for driver data in the vmd_ids list.
>      Suggested by Jonathan
>  V5
>    - New patch
> 
>  drivers/pci/controller/vmd.c | 76 ++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..cde6e2cba210 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -69,6 +69,10 @@ enum vmd_features {
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>  };
>  
> +struct vmd_device_data {
> +	enum vmd_features features;
> +};
> +
>  static DEFINE_IDA(vmd_instance_ida);
>  
>  /*
> @@ -710,11 +714,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>  	vmd_bridge->native_dpc = root_bridge->native_dpc;
>  }
>  
> -static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> +static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
>  	struct resource *res;
>  	u32 upper_bits;
> +	unsigned long features = info->features;
>  	unsigned long flags;
>  	LIST_HEAD(resources);
>  	resource_size_t offset[2] = {0};
> @@ -881,7 +886,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> -	unsigned long features = (unsigned long) id->driver_data;
> +	struct vmd_device_data *info = (struct vmd_device_data *)id->driver_data;
> +	unsigned long features = info->features;
>  	struct vmd_dev *vmd;
>  	int err;
>  
> @@ -925,7 +931,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
> -	err = vmd_enable_domain(vmd, features);
> +	err = vmd_enable_domain(vmd, info);
>  	if (err)
>  		goto out_release_instance;
>  
> @@ -994,29 +1000,47 @@ static int vmd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>  
>  static const struct pci_device_id vmd_ids[] = {
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa77f),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> -	{0,}
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
> +		},
> +	},
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
> +		},
> +	},
> +	{ PCI_VDEVICE(INTEL, 0x467f),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		},
> +	},
> +	{ PCI_VDEVICE(INTEL, 0x4c3d),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		},
> +	},
> +	{ PCI_VDEVICE(INTEL, 0xa77f),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		},
> +	},
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> +		(kernel_ulong_t)&(struct vmd_device_data) {
> +			.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +		},
> +	},
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
>  
> -- 
> 2.25.1
> 
> 

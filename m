Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD94BC1C0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiBRVUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 16:20:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBRVUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 16:20:04 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A761D6;
        Fri, 18 Feb 2022 13:19:46 -0800 (PST)
Message-ID: <366a9602-555f-7a1b-a8db-bbcbf84b7b08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645219184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/Sth3fu7bm5ISYgjUl7PqmHSSRtqXyNCYwXP4ToBV0=;
        b=TYPxEPDn2jcrQLSE8u1I21z8jH93cRkqLe8o/9VoibemK6t5OWxdcorA5LNYgolyEeqAyb
        dLABZE2f3R7cHvEo367GFkSpem3whgcRTmrgBaEU12N24uFaUqY4ZGaGYH6xIlcFpS1heP
        XwOal3xeVdt73QCmhrrMwlWAC+nJoPk=
Date:   Fri, 18 Feb 2022 14:19:20 -0700
MIME-Version: 1.0
Subject: Re: [PATCH V5 2/3] PCI: vmd: Add vmd_device_data
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218045056.333799-1-david.e.box@linux.intel.com>
 <20220218045056.333799-3-david.e.box@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220218045056.333799-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On 2/17/2022 9:50 PM, David E. Box wrote:
> Add vmd_device_data to allow adding additional info for driver data. Also
> refactor the PCI ID list to use PCI_VDEVICE and simplify assignments for
> devices that use the same driver_data.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V5
>    - New patch
> 
>   drivers/pci/controller/vmd.c | 58 ++++++++++++++++++++----------------
>   1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..a582c351b461 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -69,6 +69,10 @@ enum vmd_features {
>   	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
>   };
>   
> +struct vmd_device_data {
> +	enum vmd_features features;
> +};
> +
>   static DEFINE_IDA(vmd_instance_ida);
>   
>   /*
> @@ -710,11 +714,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>   	vmd_bridge->native_dpc = root_bridge->native_dpc;
>   }
>   
> -static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> +static int vmd_enable_domain(struct vmd_dev *vmd, struct vmd_device_data *info)
>   {
>   	struct pci_sysdata *sd = &vmd->sysdata;
>   	struct resource *res;
>   	u32 upper_bits;
> +	unsigned long features = info->features;
>   	unsigned long flags;
>   	LIST_HEAD(resources);
>   	resource_size_t offset[2] = {0};
> @@ -881,7 +886,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>   
>   static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   {
> -	unsigned long features = (unsigned long) id->driver_data;
> +	struct vmd_device_data *info = (struct vmd_device_data *)id->driver_data;
> +	unsigned long features = info->features;
>   	struct vmd_dev *vmd;
>   	int err;
>   
> @@ -925,7 +931,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   
>   	spin_lock_init(&vmd->cfg_lock);
>   	pci_set_drvdata(dev, vmd);
> -	err = vmd_enable_domain(vmd, features);
> +	err = vmd_enable_domain(vmd, info);
>   	if (err)
>   		goto out_release_instance;
>   
> @@ -993,30 +999,30 @@ static int vmd_resume(struct device *dev)
>   #endif
>   static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>   
> +static const struct vmd_device_data vmd_201d_data = {
> +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,
> +};
> +
> +static const struct vmd_device_data vmd_28c0_data = {
> +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW |
> +		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +		    VMD_FEAT_CAN_BYPASS_MSI_REMAP,
> +};
> +
> +static const struct vmd_device_data vmd_467f_data = {
> +	.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +		    VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +		    VMD_FEAT_OFFSET_FIRST_VECTOR,
> +};
> +

I'm not the biggest fan of this structure
Can you inline the declarations into the vmd_ids table below?



>   static const struct pci_device_id vmd_ids[] = {
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
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D), (kernel_ulong_t)&vmd_201d_data },
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0), (kernel_ulong_t)&vmd_28c0_data },
> +	{ PCI_VDEVICE(INTEL, 0x467f), (kernel_ulong_t)&vmd_467f_data },
> +	{ PCI_VDEVICE(INTEL, 0x4c3d), (kernel_ulong_t)&vmd_467f_data },
> +	{ PCI_VDEVICE(INTEL, 0xa77f), (kernel_ulong_t)&vmd_467f_data },
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B), (kernel_ulong_t)&vmd_467f_data },
> +	{ }

For instance:
{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_201D), (kernel_ulong_t)&(struct vmd_device_data) {
							.features = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,


>   };
>   MODULE_DEVICE_TABLE(pci, vmd_ids);
>   

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1676BF45D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCQVhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 17:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjCQVg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 17:36:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E3049898;
        Fri, 17 Mar 2023 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679088941; x=1710624941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p8BFbONHc7WqCzZIsrm1QJI48QM17cOqjlYx5rUU83M=;
  b=htGBf4VfbREFIEH2xqQuTjV+2AkmusrecI9SU2jXmxW2Q4FrMBFuxiQS
   TfcsaCHdTjsm92LvigQJ2jQI3dQY/Ae5Ho1QyB39wLFJ+VIaAcUgG9t8i
   K1ZADsmsCnVjZIEcsrBF32e6/FbVG270dR7Q7PQvvbGwJOe86mFFlYB48
   NRkfx64mNudnpAH0Q71pT8gdIOlHUIJij9lwxaJO7IU9fQ/kG56XKn/qC
   FZeQ5nPACLs7FM1LnP2A11O3EYqo+W2u2Asru40pn8d5fZRFnuWEISGr7
   O5yToCIXT5koeR05AM8559tDOOwIWnBP+XzCcI04FlkArrbs3LBcYxqHm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="403237078"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="403237078"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 14:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804244454"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804244454"
Received: from fcvilla-mobl1.amr.corp.intel.com (HELO [10.209.177.176]) ([10.209.177.176])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 14:31:50 -0700
Message-ID: <44b1519b-f9e0-476a-ff47-8d21f004b3cd@linux.intel.com>
Date:   Fri, 17 Mar 2023 14:31:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] PCI: vmd: Add the module param to adjust MSI mode
Content-Language: en-US
To:     korantwork@gmail.com, helgaas@kernel.org, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20230316122322.339316-1-korantwork@gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230316122322.339316-1-korantwork@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/16/2023 5:23 AM, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
>
> In the legacy, the vmd MSI mode can only be adjusted by configing

configuring

> vmd_ids table. This patch adds another way to adjust MSI mode by
> adjusting module param, which allow users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver. There are two
> params could be recognized: on, off. The default param is NULL,
> the goal is not to effect the existing settings of the device.
>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..fb61181baa9e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,19 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +/*
> + * The VMD msi_remap module parameter provides the alternative way
> + * to adjust MSI mode when loading vmd.ko other than vmd_ids table.
> + * There are two params could be recognized:
> + *
> + * off: enable MSI bypass

What about this?
off: disable MSI remapping

> + * on: enable MSI remapping
> + *
> + */
> +static char *msi_remap;
> +module_param(msi_remap, charp, 0444);
> +MODULE_PARM_DESC(msi_remap, "Whether to enable MSI remapping function");
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -875,6 +888,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			return ret;
>  
>  		vmd_set_msi_remapping(vmd, true);
> +		dev_info(&vmd->dev->dev, "init vmd with remapping MSI\n");
>  
>  		ret = vmd_create_irq_domain(vmd);
>  		if (ret)
> @@ -887,6 +901,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
>  	} else {
>  		vmd_set_msi_remapping(vmd, false);
> +		dev_info(&vmd->dev->dev, "init vmd with bypass MSI\n");
>  	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
> @@ -955,6 +970,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	return 0;
>  }
>  
> +static void vmd_config_msi_remap_param(unsigned long *features)
> +{
> +	if (msi_remap) {
> +		if (strcmp(msi_remap, "on") == 0)
> +			*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
> +		else if (strcmp(msi_remap, "off") == 0)
> +			*features |= VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +	}
> +}
> +
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
> @@ -984,6 +1009,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (err < 0)
>  		goto out_release_instance;
>  
> +	vmd_config_msi_remap_param(&features);
> +
>  	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
>  	if (!vmd->cfgbar) {
>  		err = -ENOMEM;

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Thanks


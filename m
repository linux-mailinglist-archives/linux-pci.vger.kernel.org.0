Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86F96B15AF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCHW50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCHW5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 17:57:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A4CD674;
        Wed,  8 Mar 2023 14:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 325E3CE21E5;
        Wed,  8 Mar 2023 22:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BA4C433EF;
        Wed,  8 Mar 2023 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678316240;
        bh=Vlvn8CfBYizVQlVUd+yCpK3GnQGiqG3oOT5tnHgDjXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d7xnvR229RhW7YOMcKr4+DOZ/iEdVNp9dUw8rYV3O6DQ6eKjp32bcmxiQKq+eN5Is
         ADfYUISgRX61tRsXnm7gsr/YbRrzetF2sS4mbsHa88L3HMIkT0z1ddpfKYuBgszLdq
         qHv3Et3UWC+BtDHPX83xQkkfwuf7KnzRf7tKXqO9cELUnwlv93nXtM7z2q7C+oiE1D
         kRWDfg8QOnGacMC/zXGNhNUMzVBPVVHZ/5DDC58RvnBK5dhkXYM0AQZp3dRzmwPboP
         xU8+MxtOb3EiR8QBzxvMgl3YNy+DzC7Psu72L9I8SMR8jLe1mlLNWHibBui5hjYIZd
         mwfHzG/ZAvYvA==
Date:   Wed, 8 Mar 2023 16:57:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     korantwork@gmail.com
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v2] PCI:vmd: add the module param to adjust msi mode
Message-ID: <20230308225718.GA1054189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307083559.2379758-1-korantwork@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please adjust the subject line to match previous history, e.g.,

  PCI: vmd: Add ... MSI ...

On Tue, Mar 07, 2023 at 04:35:59PM +0800, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> In the legacy, the vmd msi-mode can only be adjusted by configing
> vmd_ids table.This patch adds another way to adjust msi mode by
> adjusting module param, which allow users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver.There are two
> params could be recognized: on, off. The default param is "NULL",
> the goal is not to affect the existing settings of the device.

Please add a space after the period that ends each sentence.
Capitalize "MSI" to match usage in spec.

> Signed-off-by: Xinghui Li <korantli@tencent.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

I didn't see a response from Nirmal on the mailing list with the
Reviewed-by.  I think it's better if Nirmal responds to the patch
directly on the mailing list with the Reviewed-by, and whoever applies
the patch can incorporate it.  Otherwise we have no visibility into
any interaction between you and Nirmal.

> ---
>  drivers/pci/controller/vmd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..8b42b2c1d949 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,20 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +/*
> + * The VMD msi_remap module parameter provides the alternative way
> + * to adjust msi mode when loading vmd.ko other than vmd_ids table.
> + * There are two params could be recognized:
> + *
> + * 1-off
> + * 2-on

It looks like your code matches either "on" or "off", not "1" or "2".

> + * The default param is "NULL", the goal is not to affect the existing
> + * settings of the device.
> + */
> +char *msi_remap = "NULL";

Looks like this should be static?  And using "NULL" (as opposed to
something like the empty string "") suggests some intrinsic meaning of
"NULL", but I think there is no intrinsic meaning and the only point
is that "NULL" doesn't match either "on" or "off".

> +module_param(msi_remap, charp, 0444);
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -875,6 +889,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			return ret;
>  
>  		vmd_set_msi_remapping(vmd, true);
> +		dev_info(&vmd->dev->dev, "init vmd with remapping msi-x\n");
>  
>  		ret = vmd_create_irq_domain(vmd);
>  		if (ret)
> @@ -887,6 +902,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
>  	} else {
>  		vmd_set_msi_remapping(vmd, false);
> +		dev_info(&vmd->dev->dev, "init vmd with bypass msi-x\n");
>  	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
> @@ -955,6 +971,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	return 0;
>  }
>  
> +static void vmd_config_msi_remap_param(unsigned long *features)
> +{
> +	if (strcmp(msi_remap, "on") == 0)
> +		*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
> +	else if (strcmp(msi_remap, "off") == 0)
> +		*features |= VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +}
> +
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
> @@ -984,6 +1008,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (err < 0)
>  		goto out_release_instance;
>  
> +	vmd_config_msi_remap_param(&features);
> +
>  	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
>  	if (!vmd->cfgbar) {
>  		err = -ENOMEM;
> -- 
> 2.31.1
> 

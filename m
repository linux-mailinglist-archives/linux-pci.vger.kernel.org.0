Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565E6CCC23
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC1Vel (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1Vel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 17:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9DB26BE;
        Tue, 28 Mar 2023 14:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA8A6196F;
        Tue, 28 Mar 2023 21:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D845BC433EF;
        Tue, 28 Mar 2023 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680039279;
        bh=vWyHCjF+BTgXOwgUXU3RyEwPO+Qw/pB93Lo/jd0y3nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OmpcmwqPF24Q0fAer/sLX2UWm/3sHFKbjiLDyYHNGNT3rJSGB0WUFOpniAoge4EpT
         +C7ImmqB/NTjY5E+T/RdYNdeOIw1Qq0z0F996CyECzxWcAlAZv8J1+QDaFNSt1vr3a
         Nhavp8GgUA7EX/+rlhRtaKIY3L+cJk775ZJVfWdWbemTmM32w8wT3Fx7peBXr+49EF
         ONZPtOUpZxjSOEtQ3oYx2q/RJUjgvqPZzojXRP2xuk90x/Rpeiu9YNpiOES2POs0JD
         v5i1LQ8RfCtH7xCZMzYC/dnvpnPnF37mA+foeFtX4Sf3uh4mQWdtSqSTZYJsdC+1mp
         283nDZ9AJwQcg==
Date:   Tue, 28 Mar 2023 16:34:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     korantwork@gmail.com
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230328213437.GA2963709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320132316.3126838-1-korantwork@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 09:23:16PM +0800, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> In the legacy, the vmd MSI mode can only be adjusted by configuring
> vmd_ids table. This patch adds another way to adjust MSI mode by
> adjusting module param, which allows users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver. There are two
> params that could be recognized: on, off. The default param is NULL,
> the goal is not to effect the existing settings of the device.

"two params: on, off ... default param is NULL" doesn't read quite
right because "NULL" is not a valid parameter value.

I think you could just omit that last sentence completely because it's
obvious that if you don't specify the parameter, it doesn't affect
anything and the existing behavior is unchanged (it's determined by
whether VMD_FEAT_CAN_BYPASS_MSI_REMAP is specified in vmd_ids[]).

> Signed-off-by: Xinghui Li <korantli@tencent.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

I think Lorenzo is out of the office this week, but I'm sure he'll
take care of this when he returns.

In the meantime, can you include a sample usage in the commit log so
folks don't have to dig through the patch and figure out how to use
the parameter?

It would also be nice to include a hint about why a user would choose
"on" or "off".  What is the performance effect?  What sort of I/O
scenario would lead you to choose "on" vs "off"?

ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
suggests that MSI-X remapping (I assume the "msi_remap=on" case):

  - Limits the number MSI-X vectors available to child devices to the
    number of VMD MSI-X vectors.

  - Reduces interrupt handling performance because child device
    interrupts have to go through the VMD MSI-X domain interrupt
    handler.

So I assume "msi_remap=off" would remove that MSI-X vector limit and
improve interrupt handling performance?

But obviously there's more to consider because those are both good
things and if we could do that all the time, we would.  So there must
be cases where we *have* to remap.  ee81ee84f873 suggests that not all
VMD devices support disabling remap.  There's also a hint that some
virt configs require it.

This patch doesn't enforce either of those things.  What happens if
the user gets it wrong?

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
> + * off: disable MSI remapping
> + * on:  enable MSI remapping
> + *

Spurious blank line.

> + */
> +static char *msi_remap;
> +module_param(msi_remap, charp, 0444);
> +MODULE_PARM_DESC(msi_remap, "Whether to enable MSI remapping function");

ee81ee84f873 mentions MSI-X explicitly (which is different from MSI),
so maybe use "MSI-X" here and in the messages below to avoid any
confusion.

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

The usual strcmp() idiom is to test "!strcmp(...)" instead of
"strcmp(...) == 0)".  No need for "()" around
VMD_FEAT_CAN_BYPASS_MSI_REMAP.

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
> -- 
> 2.31.1
> 

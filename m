Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D066F1E24
	for <lists+linux-pci@lfdr.de>; Fri, 28 Apr 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbjD1Skl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346338AbjD1Skk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 14:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F51BEB;
        Fri, 28 Apr 2023 11:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 060CF644EC;
        Fri, 28 Apr 2023 18:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188BEC433EF;
        Fri, 28 Apr 2023 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682707238;
        bh=6QaYrKKqyi4SPrBpxEaO4Zgaql0xJU+aoMiwQ/TM5Jk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QGKCyKl7px4vlnQhfu2pG7CkleOfS41l+UtwgIfUZpKbfW3EZplr3j1EBIxMReUtt
         pVpFfOcGp3PrNPZr/2Mc5UiDqv/nvZEPKaVrCpwsSO8Gr8VaCewfnp2iNdM3nu79Zx
         1oAzoZnSt5LxEGiY3dMLiVRqIb6HP5VVckCIsY/kuArlJS5prOsH4Ty0V3GPikiLez
         YUmqvPnKo+ORKr4mBYCyy7hmrMP7bHU6ZeqzRmZ7jw3w52jrgjXzVcTqgeHDRT78Q4
         jBj25YWdtT2uib/KW1HErKs8Nedrx/Ju80G27SCFCWifqD3XgRdsdSnrGpfpKEzvfY
         e7I2ZZBDyJrOA==
Date:   Fri, 28 Apr 2023 13:40:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     korantwork@gmail.com
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v5] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230428184036.GA298937@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420070914.1383918-1-korantwork@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 03:09:14PM +0800, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> In the past, the vmd MSI mode can only be adjusted by configuring
> vmd_ids table. This patch adds another way to adjust MSI mode by
> adjusting module parameter, which allows users easier to adjust the vmd
> according to the I/O scenario without rebuilding driver.

We're making good progress here, but I still have a hard time
understanding what's going on, partly because some of the naming is
confusing to me.

The "VMCONFIG_MSI_REMAP" name suggests that setting this bit enables
MSI remapping, but I think it actually *disables* MSI remapping.  IMO
this should be named something like "VMCONFIG_MSI_REMAP_DISABLE".
(This would be a separate patch if we did anything like this.)

> - "disable_msi_bypass=0 or other values":
>   Under normal circumstances, we recommend enable the VMD MSI-X bypass
>   feature, which improves interrupt handling performance by avoiding
>   the VMD MSI-X domain interrupt handler.

The "disable_msi_bypass" parameter name also leads to some complicated
logic.  IIUC, "disable_msi_bypass=0" means "do not disable MSI remap
bypassing" or, in other words, "do not remap MSIs."  This is only
supported by some VMDs.  Using "disable_msi_bypass=0" to *enable* the
bypass feature is confusing.

And I guess "disable_msi_bypass=1" means "remap MSIs" (which is
supported by all VMD versions)?

What if you made boolean parameters like these:

  no_msi_remap

    If the VMD supports it, disable VMD MSI-X remapping.  This
    improves interrupt performance because child device interrupts
    avoid the VMD MSI-X domain interrupt handler.

  msi_remap

    Remap child MSI-X interrupts into VMD MSI-X interrupts.  This
    limits the number of MSI-X vectors available to the whole child
    device domain to the number of VMD MSI-X interrupts.

Is it also the case that "msi_remap" may be required for some
virtualization scenarios when the vmd driver can't work that out
itself via vmd_get_phys_offsets()?

> - "disable_msi_bypass=1":
>   Use this when multiple NVMe devices are mounted on the same PCIe
>   node with a high volume of 4K random I/O. It mitigates excessive
>   pressure on the PCIe node caused by numerous interrupts from NVMe
>   drives, resulting in improved I/O performance. Such as:
>
>   In FIO 4K random test when 4 NVME(Gen4) mounted on the same PCIE port:
>     - Enable bypass: read: IOPS=562k, BW=2197MiB/s, io=644GiB
>     - Disable bypass: read: IOPS=1144k, BW=4470MiB/s, io=1310GiB

I still don't understand what causes the performance problem here.  I
guess you see higher performance when the VMD remaps child MSIs?  So
adding the VMD MSI-X domain interrupt handler and squashing all the
child MSI vectors into the VMD MSI vector space makes things better?
That seems backwards.  Is this because of cache effects or something?

What does "excessive pressure on the PCIe node" mean?  I assume the
PCIe node means the VMD?  It receives the same number of child
interrupts in either case.

> As not all devices support VMD MSI-X bypass, this parameter is
> only applicable to devices that support the bypass function and
> have already enabled it, such as VMD_28C0.

If you made two boolean parameters, "msi_remap" would work for all
devices, and "no_msi_remap" would work only on certain VMDs, right?

> Besides, this parameter does not affect the MSI-X working mode in
> guest.

I don't understand what you're saying here.  From the patch, I think
that "disable_msi_bypass=1", i.e., "always remap child MSIs", means we
pretend this VMD doesn't support the VMCONFIG_MSI_REMAP bit.  In that
case MSI remapping always happens.

If the user may need to use "disable_msi_bypass=1" (or "msi_remap") in
some virtualization scenarios, we should mention that and maybe give a
hint about what happens *without* that parameter.

> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/pci/controller/vmd.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 990630ec57c6..8ee673810cbf 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -34,6 +34,20 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +/*
> + * The VMD disable_msi_bypass module parameter provides the alternative
> + * way to adjust MSI mode when loading vmd.ko. This parameter is only applicable
> + * to devices that both support and have enabled bypass, such as VMD_28C0.
> + * Besides, it does not affect MSI-X mode in the guest.
> + *
> + * 1: disable MSI-X bypass
> + * other values: not disable MSI-X bypass
> + */
> +static int disable_msi_bypass;
> +module_param(disable_msi_bypass, int, 0444);
> +MODULE_PARM_DESC(disable_msi_bypass, "Whether to disable MSI-X bypass function.\n"
> +	"\t\t  Only effective on the device supporting bypass, such as 28C0.");
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -875,6 +889,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			return ret;
>  
>  		vmd_set_msi_remapping(vmd, true);
> +		dev_info(&vmd->dev->dev, "init vmd with remapping MSI-X\n");
>  
>  		ret = vmd_create_irq_domain(vmd);
>  		if (ret)
> @@ -887,6 +902,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
>  	} else {
>  		vmd_set_msi_remapping(vmd, false);
> +		dev_info(&vmd->dev->dev, "init vmd with bypass MSI-X\n");
>  	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
> @@ -955,6 +971,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	return 0;
>  }
>  
> +static void vmd_config_msi_bypass_param(unsigned long *features)
> +{
> +	/*
> +	 * Not every VMD device supports and enables bypass MSI-X.
> +	 * Make sure current device has the bypass flag set.
> +	 */
> +	if (disable_msi_bypass == 1 &&
> +	  *features & VMD_FEAT_CAN_BYPASS_MSI_REMAP)
> +		*features &= ~(VMD_FEAT_CAN_BYPASS_MSI_REMAP);
> +}
> +
>  static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	unsigned long features = (unsigned long) id->driver_data;
> @@ -984,6 +1011,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (err < 0)
>  		goto out_release_instance;
>  
> +	vmd_config_msi_bypass_param(&features);
> +
>  	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
>  	if (!vmd->cfgbar) {
>  		err = -ENOMEM;
> -- 
> 2.31.1
> 

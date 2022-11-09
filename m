Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7E6237A8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 00:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKIXqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 18:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 18:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53829654B;
        Wed,  9 Nov 2022 15:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FBD61D22;
        Wed,  9 Nov 2022 23:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F92AC433C1;
        Wed,  9 Nov 2022 23:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668037611;
        bh=JcxGzPO6Cd16TxVvX67Wl9duYpJlfmwyedOx+YzFaAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qVs5UUTu4tf62brkdoXTy6/39Hc2M5O/RBn9/15aC2Ng771sM8T+RTA0hxYazI7RN
         IV19FIJnCBwPA7s1Y6f/n8CDJRaUvLLypToRMzOHn6rPNTV0jWI1Uad+ESe/GAe6/0
         zCH7tJoT/0yPgugZMsHer02VNKTWUPfZU+NgdZIi2kbsbch1Nor7WIQdVReEJG9Yng
         e8QFPPaJNIzb85DkROVRH+IAUKuTs/UGLyOxMmSUTecge1K6pe5AdnscL1JkTt4WLy
         Q4zXUxxsa58cgFkpblvzXdyhe/+pvYNBkYoel2t6Xg19Mb8B2JDZnK0u8t/eBUdwSr
         oi9F/QvQ9XTEQ==
Date:   Wed, 9 Nov 2022 17:46:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rui Ma <Rui.Ma@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander.Deucher@amd.com, bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Message-ID: <20221109234649.GA584052@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011112325.992317-1-Rui.Ma@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 11, 2022 at 07:23:25PM +0800, Rui Ma wrote:
> In some certain SR-IOV scene, when the device physical space(such as Video
> RAM)is fixed, as the number of VFs increases, some device driver may decrease
> actual BAR memory space used by each VF. However, the VF BAR memory mapping is
> always based on the usual BAR probing algorithm in PCIe spec. So do not map this
> unneeded memory can save host memory which occupied by PTEs. Although each PTE
> only occupies a few bytes of space on its own, a large number of PTEs can still
> take up a lot of space.

Dropping this for now until we resolve whether this is working around
a KVM bug as Alex suggests:

https://lore.kernel.org/r/BL1PR12MB51446437265DD1E8AA0794E9F7239@BL1PR12MB5144.namprd12.prod.outlook.com

> Signed-off-by: Rui Ma <Rui.Ma@amd.com>
> ---
>  drivers/pci/iov.c    | 14 ++++++++++++--
>  drivers/pci/pci.h    | 15 +++++++++++++++
>  drivers/pci/quirks.c | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..92a69e51d85c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -296,6 +296,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	struct pci_sriov *iov = dev->sriov;
>  	struct pci_bus *bus;
>  
> +    /*
> +     * Some SR-IOV device's BAR map range is larger than they can actually use.
> +     * This extra BAR space occupy too much reverse mapping size(physical page
> +     * back to the PTEs). So add a divisor shift parameter to resize the request
> +     * resource of VF according to num of VFs.
> +     */
> +	u16 shift = 1;
> +
>  	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>  	if (!bus)
>  		goto failed;
> @@ -328,8 +336,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  		virtfn->resource[i].name = pci_name(virtfn);
>  		virtfn->resource[i].flags = res->flags;
>  		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> +		shift = 1;
> +		shift = virtfn_get_shift(dev, iov->num_VFs, i);
>  		virtfn->resource[i].start = res->start + size * id;
> -		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
> +		virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;
>  		rc = request_resource(res, &virtfn->resource[i]);
>  		BUG_ON(rc);
>  	}
> @@ -680,12 +690,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	msleep(100);
>  	pci_cfg_access_unlock(dev);
>  
> +	iov->num_VFs = nr_virtfn;
>  	rc = sriov_add_vfs(dev, initial);
>  	if (rc)
>  		goto err_pcibios;
>  
>  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> -	iov->num_VFs = nr_virtfn;
>  
>  	return 0;
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..befc67a280eb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  }
>  #endif
>  
> +struct virtfn_get_shift_methods {
> +	u16 vendor;
> +	u16 device;
> +	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);
> +};
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2);
> +#else
> +static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
> +{
> +	return (u16)1;
> +}
> +#endif
> +
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  			  struct resource *res);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..3466738c1c54 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4085,6 +4085,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  	return -ENOTTY;
>  }
>  
> +static u16 resize_vf_bar0(struct pci_dev *dev, u16 num_VFs, int bar_num)
> +{
> +	u16 shift = 1;
> +
> +	if (bar_num == 0) {
> +		while ((1 << shift) <= num_VFs)
> +			shift += 1;
> +	}
> +	pci_info(dev, "with %d VFs, VF BAR%d get shift: %d\n", num_VFs, bar_num, shift);
> +	return shift;
> +}
> +
> +static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
> +	{ PCI_VENDOR_ID_ATI, 0x73a1, resize_vf_bar0},
> +	{ 0 }
> +};
> +
> +/*
> + * Get shift num to calculate SR-IOV device BAR. Sometimes the BAR size for
> + * SR-IOV device is too large and we want to calculate the size to define
> + * the end of virtfn.
> + */
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
> +{
> +	const struct virtfn_get_shift_methods *i;
> +
> +	for (i = virtfn_get_shift_methods; i->get_shift; i++) {
> +		if ((i->vendor == dev->vendor ||
> +		     i->vendor == (u16)PCI_ANY_ID) &&
> +		    (i->device == dev->device ||
> +		     i->device == (u16)PCI_ANY_ID))
> +			return i->get_shift(dev, arg1, arg2);
> +	}
> +
> +	return (u16)1;
> +}
> +
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 0)
> -- 
> 2.25.1
> 

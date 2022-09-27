Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249AD5ED009
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiI0WGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI0WGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 18:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBAAE7E3F;
        Tue, 27 Sep 2022 15:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B98E61BF2;
        Tue, 27 Sep 2022 22:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B287BC433D6;
        Tue, 27 Sep 2022 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664316402;
        bh=zf6/Ek9VKvQvAUEeQpa349iNcZYlcL9HB0j5vGBv2wM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nZcNZxKuqKNGjZBBtQc2ZU+b7Pm9DTuqEGy7HC1wBS/KalBLpbnLgj1VjUHr5zWFa
         nxDtqdbxpSuNnOvuv3+E0ZFv/jIvlgho/9kgROGLbvxlinP4y2HMs7zIgyR6hCGwF1
         gD9nVPHvzryd+rSXUkw2yeQsbRhK7LTO1oxVMgtYf2BeRXoscL3Rh+aPmmp75tCC6v
         Q0SGFhpU/WdyVC0H6vrUP4sPO7hg185EVTUeLlLWVIQOdic6v9zOjvMHy2HgQT8URX
         CsQwFNryEohGIChOV1++eRAqW9HVzXxqtRTHISugoE5f91l12XDC5LjDBoJQkLN3dy
         y5/V/7/GNVBtw==
Date:   Tue, 27 Sep 2022 17:06:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rui Ma <Rui.Ma@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Message-ID: <20220927220640.GA1728095@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926080542.920427-1-Rui.Ma@amd.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 04:05:42PM +0800, Rui Ma wrote:
> In SR_IOV scene, when the device physical space(such as Video RAM)is fixed,
> as the number of VFs increases, the actual BAR memory space used by each VF
> decreases.

s/SR_IOV/SR-IOV/ to match spec usage.

I think this is device-specific behavior, right?  I don't see anything
in the PCIe spec about the BAR size being dependent on NumVFs.  If
it's device-specific, it shouldn't be presented as "for all SR-IOV
devices, the actual BAR memory space decreases as number of VFs
increases."

> However, the BAR memory mapping is always based on the initial
> device physical device. So do not map this unneeded memory can save host
> memory occupied by PTEs. Although each PTE only occupies a few bytes of
> space on its own, a large number of PTEs can still take up a lot of space.

So IIUC this is basically a quirk to override the "VF BAR aperture"
size, which PCIe r6.0, sec 9.2.1.1.1 says is "determined by the usual
BAR probing algorithm as described in Section 9.3.3.14."

Except that this doesn't affect the *starting* address of each VF BAR,
which I guess is what you mean by "BAR memory mapping is always based
on the initial device physical device."

Hmm.  This kind of breaks the "plug and play" model of PCI because the
device is no longer self-describing.  Well, I guess the device still
describes its worst-case BAR size; the quirk basically just optimizes
space usage.  Right?

It's a shame if we can't reduce PTE usage by using hugeTLB pages for
this.  Aren't both virt and phys contiguous and nicely aligned for
this case?  It seems like the perfect application for huge pages.

> Signed-off-by: Rui Ma <Rui.Ma@amd.com>
> ---
>  drivers/pci/iov.c    | 14 ++++++++++++--
>  drivers/pci/pci.h    | 15 +++++++++++++++
>  drivers/pci/quirks.c | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..6b9f9b6b9be1 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -296,6 +296,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	struct pci_sriov *iov = dev->sriov;
>  	struct pci_bus *bus;
>  
> +    /*
> +     * Some SR-IOV device's BAR map range is larger than they can actually use.
> +     * This extra BAR space occupy too much reverse mapping size(physical page
> +     * back to the PTEs). So add a divisor shift parameter to resize the
> +     * request resource of VF.
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

Maybe more of the fiddling could be hidden in the quirk, e.g.,

  size = quirk_vf_bar_size(dev, iov->num_VFs, i);
  if (!size)
    size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);

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
> index da829274fc66..add587919705 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4085,6 +4085,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  	return -ENOTTY;
>  }
>  
> +static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int bar_num)

This is clearly ATI specific or at the very least specific to devices
that divvy up BAR0 in special ways, so the name is a bit too generic.

> +{
> +	u16 shift = 1;
> +
> +	if (bar_num == 0) {
> +		while ((1 << shift) <= num_VFs)
> +			shift += 1;
> +	}
> +	pci_info(dev, "BAR %d get shift: %d.\n", bar_num, shift);

Drop the period at end.  If we're changing the size, I think it would
be useful to know num_VFs, BAR #, and the new size.  IIUC, "dev" here
is the PF, so this is the "VF BAR", not the BAR 0 of the PF.

> +	return shift;
> +}
> +
> +static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
> +	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
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

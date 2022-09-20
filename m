Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FBC5BED95
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 21:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiITTYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 15:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E5A45062;
        Tue, 20 Sep 2022 12:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE0E62D1A;
        Tue, 20 Sep 2022 19:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62248C433C1;
        Tue, 20 Sep 2022 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663701853;
        bh=JrnRCZHbfI08ymI3t1xnEnPAFFIZwPIAnzrn4ahHtuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lg3Na3RHvHVuHVHp4FRY0I5HLG76D8SMdAHLj+T2CisHvq+4RW/UXxb6C7KgZG/tQ
         Tj3i9TfuNVGgWUCaoqMUkNSRTmCHtCIbwgaMiP5l06LpEhgIwoitG5pcIlpbj8GWal
         Az4aH9V7rAnTRaBxum9hg+KPZsUIdlu3zVVR06PrN3wbJhQtIOfoAAq5q3BYNkBl4r
         VC5pEfoyB0LfYWGLLNFv2vDNeQgM1+p420UUK83+ZmgBbIRxmtYCbge7S03mh0z1ed
         GOheMIJQ/dJNP58dQKz2VwRULf6bjwXWoQAP/7pRyxYY3VU1q1091V3Ec6q3Zk9NHw
         AyOnOmz2S3RqA==
Date:   Tue, 20 Sep 2022 14:24:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rui Ma <Rui.Ma@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci: Decrease VF memory BAR size to Save host
 memory occupied by PTEs:
Message-ID: <20220920192411.GA1127373@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920024108.418496-1-Rui.Ma@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please use conventional prefix and capitalization in subject (use "git
log --oneline").

On Tue, Sep 20, 2022 at 10:41:08AM +0800, Rui Ma wrote:
> The VRAM space is fixed, as the number of VFs increases, the actual BAR
> memory space used by each VF decreases. However, the BAR memory mapping is
> always based on the initial size of the VRAM. So do not map this unneeded
> memory can save host memory occupied by PTEs. Although each PTE only
> occupies a few bytes of space on its own, a large number of PTEs can still
> take up a lot of space.

This patch changes generic PCIe code, so the commit log should
describe it in terms of concepts from the PCIe spec.  VRAM is a
device-specific idea that does not appear in the spec.

sriov_init() determines the VF BAR sizes at enumeration-time, before
VFs are enabled and before we know how many VFs there are.

Apparently there are two concepts here?

  1) VF BARx size depends on NumVFs?  Please include PCIe spec
  reference for this.

  2) Space used by PTEs?  This needs more explanation, since PCIe
  itself isn't concerned about this.  I suppose you mean the overhead
  of ioremapping things?

> Signed-off-by: Rui Ma <Rui.Ma@amd.com>
> ---
>  drivers/pci/iov.c    | 11 +++++++++--
>  drivers/pci/pci.h    | 15 +++++++++++++++
>  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..d623f46669b6 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -295,6 +295,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	struct resource *res;
>  	struct pci_sriov *iov = dev->sriov;
>  	struct pci_bus *bus;

Add blank line here to follow existing coding style.

> +    /*
> +     * Some SRIOV device's Bar is too large and occupy too much rmap size.
> +     * Resize the request resource of VF.

s/SRIOV/SR-IOV/ throughout to match spec usage
s/Bar/BAR/ throughout

I don't understand "BAR is too large."  What does that mean?  How do
we determine what "too large" is?

"rmap" is not a PCIe concept and needs further details if used here.

> +     */
> +	u16 shift = 1;
>  
>  	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>  	if (!bus)
> @@ -328,8 +333,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
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
> @@ -680,12 +687,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
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

"get_shift" doesn't mean anything 

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
> index da829274fc66..82502c5923e4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4085,6 +4085,44 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  	return -ENOTTY;
>  }
>  
> +static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int bar_num)
> +{
> +	u16 shift = 1;
> +
> +	if (bar_num == 0) {
> +		while ((1 << shift) <= num_VFs)
> +			shift += 1;
> +	}
> +	pci_info(dev, "Bar %d get shift: %d.\n", bar_num, shift);
> +	return shift;
> +}
> +
> +static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
> +	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
> +	{ 0 }
> +};
> +
> +/*
> + * Get shift num to calculate SRIOV device bar.
> + * Sometimes the bar size for SRIOV device is too large
> + * and we want to calculate the size to define the end
> + * of virtfn.

Rewrap to fill 78 columns.

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

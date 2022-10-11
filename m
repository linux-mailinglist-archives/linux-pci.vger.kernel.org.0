Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DE5FB199
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJKLhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 07:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJKLhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 07:37:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739448BBA0;
        Tue, 11 Oct 2022 04:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 334A1B815A3;
        Tue, 11 Oct 2022 11:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A46AC433D6;
        Tue, 11 Oct 2022 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665488224;
        bh=VBtQaFtLWaxwSn/lcpWL94iaXvTdhOab5SQsLixxk9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaROchQDKpCahPMWqO+eopdtyan7mm+dbkBPB5l2if8DaPLob/aj9jSWqjWhbmWel
         0cLUBswn7tVbDESaRQPPTtKY7coU7EE9AIso+URqj1b3CeHMh2ExoxaxraV605P7M2
         VUOTbvXvwDYXo5SMxAZ3F4zgl+yRfQu/QmVP9EPF3QRaZklQK92Sd7YuFYW9UlMh4F
         xedSgfcslKvsENLyPBI7Ey9TmpRsuwqkiKySO9eAKFhV/h2jUjfEgTwdHHQgoeyhSa
         FVuGBhBUSNgUiF8DGNrB/cRfk8ZuXz19YhYvYWXr5LaESA4Oy4CxiQhNppzwOWMkjF
         oJty89eqUOERw==
Date:   Tue, 11 Oct 2022 14:37:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rui Ma <Rui.Ma@amd.com>
Cc:     helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Alexander.Deucher@amd.com,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Message-ID: <Y0VVXB0XTobClVJo@unreal>
References: <20221011112325.992317-1-Rui.Ma@amd.com>
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
> 
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

<...>

> +	return (u16)1;

Why do you need these casts? You can omit them.

Thanks

> +}
> +
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 0)
> -- 
> 2.25.1
> 

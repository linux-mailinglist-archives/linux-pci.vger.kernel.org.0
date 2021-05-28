Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107F03947F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhE1UeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 16:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhE1UeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 16:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A2761248;
        Fri, 28 May 2021 20:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622233946;
        bh=JJQmf3Qu8yKO3mFCvAcP0r2MydsTeFIuoqzpZHSG+zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cV7Bd3qKnCAhB9EgDQCRTipJRSdSiWHnH7FJbOyu9JwKGki9QL8c6JMWpiHPNQjo7
         TWt/9OLqZ4jhoev6NWYAgjaL4bxwjjxRprJhGoJF2WqNV+wNN9AdZhjh7ZEY6HnUwY
         3HNRxog3jyroIXRrjTSOxjYmgBg6d7INrBSiTGcdsDvQo129YKi/9Z0m/W6LPpj1Jc
         My4aGpe20t2Di8hsOQR5u3FlKR5VY5++V6MtbV2KlU2qq6LgBPVQVA7VSIU+PuDj7h
         Sa2ECTp/MgOnNY4SebfjRKsYbc2Y6e0kCRKr/o6E16HoMrafT7hfNH/hpXfKcCwrpP
         W43OmpGvTvbHg==
Date:   Fri, 28 May 2021 15:32:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V2 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210528203224.GA1516603@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528071503.1444680-4-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 03:15:02PM +0800, Huacai Chen wrote:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(). So the only possible way is configure
> MRRS of all devices in BIOS, and add a PCI device flag (PCI_DEV_FLAGS_
> NO_INCREASE_MRRS) to stop the increasing MRRS operations.

It's still not clear what the problem is.

As far as I can tell from the PCIe spec, it is legal for an OS to
program any value for MRRS, and it is legal for an endpoint to
generate a Read Request with any size up to its MRRS.  If you
disagree, please cite the relevant section in the spec.

There is no requirement for the OS to limit the MRRS based on a
restriction elsewhere in the system.  There is no mechanism for the OS
to even discover such a restriction.

Of course, there is also no requirement that the PCIe Completions
carrying the read data be the same size as the MRRS.  If the non-PCIe
part of the system has a restriction on read burst size, that part of
the system can certainly break up the read and respond with several
PCIe Completions.

If LS7A can't break up read requests, that sounds like a problem in
the LS7A design.  We should have a description of this erratum.  And
we should have some statement about this being fixed in future
designs, because we don't want to have to update the fixup with the
PCI vendor/device IDs every time new versions come out.

I also don't want to rely on some value left in MRRS by BIOS.  If
certain bridges have specific limits on what MRRS can be, the fixup
should have those limits in it.

loongson_mrrs_quirk() doesn't look efficient.  We should not have to
run the fixup for *every* PCI device in the system.  Also, we should
not mark every *device* below an LS7A, because it's not the devices
that are defective.

If it's the root port or the host bridge that's defective, we should
mark *that*, e.g., something along the lines of how quirk_no_ext_tags()
works.

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci.c    | 5 +++++
>  drivers/pci/quirks.c | 6 ++++++
>  include/linux/pci.h  | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..6f0d2f5b6f30 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  
>  	v = (ffs(rq) - 8) << 12;
>  
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;
> +	}
> +
>  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_READRQ, v);
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 66e4bea69431..10b3b2057940 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
>  		 * any devices attached under these ports.
>  		 */
>  		if (pci_match_id(bridge_devids, bridge)) {
> +			dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
> +
> +			if (pcie_bus_config == PCIE_BUS_DEFAULT ||
> +			    pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +				break;
> +
>  			if (pcie_get_readrq(dev) > 256) {
>  				pci_info(dev, "limiting MRRS to 256\n");
>  				pcie_set_readrq(dev, 256);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..7fb2072a83b8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -227,6 +227,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	/* Don't increase BIOS's MRRS configuration */
> +	PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.27.0
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59B380D75
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhENPlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 11:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhENPlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 11:41:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B07696141E;
        Fri, 14 May 2021 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621006801;
        bh=5HRIgxKoK1lfUmysadI+W4oXombqXmdB+z2cW5UqJ+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UeRMA8YPgjsLgsP+YyOD4AsPC6ybnt8DIlcZavHkw7rWvpBhja2ZMgY+kgaR+hgEm
         cSpIzpmwYWFkl2OqcbeXNP6PbSUDwhs289gIJOHys+7Cwn5v6ogTCr18F3oXeyfVlY
         jVmTgpvhk9wY19UDw7uLaDPkHeQhKBr05j15C8dAF6zsMnwY84cgOp9HEj95zW9WzV
         DKtPowuEZzlpbBmnEfon4ubb7P7kX4Pa6+KVJT5jRKXa+7OnoBNnTG/PmCp+jg6lEg
         02lvkWFxV4FMsOAcQCc+j0EnZ2Sy3IYXqXJAE5LEZi7/MyVPrOtTyz1PsyuNgAIRKo
         4418HdLth15Gg==
Date:   Fri, 14 May 2021 10:39:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 3/5] PCI: Improve the mrrs quirk for LS7A
Message-ID: <20210514153959.GA2762101@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-4-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 04:00:23PM +0800, Huacai Chen wrote:
> In new revision of LS7A, some pcie ports support larger value than 256,
> but their mrrs values are not dectectable. And moreover, the current
> loongson_mrrs_quirk() cannot avoid devices increasing its mrrs after
> pci_enable_device(). So the only possible way is configure mrrs of all
> devices in BIOS, and add a pci dev flag (PCI_DEV_FLAGS_NO_INCREASE_MRRS)
> to stop the increasing mrrs operations.

s/mrrs/MRRS/
s/dectectable/detectable/

This doesn't make sense to me.  MRRS "sets the maximum Read Request
size for the Function as a Requester" (PCIe r5.0, sec 7.5.3.4).

The MRRS in the Device Control register is a 3-bit RW field (or a RO
field with value 000b).  If it's RW, software is allowed to write any
3-bit value to it.  There is no "maximum allowed value" for software
to detect.

The value software writes is only a *limit* on the Read Request size.
The hardware is never obligated to generate Read Requests of that max
size.  If software writes 101b (4096 byte max size), and the hardware
only supports generating 128-byte Read Requests, there's no issue.
It's perfectly fine for the hardware to generate 128-byte requests.

Apparently something bad happens if software writes something "too
large" to MRRS?  What actually happens?

If the problem is that the device generates a large Read Request and
in response, it receives a data TLP that is larger than it can handle,
that sounds like an MPS issue, not an MRRS issue.

Based on the existing loongson_mrrs_quirk(), it looks like this is a
long-standing issue.  I'm sorry I missed this when reviewing the
driver in the first place.  This all needs a much better explanation
of what the real problem is.  The "h/w limitation of 256 bytes maximum
read request size" comment just doesn't make sense from the spec point
of view.

I do know that Linux uses MRRS and MPS in ... highly unusual ways, and
maybe we're tripping over that somehow.  If so, we need to figure out
exactly how so we can make Linux's use of MPS and MRRS better overall.

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

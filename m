Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75E63B6B00
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhF1Whj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 18:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233442AbhF1Whi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 18:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C27B961CF8;
        Mon, 28 Jun 2021 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624919712;
        bh=QyAz1bZ33vFRqW6hsxAk9xKcPi8o6PeEGENZ/VDmpkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KBy3dR61rGFf1QLXIaLWP37q1lbZumC59euOBeDHERFTWslWvyLHGWCASE4MNYy3C
         HkKBUCvPARj2ETyd3Qerx0ZoCkQtVKf98vda7Ux0Wo7mJ9q32x2pXyu/YKDt+fmPdm
         JhY3KrQJio8r2/9ctKfdEREoFwqRLBYzSK0Fd7E17KBPS/2XMmcdwZOFxZWhUaA192
         b0p6bHi2MRb8rS5LpWGrf4ya2o7rNu3bJVednHftOICf67ZvANl1isdO+yxAGo9wQT
         w6wCa9jHaGG3nA8ls9DaBcam62I6pJuEyJ/HM0hcpX4U7r5UUYkFWQfj0GJVedzlPF
         SbaQHJXLqQVMQ==
Date:   Mon, 28 Jun 2021 17:35:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 3/4] PCI: Improve the MRRS quirk for LS7A
Message-ID: <20210628223510.GA3956387@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628101027.1372370-4-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 28, 2021 at 06:10:26PM +0800, Huacai Chen wrote:
> In new revision of LS7A, some PCIe ports support larger value than 256,
> but their maximum supported MRRS values are not detectable. Moreover,
> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> will actually set a big value in its driver. So the only possible way
> is configure MRRS of all devices in BIOS, and add a PCI bus flag (i.e.,
> PCI_BUS_FLAGS_NO_INC_MRRS) to stop the increasing MRRS operations.
> 
> However, according to PCIe Spec, it is legal for an OS to program any
> value for MRRS, and it is also legal for an endpoint to generate a Read
> Request with any size up to its MRRS. As the hardware engineers say, the
> root cause here is LS7A doesn't break up large read requests. In detail,
> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Read
> request with a size that's "too big" (Yes, that is a problem in the LS7A
> hardware design).
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci.c    |  5 +++++
>  drivers/pci/quirks.c | 41 +++++++++++------------------------------
>  include/linux/pci.h  |  1 +
>  3 files changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8d4ebe095d0c..0f1ff4a6fe44 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5812,6 +5812,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  
>  	v = (ffs(rq) - 8) << 12;
>  
> +	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_INC_MRRS) {
> +		if (rq > pcie_get_readrq(dev))
> +			return -EINVAL;

I'd prefer to make this simpler, so we just never touch MRRS at all,
like this:

  @@ -5785,6 +5785,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
	  u16 v;
	  int ret;

  +       if (<loongson-quirk>)
  +               return -EINVAL;
  +
	  if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
		  return -EINVAL;

What would that break?  It's just harder to analyze the behavior if it
depends on what the driver is trying to do.  AFAIK, devices should
*work* correctly with any value of MRRS.

> +	}
> +
>  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_READRQ, v);
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dee4798a49fc..4bbdf5a5425f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -242,37 +242,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, loongson_system_bus_quirk);
>  
> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> -{
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge;
> -	static const struct pci_device_id bridge_devids[] = {
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> -		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> -		{ 0, },
> -	};
> -
> -	/* look for the matching bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -		/*
> -		 * Some Loongson PCIe ports have a h/w limitation of
> -		 * 256 bytes maximum read request size. They can't handle
> -		 * anything larger than this. So force this limit on
> -		 * any devices attached under these ports.
> -		 */
> -		if (pci_match_id(bridge_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				pci_info(dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -			break;
> -		}
> -	}
> +static void loongson_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Some Loongson PCIe ports have h/w limitations of maximum read
> +	 * request size. They can't handle anything larger than this. So
> +	 * force this limit on any devices attached under these ports.
> +	 */
> +	pdev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_INC_MRRS;
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_mrrs_quirk);

Thanks for making this quirk Loongson-specific.  Can you reverse the
order of patches 2 and 3, so this fix happens before moving the quirk
to drivers/pci/quirks.c?

>  /*
>   * The Mellanox Tavor device gives false positive parity errors.  Disable
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 24306504226a..b336239b5282 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -240,6 +240,7 @@ enum pci_bus_flags {
>  	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
>  	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
>  	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
> +	PCI_BUS_FLAGS_NO_INC_MRRS = (__force pci_bus_flags_t) 16,

This is not a property of the *bus*.  

Apparently it's a property of the Root Port or maybe of the Root
Complex itself.  What about RCiePs, which don't have a Root Port above
them?  They still have an MRRS field in their Device Control
registers.  Are there restrictions on how MRRS can be set for an
RCiEP?

If you need to restrict MRRS for RCiEPs as well as for devices below
LS7A Root Ports, I think setting a bit in struct pci_host_bridge and
using pci_find_host_bridge() would work.

If you don't need to restrict MRRS for RCiEPs (or if there are no
RCiEPs at all) you could put a bit in the struct pci_dev and use
pcie_find_root_port().  But this would consume a bit in *every*
pci_dev on every system, so it's a little more wasteful in that sense.

>  };
>  
>  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> -- 
> 2.27.0
> 

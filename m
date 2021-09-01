Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705C13FE56C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhIAWYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 18:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhIAWYw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 18:24:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D58260F6C;
        Wed,  1 Sep 2021 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630535034;
        bh=et0pqefooHZt84DSm1+89qLmXn83NjdrBVAloK6cwGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oqpX7Pa2hJLFiGXzeVgn41RqJLno4uoJd1cbJCyumKhXM440OIKvXtnsTB7YYnTX/
         UxzZglFrdb43vSqkgowjx0PX9Im/dvdPQ3G4HH5XBzmtRgMOZRVQO938+jOFKQccqj
         mlRhKf06kxftg1DeJZZVED3aBTnapwmnJ3rtO8oewMtEPJbM65IorQXp/Gt2Hu9eD4
         CTUePzR3FY+LLiS/UJgC9NZrtVPJ1fsjjyqCXV/1cy8P6LWHvorAytBlNOkIHLcUSg
         C2DbGG5N24FDPHxXSh0RijTa+Jo93MK0KxmpMkRbLnbcxSZuy/SfdAgxpmrmgoJ2Ta
         OYkCrCUeSUadQ==
Date:   Wed, 1 Sep 2021 17:23:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hariprasad Shenai <hariprasad@chelsio.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, leedom@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH] pci: Add pci quirk to turnoff Nosnoop and Relaxed
 Ordering
Message-ID: <20210901222353.GA251391@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445178304-14855-1-git-send-email-hariprasad@chelsio.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 18, 2015 at 07:55:04PM +0530, Hariprasad Shenai wrote:
> Some devices violate the PCI Specification regarding echoing the Root
> Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
> Ordering Attributes into the TLP Response. The PCI Specification
> "encourages" compliant Root Port implementation to drop such
> malformed TLP Responses leading to device access timeouts. Many Root Port
> implementations accept such malformed TLP Responses and a few more
> strict implementations do drop them.
> 
> For devices which fail this part of the PCI Specification, we need to
> traverse up the PCI Chain to the Root Port and turn off the Enable No
> Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
> Device Control register. This does affect all other devices which
> are downstream of that Root Port.

While researching another thread about RO [1], I got concerned about
setting RO for root ports.

Setting RO for *endpoints* makes sense: that allows (but does not
require) the endpoint to issue writes that don't require strong
ordering.

Setting RO for *root ports* seems more problematic.  It allows the
root port to issue PCIe writes that don't require strong ordering.
These would be CPU MMIO writes to devices.  But Linux currently does
not have a way for drivers to indicate that some MMIO writes need to
be ordered while others do not, and I think drivers assume that all
MMIO writes are performed in order.

I don't think Linux ever enables RO in Root Ports, but this patch
suggests that firmware might enable it.  I don't understand how that
could *ever* be safe, unless we had some mechanism like a separate
MMIO window that generated writes with relaxed ordering.

Did you trip over firmware that enables RO, or is this a preventive
thing in case firmware or Linux ever *did* enable RO in the Root Port?

[1] https://lore.kernel.org/r/20210830123704.221494-2-verdre@v0yd.nl

> Note that Configuration Space accesses are never supposed to have TLP
> Attributes, so we're safe waiting till after any Configuration Space
> accesses to do the Root Port "fixup".
> 
> Based on original work by Casey Leedom <leedom@chelsio.com>
> 
> Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
> ---
>  drivers/pci/pci.c    | 28 ++++++++++++++++++++++++++
>  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6a9a111..3ce202b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -458,6 +458,34 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_find_parent_resource);
>  
>  /**
> + * pci_find_root_pcie_port - return PCI-E Root Port
> + * @dev: PCI device to query
> + *
> + * Traverses up the parent chain and return the PCI-E Root Port PCI Device
> + * for a given PCI Device.
> + */
> +struct pci_dev *pci_find_root_pcie_port(const struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *highest_pcie_bridge = NULL;
> +
> +	while (bus) {
> +		struct pci_dev *bridge = bus->self;
> +
> +		if (!bridge || !bridge->pcie_cap)
> +			break;
> +		highest_pcie_bridge = bridge;
> +		bus = bus->parent;
> +	}
> +
> +	if (!highest_pcie_bridge)
> +		dev_warn(&dev->dev, "Can't find Root Port\n");
> +
> +	return highest_pcie_bridge;
> +}
> +EXPORT_SYMBOL(pci_find_root_pcie_port);
> +
> +/**
>   * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
>   * @dev: the PCI device to operate on
>   * @pos: config space offset of status word
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6a30252..f860956 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3692,6 +3692,62 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
>  			      quirk_tw686x_class);
>  
>  /*
> + * Some devices violate the PCI Specification regarding echoing the Root
> + * Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
> + * Ordering Attributes into the TLP Response.  The PCI Specification
> + * "encourages" compliant Root Port implementation to drop such malformed
> + * TLP Responses leading to device access timeouts.  Many Root Port
> + * implementations accept such malformed TLP Responses and a few more strict
> + * implementations do drop them.
> + *
> + * For devices which fail this part of the PCI Specification, we need to
> + * traverse up the PCI Chain to the Root Port and turn off the Enable No
> + * Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
> + * Device Control register.  This does affect all other devices which are
> + * downstream of that Root Port but since No Snoop and Relaxed ordering are
> + * "Performance Hints," we're okay with that ...
> + *
> + * Note that Configuration Space accesses are never supposed to have TLP
> + * Attributes, so we're safe waiting till after any Configuration Space
> + * accesses to do the Root Port "fixup" ...
> + */
> +static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
> +{
> +	struct pci_dev *root_port = pci_find_root_pcie_port(pdev);
> +
> +	if (!root_port) {
> +		dev_warn(&pdev->dev, "Can't find Root Port to disable No Snoop/Relaxed Ordering\n");
> +		return;
> +	}
> +
> +	dev_info(&pdev->dev, "Disabling No Snoop/Relaxed Ordering on Root Port %s\n",
> +		 dev_name(&root_port->dev));
> +	pcie_capability_clear_and_set_word(root_port,
> +					   PCI_EXP_DEVCTL,
> +					   PCI_EXP_DEVCTL_RELAX_EN |
> +					   PCI_EXP_DEVCTL_NOSNOOP_EN,
> +					   0);
> +}
> +
> +/*
> + * The Chelsio T5 chip fails to return the Root Port's TLP Attributes in
> + * its TLP responses to the Root Port.
> + */
> +static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
> +{
> +	/*
> +	 * This mask/compare operation selects for Physical Function 4 on a
> +	 * T5.  We only need to fix up the Root Port once for any of the
> +	 * PFs.  PF[0..3] have PCI Device IDs of 0x50xx, but PF4 is uniquely
> +	 * 0x54xx so we use that one,
> +	 */
> +	if ((pdev->device & 0xff00) == 0x5400)
> +		quirk_disable_root_port_attributes(pdev);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> +			 quirk_chelsio_T5_disable_root_port_attributes);
> +
> +/*
>   * AMD has indicated that the devices below do not support peer-to-peer
>   * in any system where they are found in the southbridge with an AMD
>   * IOMMU in the system.  Multifunction devices that do not support
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e90eb22..5b4d7cc 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -820,6 +820,7 @@ void pci_bus_add_device(struct pci_dev *dev);
>  void pci_read_bridge_bases(struct pci_bus *child);
>  struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  					  struct resource *res);
> +struct pci_dev *pci_find_root_pcie_port(const struct pci_dev *dev);
>  u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
>  int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>  u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> -- 
> 2.3.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

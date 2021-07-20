Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C4C3D04B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 00:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhGTVwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 17:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhGTVwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 17:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C1E161178;
        Tue, 20 Jul 2021 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626820399;
        bh=2PY7Ck2U4XXWkjFW6DEH4575GUcmD+g7l4um0pFYgrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ovYditiJEuXINfielzKJLrw7K3enKUBxMqtuxPB/BBIccXHoebP45xTxv5jmsNK2z
         /O+PrVhz3dHLRIc8g+2jC0ieLzyAn9NBvkhlNVcrHUhMu9BN89Wq89NiCGmRZ7rMj6
         bsMejja3jRU06hOfL1AL9hwDNa0LsgA50C6W9En1rrEDEk0BLyQbjDbduDWSxwjfGk
         DalDtmBeQeEOvT0RcvTaeEgbPiIEmven0Znx9ejkX4Dpnfn/oQ1o51wV0h+/NEHIVk
         KlDbJE+QSba1DUOzRELs8yE1glefQpci6HuSTG9cdi/og8UDeV0he2TDdMnKO3HXMQ
         Ts0SmFUhFRhAg==
Date:   Tue, 20 Jul 2021 17:33:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
Message-ID: <20210720223318.GA135757@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720205009.111806-2-nirmal.patel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 01:50:08PM -0700, Nirmal Patel wrote:
> During VT-d passthrough repetitive reboot tests, it was determined that the VMD
> domain needed to be reset in order to allow downstream devices to reinitialize
> properly. This is done using a secondary bus reset at each of the VMD root
> ports and any bridges in the domain.

I don't understand the "any bridges in the domain" part.  Clearly you
only reset Intel bridges, and only those on a single "bus".  So can
there be both VMD root ports and another kind of bridge on the same
bus?

Rewrap this to fit in 75 columns or so, so it doesn't overflow 80
column lines when git log indents it by 4.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e3fcdfec58b3..6e1c60048774 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -15,6 +15,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
>  
>  #include <asm/irqdomain.h>
>  #include <asm/device.h>
> @@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
>  	.write		= vmd_pci_write,
>  };
>  
> +#define PCI_HEADER_TYPE_MASK 0x7f

Already defined in include/uapi/linux/pci_regs.h.

> +#define PCI_CLASS_BRIDGE_PCI 0x0604

Already defined in include/linux/pci_ids.h.  What am I missing?  Seems
like you should see duplicate definition warnings.

> +#define DEVICE_SPACE (8 * 4096)
> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))

Add blank line here.

> +static void vmd_domain_sbr(struct vmd_dev *vmd)
> +{
> +	char __iomem *base;
> +	u16 ctl;
> +	int dev_seq;
> +	int max_devs = resource_size(&vmd->resources[0]) * 32;
> +
> +	/*
> +	* Subdevice config space may or many not be mapped linearly using 4k config
> +	* space.

Fix comment indentation.

s/many/may/

I don't really understand the comment anyway.  Is the point that
subdevice config space may not be physically contiguous?  Certainly
VMD_DEVICE_BASE() computes virtual addresses that are linear.

> +	*/
> +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
> +		base = VMD_DEVICE_BASE(vmd, dev_seq);
> +		if (readw(base + PCI_VENDOR_ID) != PCI_VENDOR_ID_INTEL)
> +			continue;
> +
> +		if ((readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK) !=
> +		    PCI_HEADER_TYPE_BRIDGE)
> +			continue;
> +
> +		if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
> +			continue;
> +
> +		/* pci_reset_secondary_bus() */
> +		ctl = readw(base + PCI_BRIDGE_CONTROL);
> +		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> +		readw(base + PCI_BRIDGE_CONTROL);
> +		msleep(2);

It's a shame we can't do this with pci_reset_secondary_bus().  Makes
me wonder if there's an opportunity for special pci_ops.

> +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> +		readw(base + PCI_BRIDGE_CONTROL);
> +
> +	}
> +	ssleep(1);
> +}
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
> +	vmd_domain_sbr(vmd);
> +
>  	pci_scan_child_bus(vmd->bus);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
> -- 
> 2.27.0
> 

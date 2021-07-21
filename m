Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFD3D0B39
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhGUIUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 04:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236315AbhGUIJy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 04:09:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AFA561175;
        Wed, 21 Jul 2021 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626857429;
        bh=ENvzFRWnVXYmpUTfYqHC1A+a98fKoue84deOo6WL+B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ic8SIIyF1DyTY0skJ85fYVD65JnM3bRFOiOKVJMqPrPRZ3Lx9GvHRsmy+xH7OrKwp
         a2FeWTNuJ0aQ7AhMlCdXRlQKnC+j1dNcnYW250rMsNNw4iwGrayuBJfCmyRY85ldUS
         Rlvt7+RbJl8Jy4vZtH1WAsyHgCJmSPmxrvF3pNZ4r8jDEqp7NNbgxDSk6Mpf2vdpSL
         DHAE3zsleaLSYRDYVXrOrFsOzANUCl3e4gB1KYAUWgUgQ1pTlDyO6jLKfPxLIl5iM1
         uWvwH4m9R/qyMn0/chzYPBeTjkHROA/pIpcx9FwncRMXN7szFax8pwqzqOG203Oa4V
         rP2NfGj/rxVCQ==
Received: by pali.im (Postfix)
        id C424379B; Wed, 21 Jul 2021 10:50:26 +0200 (CEST)
Date:   Wed, 21 Jul 2021 10:50:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
Message-ID: <20210721085026.aue5snnynlqw6r46@pali>
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
 <20210720205009.111806-2-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720205009.111806-2-nirmal.patel@linux.intel.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 20 July 2021 13:50:08 Nirmal Patel wrote:
> During VT-d passthrough repetitive reboot tests, it was determined that the VMD
> domain needed to be reset in order to allow downstream devices to reinitialize
> properly. This is done using a secondary bus reset at each of the VMD root
> ports and any bridges in the domain.
> 
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
> +#define PCI_CLASS_BRIDGE_PCI 0x0604
> +#define DEVICE_SPACE (8 * 4096)
> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))
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
> +
> +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> +		readw(base + PCI_BRIDGE_CONTROL);

Hello!

You cannot unconditionally call secondary bus reset for arbitrary PCIe
Bridge. Calling it breaks more PCIe devices behind bridge and
pci_reset_secondary_bus() already handles it and skip reset if reset is
causing issues.

I would suggest to use pci_reset_secondary_bus() and extend it
so you can call it also from your driver.

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

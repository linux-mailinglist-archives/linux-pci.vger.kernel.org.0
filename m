Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184A34EA92
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUO20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:28:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUO20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:28:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5636128;
        Fri, 21 Jun 2019 07:28:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893C13F575;
        Fri, 21 Jun 2019 07:28:24 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:28:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VMD: Fix config addressing with bus offsets
Message-ID: <20190621142803.GA21807@e121166-lin.cambridge.arm.com>
References: <20190611211538.29151-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611211538.29151-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[dropped CC stable]

On Tue, Jun 11, 2019 at 03:15:38PM -0600, Jon Derrick wrote:
> VMD config space addressing relies on mapping the BDF of the target into
> the VMD config bar. When using bus number offsets to number the VMD
> domain, the offset needs to be ignored in order to correctly map devices
> to their config space.
> 
> Fixes: 2a5a9c9a20f9 ("PCI: vmd: Add offset to bus numbers if necessary")
> Cc: <stable@vger.kernel.org> # v4.19
> Cc: <stable@vger.kernel.org> # v4.18

Hi Jon,

that's not how stable should be handled. You should always start
by fixing mainline and if there are backports to be fixed too you
should add patch dependencies in the CC area, see:

Documentation/process/stable-kernel-rules.rst

Never add stable to the CC list in the email header, only in the
commit log.

When your patch hits mainline it will trickle back into stable,
if you specified dependencies as described above there is nothing
to do.

Thanks,
Lorenzo

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index fd2dbd7..a59afec 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -94,6 +94,7 @@ struct vmd_dev {
>  	struct resource		resources[3];
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
> +	u8			busn_start;
>  
>  #ifdef CONFIG_X86_DEV_DMA_OPS
>  	struct dma_map_ops	dma_ops;
> @@ -465,7 +466,8 @@ static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
>  	char __iomem *addr = vmd->cfgbar +
> -			     (bus->number << 20) + (devfn << 12) + reg;
> +			     ((bus->number - vmd->busn_start) << 20) +
> +			     (devfn << 12) + reg;
>  
>  	if ((addr - vmd->cfgbar) + len >=
>  	    resource_size(&vmd->dev->resource[VMD_CFGBAR]))
> @@ -588,7 +590,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	unsigned long flags;
>  	LIST_HEAD(resources);
>  	resource_size_t offset[2] = {0};
> -	resource_size_t membar2_offset = 0x2000, busn_start = 0;
> +	resource_size_t membar2_offset = 0x2000;
>  
>  	/*
>  	 * Shadow registers may exist in certain VMD device ids which allow
> @@ -630,14 +632,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
>  		if (BUS_RESTRICT_CAP(vmcap) &&
>  		    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
> -			busn_start = 128;
> +			vmd->busn_start = 128;
>  	}
>  
>  	res = &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] = (struct resource) {
>  		.name  = "VMD CFGBAR",
> -		.start = busn_start,
> -		.end   = busn_start + (resource_size(res) >> 20) - 1,
> +		.start = vmd->busn_start,
> +		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
>  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
>  
> @@ -705,8 +707,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>  
> -	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
> -				       sd, &resources);
> +	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
> +				       &vmd_ops, sd, &resources);
>  	if (!vmd->bus) {
>  		pci_free_resource_list(&resources);
>  		irq_domain_remove(vmd->irq_domain);
> -- 
> 1.8.3.1
> 

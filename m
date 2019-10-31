Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D043EAF0C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJaLhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 07:37:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfJaLhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 07:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3C3F1F1;
        Thu, 31 Oct 2019 04:37:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E0D3F719;
        Thu, 31 Oct 2019 04:37:19 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:37:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Message-ID: <20191031113717.GC26080@e121166-lin.cambridge.arm.com>
References: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
 <1571245488-3549-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571245488-3549-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 11:04:47AM -0600, Jon Derrick wrote:
> When some VMDs are enabled and others are not, it's difficult to
> determine which IIO stack corresponds to the enabled VMD.
> 
> To assist userspace with management tasks, VMD BIOS will write the VMD
> instance number and socket number into the first enabled root port's IO
> Base/Limit registers prior to OS handoff. VMD driver can capture this
> information and expose it to userspace.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 79 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 959c7c7..dbe1bff 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -98,6 +98,8 @@ struct vmd_dev {
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
>  	u8			busn_start;
> +	u8			socket_nr;
> +	u8			instance_nr;
>  
>  	struct dma_map_ops	dma_ops;
>  	struct dma_domain	dma_domain;
> @@ -543,6 +545,74 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  	.write		= vmd_pci_write,
>  };
>  
> +/**
> + * for_each_vmd_root_port - iterate over all enabled VMD Root Ports
> + * @vmd: &struct vmd_dev VMD device descriptor
> + * @rp: int iterator cursor
> + * @temp: u32 temporary value for config read
> + *
> + * VMD Root Ports are located in the VMD PCIe Domain at 00:[0-3].0, and config
> + * space can be determinately accessed through the VMD Config BAR. Because VMD
> + * Root Ports can be individually disabled, it's important to iterate for the
> + * first enabled Root Port as determined by reading the Vendor/Device register.
> + */
> +#define for_each_vmd_root_port(vmd, rp, temp)				\
> +	for (rp = 0; rp < 4; rp++)					\
> +		if (vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),	\
> +				 PCI_VENDOR_ID, 4, &temp) ||		\
> +		    temp == 0xffffffff) {} else

Nit: I do not think this macro is particularly helpful or easy to read.

I leave it up to you but I would turn this code (plus the inner loop in
vmd_parse_domain()) into a function, eg:

struct vmd_dev *vmd_find_first_root_port(..)

with the code in the macro above inlined. Up to you.

Thanks,
Lorenzo

> +static int vmd_parse_domain(struct vmd_dev *vmd)
> +{
> +	int root_port, ret;
> +	u32 temp, iobase;
> +
> +	vmd->socket_nr = -1;
> +	vmd->instance_nr = -1;
> +
> +	for_each_vmd_root_port(vmd, root_port, temp) {
> +		ret = vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),
> +				   PCI_IO_BASE, 2, &iobase);
> +		if (ret)
> +			return ret;
> +
> +		vmd->socket_nr = (iobase >> 4) & 0xf;
> +		vmd->instance_nr = (iobase >> 14) & 0x3;
> +
> +		/* First available will be used */
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t socket_nr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> +
> +	return sprintf(buf, "%u\n", vmd->socket_nr);
> +}
> +static DEVICE_ATTR_RO(socket_nr);
> +
> +static ssize_t instance_nr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> +
> +	return sprintf(buf, "%u\n", vmd->instance_nr);
> +}
> +static DEVICE_ATTR_RO(instance_nr);
> +
> +static struct attribute *vmd_dev_attrs[] = {
> +	&dev_attr_socket_nr.attr,
> +	&dev_attr_instance_nr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(vmd_dev);
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -582,6 +652,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	resource_size_t offset[2] = {0};
>  	resource_size_t membar2_offset = 0x2000;
>  	struct pci_bus *child;
> +	int ret;
> +
> +	ret = vmd_parse_domain(vmd);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Shadow registers may exist in certain VMD device ids which allow
> @@ -591,7 +666,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	 */
>  	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
>  		u32 vmlock;
> -		int ret;
>  
>  		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
>  		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
> @@ -876,7 +950,8 @@ static int vmd_resume(struct device *dev)
>  	.probe		= vmd_probe,
>  	.remove		= vmd_remove,
>  	.driver		= {
> -		.pm	= &vmd_dev_pm_ops,
> +		.pm		= &vmd_dev_pm_ops,
> +		.dev_groups	= vmd_dev_groups,
>  	},
>  };
>  module_pci_driver(vmd_drv);
> -- 
> 1.8.3.1
> 

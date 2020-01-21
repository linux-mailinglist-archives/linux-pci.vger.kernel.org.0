Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07511143F36
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgAUORP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 09:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUORP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jan 2020 09:17:15 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 375D02087E;
        Tue, 21 Jan 2020 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579616234;
        bh=eGP8z6dxRF+W8utN64emYHnd98d13UH+DfvCNXZYpbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c22eyzSNHY9dnn++zti3b8e+NUbi3X6N4cx3YafkTKPC/QYJR9gCHla3sKAoq8exI
         sD6SQ96r4j2pM9OcN9VGUk9UdefZ+bIwiRM85+79oMDyeopexe8rimq4v9Ac+TLcCE
         u+aSjnd+zRJ320sQUc+MpMiLybHnLjdUhYjnw2zc=
Date:   Tue, 21 Jan 2020 08:17:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
Message-ID: <20200121141712.GA94911@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101052648.14295-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, thread at https://lore.kernel.org/r/20200101052648.14295-1-baolu.lu@linux.intel.com]

On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have its iommu_passthrough bit in struct
> device set. This is very similar to the existing 'disable_acs_redir'
> parameter.

Almost all of this patchset is in drivers/iommu.  Should the parameter
be "iommu ..." instead of "pci=iommu_passthrough=..."?

There is already an "iommu.passthrough=" argument.  Would this fit
better there?  Since the iommu_passthrough bit is generic, it seems
like you anticipate similar situations for non-PCI devices.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  drivers/pci/pci.c                             | 34 +++++++++++++++++++
>  drivers/pci/pci.h                             |  1 +
>  drivers/pci/probe.c                           |  2 ++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..d3edc2cb6696 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3583,6 +3583,11 @@
>  				may put more devices in an IOMMU group.
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
> +		iommu_passthrough=<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will bypass IOMMU DMA
> +				translation.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 90dbd7c70371..05bf3f4acc36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_fixup_cardbus);
>  
> +static const char *iommu_passthrough_param;
> +bool pci_iommu_passthrough_match(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p = iommu_passthrough_param;
> +
> +	if (!p)
> +		return false;
> +
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
> +				     iommu_passthrough_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			pci_info(dev, "PCI: IOMMU passthrough\n");
> +			return true;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	return false;
> +}
> +
>  static int __init pci_setup(char *str)
>  {
>  	while (str) {
> @@ -6462,6 +6493,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "iommu_passthrough=", 18)) {
> +				iommu_passthrough_param = str + 18;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> @@ -6486,6 +6519,7 @@ static int __init pci_realloc_setup_params(void)
>  	resource_alignment_param = kstrdup(resource_alignment_param,
>  					   GFP_KERNEL);
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
> +	iommu_passthrough_param = kstrdup(iommu_passthrough_param, GFP_KERNEL);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a0a53bd05a0b..95f6af06aba6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -288,6 +288,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>  void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
> +bool pci_iommu_passthrough_match(struct pci_dev *dev);
>  
>  /* PCIe link information */
>  #define PCIE_SPEED2STR(speed) \
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..4c571ee75621 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2404,6 +2404,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  
>  	dev->state_saved = false;
>  
> +	dev->dev.iommu_passthrough = pci_iommu_passthrough_match(dev);
> +
>  	pci_init_capabilities(dev);
>  
>  	/*
> -- 
> 2.17.1
> 

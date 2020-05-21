Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69CA1DD7BB
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgEUT5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgEUT5R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 15:57:17 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75DF20738;
        Thu, 21 May 2020 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590091037;
        bh=3GAvSfAMUddifLPCHvTDvFY432iF5D80Ue+hjq5ma/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gLbu0zhdPVgG7Aa7IJPzjZ012leZ59yB44+hm4Djnqe8e9igB7XrDDOqwRrCvIVps
         VGzPP6kAzLHPckkBWX0D0Xq9iZwTRZN5nDCIv9E4wOlxFcjK/Q0L66P9VnXc+BbvIF
         b1FuHaozN67QS9jwH61wycwEOTtGQA/LP4ZnnrZo=
Date:   Thu, 21 May 2020 14:57:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 08/12] of/irq: make of_msi_map_get_device_domain() bus
 agnostic
Message-ID: <20200521195715.GA1171267@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521130008.8266-9-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 02:00:04PM +0100, Lorenzo Pieralisi wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
> 
> of_msi_map_get_device_domain() is PCI specific but it need not be and
> can be easily changed to be bus agnostic in order to be used by other
> busses by adding an IRQ domain bus token as an input parameter.
> 
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/msi.c

> ---
>  drivers/of/irq.c       | 8 +++++---
>  drivers/pci/msi.c      | 2 +-
>  include/linux/of_irq.h | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a296eaf52a5b..48a40326984f 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -613,18 +613,20 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
>   * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
>   * @dev: device for which the mapping is to be done.
>   * @rid: Requester ID for the device.
> + * @bus_token: Bus token
>   *
>   * Walk up the device hierarchy looking for devices with a "msi-map"
>   * property.
>   *
>   * Returns: the MSI domain for this device (or NULL on failure)
>   */
> -struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
> +struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
> +						u32 bus_token)
>  {
>  	struct device_node *np = NULL;
>  
> -	__of_msi_map_rid(dev, &np, rid);
> -	return irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	__of_msi_map_rid(dev, &np, id);
> +	return irq_find_matching_host(np, bus_token);
>  }
>  
>  /**
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 74a91f52ecc0..9532e1d12d3f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1556,7 +1556,7 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  	u32 rid = pci_dev_id(pdev);
>  
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> -	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
> +	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
>  	if (!dom)
>  		dom = iort_get_device_domain(&pdev->dev, rid,
>  					     DOMAIN_BUS_PCI_MSI);
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 1214cabb2247..7142a3722758 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -52,7 +52,8 @@ extern struct irq_domain *of_msi_get_domain(struct device *dev,
>  					    struct device_node *np,
>  					    enum irq_domain_bus_token token);
>  extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> -						       u32 rid);
> +							u32 id,
> +							u32 bus_token);
>  extern void of_msi_configure(struct device *dev, struct device_node *np);
>  u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
>  #else
> @@ -85,7 +86,7 @@ static inline struct irq_domain *of_msi_get_domain(struct device *dev,
>  	return NULL;
>  }
>  static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
> -							      u32 rid)
> +						u32 id, u32 bus_token)
>  {
>  	return NULL;
>  }
> -- 
> 2.26.1
> 

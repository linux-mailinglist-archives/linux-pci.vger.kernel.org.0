Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB11F1DD7AF
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgEUT4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgEUT4r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 15:56:47 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226AE20829;
        Thu, 21 May 2020 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590091006;
        bh=3pPxhsoMN8AFg9ooaYG2vkfeO0yylrZ+Y4cUkEkWdkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZEHVBYHLP72nxe38Sw3h1kSXw8ATmk0v5q21R9wchW+xahwMzGbEsDbJgb9EZnlnh
         v7ZanNXBfhlz6GdwVLqNlJXzxGPRQvEBqIMn57kkP7P7rFZALfVOjFui0msOei15uL
         FR4uSaRrm7XQSfofT1IQKrYTYOGx9AwA5sXJqQIE=
Date:   Thu, 21 May 2020 14:56:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH 02/12] ACPI/IORT: Make iort_get_device_domain IRQ domain
 agnostic
Message-ID: <20200521195644.GA1171134@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521130008.8266-3-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 01:59:58PM +0100, Lorenzo Pieralisi wrote:
> iort_get_device_domain() is PCI specific but it need not be,
> since it can be used to retrieve IRQ domain nexus of any kind
> by adding an irq_domain_bus_token input to it.
> 
> Make it PCI agnostic by also renaming the requestor ID input
> to a more generic ID name.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/msi.c

> ---
>  drivers/acpi/arm64/iort.c | 14 +++++++-------
>  drivers/pci/msi.c         |  3 ++-
>  include/linux/acpi_iort.h |  7 ++++---
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7cfd77b5e6e8..8f2a961c1364 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -567,7 +567,6 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
>  		node = iort_get_iort_node(dev->fwnode);
>  		if (node)
>  			return node;
> -
>  		/*
>  		 * if not, then it should be a platform device defined in
>  		 * DSDT/SSDT (with Named Component node in IORT)
> @@ -658,13 +657,13 @@ static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
>  /**
>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>   * @dev: The device.
> - * @req_id: Device's requester ID
> + * @id: Device's ID
>   * @idx: Index of the ITS identifier list.
>   * @its_id: ITS identifier.
>   *
>   * Returns: 0 on success, appropriate error value otherwise
>   */
> -static int iort_dev_find_its_id(struct device *dev, u32 req_id,
> +static int iort_dev_find_its_id(struct device *dev, u32 id,
>  				unsigned int idx, int *its_id)
>  {
>  	struct acpi_iort_its_group *its;
> @@ -674,7 +673,7 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
>  	if (!node)
>  		return -ENXIO;
>  
> -	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
> +	node = iort_node_map_id(node, id, NULL, IORT_MSI_TYPE);
>  	if (!node)
>  		return -ENXIO;
>  
> @@ -697,19 +696,20 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
>   *
>   * Returns: the MSI domain for this device, NULL otherwise
>   */
> -struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
> +struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
> +					  enum irq_domain_bus_token bus_token)
>  {
>  	struct fwnode_handle *handle;
>  	int its_id;
>  
> -	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
> +	if (iort_dev_find_its_id(dev, id, 0, &its_id))
>  		return NULL;
>  
>  	handle = iort_find_domain_token(its_id);
>  	if (!handle)
>  		return NULL;
>  
> -	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> +	return irq_find_matching_fwnode(handle, bus_token);
>  }
>  
>  static void iort_set_device_domain(struct device *dev,
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7a..74a91f52ecc0 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1558,7 +1558,8 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
>  	if (!dom)
> -		dom = iort_get_device_domain(&pdev->dev, rid);
> +		dom = iort_get_device_domain(&pdev->dev, rid,
> +					     DOMAIN_BUS_PCI_MSI);
>  	return dom;
>  }
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 8e7e2ec37f1b..08ec6bd2297f 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -29,7 +29,8 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
>  #ifdef CONFIG_ACPI_IORT
>  void acpi_iort_init(void);
>  u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> -struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
> +struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
> +					  enum irq_domain_bus_token bus_token);
>  void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
> @@ -40,8 +41,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  { return req_id; }
> -static inline struct irq_domain *iort_get_device_domain(struct device *dev,
> -							u32 req_id)
> +static inline struct irq_domain *iort_get_device_domain(
> +	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
>  { return NULL; }
>  static inline void acpi_configure_pmsi_domain(struct device *dev) { }
>  /* IOMMU interface */
> -- 
> 2.26.1
> 

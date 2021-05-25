Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F8390D00
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 01:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEYXlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 19:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhEYXll (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 19:41:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE07D61402;
        Tue, 25 May 2021 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621986011;
        bh=d9t4GCdLUZ0RmVXyDwtszyEPaUZjSQM6gFXZJsMIRQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r1WDTSTszj3Gd4YuG6XMbWLSptU8naD7mSHWp9bpNLrj7w365RjKn3/tKyuMHYCm2
         liISS1yJkwz5TegTylYhaGK0q7juB2ZoMwIk9Q7dQ4v7rvKgXh22cvYEQEGm6GPuRG
         xAJLAJFkU9Te8AVU/nlfwvEwBGC6cQln/PJk2VsmSsqXhYOP599biMmE5/Rsprh+Q2
         BjZVGPgt0PKMsSFX46o3524c9SWNNvTuOc7PRBMb42/ZkXrasvMvUb/EhMvoMz5rU3
         g/Dr9b5lQXyZYdks0Pvl/4gT4rHAmJPrNPy4I54/labWwrotW6hyrBpEk3N9ky8EAP
         /KrIxH4pFe+SQ==
Date:   Tue, 25 May 2021 18:40:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bhelgaas@google.com, maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Fix MSIs for generic hosts that use
 device-tree's "msi-map"
Message-ID: <20210525234009.GA1242540@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510173129.750496-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 07:31:30PM +0200, Jean-Philippe Brucker wrote:
> Since commit 9ec37efb8783 ("PCI/MSI: Make pci_host_common_probe()
> declare its reliance on MSI domains"), platforms that rely on the
> "msi-map" device-tree property don't get MSIs anymore.
> 
> On the Arm Fast Model for example [1], the host bridge doesn't have a
> "msi-parent" property since it doesn't itself generate MSIs, and so
> doesn't get a MSI domain. It has an "msi-map" property instead to
> describe MSI controllers of child devices. As a result, due to the new
> msi_domain check in pci_register_host_bridge(), the whole bus gets
> PCI_BUS_FLAGS_NO_MSI.
> 
> Check whether the root complex has an "msi-map" property before giving
> up on MSIs.
> 
> [1] arch/arm64/boot/dts/arm/fvp-base-revc.dts
> 
> Fixes: 9ec37efb8783 ("PCI/MSI: Make pci_host_common_probe() declare its reliance on MSI domains")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Applied to for-linus for v5.13, since we merged 9ec37efb8783 for
v5.13-rc1.  Thanks!

> ---
>  include/linux/pci.h | 2 ++
>  drivers/pci/of.c    | 7 +++++++
>  drivers/pci/probe.c | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..24306504226a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2344,6 +2344,7 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
>  struct device_node;
>  struct irq_domain;
>  struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
> +bool pci_host_of_has_msi_map(struct device *dev);
>  
>  /* Arch may override this (weak) */
>  struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
> @@ -2351,6 +2352,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
>  #else	/* CONFIG_OF */
>  static inline struct irq_domain *
>  pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
> +static inline bool pci_host_of_has_msi_map(struct device *dev) { return false; }
>  #endif  /* CONFIG_OF */
>  
>  static inline struct device_node *
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..85dcb7097da4 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -103,6 +103,13 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
>  #endif
>  }
>  
> +bool pci_host_of_has_msi_map(struct device *dev)
> +{
> +	if (dev && dev->of_node)
> +		return of_get_property(dev->of_node, "msi-map", NULL);
> +	return false;
> +}
> +
>  static inline int __of_pci_pci_compare(struct device_node *node,
>  				       unsigned int data)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8869..275204646c68 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -925,7 +925,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	device_enable_async_suspend(bus->bridge);
>  	pci_set_bus_of_node(bus);
>  	pci_set_bus_msi_domain(bus);
> -	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev))
> +	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
> +	    !pci_host_of_has_msi_map(parent))
>  		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>  
>  	if (!parent)
> -- 
> 2.31.1
> 

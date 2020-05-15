Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25A21D5B54
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEOVSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 17:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOVSX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 17:18:23 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B7F205CB;
        Fri, 15 May 2020 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589577503;
        bh=ZQ43XWvnomP6iief7qgRRbmyG/Bi9bziKV7eLxey5z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iYw1rXpYC7+iTiovQH69ZJN7ikDy6fxVEhYEdV1ssHJazsWRNLymxAPARP3cwPsrF
         MgKv6QPMsHDyZenI3gXiYZA2LWLuoVh7agD+i9unX1itmKntZUFYS9KRoZeKACj6y1
         SvAGo7FPYdfzQx+wZlqZKyL/uju5rWadJrrwKKik=
Date:   Fri, 15 May 2020 16:18:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, will@kernel.org, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 1/4] PCI/ATS: Only enable ATS for trusted devices
Message-ID: <20200515211820.GA545575@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104359.1178606-2-jean-philippe@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 12:43:59PM +0200, Jean-Philippe Brucker wrote:
> Add pci_ats_supported(), which checks whether a device has an ATS
> capability, and whether it is trusted.  A device is untrusted if it is
> plugged into an external-facing port such as Thunderbolt and could be
> spoof an existing device to exploit weaknesses in the IOMMU
> configuration.  PCIe ATS is one such weaknesses since it allows
> endpoints to cache IOMMU translations and emit transactions with
> 'Translated' Address Type (10b) that partially bypass the IOMMU
> translation.
> 
> The SMMUv3 and VT-d IOMMU drivers already disallow ATS and transactions
> with 'Translated' Address Type for untrusted devices.  Add the check to
> pci_enable_ats() to let other drivers (AMD IOMMU for now) benefit from
> it.
> 
> By checking ats_cap, the pci_ats_supported() helper also returns whether
> ATS was globally disabled with pci=noats, and could later include more
> things, for example whether the whole PCIe hierarchy down to the
> endpoint supports ATS.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci-ats.h |  3 +++
>  drivers/pci/ats.c       | 18 +++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index d08f0869f1213e..f75c307f346de9 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -6,11 +6,14 @@
>  
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
> +bool pci_ats_supported(struct pci_dev *dev);
>  int pci_enable_ats(struct pci_dev *dev, int ps);
>  void pci_disable_ats(struct pci_dev *dev);
>  int pci_ats_queue_depth(struct pci_dev *dev);
>  int pci_ats_page_aligned(struct pci_dev *dev);
>  #else /* CONFIG_PCI_ATS */
> +static inline bool pci_ats_supported(struct pci_dev *d)
> +{ return false; }
>  static inline int pci_enable_ats(struct pci_dev *d, int ps)
>  { return -ENODEV; }
>  static inline void pci_disable_ats(struct pci_dev *d) { }
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f2d8d1fc..15fa0c37fd8e44 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,22 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +/**
> + * pci_ats_supported - check if the device can use ATS
> + * @dev: the PCI device
> + *
> + * Returns true if the device supports ATS and is allowed to use it, false
> + * otherwise.
> + */
> +bool pci_ats_supported(struct pci_dev *dev)
> +{
> +	if (!dev->ats_cap)
> +		return false;
> +
> +	return !dev->untrusted;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_supported);
> +
>  /**
>   * pci_enable_ats - enable the ATS capability
>   * @dev: the PCI device
> @@ -42,7 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	u16 ctrl;
>  	struct pci_dev *pdev;
>  
> -	if (!dev->ats_cap)
> +	if (!pci_ats_supported(dev))
>  		return -EINVAL;
>  
>  	if (WARN_ON(dev->ats_enabled))
> -- 
> 2.26.2
> 

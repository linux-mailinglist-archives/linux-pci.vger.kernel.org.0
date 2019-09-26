Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516E5BF942
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfIZSg6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 14:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfIZSg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 14:36:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37046206E0;
        Thu, 26 Sep 2019 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569523017;
        bh=xjjJ++Pq6pOD0Z6Bdeb/NVVwlH+p3eI+ZRk1UkqiyYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZcG3VjJrl3BAKIBfQjtCDBTWUYTWLaJXI7+Y00RIpzUCYRYonx4XTADUBDABzUZZ7
         gjTsHFXMiRyxUrIWm0oqpbpbQM1PPwiQSp21NUcXQdRFDrwMIIPaIhASUlwMCZmoVT
         KkVeQ62odeM+2uCiQIPN5atEcU1CJPJy1HRJHwBs=
Date:   Thu, 26 Sep 2019 13:36:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] PCI: Add pci_pr3_present() helper to check Power
 Resource for D3hot
Message-ID: <20190926183654.GA171415@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925114353.25600-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 07:43:53PM +0800, Kai-Heng Feng wrote:
> Add pci_pr3_present() to check whether the platform supplies _PR3 to
> tell us which power resources the device depends on when in D3hot. This
> information is useful to let drivers choose different runtime suspend
> behavior. A user will be add in next patch.
> 
> This is mostly the same as nouveau_pr3_present().
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Takashi will merge this along with the ALSA patch.

> ---
> v5:
> - Add wording suggestion from Bjorn.
> v4:
> - Let caller to find its upstream port device.
> 
>  drivers/pci/pci.c   | 16 ++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..d03f624d8928 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5856,6 +5856,22 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +bool pci_pr3_present(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return false;
> +
> +	return adev->power.flags.power_resources &&
> +		acpi_has_method(adev->handle, "_PR3");
> +}
> +EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f9088c89a534..1d15c5d49cdd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> +bool pci_pr3_present(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH
> -- 
> 2.17.1
> 

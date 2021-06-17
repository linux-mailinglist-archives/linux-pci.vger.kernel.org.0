Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B199D3ABE7D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhFQV7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFQV7t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:59:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A31B161241;
        Thu, 17 Jun 2021 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623967060;
        bh=lwviQ+uuIQe9j8mrtNw6CfBqI/l4gnXrBM+DGX2hOYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iTVv7fmyQRHZV/4nAyv1MShGWU1deIIsWuZeXzIUG7AKlY09sJ2S+9/tXXkKAKh3U
         pYfANKX/4KPRgDLg/mg8sdQaRxEcNjkry/5sLmGd41w86R1SBWTlWeGRePtaPM+frP
         AjXt1NHxSNxrSaC+SWvN6qbIRiN1bnD65FuWFScxddM1Wj2YhAfISkcgwoBKsqLTlN
         flwzEW4OIqHmgQkYX5+5WRy1r6vI2v42maoIdbfPuCo/8l0VUqAqGDuncmNw8uLtQY
         RpzEQ1ety1hAtIic1v2xdpCnk84t32Gm5K5inI/bFuhoIpzx7hIBa3r/d+apOKlbx0
         /bdNV9CmkhmcA==
Date:   Thu, 17 Jun 2021 16:57:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210617215734.GA3135430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-2-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, since he added pcie_flr()]

On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:
> Currently there is separate function pcie_has_flr() to probe if pcie flr is
> supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not.  Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.

I don't like the fact that we handle FLR differently from other types
of reset, so I do like the fact that this makes them more consistent.

> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
>  drivers/pci/pci.c                          | 62 ++++++++++++----------
>  drivers/pci/pcie/aer.c                     | 12 ++---
>  drivers/pci/quirks.c                       |  9 ++--
>  include/linux/pci.h                        |  2 +-
>  5 files changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> index facc8e6bc..15d6c8452 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	/* check flr support */
> -	if (pcie_has_flr(pdev))
> -		pcie_flr(pdev);
> +	pcie_reset_flr(pdev, 0);
>  
>  	pci_restore_state(pdev);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 452351025..3bf36924c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4611,32 +4611,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> -/**
> - * pcie_has_flr - check if a device supports function level resets
> - * @dev: device to check
> - *
> - * Returns true if the device advertises support for PCIe function level
> - * resets.
> - */
> -bool pcie_has_flr(struct pci_dev *dev)
> -{
> -	u32 cap;
> -
> -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> -		return false;
> -
> -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -	return cap & PCI_EXP_DEVCAP_FLR;
> -}
> -EXPORT_SYMBOL_GPL(pcie_has_flr);
> -
>  /**
>   * pcie_flr - initiate a PCIe function level reset
>   * @dev: device to reset
>   *
> - * Initiate a function level reset on @dev.  The caller should ensure the
> - * device supports FLR before calling this function, e.g. by using the
> - * pcie_has_flr() helper.
> + * Initiate a function level reset unconditionally on @dev without
> + * checking any flags and DEVCAP
>   */
>  int pcie_flr(struct pci_dev *dev)
>  {
> @@ -4659,6 +4639,31 @@ int pcie_flr(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
>  
> +/**
> + * pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: If set, only check if the device can be reset this way.
> + *
> + * Initiate a function level reset on @dev.
> + */
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	u32 cap;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);

Christoph added pcie_flr() with a60a2b73ba69 ("PCI: Export
pcie_flr()"), where the commit log says he split out the probing
because "non-core callers already know their hardware."

It *is* reasonable to expect that drivers know whether their device
supports FLR so they don't need to probe.

But we don't expose the "probe" argument outside the PCI core for any
other reset methods, and I would like to avoid that here.

It seems excessive to have to read PCI_EXP_DEVCAP every time.
PCI_EXP_DEVCAP_FLR is a read-only bit, and we should only need to look
at it once.

What I would really like here is a single bit in the pci_dev that we
could set at enumeration-time, e.g., something like this:

  struct pci_dev {
    ...
    unsigned int has_flr:1;
  };

  void set_pcie_port_type(...)    # during enumeration
  {
    pci_read_config_word(dev, pos + PCI_EXP_DEVCAP, &reg16);
    if (reg16 & PCI_EXP_DEVCAP_FLR)
      dev->has_flr = 1;
  }

  static void quirk_no_flr(...)
  {
    dev->has_flr = 0;             # get rid of PCI_DEV_FLAGS_NO_FLR_RESET
  }

  int pcie_flr(...)
  {
    if (!dev->has_flr)
      return -ENOTTY;

    if (!pci_wait_for_pending_transaction(dev))
      ...
  }

I think this should be enough that we could get rid of pcie_has_flr()
without having to expose the "probe" argument outside drivers/pci/.

Procedural note: if we *do* have to expose the "probe" argument, can
you arrange it to have the correct type before touching the drivers, so
we only have to touch the drivers once?

> +}
> +EXPORT_SYMBOL_GPL(pcie_reset_flr);
> +
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
>  	int pos;
> @@ -5139,11 +5144,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	rc = pci_dev_specific_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev)) {
> -		rc = pcie_flr(dev);
> -		if (rc != -ENOTTY)
> -			return rc;
> -	}
> +	rc = pcie_reset_flr(dev, 0);
> +	if (rc != -ENOTTY)
> +		return rc;
>  	rc = pci_af_flr(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
> @@ -5174,8 +5177,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	rc = pci_dev_specific_reset(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> +	rc = pcie_reset_flr(dev, 1);
> +	if (rc != -ENOTTY)
> +		return rc;
>  	rc = pci_af_flr(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ec943cee5..98077595a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	}
>  
>  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> -		if (pcie_has_flr(dev)) {
> -			rc = pcie_flr(dev);
> -			pci_info(dev, "has been reset (%d)\n", rc);
> -		} else {
> -			pci_info(dev, "not reset (no FLR support)\n");
> -			rc = -ENOTTY;
> -		}
> +		rc = pcie_reset_flr(dev, 0);
> +		if (!rc)
> +			pci_info(dev, "has been reset\n");
> +		else
> +			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
>  	} else {
>  		rc = pci_bus_error_reset(dev);
>  		pci_info(dev, "%s Port link has been reset (%d)\n",
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d85914afe..f977ba79a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3819,7 +3819,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>  	u32 cfg;
>  
>  	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
> -	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
>  		return -ENOTTY;
>  
>  	if (probe)
> @@ -3888,13 +3888,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>   */
>  static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  {
> -	if (!pcie_has_flr(dev))
> -		return -ENOTTY;
> +	int ret = pcie_reset_flr(dev, probe);
>  
>  	if (probe)
> -		return 0;
> -
> -	pcie_flr(dev);
> +		return ret;
>  
>  	msleep(250);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59..20b90c205 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1225,7 +1225,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
>  void pcie_print_link_status(struct pci_dev *dev);
> -bool pcie_has_flr(struct pci_dev *dev);
> +int pcie_reset_flr(struct pci_dev *dev, int probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
> -- 
> 2.31.1
> 

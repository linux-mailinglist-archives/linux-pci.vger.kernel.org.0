Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D3332B08
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCIPur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 10:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCIPuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Mar 2021 10:50:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88CCD65237;
        Tue,  9 Mar 2021 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615305020;
        bh=C2KURmoF452H6cLgfUG1uKnV5APjt9zFKZFiMh0PD48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ExZ8Dv2xTOYS/F15Y0UrXQQr7TqyloM1JWWWABKJNch3Lx7Vnk01mankWyzNQqg8x
         s/A25FX7tDpEll4uznKZ4ccMmqEk8FPYm90r02Qsm61EPrP8dugeRo53DuWVmSUgoU
         oJIrsNEJLU0kYVvWIohXLjcAL1/p3E0JIxfKS5uaJ9x7NOFUTVZ2F1HRW5oJTeDkw1
         XP7/n5kJksJ83O4l3/1gopSXewxrCH9VRTyj9kKMM1M5HtbZkv/2lPQ0XX/Xsza/sL
         IPHggzswjmCgBJFTANFhXt0P1CyqImumbRFMV/+R5LvvBIDyHyZg68R8bb5Ozn32PP
         6sM8RevA9sgPw==
Date:   Tue, 9 Mar 2021 09:50:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.dom,
        prime.zeng@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [RESEND PATCH] PCI: Factor functions of PCI function reset
Message-ID: <20210309155018.GA1894628@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605090123-14243-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Krzysztof]

On Wed, Nov 11, 2020 at 06:22:03PM +0800, Yicong Yang wrote:
> Previosly we use pci_probe_reset_function() to probe whehter a function
> can be reset and use __pci_reset_function_locked() to perform a function
> reset. These two functions have lots of common lines.

s/Previosly/Previously/
s/we use/we used/
s/whehter/whether/

I'm not a big fan of dual-purpose functions that decide whether to
probe or to reset based on a parameter.  Those two things just don't
seem semantically compatible.  But I do see your point about common
lines, and the underlying functions (pci_dev_specific_reset(),
pci_af_flr(), etc) already have that structure.

Let me think about this some more.

> Factor the two functions and reduce the redundancy.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pci.c   | 61 ++++++++++++++++-------------------------------------
>  drivers/pci/pci.h   |  2 +-
>  drivers/pci/probe.c |  2 +-
>  3 files changed, 20 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c549..e3e5f0f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5006,9 +5006,11 @@ static void pci_dev_restore(struct pci_dev *dev)
>  }
> 
>  /**
> - * __pci_reset_function_locked - reset a PCI device function while holding
> - * the @dev mutex lock.
> + * pci_probe_reset_function - check whether the device can be safely reset
> + *                            or reset a PCI device function while holding
> + *                            the @dev mutex lock.
>   * @dev: PCI device to reset
> + * @probe: Probe or not whether the device can be reset.
>   *
>   * Some devices allow an individual function to be reset without affecting
>   * other functions in the same device.  The PCI device must be responsive
> @@ -5022,10 +5024,10 @@ static void pci_dev_restore(struct pci_dev *dev)
>   * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
>   * etc.
>   *
> - * Returns 0 if the device function was successfully reset or negative if the
> - * device doesn't support resetting a single function.
> + * Returns 0 if the device function can be reset or was successfully reset.
> + * negative if the device doesn't support resetting a single function.
>   */
> -int __pci_reset_function_locked(struct pci_dev *dev)
> +int pci_probe_reset_function(struct pci_dev *dev, int probe)
>  {
>  	int rc;
> 
> @@ -5039,61 +5041,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	 * other error, we're also finished: this indicates that further
>  	 * reset mechanisms might be broken on the device.
>  	 */
> -	rc = pci_dev_specific_reset(dev, 0);
> +	rc = pci_dev_specific_reset(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev)) {
> +		if (probe)
> +			return 0;
>  		rc = pcie_flr(dev);
>  		if (rc != -ENOTTY)
>  			return rc;
>  	}
> -	rc = pci_af_flr(dev, 0);
> +	rc = pci_af_flr(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	rc = pci_pm_reset(dev, 0);
> +	rc = pci_pm_reset(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 0);
> +	rc = pci_dev_reset_slot_function(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> -	return pci_parent_bus_reset(dev, 0);
> +
> +	return pci_parent_bus_reset(dev, probe);
>  }
> -EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> 
> -/**
> - * pci_probe_reset_function - check whether the device can be safely reset
> - * @dev: PCI device to reset
> - *
> - * Some devices allow an individual function to be reset without affecting
> - * other functions in the same device.  The PCI device must be responsive
> - * to PCI config space in order to use this function.
> - *
> - * Returns 0 if the device function can be reset or negative if the
> - * device doesn't support resetting a single function.
> - */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> -
> -	might_sleep();
> -
> -	rc = pci_dev_specific_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> -	rc = pci_af_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -
> -	return pci_parent_bus_reset(dev, 1);
> +	return pci_probe_reset_function(dev, 0);
>  }
> +EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> 
>  /**
>   * pci_reset_function - quiesce and reset a PCI device function
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7c..73740dd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,7 +39,7 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
> 
> -int pci_probe_reset_function(struct pci_dev *dev);
> +int pci_probe_reset_function(struct pci_dev *dev, int probe);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d3712..793cc8a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2403,7 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
> 
>  	pcie_report_downtraining(dev);
> 
> -	if (pci_probe_reset_function(dev) == 0)
> +	if (pci_probe_reset_function(dev, 1) == 0)
>  		dev->reset_fn = 1;
>  }
> 
> --
> 2.8.1
> 

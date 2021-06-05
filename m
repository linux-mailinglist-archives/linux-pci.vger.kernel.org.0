Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9B39CB16
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFEU73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 16:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEU73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 16:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B71146138C;
        Sat,  5 Jun 2021 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622926661;
        bh=TPWZg+mnjUPfUy/j5QyNwvmf07qGh6lfvORxedAcVOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H+Nb4suT87C76SMQ1VGje5ufamKQyO9PDReKKtdCwlCQcz0QtoeVB1GPs6Tv87Om9
         RBOnsKfr1o9g2sr4iBhauCYTFm9G1/9GCTh3ckjTbieRIResqYT/lURd45zmyR3/BN
         xCF7MB/JgowNKU6e6nFtazeMFLcovrauZm751xVJ3gtCdmqznXq951DjirdSkCT5pl
         cr+wRf2aicAA8Mgry6dVhXhxk34yJ0UZ3k6fk5VfQ6OsboeNj6MJiSRYLub1zNUyyw
         MZ+8TI78b7F/J/V/sbcBZWG+JtOlEWCwz1AHOsL7sfn/ePmGYjFS44maQC0uD7+7VB
         rA6O2xL7zOnAA==
Date:   Sat, 5 Jun 2021 15:57:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v5 3/7] PCI: Remove reset_fn field from pci_dev
Message-ID: <20210605205739.GA2322756@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529192527.2708-4-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 30, 2021 at 12:55:23AM +0530, Amey Narkhede wrote:
> reset_fn field is used to indicate whether the
> device supports any reset mechanism or not.
> Deprecate use of reset_fn in favor of new
> reset_methods array which can be used to keep
> track of all supported reset mechanisms of a device
> and their ordering.
> The octeon driver is incorrectly using reset_fn field
> to detect if the device supports FLR or not. Use
> pcie_reset_flr to probe whether it supports
> FLR or not.

s/Deprecate use of/Remove/
("deprecate" means to disapprove of something, and you're doing more
than that :))

Rewrap above to fill 75 columns.  Separate paragraphs with blank
lines.  Add "()" after function names (mentioned elsewhere, but please
do it everywhere).

> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
>  drivers/pci/pci-sysfs.c                            | 2 +-
>  drivers/pci/pci.c                                  | 6 +++---
>  drivers/pci/probe.c                                | 1 -
>  drivers/pci/quirks.c                               | 2 +-
>  drivers/pci/remove.c                               | 1 -
>  include/linux/pci.h                                | 1 -
>  7 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> index 516f166ce..336d149ee 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
>  			oct->irq_name_storage = NULL;
>  		}
>  		/* Soft reset the octeon device before exiting */
> -		if (oct->pci_dev->reset_fn)
> +		if (!pcie_reset_flr(oct->pci_dev, 1))
>  			octeon_pci_flr(oct);
>  		else
>  			cn23xx_vf_ask_pf_to_do_flr(oct);
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index beb8d1f4f..316f70c3e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1367,7 +1367,7 @@ static umode_t pci_dev_reset_attr_is_visible(struct kobject *kobj,
>  {
>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (!pdev->reset_fn)
> +	if (!pci_reset_supported(pdev))
>  		return 0;
>  
>  	return a->mode;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67a2605d4..bbed852d9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5231,7 +5231,7 @@ int pci_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	if (!dev->reset_fn)
> +	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
>  
>  	pci_dev_lock(dev);
> @@ -5267,7 +5267,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	if (!dev->reset_fn)
> +	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
>  
>  	pci_dev_save_and_disable(dev);
> @@ -5290,7 +5290,7 @@ int pci_try_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	if (!dev->reset_fn)
> +	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
>  
>  	if (!pci_dev_trylock(dev))
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8cf532681..90fd4f61f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2405,7 +2405,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> -	dev->reset_fn = pci_reset_supported(dev);
>  }
>  
>  /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f977ba79a..e86cf4a3b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5589,7 +5589,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  
>  	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
>  	    pdev->subsystem_device != 0x222e ||
> -	    !pdev->reset_fn)
> +	    !pci_reset_supported(pdev))
>  		return;
>  
>  	if (pci_enable_device_mem(pdev))
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index dd12c2fcc..4c54c7505 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -19,7 +19,6 @@ static void pci_stop_dev(struct pci_dev *dev)
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> -		dev->reset_fn = 0;
>  
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0955246f8..6e9bc4f9c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -429,7 +429,6 @@ struct pci_dev {
>  	unsigned int	state_saved:1;
>  	unsigned int	is_physfn:1;
>  	unsigned int	is_virtfn:1;
> -	unsigned int	reset_fn:1;
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> -- 
> 2.31.1
> 

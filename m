Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5033A8F2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 00:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCNXww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 19:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCNXwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Mar 2021 19:52:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5A2864E76;
        Sun, 14 Mar 2021 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615765971;
        bh=g14k8DNjiTg7h5ZIKFA3+OAP9KpKDeQ09DyhYA64vRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFyQ7IxcK+7G7s4qyWr+HpTbH320rvi/z76ILEiS7euBdXx90uUV6gq4HHJ3XoXnK
         90VT1Jngmeg6an02YNT3PhqoadRckO4kH1FWezj6DBd0g9vIh77ops8FS8ipZq6qJZ
         gKa8dIUppxphzPlpi02Dc8hCNsCz5Fb99cE3vaKHzpyiRZdD7oBceHCAXGy9AULosh
         o5tAkdUfKwYJIzJqe6WPYOV72Q7CyWNA32/0peTUxGkTm/+JHL8U4IiRR5kvf2LnVz
         UaByH9V56xLjiHt09cYaPF2Lqrk8iEhQxRL1x8wUSeF2DTx1yHfXOX0QGbSVJw1LyJ
         kcI7tDQnowmAA==
Received: by pali.im (Postfix)
        id B1E4289B; Mon, 15 Mar 2021 00:52:48 +0100 (CET)
Date:   Mon, 15 Mar 2021 00:52:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     ameynarkhede03@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 3/4] PCI: Remove reset_fn field from pci_dev
Message-ID: <20210314235248.abcca4phc3h74lgz@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-4-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312173452.3855-4-ameynarkhede03@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 March 2021 23:04:51 ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> reset_fn field is used to indicate whether the
> device supports any reset mechanism or not.
> Deprecate use of reset_fn in favor of new
> reset_methods bitmap which can be used to keep
> track of all supported reset mechanisms of a device.

Hello Amey!

You cannot trigger PCIe Hot Reset (PCI secondary bus reset) in this
simple way from sysfs via new reset methods.

I proposed very similar functionality just few days ago:
https://lore.kernel.org/linux-pci/20210301171221.3d42a55i7h5ubqsb@pali/T/#u

And I realized that it needs more steps to be done.

At least some remove-reset-rescan procedure done atomically is required.

> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 2 +-
>  drivers/pci/pci-sysfs.c                            | 6 ++----
>  drivers/pci/pci.c                                  | 6 +++---
>  drivers/pci/probe.c                                | 1 -
>  drivers/pci/quirks.c                               | 2 +-
>  include/linux/pci.h                                | 1 -
>  6 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> index 9b9d305c6..3e2c49e08 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
>  			oct->irq_name_storage = NULL;
>  		}
>  		/* Soft reset the octeon device before exiting */
> -		if (oct->pci_dev->reset_fn)
> +		if (oct->pci_dev->reset_methods)
>  			octeon_pci_flr(oct);
>  		else
>  			cn23xx_vf_ask_pf_to_do_flr(oct);
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index f8afd54ca..78d2c130c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,7 +1334,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> 
>  	pcie_vpd_create_sysfs_dev_files(dev);
> 
> -	if (dev->reset_fn) {
> +	if (dev->reset_methods) {
>  		retval = device_create_file(&dev->dev, &dev_attr_reset);
>  		if (retval)
>  			goto error;
> @@ -1417,10 +1417,8 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  {
>  	pcie_vpd_remove_sysfs_dev_files(dev);
> -	if (dev->reset_fn) {
> +	if (dev->reset_methods)
>  		device_remove_file(&dev->dev, &dev_attr_reset);
> -		dev->reset_fn = 0;
> -	}
>  }
> 
>  /**
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 407b44e85..b7f6c6588 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5175,7 +5175,7 @@ int pci_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
> 
> -	if (!dev->reset_fn)
> +	if (!dev->reset_methods)
>  		return -ENOTTY;
> 
>  	pci_dev_lock(dev);
> @@ -5211,7 +5211,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int rc;
> 
> -	if (!dev->reset_fn)
> +	if (!dev->reset_methods)
>  		return -ENOTTY;
> 
>  	pci_dev_save_and_disable(dev);
> @@ -5234,7 +5234,7 @@ int pci_try_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
> 
> -	if (!dev->reset_fn)
> +	if (!dev->reset_methods)
>  		return -ENOTTY;
> 
>  	if (!pci_dev_trylock(dev))
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 01dd037bd..4764e031a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
> 
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> -	dev->reset_fn = !!dev->reset_methods;
>  }
> 
>  /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0a3df84c9..20a81b1bc 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5535,7 +5535,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> 
>  	if (pdev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
>  	    pdev->subsystem_device != 0x222e ||
> -	    !pdev->reset_fn)
> +	    !pdev->reset_methods)
>  		return;
> 
>  	if (pci_enable_device_mem(pdev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 56d6e4750..a2f003f4e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -437,7 +437,6 @@ struct pci_dev {
>  	unsigned int	state_saved:1;
>  	unsigned int	is_physfn:1;
>  	unsigned int	is_virtfn:1;
> -	unsigned int	reset_fn:1;
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> --
> 2.30.2

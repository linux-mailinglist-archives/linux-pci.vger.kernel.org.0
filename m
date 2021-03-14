Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476E33A8EF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 00:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCNXwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 19:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCNXvs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Mar 2021 19:51:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D7264DFD;
        Sun, 14 Mar 2021 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615765908;
        bh=TCH0XlPssZVBCrF/57Bwz8SvVdCaoN9rNUbE8rH6CWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGV6c//1hfum/nEbk0vCXM00/VDPaLJ6ZHrv1Lf/82XCdiJrJfnvRW7/MfB7kX5eL
         NaGhhUTAYE1tVPQXJ7qt5GDOWrbsEJAo8P5LAMxTypOT5AhSetXk6unF9O5+X+wWza
         qh3i60jz9n3C3bhX5uBYXsPwsYzVxPJFbsA5a/7H4eY+1qhstf400IFRCLVyu6sior
         fCTsbhbqB1VvN7HasET2GLmQNV3fjDjzO8WAAjaBU5OJcYT9FzsT+HceGtCZTMl/L9
         qgAfz3acDy4AI1K2kHyRhwVd8Zu5xwkD84yX+fmo9/djr6jPsuSzMbEMzz8SXAkmdK
         5UclpZyE4xqOw==
Received: by pali.im (Postfix)
        id B8B9789B; Mon, 15 Mar 2021 00:51:44 +0100 (CET)
Date:   Mon, 15 Mar 2021 00:51:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     ameynarkhede03@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 2/4] PCI: Add new bitmap for keeping track of supported
 reset mechanisms
Message-ID: <20210314235144.as3hcpmwuxrwouec@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-3-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312173452.3855-3-ameynarkhede03@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 March 2021 23:04:50 ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> Introduce a new bitmap reset_methods in struct pci_dev
> to keep track of reset mechanisms supported by the
> device. Also refactor probing and reset functions
> to take advantage of calling convention of reset
> functions.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
>  drivers/pci/pci.c   | 106 ++++++++++++++++++++++++--------------------
>  drivers/pci/pci.h   |  11 ++++-
>  drivers/pci/probe.c |   5 +--
>  include/linux/pci.h |  10 +++++
>  4 files changed, 79 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4a7c084a3..407b44e85 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -40,6 +40,26 @@ const char *pci_power_names[] = {
>  };
>  EXPORT_SYMBOL_GPL(pci_power_names);
> 
> +static int pci_af_flr(struct pci_dev *dev, int probe);
> +static int pci_pm_reset(struct pci_dev *dev, int probe);
> +static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe);
> +static int pci_parent_bus_reset(struct pci_dev *dev, int probe);
> +
> +/*
> + * The ordering for functions in pci_reset_fn_methods
> + * is required for bitmap positions defined
> + * in reset_methods in struct pci_dev
> + */
> +const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> +	{ .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
> +	{ .reset_fn = &pcie_flr, .name = "flr" },
> +	{ .reset_fn = &pci_af_flr, .name = "af_flr" },
> +	{ .reset_fn = &pci_pm_reset, .name = "pm" },
> +	{ .reset_fn = &pci_dev_reset_slot_function, .name = "slot" },
> +	{ .reset_fn = &pci_parent_bus_reset, .name = "bus" },

Hello Amey! In the list of reset methods is missing PCIe Warm Reset.

Could you extend and prepare API also for PCIe Warm Reset? According to
PCI Express mini card and m.2 electromechanical specifications, PCIe
Warm Reset can be triggered by PERST# signal and more kernel drivers can
internally control PERST#. Just there is no kernel API and therefore
PCIe Warm Reset nor PERST# signal is unified.

> +	{ 0 },
> +};
> +
>  int isa_dma_bridge_buggy;
>  EXPORT_SYMBOL(isa_dma_bridge_buggy);
> 
> @@ -5080,71 +5100,59 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, rc = -ENOTTY;
> +	const struct pci_reset_fn_method *reset;
> 
>  	might_sleep();
> 
> -	/*
> -	 * A reset method returns -ENOTTY if it doesn't support this device
> -	 * and we should try the next method.
> -	 *
> -	 * If it returns 0 (success), we're finished.  If it returns any
> -	 * other error, we're also finished: this indicates that further
> -	 * reset mechanisms might be broken on the device.
> -	 */
> -	rc = pci_dev_specific_reset(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pcie_flr(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_af_flr(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	return pci_parent_bus_reset(dev, 0);
> +	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
> +		if (!(dev->reset_methods & (1 << i)))
> +			continue;
> +
> +		/*
> +		 * A reset method returns -ENOTTY if it doesn't support this device
> +		 * and we should try the next method.
> +		 *
> +		 * If it returns 0 (success), we're finished.  If it returns any
> +		 * other error, we're also finished: this indicates that further
> +		 * reset mechanisms might be broken on the device.
> +		 */
> +		rc = reset->reset_fn(dev, 0);
> +		if (rc != -ENOTTY)
> +			return rc;
> +	}
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> 
>  /**
> - * pci_probe_reset_function - check whether the device can be safely reset
> - * @dev: PCI device to reset
> + * pci_init_reset_methods - check whether device can be safely reset
> + * and store supported reset mechanisms.
> + * @dev: PCI device to check for reset mechanisms
>   *
>   * Some devices allow an individual function to be reset without affecting
>   * other functions in the same device.  The PCI device must be responsive
> - * to PCI config space in order to use this function.
> + * to reads and writes to its PCI config space in order to use this function.
>   *
> - * Returns 0 if the device function can be reset or negative if the
> - * device doesn't support resetting a single function.
> + * Stores reset mechanisms supported by device in reset_methods bitmap
> + * field of struct pci_dev
>   */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +void pci_init_reset_methods(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, rc;
> +	const struct pci_reset_fn_method *reset;
> 
> -	might_sleep();
> +	dev->reset_methods = 0;
> 
> -	rc = pci_dev_specific_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pcie_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_af_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_dev_reset_slot_function(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> +	might_sleep();
> 
> -	return pci_parent_bus_reset(dev, 1);
> +	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
> +		rc = reset->reset_fn(dev, 1);
> +		if (!rc)
> +			dev->reset_methods |= (1 << i);
> +		else if (rc != -ENOTTY)
> +			break;
> +	}
>  }
> 
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ef7c46613..ec093efdc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,7 +39,7 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
> 
> -int pci_probe_reset_function(struct pci_dev *dev);
> +void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> 
> @@ -612,6 +612,15 @@ struct pci_dev_reset_methods {
>  	int (*reset)(struct pci_dev *dev, int probe);
>  };
> 
> +typedef int (*pci_reset_fn_t)(struct pci_dev *, int);
> +
> +struct pci_reset_fn_method {
> +	pci_reset_fn_t reset_fn;
> +	char *name;
> +};
> +
> +extern const struct pci_reset_fn_method pci_reset_fn_methods[];
> +
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
>  #else
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc..01dd037bd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2403,9 +2403,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
> 
>  	pcie_report_downtraining(dev);
> -
> -	if (pci_probe_reset_function(dev) == 0)
> -		dev->reset_fn = 1;
> +	pci_init_reset_methods(dev);
> +	dev->reset_fn = !!dev->reset_methods;
>  }
> 
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 621ff5224..56d6e4750 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -325,6 +325,16 @@ struct pci_dev {
>  	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
>  	u8		revision;	/* PCI revision, low byte of class word */
>  	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
> +	/*
> +	 * bit 0 -> dev_specific
> +	 * bit 1 -> flr
> +	 * bit 2 -> af_flr
> +	 * bit 3 -> pm
> +	 * bit 4 -> slot
> +	 * bit 5 -> bus
> +	 * See pci_reset_fn_methods array in pci.c
> +	 */
> +	u8 __bitwise reset_methods;		/* bitmap for device supported reset capabilities */
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> --
> 2.30.2

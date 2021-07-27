Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA73D838F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 00:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhG0W7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 18:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232314AbhG0W7y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 18:59:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44B4E60EB2;
        Tue, 27 Jul 2021 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627426793;
        bh=f4DcOByZBXuJoost9Zw01aMhLfuIaKhd4rP2fFlb1FE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EZUXR0ULwxaGuuxD5+MMnbLrwcsd0rtGtSO9A86k4phLTMXH2gTs8XOP8DZY6JK4m
         mtzhHhxWGLSCW4ke2ObS1eyqqVMhdMWgisZuVTPZU/X9ZgE2PsiKApBDAgmbep2Q/q
         CKkyX6f2kifPMjViqJ0gZHVnsr7EilC82WJgXiSTsZGNSCixgKmotvNMMb9QtUdEAV
         XeY73nJ1+P5LfINTjKWuW80HuqeEFW0mcBjlpFpiABupnLvZZ0T1QinebhrdRbh2ys
         YsVr8iHsiveKsLJiS14a51pYBdFHLAdkxRm8nHRjyEhW+ukdlTS0pXYXNMDrEdDOmB
         zYaMFPBBnSPyQ==
Date:   Tue, 27 Jul 2021 17:59:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210727225951.GA752728@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709123813.8700-3-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 06:08:07PM +0530, Amey Narkhede wrote:
> Introduce a new array reset_methods in struct pci_dev to keep track of
> reset mechanisms supported by the device and their ordering.
> 
> Also refactor probing and reset functions to take advantage of calling
> convention of reset functions.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
>  drivers/pci/pci.h   |  9 ++++-
>  drivers/pci/probe.c |  5 +--
>  include/linux/pci.h |  7 ++++
>  4 files changed, 70 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fefa6d7b3..42440cb10 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  		msleep(delay);
>  }
>  
> +int pci_reset_supported(struct pci_dev *dev)
> +{
> +	u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
> +
> +	return memcmp(null_reset_methods,
> +		      dev->reset_methods, sizeof(null_reset_methods));

I think "return dev->reset_methods[0] != 0;" is sufficient, isn't it?

> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  int pci_domains_supported = 1;
>  #endif
> @@ -5104,6 +5112,15 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
>  
> +const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> +	{ },
> +	{ &pci_dev_specific_reset, .name = "device_specific" },
> +	{ &pcie_reset_flr, .name = "flr" },
> +	{ &pci_af_flr, .name = "af_flr" },
> +	{ &pci_pm_reset, .name = "pm" },
> +	{ &pci_reset_bus_function, .name = "bus" },
> +};

No need for "&" before the function names.

This should be static until it's needed outside this file.  You can
remove the "static" in the patch that adds the use in another file.

Looks like the only use is in pci-sysfs.c.  I think it might be better
to move the pci_dev_reset_method_attr_group and related stuff here to
pci.c and add an extern for it, as is done for aspm_ctrl_attr_group.

I know there's some trick that relies on the first element being
empty, and it's probably worth a one-line comment there to point it
out.  Maybe something like this?

  /* dev->reset_methods[] is a 0-terminated list of indices into this */

>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holding
>   * the @dev mutex lock.
> @@ -5126,65 +5143,62 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, m, rc = -ENOTTY;
>  
>  	might_sleep();
>  
>  	/*
> -	 * A reset method returns -ENOTTY if it doesn't support this device
> -	 * and we should try the next method.
> +	 * A reset method returns -ENOTTY if it doesn't support this device and
> +	 * we should try the next method.
>  	 *
> -	 * If it returns 0 (success), we're finished.  If it returns any
> -	 * other error, we're also finished: this indicates that further
> -	 * reset mechanisms might be broken on the device.
> +	 * If it returns 0 (success), we're finished.  If it returns any other
> +	 * error, we're also finished: this indicates that further reset
> +	 * mechanisms might be broken on the device.
>  	 */
> -	rc = pci_dev_specific_reset(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pcie_reset_flr(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_af_flr(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	return pci_reset_bus_function(dev, 0);
> +	for (i = 0; i <  PCI_NUM_RESET_METHODS && (m = dev->reset_methods[i]); i++) {

I'm not a huge fan of using assignments as a loop condition because
it's a little subtle.  Is there a way to restructure this, e.g.,

  for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
    m = dev->reset_methods[i];
    if (!m)
      return -ENOTTY;

    rc = pci_reset_fn_methods[m].reset_fn(dev, 0);

> +		rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
> +		if (!rc)
> +			return 0;
> +		if (rc != -ENOTTY)
> +			return rc;
> +	}
> +
> +	return -ENOTTY;
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

Since you're reworking this comment anyway, maybe update the "must be
responsive to PCI config space" comment to explicitly say the device
must be in D0-D3hot.

> - * Returns 0 if the device function can be reset or negative if the
> - * device doesn't support resetting a single function.
> + * Stores reset mechanisms supported by device in reset_methods byte array
> + * which is a member of struct pci_dev.
>   */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +void pci_init_reset_methods(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, n, rc;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
> +
> +	n = 0;

Move this init down to just before the loop that uses it.

> +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
>  
>  	might_sleep();
>  
> -	rc = pci_dev_specific_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pcie_reset_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_af_flr(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	rc = pci_pm_reset(dev, 1);
> -	if (rc != -ENOTTY)
> -		return rc;
> +	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> +		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
> +		if (!rc)
> +			reset_methods[n++] = i;

Why do we need this local reset_methods[] array?  Can we just fill
in dev->reset_methods[] directly and skip the memcpy() below?

> +		else if (rc != -ENOTTY)
> +			break;
> +	}
>  
> -	return pci_reset_bus_function(dev, 1);
> +	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 37c913bbc..db1ad94e7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -33,7 +33,8 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
>  
> -int pci_probe_reset_function(struct pci_dev *dev);
> +int pci_reset_supported(struct pci_dev *dev);
> +void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> @@ -606,6 +607,12 @@ struct pci_dev_reset_methods {
>  	int (*reset)(struct pci_dev *dev, int probe);
>  };
>  
> +struct pci_reset_fn_method {
> +	int (*reset_fn)(struct pci_dev *pdev, int probe);
> +	char *name;
> +};
> +
> +extern const struct pci_reset_fn_method pci_reset_fn_methods[];
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_reset(struct pci_dev *dev, int probe);
>  #else
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 072a3d4dc..bc4af914a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2406,9 +2406,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
>  
>  	pcie_report_downtraining(dev);
> -
> -	if (pci_probe_reset_function(dev) == 0)
> -		dev->reset_fn = 1;
> +	pci_init_reset_methods(dev);
> +	dev->reset_fn = pci_reset_supported(dev);
>  }
>  
>  /*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d432428fd..9f3e85f33 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -49,6 +49,9 @@
>  			       PCI_STATUS_SIG_TARGET_ABORT | \
>  			       PCI_STATUS_PARITY)
>  
> +/* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> +#define PCI_NUM_RESET_METHODS 6
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> @@ -506,6 +509,10 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
>  
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> +	/*
> +	 * See pci_reset_fn_methods array in pci.c for ordering.
> +	 */
> +	u8 reset_methods[PCI_NUM_RESET_METHODS];	/* Reset methods ordered by priority */
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> -- 
> 2.32.0
> 

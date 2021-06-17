Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7D3ABF38
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFQXPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 19:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhFQXPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 19:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C558D613B4;
        Thu, 17 Jun 2021 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623971587;
        bh=RoMqJ+Xfc+0bUt87yDdM4xkQnlr44KHav5UAmVRoGSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KI0K/h37NxrM9QrxlTZfUzvdisT868bsT53ZQVhzkRnWN8OLfFQF96CWrITUrQlI3
         +kxdhZTX9kl53iagpvoadpLIZoFzMPwSeAIC0txpxruPYUao94DE2In8OaWU9ntpJ1
         +GkFBsA6qRx3gHvmynShwS/fuPvdBwhlDoNConWUle68P/KJ6Nn34DEx9rZfgFv/sm
         2CghpST3Xal4v6NfH+7ef/Q3o0mDIwKoxPe7SeUJ3pG8K880UBlOOnUIRhB+zW/1qv
         bvA2tVaadLyc73Utfw8qsCna4x/oX/99q0DOuNo7jmI/+HTY1h9Bs1/7FBFoCSDtAD
         q1Xh39OJWNjYQ==
Date:   Thu, 17 Jun 2021 18:13:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210617231305.GA3139128@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-3-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Add new" in subject and below is slightly redundant.

On Tue, Jun 08, 2021 at 11:18:51AM +0530, Amey Narkhede wrote:
> Introduce a new array reset_methods in struct pci_dev to keep track of
> reset mechanisms supported by the device and their ordering.
> Also refactor probing and reset functions to take advantage of calling
> convention of reset functions.
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/pci.c   | 108 ++++++++++++++++++++++++++------------------
>  drivers/pci/pci.h   |   8 +++-
>  drivers/pci/probe.c |   5 +-
>  include/linux/pci.h |   7 +++
>  4 files changed, 81 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3bf36924c..39a9ea8bb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>  		msleep(delay);
>  }
>  
> +bool pci_reset_supported(struct pci_dev *dev)
> +{
> +	u8 null_reset_methods[PCI_RESET_METHODS_NUM] = { 0 };
> +
> +	return memcmp(null_reset_methods,
> +		      dev->reset_methods, PCI_RESET_METHODS_NUM);

memcmp() doesn't actually return a bool.  Either just return int
and rely on the C "anything non-zero is true, zero is false" or
convert the memcmp result to bool, i.e., something like:

  if (memcmp(...) == 0)
    return true;
  return false;

> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  int pci_domains_supported = 1;
>  #endif
> @@ -5107,6 +5115,18 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
>  
> +/*
> + * The ordering for functions in pci_reset_fn_methods is required for
> + * reset_methods byte array defined in struct pci_dev.

I'm not quite sure what this comment is telling me.  What breaks if I
change the order?  If I add a new method, how do I know where to put
it?

By reading the code, I infer that:

  - Each dev has dev->reset_methods[PCI_RESET_METHODS_NUM]

  - dev->reset_methods[i] corresponds to pci_reset_fn_methods[i]

  - dev->reset_methods[i] == 0 means dev doesn't support that method

  - Otherwise, dev->reset_methods[i] is a value in the range of
    [1, PCI_RESET_METHODS_NUM], and the higher the number, the higher
    the reset method priority

  - The order in pci_reset_fn_methods[] determines the initial
    priority via pci_init_reset_methods(), but the priority can be
    changed via sysfs

> + */
> +const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> +	{ &pci_dev_specific_reset, .name = "device_specific" },
> +	{ &pcie_reset_flr, .name = "flr" },
> +	{ &pci_af_flr, .name = "af_flr" },
> +	{ &pci_pm_reset, .name = "pm" },
> +	{ &pci_reset_bus_function, .name = "bus" },
> +};
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holding
>   * the @dev mutex lock.
> @@ -5129,65 +5149,67 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, rc = -ENOTTY;
> +	u8 prio;
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
> +	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (dev->reset_methods[i] == prio) {
> +				/*
> +				 * A reset method returns -ENOTTY if it doesn't
> +				 * support this device and we should try the
> +				 * next method.
> +				 *
> +				 * If it returns 0 (success), we're finished.
> +				 * If it returns any other error, we're also
> +				 * finished: this indicates that further reset
> +				 * mechanisms might be broken on the device.
> +				 */
> +				rc = pci_reset_fn_methods[i].reset_fn(dev, 0);
> +				if (rc != -ENOTTY)
> +					return rc;

Maybe leave the comment outside the loop where it used to be so the
text lines are longer and it's easier to read.

> +				break;
> +			}
> +		}
> +		if (i == PCI_RESET_METHODS_NUM)
> +			break;
> +	}
> +	return rc;

I wonder if this would be easier if dev->reset_methods[] contained
indices into pci_reset_fn_methods[], highest priority first, with the
priority being determined when dev->reset_methods[] is updated.  For
example:

  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
    { },                                                     # 0
    { &pci_dev_specific_reset, .name = "device_specific" },  # 1
    { &pci_dev_acpi_reset, .name = "acpi" },                 # 2
    { &pcie_reset_flr, .name = "flr" },                      # 3
    { &pci_af_flr, .name = "af_flr" },                       # 4
    { &pci_pm_reset, .name = "pm" },                         # 5
    { &pci_reset_bus_function, .name = "bus" },              # 6
  };

  dev->reset_methods[] = [1, 2, 3, 4, 5, 6]
    means all reset methods are supported, in the default priority
    order

  dev->reset_methods[] = [1, 0, 0, 0, 0, 0]
    means only pci_dev_specific_reset is supported

  dev->reset_methods[] = [3, 5, 0, 0, 0, 0]
    means pcie_reset_flr and pci_pm_reset are supported, in that
    priority order

Then we wouldn't need the nested loop and the return value would be
easier to analyze:

  for (i = 0; i < PCI_RESET_METHODS_NUM && (m = dev->reset_methods[i]); i++) {
    rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
    if (rc == 0)
      return 0;
    if (rc != -ENOTTY)
      return rc;
  }
  return -ENOTTY;

pci_init_reset_methods() would be something like:

  n = 0;
  for (i = 1; i < PCI_RESET_METHODS_NUM; i++) {
    rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
    if (!rc)
      dev->reset_methods[n++] = i;
    if (rc != -ENOTTY)
      return;
  }

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
> + * Stores reset mechanisms supported by device in reset_methods byte array
> + * which is a member of struct pci_dev.
>   */
> -int pci_probe_reset_function(struct pci_dev *dev)
> +void pci_init_reset_methods(struct pci_dev *dev)
>  {
> -	int rc;
> +	int i, rc;
> +	u8 prio = PCI_RESET_METHODS_NUM;
> +	u8 reset_methods[PCI_RESET_METHODS_NUM] = { 0 };
>  
> -	might_sleep();
> +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_RESET_METHODS_NUM);
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
> +	might_sleep();
>  
> -	return pci_reset_bus_function(dev, 1);
> +	for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
> +		if (!rc)
> +			reset_methods[i] = prio--;
> +		else if (rc != -ENOTTY)
> +			break;
> +	}
> +	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 37c913bbc..13ec6bd6f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -33,7 +33,7 @@ enum pci_mmap_api {
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  		  enum pci_mmap_api mmap_api);
>  
> -int pci_probe_reset_function(struct pci_dev *dev);
> +void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> @@ -606,6 +606,12 @@ struct pci_dev_reset_methods {
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
> index 3a62d09b8..8cf532681 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2404,9 +2404,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
> index 20b90c205..0955246f8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -49,6 +49,8 @@
>  			       PCI_STATUS_SIG_TARGET_ABORT | \
>  			       PCI_STATUS_PARITY)
>  
> +#define PCI_RESET_METHODS_NUM 5

I'm pretty sure this needs to be kept in sync with something, maybe
ARRAY_SIZE(pci_reset_fn_methods)?  We need some mechanism to enforce
this, or at the very least, a comment.  Oh, I see you have a
BUILD_BUG_ON() in pci_init_reset_methods().  That's good, but a
comment here would help, too.

This name should be something like "PCI_RESET_METHODS" or
"PCI_NUM_RESET_METHODS".  Putting "_NUM" at the end makes it sounds
like we're referring to one specific method.

>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> @@ -505,6 +507,10 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
>  
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> +	/*
> +	 * See pci_reset_fn_methods array in pci.c for ordering.
> +	 */
> +	u8 reset_methods[PCI_RESET_METHODS_NUM];	/* Reset methods ordered by priority */
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> @@ -1227,6 +1233,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_reset_flr(struct pci_dev *dev, int probe);
>  int pcie_flr(struct pci_dev *dev);
> +bool pci_reset_supported(struct pci_dev *dev);

This function isn't used outside drivers/pci/, so I'd rather have the
prototype in drivers/pci/pci.h.

>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_reset_function_locked(struct pci_dev *dev);
> -- 
> 2.31.1
> 

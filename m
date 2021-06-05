Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18D39CB10
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFEUzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 16:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhFEUzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 16:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39AA4613EF;
        Sat,  5 Jun 2021 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622926399;
        bh=Ignpn+45lUFZZoKhwyn5+pQJVDking0sb9LlCPA9BIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=prm+13VDhkw/2nOfheIhNwOJwacB0ZedJi0D/WhxInh5kYSfC5mh2ut2dQiqCWF1T
         RWYCIq3T21QpOUUcNT7bclremEdL5665+o7iW8hf045SWPd4JDtIciW54934kar/ZW
         shnzNIQa4arAM0BGUeYPrRJwlMQNTObGml6F7sKANoO9pTPga0JumPnSoeJyMb3FyO
         ahhdE1Ub4B0Tt+uDZ0e7alYD3etUBNKsr+frLkCAYmz4s7EFOMmawZ8WbdZLS2D02u
         n6bzpi5z9NPmGdqAYvwWIf5zc9PoaSIaKEecjb2D2eWjlIYIYdzLzwT5Rm6Jr6BRI8
         LHqaLziU94bvg==
Date:   Sat, 5 Jun 2021 15:53:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 5/7] PCI: Add support for a function level reset based
 on _RST method
Message-ID: <20210605205317.GA2254430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529192527.2708-6-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael in case you have any ideas about acpi_bind_one() below]

Mention ACPI in the subject, e.g.,

  PCI: Add support for ACPI _RST reset method

On Sun, May 30, 2021 at 12:55:25AM +0530, Amey Narkhede wrote:
> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device.
> 
> Implement a new reset function pci_dev_acpi_reset() for probing RST
> method and execute if it is defined in the firmware. The ACPI binding
> information is available only after calling device_add(). To consider
> _RST method, move pci_init_reset_methods() to end of pci_device_add()
> and craete two sysfs entries reset & reset_methond from
> pci_create_sysfs_dev_files()

s/craete/create/
s/reset_methond/reset_method/

> The default priority of the acpi reset is set to below device-specific
> and above hardware resets.

s/acpi/ACPI/

> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++---
>  drivers/pci/pci.c       | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/probe.c     |  2 +-
>  include/linux/pci.h     |  2 +-
>  4 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 04b3d6565..b332d7923 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1482,12 +1482,30 @@ static const struct attribute_group pci_dev_reset_attr_group = {
>  	.is_visible = pci_dev_reset_attr_is_visible,
>  };
>  
> +const struct attribute_group *pci_dev_reset_groups[] = {
> +	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
> +	NULL,
> +};

These should be static sysfs attributes if possible, e.g., see
e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute").
pci_create_sysfs_dev_files() will soon be removed completely.

>  int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  {
> +	int retval;
> +
>  	if (!sysfs_initialized)
>  		return -EACCES;
>  
> -	return pci_create_resource_files(pdev);
> +	retval = pci_create_resource_files(pdev);
> +	if (retval)
> +		return retval;
> +
> +	retval = device_add_groups(&pdev->dev, pci_dev_reset_groups);
> +	if (retval) {
> +		pci_remove_resource_files(pdev);
> +		return retval;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1501,6 +1519,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
>  	if (!sysfs_initialized)
>  		return;
>  
> +	device_remove_groups(&pdev->dev, pci_dev_reset_groups);
>  	pci_remove_resource_files(pdev);
>  }
>  
> @@ -1594,8 +1613,6 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_group,
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
> -	&pci_dev_reset_attr_group,
> -	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bbed852d9..4a7019d0b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5115,6 +5115,35 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
>  
> +/**
> + * pci_dev_acpi_reset - do a function level reset using _RST method
> + * @dev: device to reset
> + * @probe: check if _RST method is included in the acpi_device context.
> + */
> +static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> +{
> +#ifdef CONFIG_ACPI
> +	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> +
> +	/* Return -ENOTTY if _RST method is not included in the dev context */
> +	if (!handle || !acpi_has_method(handle, "_RST"))
> +		return -ENOTTY;
> +
> +	/* Return 0 for probe phase indicating that we can reset this device */
> +	if (probe)
> +		return 0;
> +
> +	/* Invoke _RST() method to perform a function level reset */

Superfluous comment.  Actually all the single-line comments here are
superfluous.

> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> +		pci_warn(dev, "Failed to reset the device\n");

The message should mention the type of reset, e.g., "ACPI _RST failed ..."

> +		return -EINVAL;
> +	}
> +	return 0;
> +#else
> +	return -ENOTTY;
> +#endif
> +}
> +
>  /*
>   * The ordering for functions in pci_reset_fn_methods
>   * is required for reset_methods byte array defined
> @@ -5122,6 +5151,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ &pci_dev_specific_reset, .name = "device_specific" },
> +	{ &pci_dev_acpi_reset, .name = "acpi" },
>  	{ &pcie_reset_flr, .name = "flr" },
>  	{ &pci_af_flr, .name = "af_flr" },
>  	{ &pci_pm_reset, .name = "pm" },
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 90fd4f61f..eeab791a0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2404,7 +2404,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
>  
>  	pcie_report_downtraining(dev);
> -	pci_init_reset_methods(dev);
>  }
>  
>  /*
> @@ -2495,6 +2494,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
> +	pci_init_reset_methods(dev);

This is a little sketchy.  We shouldn't be doing device config stuff
after device_add() because that's when it becomes available for
drivers to bind to the device.  If we do anything with the device
after that point, we may interfere with a driver.

I think the problem is that we don't call acpi_bind_one() until
device_add().  There's some hackery in pci-acpi.c to deal with a
similar problem for something else -- see acpi_pci_bridge_d3().

I don't know how to fix this yet.  Here's the call graph that I think
is relevant:

  pci_scan_single_device
    pci_scan_device
      pci_set_of_node
        dev->dev.of_node = of_pci_find_child_device()  <-- set OF stuff
    pci_device_add
      device_add
        device_platform_notify
          acpi_platform_notify
            case KOBJ_ADD:
              acpi_device_notify
                acpi_bind_one
                  ACPI_COMPANION_SET()       <-- sets ACPI_COMPANION
      pci_init_reset_methods
        pci_dev_acpi_reset(PCI_RESET_PROBE)
          handle = ACPI_HANDLE(&dev->dev)    <-- uses ACPI_COMPANION

I think it's kind of a general problem that we currently don't have
access to the ACPI stuff until *after* device_add().  I included
pci_set_of_node() in the graph above because that seems sort of
like an OF analogue of what acpi_bind_one() is doing.

I would really like to do the ACPI_COMPANION setup earlier, maybe
at the same time as pci_set_of_node().  But I don't know enough about
what acpi_bind_one() does -- there's a lot going on in there.

>  }
>  
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6e9bc4f9c..a7f063da2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -49,7 +49,7 @@
>  			       PCI_STATUS_SIG_TARGET_ABORT | \
>  			       PCI_STATUS_PARITY)
>  
> -#define PCI_RESET_METHODS_NUM 5
> +#define PCI_RESET_METHODS_NUM 6
>  
>  /*
>   * The PCI interface treats multi-function devices as independent
> -- 
> 2.31.1
> 

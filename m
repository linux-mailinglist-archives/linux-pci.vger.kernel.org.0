Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722E93700A2
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhD3Skj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 14:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhD3Skj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 14:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619807990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKM7JOerLxCkpDJY1rd1Atdc/Vr9eHPMO++f4IYLagk=;
        b=hkFMXrB3PuZIZzaqxttRZZ6aVM8FdzVV9NKunGmMvX+80uf/+i5m0ysb5AM+hVGUY8/obH
        1UqM2qo+0ATcQi+i6cLKHLo4VgBmfm6eprignyRcrkkIQAMU1zBzcdidJvKD9HhKur8uLT
        6gAAsvoz+k/FrHCu2oM28zTiKFExozQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-L8Vm7CR2M1GEMld4nERLwA-1; Fri, 30 Apr 2021 14:39:47 -0400
X-MC-Unique: L8Vm7CR2M1GEMld4nERLwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685F718BA280;
        Fri, 30 Apr 2021 18:39:46 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C14725D9CC;
        Fri, 30 Apr 2021 18:39:45 +0000 (UTC)
Date:   Fri, 30 Apr 2021 12:39:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Add support for a function level reset
 based on _RST method
Message-ID: <20210430123945.54dd479c@redhat.com>
In-Reply-To: <20210429004907.29044-1-sdonthineni@nvidia.com>
References: <20210429004907.29044-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Apr 2021 19:49:06 -0500
Shanker Donthineni <sdonthineni@nvidia.com> wrote:

> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device.
> 
> Implement a new reset function pci_dev_acpi_reset() for probing RST
> method and execute if it is defined in the firmware. The ACPI binding
> information is available only after calling device_add(), so move
> pci_init_reset_methods() to end of the pci_device_add().
> 
> The default priority of the acpi reset is set to below device-specific
> and above hardware resets.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
> changes since v2:
>  - fix typo in the commit text
> changes since v2:
>  - rebase patch on top of https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/
> 
>  drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/probe.c |  2 +-
>  include/linux/pci.h |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 664cf2d358d6..510f9224a3b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5076,6 +5076,35 @@ static void pci_dev_restore(struct pci_dev *dev)
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
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> +		pci_warn(dev, "Failed to reset the device\n");
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
> @@ -5083,6 +5112,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>   */
>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
> +	{ .reset_fn = &pci_dev_acpi_reset, .name = "acpi_reset" },

Would it make sense to name this "acpi_rst" after the method name?
Otherwise "_reset" is a bit redundant to the sysfs attribute, we could
simply name it "acpi" to indicate an ACPI based reset.  Thanks,

Alex


>  	{ .reset_fn = &pcie_reset_flr, .name = "flr" },
>  	{ .reset_fn = &pci_af_flr, .name = "af_flr" },
>  	{ .reset_fn = &pci_pm_reset, .name = "pm" },
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4764e031a44b..d4becd6ffb52 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2403,7 +2403,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
>  
>  	pcie_report_downtraining(dev);
> -	pci_init_reset_methods(dev);
>  }
>  
>  /*
> @@ -2494,6 +2493,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
> +	pci_init_reset_methods(dev);
>  }
>  
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9f8347799634..b4a5d2146542 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -49,7 +49,7 @@
>  			       PCI_STATUS_SIG_TARGET_ABORT | \
>  			       PCI_STATUS_PARITY)
>  
> -#define PCI_RESET_FN_METHODS 5
> +#define PCI_RESET_FN_METHODS 6
>  
>  /*
>   * The PCI interface treats multi-function devices as independent


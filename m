Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7F3B887A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhF3SgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 14:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232727AbhF3SgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 14:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625078018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiBpbTi9lZahUvrc1SknV50EoZVavTZWkMnk6dYLMBs=;
        b=V0tjbJfb09fl9Hr1tL8ZR1CBc1Z4qUNxhb1+UL2Md7T6v14jpb2b0cW63jm68ZZJc/3FzJ
        mt0J+TeksCkw105njJbqhJq7OAD0KaVE724fIoSR1HxxpsTKO1PknGrGGToyS8sNPYt9sr
        UwRPXUuH4BE3nwqATAmidHHtFOaAotc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-SdaDY2uCNIWIWFkfQnHuMQ-1; Wed, 30 Jun 2021 14:33:37 -0400
X-MC-Unique: SdaDY2uCNIWIWFkfQnHuMQ-1
Received: by mail-ot1-f70.google.com with SMTP id k11-20020a056830242bb0290400324955afso2244771ots.14
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 11:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiBpbTi9lZahUvrc1SknV50EoZVavTZWkMnk6dYLMBs=;
        b=heHJyWsiR34yKb2uInLwn6yHUYKKRvpcVCeKZj+iRNs//Y/qulrX/xxzgpFtmscxDD
         G98RJLW5CkwE8i9NIMI5hpsoyvJUpLBboSoMv5PXpQEMwTWcSb5eiayrttAh/pTbJbLS
         4XVA1HVtGnz6NBFdcIRFCdkJr7c/I3tddcQ/TWMqAM6QQfjhTG176OrfIRY4OWoTgDy7
         6rJ9Vy+m0kiGvqoSe3t2K1SwqWftXT0gtqC2m1yFGUcs4lvVfBaZ3TTiMnnZK8U2aCtR
         xZJ88JxEaTj2OtK2Kx+Qo9GyNOt7WAPklXxdcMr5jql/FhhPnT/U44bea0/VPf4nl1ih
         EVsA==
X-Gm-Message-State: AOAM533vYtryUa7gmIYYUIla+9AL8YKWRGzKYQvhYgszzX9AhGZFy/Xf
        Sv28eBWSBpXnG1KrRjZBf2mR0hUzxvu4wYI+blLcT/SCjPyOO6cmvJbeeIIYeXZr0GWhgdJoQ5I
        37SyTSHiELhQSAMxkINnN
X-Received: by 2002:a9d:5c7:: with SMTP id 65mr2716485otd.360.1625078016070;
        Wed, 30 Jun 2021 11:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAVMA2IahTHXj7U0/2PAB3UG6X5tHBThpMmLxZaoEC46VJZDrmV1dUfNJKLrq4mXpfsF+MLg==
X-Received: by 2002:a9d:5c7:: with SMTP id 65mr2716454otd.360.1625078015787;
        Wed, 30 Jun 2021 11:33:35 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id x5sm2940721oto.63.2021.06.30.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:33:35 -0700 (PDT)
Date:   Wed, 30 Jun 2021 12:33:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210630123334.45e8b376.alex.williamson@redhat.com>
In-Reply-To: <20210629160104.2893-3-ameynarkhede03@gmail.com>
References: <20210629160104.2893-1-ameynarkhede03@gmail.com>
        <20210629160104.2893-3-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Jun 2021 21:30:58 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

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
>  drivers/pci/pci.c   | 97 ++++++++++++++++++++++++++-------------------
>  drivers/pci/pci.h   |  9 ++++-
>  drivers/pci/probe.c |  5 +--
>  include/linux/pci.h |  7 ++++
>  4 files changed, 74 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 28f099a4f..1932c7ec4 100644
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
> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  int pci_domains_supported = 1;
>  #endif
> @@ -5101,6 +5109,19 @@ static void pci_dev_restore(struct pci_dev *dev)
>  		err_handler->reset_done(dev);
>  }
>  
> +/*
> + * The ordering for functions in pci_reset_fn_methods is required for
> + * reset_methods byte array defined in struct pci_dev.
> + */

Is this comment still relevant?  Ordering here defines the default
priority scheme, but now that index=priority rather than index=method
in reset_methods, I'm not sure these comments are very clear.  Thanks,

Alex

> +const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> +	{ },
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
> @@ -5123,65 +5144,61 @@ static void pci_dev_restore(struct pci_dev *dev)
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
> +	int i, n, rc;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>  
> -	might_sleep();
> +	n = 0;
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
> +	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
>  
> -	return pci_reset_bus_function(dev, 1);
> +	might_sleep();
> +
> +	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> +		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
> +		if (!rc)
> +			reset_methods[n++] = i;
> +		else if (rc != -ENOTTY)
> +			break;
> +	}
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
> index 862d91615..7355769f8 100644
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
> index 74f42a2cd..bce3d3e52 100644
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
> @@ -504,6 +507,10 @@ struct pci_dev {
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


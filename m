Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795C36C842
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhD0PGF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbhD0PGD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 11:06:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFBC061574;
        Tue, 27 Apr 2021 08:05:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m11so386220pfc.11;
        Tue, 27 Apr 2021 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ka4mgxC7C1AGi31EexliR03UvgiH+x0JS5YAWLBMMAw=;
        b=uqiUnGZm1TawoiIyYe2pXxDybblCIb24NftGTN9DOlQ/kCzxyWvQKUVfFpAsNmxXW6
         4Pu43l1IwedSn93iI/sy5Kqw4KxB8dMjsvVLDXUTgYaqSTnx6kcL/i1Fhhu0xxQWceO6
         ESgtZQFag8ukZ5JLS3BYtsbt28lWgxTyl/Iywy+vPIDYFZY692Hx4a/AIXxqp3FX45++
         g+JXRbtbv9JLZs7JxIZ08Q4pthY4pgWQPxo3+9s+S/jMqOZjqhP90TxE5Yl7X/o4HWK+
         KfNiBvMBhp378VWd1H5BJljK4BuI7lIT2YPPw1uFVDmojVnnjf5jxmpmAXUSSUslkm25
         wryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ka4mgxC7C1AGi31EexliR03UvgiH+x0JS5YAWLBMMAw=;
        b=L+b1ib73IZmlDZy0Hz/Hn2+n6Rg83YMR44aD6lFR3stFNduiu1N/PUQaGN1duKS+vy
         yovmGNhqJzVKoahUFTSMApYX1dU50cgczOCC4qFE6+U/HE+aUFg86BQWbdl077qJmR4L
         uE0T5hUDbbzISsxHnwpwnoEr6wcDrCNumCZ/ekx4cerJ1kzWb01MfYJoqfPlec36x3t/
         QKkkX0puwCMKq6DuYgZDluM3wV8/l9vXd9Qze9XoSn0Ll7O1k6VoJfYkdGs/jGoP/G7u
         eBUKVKjT1vMjotwgH8E/XALU+87G48H3HIkrnXIX1b3GqhlrUye6F5LhnIek/pbEPCpt
         9Yhg==
X-Gm-Message-State: AOAM533ZFRg3+xts1XCpAIRrcrcDE35BM3m4usUoFmVlF7OqeepPQIBQ
        IdlkWnIdt9T3BJSSNXdr+wg=
X-Google-Smtp-Source: ABdhPJwBjasGP4v2KwbPCTG/yrO/NjF56RV6IdAgrp5nK1eqT/+m4PeSZjmpT86fuMEkldrpvfpS4Q==
X-Received: by 2002:a65:4106:: with SMTP id w6mr22324174pgp.420.1619535919261;
        Tue, 27 Apr 2021 08:05:19 -0700 (PDT)
Received: from localhost ([103.248.31.152])
        by smtp.gmail.com with ESMTPSA id x3sm2913318pfj.95.2021.04.27.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 08:05:17 -0700 (PDT)
Date:   Tue, 27 Apr 2021 20:35:15 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v3 1/2] PCI: Add support for a function level reset based
 on _RST method
Message-ID: <20210427150515.vts6whtuxpkaztxr@archlinux>
References: <20210427145535.4034-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427145535.4034-1-sdonthineni@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/27 09:55AM, Shanker Donthineni wrote:
> The _RST is a standard method specified in the ACPI specification. It
> provides a function level reset when it is described in the acpi_device
> context associated with PCI-device.
>
> Implement a new reset function pci_dev_acpi_reset() for probing RST
> method and execute if it is defined in the firmware.
>
> The ACPI based reset is called after the device-specific reset and
> before standard PCI hardware resets.
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  - Fix typo in the commit text
>
>  drivers/pci/pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..6dadb19848c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5054,6 +5054,35 @@ static void pci_dev_restore(struct pci_dev *dev)
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
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holding
>   * the @dev mutex lock.
> @@ -5089,6 +5118,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	 * reset mechanisms might be broken on the device.
>  	 */
>  	rc = pci_dev_specific_reset(dev, 0);
> +	if (rc != -ENOTTY)
> +		return rc;
> +	rc = pci_dev_acpi_reset(dev, 0);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev)) {
> @@ -5127,6 +5159,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	might_sleep();
>
>  	rc = pci_dev_specific_reset(dev, 1);
> +	if (rc != -ENOTTY)
> +		return rc;
> +	rc = pci_dev_acpi_reset(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
>  	if (pcie_has_flr(dev))
> --
> 2.17.1
>
Would you like to rebase this patch on [1]?
Or should I send the v3?

[1]: https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/

Thanks,
Amey

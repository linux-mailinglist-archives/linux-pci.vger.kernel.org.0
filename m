Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9FE3695C4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhDWPMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 11:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237081AbhDWPMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Apr 2021 11:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2305B613D5;
        Fri, 23 Apr 2021 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619190726;
        bh=8Mkj5bXqM2cvFiGupG938Y/QnyU3NfrDfuKS5blpr08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jD20PlsbvdhCddy52R4Gpb3+mp9sbsN5mK9DcEUegwgXIsgvJNJdSyrv2j42xC7LS
         GlGjavrV+w7EJtijlqqDOm/SBrAqycY2V34hLtLSSsdr2/uYzE2dDmjGv7lo8sBAn1
         LyuAoz8siw4oM8pqMgT8gMF789tH6tnnobQGtlRHsipdMSuhZSpfEhA4y6QTQm5tql
         LiAbjK9lcvXn8vJ9ANHwKvOAU3l/C7zUfb7TioUcUIjmGULYQZCfgLZqgC3K9ItI8J
         VOCDOxU/ix7kt2Do+gTaVH4vZDYYt5BSz5HqOVjI3omDs9nbliNNCZ0+TQXo/pmYEQ
         ma4fADxmufwPg==
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
Date:   Fri, 23 Apr 2021 11:12:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423145402.14559-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Alex,

On 4/23/2021 10:54 AM, Shanker Donthineni wrote:
> +static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
> +{
> +#ifdef CONFIG_ACPI
> +	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> +
> +	/*
> +	 * Check for the affected devices' ID range. If device is not in
> +	 * the affected range, return -ENOTTY indicating no device
> +	 * specific reset method is available.
> +	 */
> +	if ((dev->device & 0xffc0) != 0x2340)
> +		return -ENOTTY;
> +
> +	/*
> +	 * Return -ENOTTY indicating no device-specific reset method if _RST
> +	 * method is not defined
> +	 */
> +	if (!handle || !acpi_has_method(handle, "_RST"))
> +		return -ENOTTY;
> +
> +	/* Return 0 for probe phase indicating that we can reset this device */
> +	if (probe)
> +		return 0;
> +
> +	/* Invoke _RST() method to perform the device-specific reset */
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
> +		pci_warn(dev, "Failed to reset the device\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +#else
> +	return -ENOTTY;
> +#endif
> +}

Interesting, some pieces of this function (especially the ACPI _RST)
could be generalized.

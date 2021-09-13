Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41F2409CF3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 21:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbhIMT3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 15:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241848AbhIMT3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 15:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE3D610D1;
        Mon, 13 Sep 2021 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561287;
        bh=xyo/fpG9HiJAEnyi93V7sSK9RQtZmJZIhxkYolMncds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KcAuA+FcOQuSlLJNw2sVTUYkrAu9R31Upge0DQjEFDnjrZFTTiqVEeNHo7YX1V2l3
         ubHbF6KKqct9o4DvHUtH+sf8FCJNiPoS4RMIFC10jMGDi5UjyImdS47xQcSn4z3GmM
         ccRKs66Ajltf5grD+uvq3Au3jEkBE5xevi65DLvXgXquHAQWvbx1JNullW/BfwhAEt
         nIPhKu35u1vjHxLRuSYEF+WrxuwyXqHvkW6VIIJm2Zcqgdyuws+qQaahH/lTk2Md8H
         egdhFm51POq/sLt/sbMiTLdWIyAxH2T9Mwm3+xgB5ZiVb6AgkMLSRzBVoXN0rEIy9F
         T6W8UMsc30+vg==
Date:   Mon, 13 Sep 2021 14:28:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Don't reset a fwnode set by OF
Message-ID: <20210913192805.GA1347289@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913172358.1775381-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Mon, Sep 13, 2021 at 06:23:59PM +0100, Jean-Philippe Brucker wrote:
> Commit 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time
> with OF") added a call to pci_set_acpi_fwnode() in pci_setup_device(),
> which unconditionally clears any fwnode previously set by
> pci_set_of_node().
> 
> pci_set_acpi_fwnode() looks for ACPI_COMPANION(), which only returns the
> existing fwnode if it was set by ACPI_COMPANION_SET(). If it was set by
> OF instead, ACPI_COMPANION() returns NULL and pci_set_acpi_fwnode()
> accidentally clears the fwnode. To fix this, look for any fwnode instead
> of just ACPI companions.
> 
> Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This fixes boot of virtio-iommu under OF on v5.15-rc1
> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a1b1e2a01632..483a9e50f6ca 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -937,7 +937,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev);
>  
>  void pci_set_acpi_fwnode(struct pci_dev *dev)
>  {
> -	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
> +	if (!dev->dev.fwnode && !pci_dev_is_added(dev))

I don't doubt that this is correct, but it seems excessively subtle,
like we're violating some layering or something.

Rafael, Rob, is there anything better we can do here?

>  		ACPI_COMPANION_SET(&dev->dev,
>  				   acpi_pci_find_companion(&dev->dev));
>  }
> -- 
> 2.33.0
> 

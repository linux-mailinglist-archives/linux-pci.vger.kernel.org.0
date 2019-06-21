Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE374EA01
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfFUN4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 09:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUN4V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 09:56:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B206E2083B;
        Fri, 21 Jun 2019 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561125381;
        bh=BBRLV5HK4wojUuRwh0Rs7j6ma6H9sAhgSFIRNIQgDhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBkgFZ78v39DEfSXuGiLLocJ+jUu/9obvwtDpFnq9msQlxrPRQNKcqCS1tzCrzzu9
         zcX6lYf5FN4xy5pbLwGx1vi+D/nXP3DNXAzTsefIFPkn7QSBaheUzxp4f51QG6Hs9d
         rPFDb7MuSom/wFM61ziIx+4IyV1xEZWrPphXDgf8=
Date:   Fri, 21 Jun 2019 08:56:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        joe@perches.com, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] bus: hisi_lpc: Add .remove method to avoid driver
 unbind crash
Message-ID: <20190621135619.GE82584@google.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <1561026716-140537-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561026716-140537-5-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-acpi]

On Thu, Jun 20, 2019 at 06:31:55PM +0800, John Garry wrote:
> The original driver author seemed to be under the impression that a driver
> cannot be removed if it does not have a .remove method. Or maybe if it is
> a built-in platform driver.
> 
> This is not true. This crash can be created:
> 
> root@ubuntu:/sys/bus/platform/drivers/hisi-lpc# echo HISI0191\:00 > unbind
> root@ubuntu:/sys/bus/platform/drivers/hisi-lpc# ipmitool raw 6 1
>  Unable to handle kernel paging request at virtual address ffff000010035010
> ...

> The problem here is that the host goes away but the associated logical PIO
> region remains registered, as do the child devices.
> 
> Fix by adding a .remove method to tidy-up by removing the child devices
> and unregistering the logical PIO region.
> 
> Fixes: adf38bb0b595 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/bus/hisi_lpc.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 6d301aafcad2..0e9f1f141c93 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -456,6 +456,17 @@ struct hisi_lpc_acpi_cell {
>  	size_t pdata_size;
>  };
>  
> +static void hisi_lpc_acpi_remove(struct device *hostdev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(hostdev);
> +	struct acpi_device *child;
> +
> +	device_for_each_child(hostdev, NULL, hisi_lpc_acpi_remove_subdev);
> +
> +	list_for_each_entry(child, &adev->children, node)
> +		acpi_device_clear_enumerated(child);

There are only two other non-ACPI core callers of
acpi_device_clear_enumerated() (i2c and spi).  That always makes me
wonder if we're getting too deep in ACPI internals.

> +}
> +
>  /*
>   * hisi_lpc_acpi_probe - probe children for ACPI FW
>   * @hostdev: LPC host device pointer
> @@ -555,8 +566,7 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>  	return 0;
>  
>  fail:
> -	device_for_each_child(hostdev, NULL,
> -			      hisi_lpc_acpi_remove_subdev);
> +	hisi_lpc_acpi_remove(hostdev);
>  	return ret;
>  }
>  
> @@ -626,6 +636,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dev_set_drvdata(dev, lpcdev);
> +
>  	io_end = lpcdev->io_host->io_start + lpcdev->io_host->size;
>  	dev_info(dev, "registered range [%pa - %pa]\n",
>  		 &lpcdev->io_host->io_start, &io_end);
> @@ -633,6 +645,23 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int hisi_lpc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
> +	struct hisi_lpc_dev *lpcdev = dev_get_drvdata(dev);
> +	struct logic_pio_hwaddr *range = lpcdev->io_host;
> +
> +	if (acpi_device)
> +		hisi_lpc_acpi_remove(dev);
> +	else
> +		of_platform_depopulate(dev);
> +
> +	logic_pio_unregister_range(range);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id hisi_lpc_of_match[] = {
>  	{ .compatible = "hisilicon,hip06-lpc", },
>  	{ .compatible = "hisilicon,hip07-lpc", },
> @@ -646,5 +675,6 @@ static struct platform_driver hisi_lpc_driver = {
>  		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
>  	},
>  	.probe = hisi_lpc_probe,
> +	.remove = hisi_lpc_remove,
>  };
>  builtin_platform_driver(hisi_lpc_driver);
> -- 
> 2.17.1
> 

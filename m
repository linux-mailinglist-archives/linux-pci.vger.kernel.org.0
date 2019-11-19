Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578C0102FB2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 00:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKSXGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 18:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfKSXGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 18:06:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A079222A9;
        Tue, 19 Nov 2019 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574204767;
        bh=0ZxGb8IeKR+ASCSkRVfCYGuXWMT9Mc8Uuj/B9b3d9lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PQ934EHXGMFRgp8m9W0Px+nDpIn4ZUBmTVSLvvefYsoNdLB+7St2IuRSB1qYhiqXk
         QNieOk+53cXP73XxjsURZNRQp+zIRKGTBTYNBVKPramSsiCSPlrPWO/9d/oq6YpVMz
         rFvw18VhpxnayeRyk6rRyQrV4rNSIoTEYKU0gRdM=
Date:   Tue, 19 Nov 2019 17:06:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, okaya@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Introduce pci_dev_wait() in pci_power_up() API
Message-ID: <20191119230603.GA239092@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118172310.21373-1-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 10:53:10PM +0530, Vidya Sagar wrote:
> Add pci_dev_wait() in pci_power_up() before accessing the configuration
> space of a device for the first time in the system resume sequence.
> This is  to accommodate devices (Ex:- Intel 750 NVMe) that respond with CRS
> status while they get ready for configuration space access and before they
> finally start responding with proper values. It also refactors code to move
> pci_dev_wait() ahead of pci_power_up() to avoid build error.

Would you mind splitting this into:

  1) Move the pci_dev_wait() definition (no functional change)
  2) Add the call to pci_dev_wait() from pci_power_up()

Then the important change will stand out instead of being buried in
the middle of a big diff that mostly doesn't do anything.

I'm getting uneasy with our use of PCI_COMMAND instead of
PCI_VENDOR_ID.  If we're going to enable CRS SV, it seems like we
ought to use it in the way the spec suggests, i.e., by reading the
Vendor ID.  But that's something for a future patch, not *this* patch.

> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pci.c | 89 +++++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 599b2fc99234..7672b9a44bac 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1020,6 +1020,47 @@ void pci_wakeup_bus(struct pci_bus *bus)
>  		pci_walk_bus(bus, pci_wakeup, NULL);
>  }
>  
> +static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> +{
> +	int delay = 1;
> +	u32 id;
> +
> +	/*
> +	 * After reset, the device should not silently discard config
> +	 * requests, but it may still indicate that it needs more time by
> +	 * responding to them with CRS completions.  The Root Port will
> +	 * generally synthesize ~0 data to complete the read (except when
> +	 * CRS SV is enabled and the read was for the Vendor ID; in that
> +	 * case it synthesizes 0x0001 data).
> +	 *
> +	 * Wait for the device to return a non-CRS completion.  Read the
> +	 * Command register instead of Vendor ID so we don't have to
> +	 * contend with the CRS SV value.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &id);
> +	while (id == ~0) {
> +		if (delay > timeout) {
> +			pci_warn(dev, "not ready %dms after %s; giving up\n",
> +				 delay - 1, reset_type);
> +			return -ENOTTY;
> +		}
> +
> +		if (delay > 1000)
> +			pci_info(dev, "not ready %dms after %s; waiting\n",
> +				 delay - 1, reset_type);
> +
> +		msleep(delay);
> +		delay *= 2;
> +		pci_read_config_dword(dev, PCI_COMMAND, &id);
> +	}
> +
> +	if (delay > 1000)
> +		pci_info(dev, "ready %dms after %s\n", delay - 1,
> +			 reset_type);
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_power_up - Put the given device into D0
>   * @dev: PCI device to power up
> @@ -1045,6 +1086,13 @@ int pci_power_up(struct pci_dev *dev)
>  		pci_wakeup_bus(dev->subordinate);
>  	}
>  
> +	/*
> +	 * Wait for those devices (Ex: Intel 750 NVMe) that are not ready yet
> +	 * and responding with CRS statuses for the configuration space
> +	 * requests.
> +	 */
> +	pci_dev_wait(dev, "Switch to D0", PCIE_RESET_READY_POLL_MS);
> +
>  	return pci_raw_set_power_state(dev, PCI_D0);
>  }
>  
> @@ -4420,47 +4468,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> -{
> -	int delay = 1;
> -	u32 id;
> -
> -	/*
> -	 * After reset, the device should not silently discard config
> -	 * requests, but it may still indicate that it needs more time by
> -	 * responding to them with CRS completions.  The Root Port will
> -	 * generally synthesize ~0 data to complete the read (except when
> -	 * CRS SV is enabled and the read was for the Vendor ID; in that
> -	 * case it synthesizes 0x0001 data).
> -	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> -	 */
> -	pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	while (id == ~0) {
> -		if (delay > timeout) {
> -			pci_warn(dev, "not ready %dms after %s; giving up\n",
> -				 delay - 1, reset_type);
> -			return -ENOTTY;
> -		}
> -
> -		if (delay > 1000)
> -			pci_info(dev, "not ready %dms after %s; waiting\n",
> -				 delay - 1, reset_type);
> -
> -		msleep(delay);
> -		delay *= 2;
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	}
> -
> -	if (delay > 1000)
> -		pci_info(dev, "ready %dms after %s\n", delay - 1,
> -			 reset_type);
> -
> -	return 0;
> -}
> -
>  /**
>   * pcie_has_flr - check if a device supports function level resets
>   * @dev: device to check
> -- 
> 2.17.1
> 

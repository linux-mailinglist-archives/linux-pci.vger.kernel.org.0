Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4B3292FF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Mar 2021 21:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbhCAU4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Mar 2021 15:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243938AbhCAUxk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Mar 2021 15:53:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2A8C61606;
        Mon,  1 Mar 2021 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614630499;
        bh=YoemYxX5fP7QqIIwm3B1ehuIMnFwkmcXLzB8TOLXBmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DonRjxkS9VoNpqJFm7EnJEa9sAYuYYVMZEgMiBMoIIjZTFDsU3D4VsZII40Yf6CIm
         EVK0whgQft2ymSyACZkiPrdzL4xnxO39gW4nl3pOb4x3oU9+rAWRSn0neupGD3txSx
         NjM+2Qs/mZC0grudpOTScJ6GVUtbz4GtPCEMzWHT2J6Hpl5asr+aECEm71RrtvswCA
         mLn9KVL1VZmdWed1dYhD2ImQ1sPwmO8QhbR3rjIF1ZmLpb/JoKRPszD7LzMGVyCK4/
         DOA58GXZDizgAU8W2Q8PGaNmasQB1WqnhCvTGkpxZ2dfdQreUfY4eohJL70VaQtY8R
         BhpgTIEAqN8qw==
Date:   Mon, 1 Mar 2021 14:28:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: RFC: sysfs node for Secondary PCI bus reset (PCIe Hot Reset)
Message-ID: <20210301202817.GA201451@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301171221.3d42a55i7h5ubqsb@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, reset expert]

On Mon, Mar 01, 2021 at 06:12:21PM +0100, Pali Rohár wrote:
> Hello!
> 
> PCIe card can be reset via in-band Hot Reset signal which can be
> triggered by PCIe bridge via Secondary Bus Reset bit in PCI config
> space.
> 
> Kernel already exports sysfs node "reset" for triggering Functional
> Reset of particular function of PCI device. But in some cases Functional
> Reset is not enough and Hot Reset is required.
> 
> Following RFC patch exports sysfs node "reset_bus" for PCI bridges which
> triggers Secondary Bus Reset and therefore for PCIe bridges it resets
> connected PCIe card.
> 
> What do you think about it?
> 
> Currently there is userspace script which can trigger PCIe Hot Reset by
> modifying PCI config space from userspace:
> 
> https://alexforencich.com/wiki/en/pcie/hot-reset-linux
> 
> But because kernel already provides way how to trigger Functional Reset
> it could provide also way how to trigger PCIe Hot Reset.
> 
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 50fcb62d59b5..f5e11c589498 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1321,6 +1321,30 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR(reset, 0200, NULL, reset_store);
>  
> +static ssize_t reset_bus_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	unsigned long val;
> +	ssize_t result = kstrtoul(buf, 0, &val);
> +
> +	if (result < 0)
> +		return result;
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(dev);
> +	result = pci_bridge_secondary_bus_reset(pdev);
> +	pm_runtime_put(dev);
> +	if (result < 0)
> +		return result;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(reset_bus, 0200, NULL, reset_bus_store);
> +
>  static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  {
>  	int retval;
> @@ -1332,8 +1356,15 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  		if (retval)
>  			goto error;
>  	}
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		retval = device_create_file(&dev->dev, &dev_attr_reset_bus);
> +		if (retval)
> +			goto error_reset_bus;
> +	}
>  	return 0;
>  
> +error_reset_bus:
> +	device_remove_file(&dev->dev, &dev_attr_reset);
>  error:
>  	pcie_vpd_remove_sysfs_dev_files(dev);
>  	return retval;
> @@ -1414,6 +1445,8 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  		device_remove_file(&dev->dev, &dev_attr_reset);
>  		dev->reset_fn = 0;
>  	}
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		device_remove_file(&dev->dev, &dev_attr_reset_bus);
>  }
>  
>  /**

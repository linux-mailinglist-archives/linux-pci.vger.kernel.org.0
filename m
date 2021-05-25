Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDC390382
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhEYOK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 10:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233481AbhEYOKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 10:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB20B613FA;
        Tue, 25 May 2021 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621951736;
        bh=aMMB0gEk8E62F5boqfs8140RGMKlplKXhaRe8dOpOKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IwllkaIUpahGj0N/ZBcKcqrA374GsC+KsdtcgLBMY5BWkfNVDbaoXHxtuvx+fhKtz
         oKfXVizm/coSPuhGA1z5cPOJw6SXPenhnF4JOgIU/erSohPCeEYyTrW3qzHMPSe+g8
         xsKYvlhvRisHDPkfUNkke+wjpCqBAxnXTt5IB6CAdAMLOyMWXO7AppQTuLt4Tba/M6
         6Q86Fle/qGrOuDfu7ReUxQrnADXhsRVGuyjrX1TGCpngcygoQlUjpy8N+6UXbGQAPy
         s2yeRoPVbTM70hyEA0aWKtta1yDeo52QjBxt2WAuTvb6nj+YNtcJroj6HSjTB3/dp0
         iM9ks9n/rLqPQ==
Date:   Tue, 25 May 2021 09:08:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lambert Wang <lambert.q.wang@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
Message-ID: <20210525140854.GA1186411@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525125925.112306-1-lambert.q.wang@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Tue, May 25, 2021 at 08:59:25PM +0800, Lambert Wang wrote:
> Device drivers use this API to proactively check if the device
> is alive or not. It is helpful for some PCI devices to detect
> surprise removal and do recovery when Hotplug function is disabled.
> 
> Note: Device in power states larger than D0 is also treated not alive
> by this function.
> 
> Signed-off-by: Lambert Wang <lambert.q.wang@gmail.com>
> ---
>  drivers/pci/pci.c   | 23 +++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..8a7c039b1cd5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4659,6 +4659,29 @@ int pcie_flr(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
>  
> +/**
> + * pci_dev_is_alive - check the pci device is alive or not
> + * @pdev: the PCI device
> + *
> + * Device drivers use this API to proactively check if the device
> + * is alive or not. It is helpful for some PCI devices to detect
> + * surprise removal and do recovery when Hotplug function is disabled.
> + *
> + * Note: Device in power state larger than D0 is also treated not alive
> + * by this function.
> + *
> + * Returns true if the device is alive.
> + */
> +bool pci_dev_is_alive(struct pci_dev *pdev)
> +{
> +	u16 vendor;
> +
> +	pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
> +
> +	return vendor == pdev->vendor;
> +}
> +EXPORT_SYMBOL(pci_dev_is_alive);

This is quite similar to pci_device_is_present().  Does that not do
what you need?

I'm not a big fan of either pci_device_is_present() or
pci_dev_is_alive() because they are racy.  You must assume that even
if they return "true," the device may disappear because of a surprise
removal before you can act on that information.

>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
>  	int pos;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..2a3ba06a7347 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1227,6 +1227,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  void pcie_print_link_status(struct pci_dev *dev);
>  bool pcie_has_flr(struct pci_dev *dev);
>  int pcie_flr(struct pci_dev *dev);
> +bool pci_dev_is_alive(struct pci_dev *pdev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_reset_function_locked(struct pci_dev *dev);
> -- 
> 2.30.2
> 

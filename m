Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E683816A824
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBXOP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 09:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgBXOPz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 09:15:55 -0500
Received: from localhost (52.sub-174-234-140.myvzw.com [174.234.140.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01D520880;
        Mon, 24 Feb 2020 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582553754;
        bh=XCz98vLZW6w/xNhdXjYLn54ZixK2JilGaitOtPGmMvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CiqJ30OyI8S16FM0s04k11u8hdvW/ESmAR0LgjcOX3sDn0jmkQnhIKAK+66JUKaJl
         TcnQ17I7B1cjisYZGQP23ile5qHfOKb+aY2TPcwFmbrG7ppVrUmQOJ4ZHd3a3NdLGg
         Z+FB1pzImqT5cmXjYfSJSAMfBWz1JpYVsppB54z8=
Date:   Mon, 24 Feb 2020 08:15:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Message-ID: <20200224141551.GA217704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223122057.6504-2-stanspas@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ashok, Alex, Sinan, Rajat]

On Sun, Feb 23, 2020 at 01:20:55PM +0100, Stanislav Spassov wrote:
> From: Wei Wang <wawei@amazon.de>
> 
> The resonable value for the maximum time to wait for a PCI device to be
> ready after reset varies depending on the platform and the reliability
> of its set of devices.

There are several mechanisms in the spec for reducing these times,
e.g., Readiness Notifications (PCIe r5.0, sec 6.23), the Readiness
Time Reporting capability (sec 7.9.17), and ACPI _DSM methods (PCI
Firmware Spec r3.2, sec 4.6.8, 4.6.9).

I would much rather use standard mechanisms like those instead of
adding kernel parameters.  A user would have to use trial and error
to figure out the value to use with a parameter like this, and that
doesn't feel like a robust approach.

> Signed-off-by: Wei Wang <wawei@amazon.de>
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>  drivers/pci/pci.c                             | 22 ++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dbc22d684627..5e4dade9acc8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3653,6 +3653,11 @@
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_reset_ready_poll_ms= [PCI,PCIE]
> +			Specifies timeout for PCI(e) device readiness polling
> +			after device reset (in milliseconds).
> +			Default: 60000 = 60 seconds
> +
>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>  
>  	pd_ignore_unused
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d828ca835a98..db9b58ab6c68 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -149,7 +149,19 @@ static int __init pcie_port_pm_setup(char *str)
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>  
>  /* Time to wait after a reset for device to become responsive */
> -#define PCIE_RESET_READY_POLL_MS 60000
> +#define PCIE_RESET_READY_POLL_MS_DEFAULT 60000
> +
> +int __read_mostly pcie_reset_ready_poll_ms = PCIE_RESET_READY_POLL_MS_DEFAULT;
> +
> +static int __init pcie_reset_ready_poll_ms_setup(char *str)
> +{
> +	int timeout;
> +
> +	if (!kstrtoint(str, 0, &timeout))
> +		pcie_reset_ready_poll_ms = timeout;
> +	return 1;
> +}
> +__setup("pcie_reset_ready_poll_ms=", pcie_reset_ready_poll_ms_setup);
>  
>  /**
>   * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
> @@ -4506,7 +4518,7 @@ int pcie_flr(struct pci_dev *dev)
>  	 */
>  	msleep(100);
>  
> -	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> +	return pci_dev_wait(dev, "FLR", pcie_reset_ready_poll_ms);
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
>  
> @@ -4551,7 +4563,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  	 */
>  	msleep(100);
>  
> -	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
> +	return pci_dev_wait(dev, "AF_FLR", pcie_reset_ready_poll_ms);
>  }
>  
>  /**
> @@ -4596,7 +4608,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>  	pci_dev_d3_sleep(dev);
>  
> -	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> +	return pci_dev_wait(dev, "PM D3hot->D0", pcie_reset_ready_poll_ms);
>  }
>  
>  /**
> @@ -4826,7 +4838,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +	return pci_dev_wait(dev, "bus reset", pcie_reset_ready_poll_ms);
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);

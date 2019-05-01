Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1710C8B
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 20:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfEASBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 14:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfEASBc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 14:01:32 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877A02089E;
        Wed,  1 May 2019 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556733691;
        bh=qA8hFYpfD/GK5NUPgh1PBCjGxpjqeSIyPpWHoad3VIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtKgTvpkH2e0iqJ/8cTEmi3qzZW0E9cmb48NFC7IZkKjJsm+1K3/+GDKusrZmkJ3J
         TAK49DakAqVRw89DmJ59QwParvbf6AhizuGxF7k80xjusTvXJdZ6gupL+nEV2/2+3t
         BFWv2cnsd15a26Qoa3NMfPkp1rHUrNgKZTxfrAyk=
Date:   Wed, 1 May 2019 13:01:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>
Subject: Re: [PATCHv2] PCI/LINK: Add Kconfig option (default off)
Message-ID: <20190501180129.GA36824@google.com>
References: <20190501142942.26972-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501142942.26972-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 01, 2019 at 08:29:42AM -0600, Keith Busch wrote:
> e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> notification") added dmesg logging whenever a link changes speed or width
> to a state that is considered degraded.  Unfortunately, it cannot
> differentiate signal integrity-related link changes from those
> intentionally initiated by an endpoint driver, including drivers that may
> live in userspace or VMs when making use of vfio-pci.  Some GPU drivers
> actively manage the link state to save power, which generates a stream of
> messages like this:
> 
>   vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5 GT/s x16 link)
> 
> Since we can't distinguish the intentional changes from the signal
> integrity issues, leave the reporting turned off by default.  Add a Kconfig
> option to turn it on if desired.
> 
> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied to for-linus for v5.1, thanks!

> ---
>  drivers/pci/pcie/Kconfig   | 8 ++++++++
>  drivers/pci/pcie/Makefile  | 2 +-
>  drivers/pci/pcie/portdrv.h | 4 ++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 5cbdbca904ac..a70efdffe647 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -142,3 +142,11 @@ config PCIE_PTM
>  
>  	  This is only useful if you have devices that support PTM, but it
>  	  is safe to enable even if you don't.
> +
> +config PCIE_BW
> +	bool "PCI Express Bandwidth Change Notification"
> +	depends on PCIEPORTBUS
> +	help
> +	  This enables PCI Express Bandwidth Change Notification. If
> +	  you know link width or rate changes occur only to correct
> +	  unreliable links, you may answer Y.
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index f1d7bc1e5efa..efb9d2e71e9e 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -3,7 +3,6 @@
>  # Makefile for PCI Express features and port driver
>  
>  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
> -pcieportdrv-y			+= bw_notification.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> @@ -13,3 +12,4 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>  obj-$(CONFIG_PCIE_PTM)		+= ptm.o
> +obj-$(CONFIG_PCIE_BW)		+= bw_notification.o
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1d50dc58ac40..944827a8c7d3 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -49,7 +49,11 @@ int pcie_dpc_init(void);
>  static inline int pcie_dpc_init(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_PCIE_BW
>  int pcie_bandwidth_notification_init(void);
> +#else
> +static inline int pcie_bandwidth_notification_init(void) { return 0; }
> +#endif
>  
>  /* Port Type */
>  #define PCIE_ANY_PORT			(~0)
> -- 
> 2.14.4
> 

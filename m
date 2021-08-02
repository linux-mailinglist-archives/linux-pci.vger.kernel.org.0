Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17BA3DE2C6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhHBW7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231920AbhHBW7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:59:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39A9A60D07;
        Mon,  2 Aug 2021 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627945153;
        bh=1Bofb61PLpcRbzOyR/LUCmt5m+zVGAE7UgKRzYZRtGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N8yxfjDzHs8+x81LEfM8y1VUlQD16xO3QMdepox/dBTLcaGDXTWh6sni8moyjDLvh
         lnWx9Vz+aTXi2Hv6LtDOwywLgjUFat03KxWtg5x1oZlXVnycSUSZHQ4Tl/ZkaQOzA0
         mgI17rDarJ/bxR/bOSeV5pZKjcBhL+Sp6nyj4CB2dw2hNDrlye4YUGbSlFvs8Adiil
         VB4zJvK0bwY7F2sna5LnULGmnBuxEQOiACjxNuAg9V4gpIFiHVmRRBRqbIuKArOjjx
         W9gQKPdptkUEgLoO6eoyEG17Jk7v4sBaxdoAy2TfhyCajKxms5OrSitXZNjEBkGm5r
         ynS+/gg7HXc+Q==
Date:   Mon, 2 Aug 2021 17:59:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v13 9/9] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210802225911.GA1473016@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801142518.1224-10-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 01, 2021 at 07:55:18PM +0530, Amey Narkhede wrote:
> Change the type of probe argument in functions which implement reset
> methods from int to bool to make the context and intent clear.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
>  .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
>  drivers/pci/hotplug/pciehp.h                  |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c              |  4 +-
>  drivers/pci/hotplug/pnv_php.c                 |  4 +-
>  drivers/pci/pci-acpi.c                        |  7 +-
>  drivers/pci/pci.c                             | 69 ++++++++++---------
>  drivers/pci/pci.h                             | 12 ++--
>  drivers/pci/pcie/aer.c                        |  2 +-
>  drivers/pci/quirks.c                          | 34 ++++-----
>  include/linux/pci.h                           |  5 +-
>  include/linux/pci_hotplug.h                   |  2 +-
>  12 files changed, 75 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> index 15d6c8452807..f97fa8e997b5 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	pcie_reset_flr(pdev, 0);
> +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
>  
>  	pci_restore_state(pdev);
>  
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> index 336d149ee2e2..6e666be6907a 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
>  			oct->irq_name_storage = NULL;
>  		}
>  		/* Soft reset the octeon device before exiting */
> -		if (!pcie_reset_flr(oct->pci_dev, 1))
> +		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
>  			octeon_pci_flr(oct);
>  		else
>  			cn23xx_vf_ask_pf_to_do_flr(oct);
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 4fd200d8b0a9..f12e1ef9f183 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -181,7 +181,7 @@ void pciehp_release_ctrl(struct controller *ctrl);
>  
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
>  int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
> -int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
> +int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool mode);

Changing this to bool is ok, but I think changing the name from
"probe" to "mode" makes it worse.  It makes sense that "probe == true"
means do a probe instead of a reset, but "mode == true" tells me
nothing.

Bjorn

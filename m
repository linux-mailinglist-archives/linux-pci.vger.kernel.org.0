Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628F39486B
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhE1Voq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 17:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhE1Voq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 17:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4366611C9;
        Fri, 28 May 2021 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622238191;
        bh=Ce5YJwM8zoT9LygjS+UGtLgi6Z6ptHZryjobOpcbl+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WLUwSkhjCTF/jSNiHUYgrftxDE789cTVMCDqdkTp4oOrKFHj1UML8PR1jBV7nprr6
         5XigyZKuDceuOneJ15jRIAaOPqtyEKscDtRZlbkRqkSRXYA4xE8EZG393gRGYThCzr
         IGD5O6PKit/54RDnnEYKlcZoiMBao7OD2yBt1RFMra4op9VlPpKXRS+tJu1Z5Ilp9U
         h1oLF6ztuQuXIwTn0O2DJGEl1pNLnirGpeyxoWovK1HUdVstoPLneFes8tDzA7gsmF
         aaS9qgswfeNrqaUEwwrkXYw/rCCZTH9loXu5EWK2OZGkmeKmBTfJJ6xWcht9rbCB0F
         ka/ighIHrgyvQ==
Date:   Fri, 28 May 2021 16:43:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH V2 1/4] PCI/portdrv: Don't disable device during shutdown
Message-ID: <20210528214309.GA1523480@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528071503.1444680-2-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sinan]

On Fri, May 28, 2021 at 03:15:00PM +0800, Huacai Chen wrote:
> Use separate remove()/shutdown() callback, and don't disable PCI device
> during shutdown. This can avoid some poweroff/reboot failures.
>
> The poweroff/reboot failures could easily be reproduced on Loongson
> platforms. I think this is not a Loongson-specific problem, instead, is
> a problem related to some specific PCI hosts. On some x86 platforms,
> radeon/amdgpu devices can cause the same problem [1][2], and commit
> faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
> can resolve it.
> 
> As Tiezhu said, this occasionally shutdown or reboot failure is due to
> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device() [3].
> 
> static void do_pci_disable_device(struct pci_dev *dev)
> {
>         u16 pci_command;
> 
>         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>         if (pci_command & PCI_COMMAND_MASTER) {
>                 pci_command &= ~PCI_COMMAND_MASTER;
>                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
>         }
> 
>         pcibios_disable_device(dev);
> }
> 
> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
> shutdown or reboot. This may implies that there are DMA activities on the
> device while shutdown.
> 
> Radeon driver is more difficult than amdgpu due to its confusing symbol
> names, and I have maintained an out-of-tree patch for a long time [4].
> Recently, we found more and more devices can cause the same problem, and
> it is very difficult to modify all problematic drivers as radeon/amdgpu
> does (the .shutdown callback should make sure there is no DMA activity).
> So, I think modify the PCIe port driver is a simple and effective way.
> Because there is no poweroff/reboot problems before cc27b735ad3a75574a6a
> ("PCI/portdrv: Turn off PCIe services during shutdown"). And as early
> discussed, kexec can still work fine after this patch [5].

This needs to say *what* the failure is, and *why* the failure occurs.
There's a lot of hand-waving here but nothing really specific.

I'm getting the impression that:

  - Whatever the problem is, it didn't happen before cc27b735ad3a
    ("PCI/portdrv: Turn off PCIe services during shutdown").

  - cc27b735ad3a added a .shutdown() method for portdrv that calls
    pci_disable_device().

  - pci_disable_device() turns off bus mastering for the PCIe port,
    which means DMA from devices below the port will stop.

  - If you change the portdrv .shutdown() so DMA from devices below
    the port can continue, shutdown and reboot start working again.

So you need to explain why we need to allow DMA from those devices
even after we shutdown the port.  "It makes reboot work" is not a
sufficient explanation.

When you suggest that commit X introduced a problem, please cc the
author of X.  I added Sinan for you in this case.

A patch that fixes a problem with X should also include a "Fixes: X"
tag to help people connect problems with fixes.

> [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> [3] https://lore.kernel.org/patchwork/patch/1305067/
> [4] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
> [5] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv.h      |  2 +-
>  drivers/pci/pcie/portdrv_core.c |  6 ++++--
>  drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 2ff5724b8f13..358d7281f6e8 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -117,7 +117,7 @@ int pcie_port_device_resume(struct device *dev);
>  int pcie_port_device_runtime_suspend(struct device *dev);
>  int pcie_port_device_runtime_resume(struct device *dev);
>  #endif
> -void pcie_port_device_remove(struct pci_dev *dev);
> +void pcie_port_device_remove(struct pci_dev *dev, bool disable);
>  int __must_check pcie_port_bus_register(void);
>  void pcie_port_bus_unregister(void);
>  
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed6649c41..98c0a99a41d6 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -484,11 +484,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
>   * Remove PCI Express port service devices associated with given port and
>   * disable MSI-X or MSI for the port.
>   */
> -void pcie_port_device_remove(struct pci_dev *dev)
> +void pcie_port_device_remove(struct pci_dev *dev, bool disable)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
> +
> +	if (disable)
> +		pci_disable_device(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index c7ff1eea225a..562fbf3c1ea9 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -147,7 +147,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
>  
> -	pcie_port_device_remove(dev);
> +	pcie_port_device_remove(dev, true);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +	if (pci_bridge_d3_possible(dev)) {
> +		pm_runtime_forbid(&dev->dev);
> +		pm_runtime_get_noresume(&dev->dev);
> +		pm_runtime_dont_use_autosuspend(&dev->dev);
> +	}
> +
> +	pcie_port_device_remove(dev, false);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -219,7 +230,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 2.27.0
> 

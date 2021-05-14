Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD325380DC9
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhENQLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENQLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 12:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A950261442;
        Fri, 14 May 2021 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621008598;
        bh=gpCRgqPWPDA1f14zg4uJf4MlgBQHlkQ20MAo7hqqB1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M8DvsJTmtjgCYi7NSxDVBoXXY3NpAAfPVaZ2hPwA3tzrJ2KnFkYCbmgk0an6VoG1Q
         BklVxYNSYd9XNb4H51Us0KUgFZZnAfXve1DR0iS6HG/NYgfIbEs0IdA+UvABdkPSlB
         Yw2f2SHJV5PKt5u6O8Y0PKgecdFAlvsbcXIauKYPzUIKL/GLqs4RhLIllnn17u1vD1
         MPXrEu5teQlechsftxyThpjCeeLH6k0gebWk0rMY7JIq6i9JWmKvRFOYIFigJfmIyM
         CX//JuOToGg5KW1DiSuRRI41CwQTlBcXoflUcyYKBG4CVQKFFVMo5U9YFb5eNA0iIU
         aZVGXzmrwOTgg==
Date:   Fri, 14 May 2021 11:09:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 1/5] PCI/portdrv: Don't disable pci device during shutdown
Message-ID: <20210514160956.GA2765772@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-2-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, s/pci device/device/.  We already know this is PCI.

On Fri, May 14, 2021 at 04:00:21PM +0800, Huacai Chen wrote:
> Use separate remove()/shutdown() callback, and don't disable pci device
> during shutdown. This can avoid some poweroff/reboot failures.

s/pci/PCI/

> The poweroff/reboot failures can easily reproduce on Loongson platforms.
> I think this is not a Loongson-specific problem, instead, is a problem
> related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

Please explain exactly what these failures are and include URLs for
relevant reports, bugzillas, etc.

Conventional citation format is

  faefba95c9e8 ("drm/amdgpu: just suspend the hw on pci shutdown")

> As Tiezhu said, this occasionally shutdown or reboot failure is due to
> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().

Where did Tiezhu say this?  Please link to this conversation.

> drivers/pci/pci.c

Unnecessary; we can use cscope/tags/grep/etc to find this.

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
> names, and I have maintained an out-of-tree patch for a long time [1].
> Recently, we found more and more devices can cause the same problem, and
> it is very difficult to modify all problematic drivers as radeon/amdgpu
> does (the .shutdown callback should make sure there is no DMA activity).
> So, I think modify the PCIe port driver is a simple and effective way.
> And as early discussed, kexec can still work after this patch.

Link to this discussion as well?

This commit log does not contain a clear description of the problem
and how the patch fixes it.

> [1] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
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

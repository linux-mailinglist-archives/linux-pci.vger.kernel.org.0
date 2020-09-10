Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC332650DF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIJUdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 16:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgIJUdB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 16:33:01 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA1D206E9;
        Thu, 10 Sep 2020 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599769964;
        bh=OiDYPzSKCnMb5O1fTW9mgvhSu3ELr6sS9fDJFu84w1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2lSH3tj25mNlvrnM0yeRSgldxeSSbvoWcd3yne9Yi/+/ulRLINYBzRjxpPaNi/Wuc
         5YR4eRrXeJcWxw90scO2Lt3mrdtia3/gtW33pofIRkVDbqkDi37eDE7cZH0PQQi3c2
         baBOPQNJL8jv216tcjsSBbZw/aY4cZslCM3iRkK0=
Date:   Thu, 10 Sep 2020 15:32:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH RFC] PCI/portdrv: Don't disable pci device during shutdown
Message-ID: <20200910203242.GA811223@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596268180-9114-1-git-send-email-chenhc@lemote.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Tiezhu]

On Sat, Aug 01, 2020 at 03:49:40PM +0800, Huacai Chen wrote:
> Use separate remove()/shutdown() callback, and don't disable pci device
> during shutdown. This can avoid some poweroff/reboot failures.
> 
> The poweroff/reboot failures can easily reproduce on Loongson platforms.
> I think this is not a Loongson-specific problem, instead, is a problem
> related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
>
> Radeon driver is more difficult than amdgpu due to its confusing symbol
> names, and I have maintained an out-of-tree patch for a long time [1].
> Recently, we found more and more devices can cause the same problem, and
> it is very difficult to modify all problematic drivers as radeon/amdgpu
> does. So, I think modify the PCIe port driver is a simple and effective
> way.

Sounds plausible, but I don't know what the actual problem is, other
than "poweroff/reboot doesn't work, and this patch 'fixes' it".

> [1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  drivers/pci/pcie/portdrv.h      |  2 +-
>  drivers/pci/pcie/portdrv_core.c |  6 ++++--
>  drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index af7cf23..22ba7b9 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -123,7 +123,7 @@ int pcie_port_device_resume(struct device *dev);
>  int pcie_port_device_runtime_suspend(struct device *dev);
>  int pcie_port_device_runtime_resume(struct device *dev);
>  #endif
> -void pcie_port_device_remove(struct pci_dev *dev);
> +void pcie_port_device_remove(struct pci_dev *dev, bool disable);
>  int __must_check pcie_port_bus_register(void);
>  void pcie_port_bus_unregister(void);
>  
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522..aa165be 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -487,11 +487,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
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

portdrv can only be built statically (not as a module), and I don't
think there's value in being able to unbind it.  So I think we should
remove its .remove() method.  That would be a separate patch, of
course, but it should make this one quite a bit simpler.

>  /**
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3acf151..fcd3d2e 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -142,7 +142,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
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

I admit to being ignorant about how all this PM stuff works.  A
comment here about what's going on and why we need to check
pci_bridge_d3_possible() would be useful.

> +	pcie_port_device_remove(dev, false);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -211,7 +222,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 2.7.0
> 

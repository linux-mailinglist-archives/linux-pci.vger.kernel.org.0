Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560652C34A2
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 00:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgKXXZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 18:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730900AbgKXXZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 18:25:23 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B54F20BED;
        Tue, 24 Nov 2020 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606260322;
        bh=WyU29S8vtMIc1rJFMeOygbCPczuvrd5zId1YhelvSwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Zfgh94TF9/nIjIoLDJI3Or7lp44HlJ6YCKMt+Vi4SEzDkP3gZooM+nJOIQmnEwksc
         snjfPIHm8wMlyhYdls2klhobNi/UBBuxzgbNXU16Kw/MYboDansZOzlyUBy2HTloZw
         neCWqLCqbIxi4bno+XFjpp3X0eEKSfrszhgYE1rw=
Date:   Tue, 24 Nov 2020 17:25:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/3] PCI: portdrv: Add pcie_port_service_get_irq()
 function
Message-ID: <20201124232520.GA601096@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603848703-21099-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 10:31:41AM +0900, Kunihiko Hayashi wrote:
> Add pcie_port_service_get_irq() that returns the virtual IRQ number
> for specified portdrv service.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I don't like portdrv and am sorry to add more uses of it, but I don't
have anything better, so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/portdrv.h      |  1 +
>  drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index af7cf23..e256456 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -150,4 +150,5 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +int pcie_port_service_get_irq(struct pci_dev *dev, u32 service);
>  #endif /* _PORTDRV_H_ */
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522..f92daf8 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -480,6 +480,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(pcie_port_find_device);
>  
> +/*
> + * pcie_port_service_get_irq - get irq of the service
> + * @dev: PCI Express port the service is associated with
> + * @service: For the service to find
> + *
> + * Get irq number associated with given service on a pci_dev
> + */
> +int pcie_port_service_get_irq(struct pci_dev *dev, u32 service)
> +{
> +	struct pcie_device *pciedev;
> +
> +	pciedev = to_pcie_device(pcie_port_find_device(dev, service));
> +
> +	return pciedev->irq;
> +}
> +
>  /**
>   * pcie_port_device_remove - unregister PCI Express port service devices
>   * @dev: PCI Express port the service devices to unregister are associated with
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

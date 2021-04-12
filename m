Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA435BCA1
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhDLIoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 04:44:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2831 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhDLIoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 04:44:06 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJhsv5GGBz688MV;
        Mon, 12 Apr 2021 16:36:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 12 Apr 2021 10:43:46 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 09:43:45 +0100
Date:   Mon, 12 Apr 2021 09:42:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v10 1/3] PCI: portdrv: Add pcie_port_service_get_irq()
 function
Message-ID: <20210412094219.000031ca@Huawei.com>
In-Reply-To: <1617985338-19648-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1617985338-19648-1-git-send-email-hayashi.kunihiko@socionext.com>
        <1617985338-19648-2-git-send-email-hayashi.kunihiko@socionext.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 10 Apr 2021 01:22:16 +0900
Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> Add pcie_port_service_get_irq() that returns the virtual IRQ number
> for specified portdrv service.

Trivial comment inline.

> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/portdrv.h      |  1 +
>  drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 2ff5724..628a3de 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -144,4 +144,5 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +int pcie_port_service_get_irq(struct pci_dev *dev, u32 service);
>  #endif /* _PORTDRV_H_ */
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed664..b60f0f3 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -477,7 +477,22 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(pcie_port_find_device);
>  
> +/*

/**

this is kernel-doc style, so why not mark it as such?


> + * pcie_port_service_get_irq - get irq of the service
> + * @dev: PCI Express port the service is associated with
> + * @service: For the service to find
> + *
> + * Get IRQ number associated with given service on a pci_dev.
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


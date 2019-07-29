Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1134278670
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 09:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2HjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 03:39:11 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:2214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbfG2HjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 03:39:10 -0400
X-UUID: 956ec71b12d64041beb42b8c6da990ec-20190729
X-UUID: 956ec71b12d64041beb42b8c6da990ec-20190729
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1541818433; Mon, 29 Jul 2019 15:38:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Jul
 2019 15:38:39 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Jul 2019 15:38:38 +0800
Message-ID: <1564385918.17211.6.camel@mhfsdcap03>
Subject: Re: [v2,2/2] PCI: mediatek: Add controller support for MT7629
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Date:   Mon, 29 Jul 2019 15:38:38 +0800
In-Reply-To: <20190628073425.25165-3-jianjun.wang@mediatek.com>
References: <20190628073425.25165-1-jianjun.wang@mediatek.com>
         <20190628073425.25165-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 736AECADBE0E85D306CDAE61C7316ECFE7F8B270E6112EAB74CF5017161808C82000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-28 at 15:34 +0800, Jianjun Wang wrote:
> MT7629 is an ARM platform SoC which has the same PCIe IP with MT7622.
> 
> The HW default value of its Device ID is invalid, fix its Device ID to
> match the hardware implementation.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 18 ++++++++++++++++++
>  include/linux/pci_ids.h                |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 80601e1b939e..e5e6740b635d 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -73,6 +73,7 @@
>  #define PCIE_MSI_VECTOR		0x0c0
>  
>  #define PCIE_CONF_VEND_ID	0x100
> +#define PCIE_CONF_DEVICE_ID	0x102
>  #define PCIE_CONF_CLASS_ID	0x106
>  
>  #define PCIE_INT_MASK		0x420
> @@ -141,12 +142,16 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> + * @need_fix_device_id: whether this host's Device ID needed to be fixed or not
> + * @device_id: Device ID which this host need to be fixed
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> +	bool need_fix_device_id;
> +	unsigned int device_id;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -696,6 +701,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		writew(val, port->base + PCIE_CONF_CLASS_ID);
>  	}
>  
> +	if (soc->need_fix_device_id)
> +		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
> +
>  	/* 100ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
>  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> @@ -1216,11 +1224,21 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.setup_irq = mtk_pcie_setup_irq,
>  };
>  
> +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> +	.need_fix_class_id = true,
> +	.need_fix_device_id = true,
> +	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
> +	.ops = &mtk_pcie_ops_v2,
> +	.startup = mtk_pcie_startup_port_v2,
> +	.setup_irq = mtk_pcie_setup_irq,
> +};
> +
>  static const struct of_device_id mtk_pcie_ids[] = {
>  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
>  	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> +	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
>  	{},
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..aa32962759b2 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2131,6 +2131,7 @@
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
>  
>  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
>  
>  #define PCI_VENDOR_ID_TITAN		0x14D2
>  #define PCI_DEVICE_ID_TITAN_010L	0x8001

Hi Bjorn & Lorenzo,

Is this patch ok or is there anything I need to fixed?

Thanks.



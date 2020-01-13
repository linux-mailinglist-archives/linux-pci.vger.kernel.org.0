Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41330138FF1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 12:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMLTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 06:19:33 -0500
Received: from foss.arm.com ([217.140.110.172]:37936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 06:19:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF7513D5;
        Mon, 13 Jan 2020 03:19:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C279A3F6C4;
        Mon, 13 Jan 2020 03:19:31 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:19:30 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 05/12] PCI: mobiveil: Add callback function for
 interrupt initialization
Message-ID: <20200113111929.GK42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-6-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-6-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:45:50AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The Mobiveil GPEX internal MSI/INTx controller may not be used
> by other platforms in which the Mobiveil GPEX is integrated.
> This patch is to allow these platforms to implement their
> specific interrupt initialization.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V9:
>  - New patch splited from the #1 of V8 patches to make it easy to review.
> 
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 3 +++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h      | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 2cc424e78d33..3cd93df6fe6e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -507,6 +507,9 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
>  	struct resource *res;
>  	int ret;
>  
> +	if (rp->ops->interrupt_init)
> +		return rp->ops->interrupt_init(pcie);
> +

This may be cleaner if you have a helper function named
"mobiveil_pcie_interrupt_init" where it either calls interrupt_init if present
or calls this current function renamed to "mobiveil_pcie_integrated_interrupt_init"
or similar.

A bit like the DWC dw_pcie_rd_own_conf function.

Thanks,

Andrew Murray

>  	/* map MSI config resource */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
>  	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index e3148078e9dd..18d85806a7fc 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -130,10 +130,17 @@ struct mobiveil_msi {			/* MSI information */
>  	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
>  };
>  
> +struct mobiveil_pcie;
> +
> +struct mobiveil_rp_ops {
> +	int (*interrupt_init)(struct mobiveil_pcie *pcie);
> +};
> +
>  struct root_port {
>  	char root_bus_nr;
>  	void __iomem *config_axi_slave_base;	/* endpoint config base */
>  	struct resource *ob_io_res;
> +	struct mobiveil_rp_ops *ops;
>  	int irq;
>  	raw_spinlock_t intx_mask_lock;
>  	struct irq_domain *intx_domain;
> -- 
> 2.17.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13A35F75EF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGJP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJGJPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 05:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727EA287C;
        Fri,  7 Oct 2022 02:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BA461C1D;
        Fri,  7 Oct 2022 09:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C1C433C1;
        Fri,  7 Oct 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665134140;
        bh=qVJoQ6YlfJEzLvx32Gk1iCvr34KtLSNoE7vybUBEf/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFg7oKfCjVey3WEqhHGHWUeZ7O86HKFqJBQtjwGxKZmu2mmkWTEoTx6EAQnQLTOLF
         u32dMb288GLNFKRjsNZW2zu2JAAoPqDpgWV+Y1jmAGbJ2/ewuQGnvX1F2ZrjGgb8EY
         MWPIFuVTtznuxFEQu8D1n1aF/zKjWRqEMoM8ulyX/19JAqF4wdMn3r6948x9qyDPO6
         pXpf0cAcmEVsQHn8dKwHBAoPveMDJWxczY5f4stbFrDj/OOCt51ETVUXS14rNPgag+
         CAx6y5aeVLicCeqvCVbIA+bWW/oIFsy5jL8JCRXwPVZqyAkeqIt4ISOalzXH2mH1B+
         aoLFmE8z+rxJw==
Date:   Fri, 7 Oct 2022 11:15:30 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v12 6/6] PCI: endpoint: Add vNTB MSI support
Message-ID: <Yz/uMiElbqB3ThGd@lpieralisi>
References: <20220922161246.20586-1-Frank.Li@nxp.com>
 <20220922161246.20586-7-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922161246.20586-7-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 11:12:46AM -0500, Frank Li wrote:
>                       ┌───────┐                   ┌──────────┐
>                       │       │                   │          │
>     ┌─────────────┐   │ PCI   │                   │ PCI Host │
>     │ MSI         │◄┐ │ EP    │                   │          │
>     │ Controller  │ │ │       │ 3.MSI Write       │          │
>     └────────┬────┘ └─┼───────┼───────────────────┤          │
>       ▲      │        │       │                   ├─BAR_n    │
>       │      └────────┼───────┼──────────────────►│          │
>       │               │       │ 2.Call Back       │          │
>       │               │       │   write_msi_msg() │          │
>       │               │       │                   │          │
>       │               └───┬───┘                   └──────────┘
>       │                   │
>       └───────────────────┘
>       1.platform_msi_domain_alloc_irqs()
> 
> There is no defined way of raising IRQs by PCI host to the PCI endpoint.
> Only define MSI/MSI-X to let EP notified RC status change.

This picture is misleading, especially (2). IIUC all this patch is
doing is implementing an NTB DB in the EP, that's it, we should
reword the commit log as such.

We are in the merge window - it is very likely this patch should
be postponed to v6.2, I didn't notice that the IRQchip changes
went in - apologies.

> The memory assigned for BAR region by the PCI host is mapped to the
> message address of platform msi interrupt controller in PCI Endpoint.
> Such that, whenever the PCI host writes to the BAR region, it will
> trigger an IRQ in the Endpoint.
> 
> Basic working follow as
> 1. EP function driver call platform_msi_domain_alloc_irqs() alloc a
> MSI irq from MSI controller with call back function write_msi_msg();
> 2. write_msg_msg will config BAR and map to address defined in msi_msg;
> 3. Host side trigger an IRQ in Endpoint by write to BAR region.
> 
> Add MSI support for pci-epf-vntb. Query if system has an MSI controller.
> Set up doorbell address according to struct msi_msg.
> 
> So PCI RC can write this doorbell address to trigger EP side's IRQ.
> 
> If no MSI controller exists, fall back to software polling.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 148 +++++++++++++++---
>  1 file changed, 127 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index acea753af29ed..8fdeac2201e29 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -44,6 +44,7 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  #include <linux/ntb.h>
> +#include <linux/msi.h>
>  
>  static struct workqueue_struct *kpcintb_workqueue;
>  
> @@ -137,11 +138,14 @@ struct epf_ntb {
>  	struct epf_ntb_ctrl *reg;
>  
>  	u32 *epf_db;
> +	phys_addr_t epf_db_phys;
>  
>  	phys_addr_t vpci_mw_phy[MAX_MW];
>  	void __iomem *vpci_mw_addr[MAX_MW];
>  
>  	struct delayed_work cmd_handler;
> +
> +	int msi_virqbase;
>  };
>  
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> @@ -256,10 +260,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
> -	for (i = 1; i < ntb->db_count; i++) {
> -		if (ntb->epf_db[i]) {
> -			ntb_db_event(&ntb->ntb, i);
> -			ntb->epf_db[i] = 0;
> +	if (!ntb->epf_db_phys) {
> +		for (i = 1; i < ntb->db_count; i++) {
> +			if (ntb->epf_db[i]) {
> +				ntb->db |= 1 << (i - 1);
> +				ntb_db_event(&ntb->ntb, i);
> +				ntb->epf_db[i] = 0;
> +			}
>  		}
>  	}
>  
> @@ -464,7 +471,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  
>  	for (i = 0; i < ntb->db_count; i++) {
>  		ntb->reg->db_data[i] = 1 + i;
> -		ntb->reg->db_offset[i] = 0;
> +		ntb->reg->db_offset[i] = sizeof(u32) * i;

Why sizeof(u32) ?

>  	}
>  
>  	return 0;
> @@ -517,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +static int epf_ntb_db_size(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *epc_features;
> +	size_t size = sizeof(u32) * ntb->db_count;

Same question.

> +	u32 align;
> +
> +	epc_features = pci_epc_get_features(ntb->epf->epc,
> +					    ntb->epf->func_no,
> +					    ntb->epf->vfunc_no);
> +	align = epc_features->align;
> +
> +	if (size < 128)
> +		size = 128;
> +
> +	if (align)
> +		size = ALIGN(size, align);
> +	else
> +		size = roundup_pow_of_two(size);
> +
> +	return size;
> +}
> +
>  /**
>   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> @@ -540,27 +569,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
>  	align = epc_features->align;
> -
> -	if (size < 128)
> -		size = 128;
> -
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> +	size = epf_ntb_db_size(ntb);
>  
>  	barno = ntb->epf_ntb_bar[BAR_DB];
> +	epf_bar = &ntb->epf->bar[barno];
>  
> -	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> -	if (!mw_addr) {
> -		dev_err(dev, "Failed to allocate OB address\n");
> -		return -ENOMEM;
> +	if (ntb->epf_db_phys) {
> +		mw_addr = NULL;
> +		epf_bar->phys_addr = ntb->epf_db_phys;
> +		epf_bar->barno = barno;
> +		epf_bar->size = size;
> +	} else {
> +		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> +		if (!mw_addr) {
> +			dev_err(dev, "Failed to allocate doorbell address\n");
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	ntb->epf_db = mw_addr;
>  
> -	epf_bar = &ntb->epf->bar[barno];
> -
>  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
>  	if (ret) {
>  		dev_err(dev, "Doorbell BAR set failed\n");
> @@ -719,6 +747,83 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +static void epf_ntb_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct epf_ntb *ntb = dev_get_drvdata(desc->dev);
> +	struct epf_ntb_ctrl *reg = ntb->reg;
> +	int size = epf_ntb_db_size(ntb);
> +	u64 addr;
> +
> +	addr = msg->address_hi;
> +	addr <<= 32;
> +	addr |= msg->address_lo;
> +
> +	reg->db_data[desc->msi_index] = msg->data;
> +
> +	if (!desc->msi_index)
> +		ntb->epf_db_phys = round_down(addr, size);
> +
> +	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phys;
> +}
> +#endif

Can we move this hunk down into the same #ifdef guard please ?

> +static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)
> +{
> +	struct epf_ntb *ntb = data;
> +	int index;
> +
> +	index = irq - ntb->msi_virqbase;
> +	ntb->db |= 1 << (index - 1);
> +	ntb_db_event(&ntb->ntb, index);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
> +{
> +	struct device *dev = &ntb->epf->dev;
> +	struct irq_domain *domain;
> +	int virq;
> +	int ret;
> +	int i;
> +
> +	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
> +	if (!domain)
> +		return;
> +
> +	dev_set_msi_domain(dev, domain);
> +
> +	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
> +		ntb->db_count,
> +		epf_ntb_write_msi_msg)) {
> +		dev_err(dev, "Can't allocate MSI, falling back to polling mode\n");
> +		return;
> +	}
> +	dev_info(dev, "Using MSI as doorbell\n");

Is it really useful to print this in the kernel log ? dev_dbg seems more
suitable to me.

> +
> +	for (i = 0; i < ntb->db_count; i++) {
> +		virq = msi_get_virq(dev, i);
> +		ret = devm_request_irq(dev, virq,
> +			       epf_ntb_interrupt_handler, 0,
> +			       "pci_epf_vntb", ntb);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to request doorbell IRQ! Falling back to polling mode");
> +			ntb->epf_db_phys = 0;
> +			break;

Doesn't this require a platform_msi_domain_free_irqs() ?

Thanks,
Lorenzo

> +		}
> +
> +		if (!i)
> +			ntb->msi_virqbase = virq; /* msi start virq number */
> +	}
> +}
> +#else
> +static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
> +{
> +}
> +#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> @@ -1320,14 +1425,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  		goto err_bar_alloc;
>  	}
>  
> +	epf_set_drvdata(epf, ntb);
> +	epf_ntb_epc_msi_init(ntb);
> +
>  	ret = epf_ntb_epc_init(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize EPC\n");
>  		goto err_bar_alloc;
>  	}
>  
> -	epf_set_drvdata(epf, ntb);
> -
>  	pci_space[0] = (ntb->vntb_pid << 16) | ntb->vntb_vid;
>  	pci_vntb_table[0].vendor = ntb->vntb_vid;
>  	pci_vntb_table[0].device = ntb->vntb_pid;
> -- 
> 2.35.1
> 

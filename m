Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6E6374A5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKXJAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKXJAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:00:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617FA10EA28
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:00:40 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w79so1108259pfc.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+w4tmZDiPM69E7coV2CH15uQShu4W0QLk13WRdoYqo=;
        b=dD5T/z9NKIJhTp/gaxnDGrU96mZ28E5PpqSuka/NwlG93DRTeTfBa75wdv99Fncy8D
         puavEF4RcN5c2+Y35jocuaOW69CtUX+kkBEPhWsa0eGlGNPUCoHrwrUgLL5xC/puH3FM
         q81wpISgFha+xw6j6WpjkF0/Kkt+KyMMNf/UgPGc1V9Q3kcuMkG2xO8Z6MCBYeT15/8S
         j15flgsrb0Em9z5rcHvTlnMyD36xcdaPycMktGq18iOKEnrm1y+TCYKBGge3vWd39AWe
         9nKKii5tMvSfR4TvKT7SiYnX5aczyB5llNYPkWBlfVp2ZziByxguNNW59TcJytD7KMC+
         DW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+w4tmZDiPM69E7coV2CH15uQShu4W0QLk13WRdoYqo=;
        b=ZJ0IyQIum1Uv4gZQwlYB4Pz+uNL/W/SQbPtcSFf1EFrsWPQAc6SmyvWwCu/Oy/XInI
         IORZWoeyfV32bTKZWZJ97zR9fghbj6qG/rfi3UcIm7clHxoiZK2+7OMx4Ciw6ClyfRUk
         qq71lRFpMArzhqoit8sGt1EB+KAaOW/A1zyaFH7WzFcfzD0yHHrLUjsE2WHYlnzTCDun
         kJO+BeHF48D7KcIGsrStwZ5B3ztI5PGYGU7TzMtRrmdjd8CbUhlPp2/23a3PXv8McOOo
         D3ADQNneA7ZY+4hK4k9hOWlAHxtppY5qvlwiaUTWKbqelnRpokryarPZBCQJS/2db7SB
         dXrw==
X-Gm-Message-State: ANoB5pmvjOecAJLBW+kf1b6DwBcrwlx0q6ZSphgX976AIaJoCks7ZH3n
        61k+yM5nLQyz0KPOnWPCxj55
X-Google-Smtp-Source: AA0mqf61Q3kR3fx0rJaTtcPJhpcU3lR6pU8IQfMAubF9oJ8HCJATlfXwTnvlGQZa466xICWBLj/+jQ==
X-Received: by 2002:a63:f241:0:b0:46f:da0:f093 with SMTP id d1-20020a63f241000000b0046f0da0f093mr10972642pgk.441.1669280439701;
        Thu, 24 Nov 2022 01:00:39 -0800 (PST)
Received: from thinkpad ([59.92.97.13])
        by smtp.gmail.com with ESMTPSA id g16-20020aa796b0000000b005385e2e86eesm700314pfk.18.2022.11.24.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:00:38 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:30:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     lpieralisi@kernel.org, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lznuaa@gmail.com, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v13 2/2] PCI: endpoint: pci-epf-vntb: using platform MSI
 as doorbell
Message-ID: <20221124090028.GC5119@thinkpad>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124055036.1630573-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24, 2022 at 12:50:36AM -0500, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 

There are at least couple of BAR regions used in this patch but they were not
mentioned in the above diagram.

The subject should be:

"PCI: endpoint: pci-epf-vntb: Use EP MSI controller to handle DB from host"

> Using platform MSI interrupt controller as endpoint(EP)'s doorbell.
> 

Above line is not needed.

> The memory assigned for BAR region by the PCI host is mapped to the

Which BAR? (BAR 1 aka. DB BAR)? There are multiple BAR regions exposed by this function driver.

> message address of platform msi interrupt controller in PCI Endpoint.

s/msi/MSI. Also, use either Endpoint or EP, pick one but not both.

> Such that, whenever the PCI host writes to the BAR region, it will
> trigger an IRQ in the EP.
> 
> Basic working follow as

"work flow is"?

> 1. EP function driver call platform_msi_domain_alloc_irqs() alloc a

pci-epf-vntb function driver calls platform_msi_domain_alloc_irqs() to allocate
MSI's from the platform MSI controller.

> MSI irq from MSI controller with call back function write_msi_msg();
> 2. write_msg_msg will config BAR and map to address defined in msi_msg;

The epf_ntb_write_msi_msg() passed as a callback will write the offset of the
MSI controller's MSI address dedicated for each MSI to the doorbell register
db_offset and also writes the MSI data to db_data register in the CTRL BAR
region.

> 3. Host side trigger an IRQ at Endpoint by write to BAR region.
> 

Finally, the host can trigger doorbell by reading the offset of the doorbell
from db_offset register and writing the data read from db_data register in CTRL
BAR region to the computed address in the DB BAR region.

> Add MSI doorbell support for pci-epf-vntb. Query if system has an MSI
> controller. Set up doorbell address according to struct msi_msg.
> 
> So PCI host can write this doorbell address to trigger EP side's IRQ.
> 
> If no MSI controller exists, fall back to software polling.
> 

"Add doorbell support to pci-epf-vntb function driver making use of the platform
MSI controller. If the MSI controller is not available, fallback to the polling
method."

Also, please move this paragraph to the beginning of the description.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 146 +++++++++++++++---
>  1 file changed, 125 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0d744975f815..f770a068e58c 100644
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

You should add kernel doc comments for this struct in a separate patch. It will
help in understanding the driver better.

>  
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> @@ -256,11 +260,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
> -	for (i = 1; i < ntb->db_count; i++) {
> -		if (ntb->epf_db[i]) {
> -			ntb->db |= 1 << (i - 1);
> -			ntb_db_event(&ntb->ntb, i);
> -			ntb->epf_db[i] = 0;

A comment here stating that polling is implemented would be better.

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
> @@ -518,6 +524,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +static int epf_ntb_db_size(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *epc_features;
> +	size_t size = sizeof(u32) * ntb->db_count;
> +	u32 align;
> +
> +	epc_features = pci_epc_get_features(ntb->epf->epc,
> +					    ntb->epf->func_no,
> +					    ntb->epf->vfunc_no);
> +	align = epc_features->align;
> +
> +	if (size < 128)

Shouldn't this be (size > 128)?

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
> @@ -539,27 +567,26 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
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
> @@ -728,6 +755,82 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +static irqreturn_t epf_ntb_interrupt_handler(int irq, void *data)

Shouldn't this function also be guarded?

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

It'd be better to use the relevant commit description as a comment here.

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

A comment stating that the base address to be used as the DB BAR is set here
would be useful too.

> +	if (!desc->msi_index)
> +		ntb->epf_db_phys = round_down(addr, size);
> +
> +	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phys;
> +}
> +
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

Please wrap above two in a single line till 100 column limit.

> +		dev_err(dev, "Can't allocate MSI, falling back to polling mode\n");

This should be dev_dbg().

> +		return;
> +	}
> +	dev_dbg(dev, "Using MSI as doorbell\n");
> +
> +	for (i = 0; i < ntb->db_count; i++) {
> +		virq = msi_get_virq(dev, i);
> +		ret = devm_request_irq(dev, virq,
> +			       epf_ntb_interrupt_handler, 0,
> +			       "pci_epf_vntb", ntb);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to request doorbell IRQ! Falling back to polling mode");

Again, dev_dbg()

> +			ntb->epf_db_phys = 0;
> +			platform_msi_domain_free_irqs(&ntb->epf->dev);
> +			break;
> +		}
> +
> +		if (!i)
> +			ntb->msi_virqbase = virq; /* msi start virq number */
> +	}
> +}
> +#else

Since this is not exposed as an API, just end the ifdef here and...

> +static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
> +{
> +}
> +#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> @@ -1336,14 +1439,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  		goto err_bar_alloc;
>  	}
>  
> +	epf_set_drvdata(epf, ntb);
> +	epf_ntb_epc_msi_init(ntb);

Guard this function instead:

#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
	epf_ntb_epc_msi_init(ntb);
#endif

Thanks,
Mani

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
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

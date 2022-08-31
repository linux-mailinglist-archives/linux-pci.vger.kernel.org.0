Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4805A7B87
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiHaKmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaKmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 06:42:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13539C874C
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 03:42:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so14554617pjj.5
        for <linux-pci@vger.kernel.org>; Wed, 31 Aug 2022 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=USnEq7i+EspKoRu1Km1ctJNVzyby3/Boh0en787tgT4=;
        b=q6KB29F9s7ScEmfBLJsjH0tGFTm+Dpby3tqOLuvcJsY9Gd89u43bMs9rdLGTgfyhDq
         owgGTWQ4MuUqs5W4XFripHtoulDfMyk+o8ENVwBaV0W2LnKXNuTKCwB4V9mDLFWoqf2t
         XeWW7/FJUoOnvEVgmaBb08SpxviMjvYHOm6WKvxAkAJf4Mv5aj0BJHOlVmY2aVtRh7zn
         S459OeLCwwBCSZ2H37gUD5Pug/j09ZSWsLJ0pS7zmaQ/CYt62ijJKH3aT9gPBUK3gxgn
         swdfTO6Ojrc7mN0T1wAYorB/dtxpiGLaQPyxv+Ht8tqYomSjIyu4tMZZyH3GVkdrS130
         PkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=USnEq7i+EspKoRu1Km1ctJNVzyby3/Boh0en787tgT4=;
        b=HEpK8IVQN/I0Cgk1H3XONdINxkwZGZ2/FBtSbs627xVmeVdMnSfEqzJ3/tM966XN0h
         9iNg0VR1bkVr38brPjH8e5/SK3cPDzZEOK+YSVjBykKY031gBFm5/81YCIMHnKFEceHr
         ud2CJqh8XQjzpgioNebxKaiYufrtiIU91IVoKVd1ugNSgc5amSCnpFVP53Jma0XPRnLo
         5nKYxgTWjGQL5j4NQ8OxDqG7sgEEaMA4rU9HMqTUCWi67Ye1GgbUy6r07R80ArA0PNr/
         Y25NbE37d0AvT7y6aZMwhSTNzEAaXGzTsYoiBUCfgMy2ghi06aVkyfM4m2CeqsnfduGD
         7Ybg==
X-Gm-Message-State: ACgBeo1pLwsdbXcv7DDDIfB+n5bDzm7/8Em0LhRGXRjzBApAznFI9Zc0
        bWQh3Rugkz3MrNT+uTA3FOgf
X-Google-Smtp-Source: AA6agR5EnVJ32R2CBH2rd5xmGM0YH2cYKxeyeZZO6OMNvLb+3DwAaaDirtc7RwYZN+HAQy3Q9bl7Yg==
X-Received: by 2002:a17:902:e54c:b0:171:4b29:d1e with SMTP id n12-20020a170902e54c00b001714b290d1emr25511345plf.39.1661942534422;
        Wed, 31 Aug 2022 03:42:14 -0700 (PDT)
Received: from thinkpad ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id h188-20020a6253c5000000b0052d46b43006sm10939208pfb.156.2022.08.31.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:42:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:12:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI
 support
Message-ID: <20220831104203.GD5076@thinkpad>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
 <20220818151127.2449064-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818151127.2449064-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 10:11:27AM -0500, Frank Li wrote:
>                         ┌───────┐          ┌──────────┐
>                         │       │          │          │
>       ┌─────────────┐   │       │          │ PCI Host │
>       │ MSI         │◄┐ │       │          │          │
>       │ Controller  │ │ │       │          │          │
>       └─────────────┘ └─┼───────┼──────────┼─BAR0     │
>                         │ PCI   │          │ BAR1     │
>                         │ Func  │          │ BAR2     │
>                         │       │          │ BAR3     │
>                         │       │          │ BAR4     │
>                         │       ├─────────►│          │
>                         └───────┘          └──────────┘
> 

This diagram doesn't say which side is host and which one is endpoint.
And not conveying any useful information.

> Linux supports endpoint functions. PCI Host write BAR<n> space like write
> to memory. The EP side can't know memory changed by the host driver.
> 

I think you just say, that there is no defined way of raising IRQs by host
to the endpoint.

> PCI Spec has not defined a standard method to do that. Only define MSI(x)
> to let EP notified RC status change.
> 

MSI is from EP, right? Throughout the driver you should call it as "doorbell"
and not MSI.

> The basic idea is to trigger an IRQ when PCI RC writes to a memory
> address. That's what MSI controller provided. EP drivers just need to
> request a platform MSI interrupt, struct msi_msg *msg will pass down a
> memory address and data. EP driver will map such memory address to one of
> PCI BAR<n>.  Host just writes such an address to trigger EP side irq.
> 

IIUC (by looking at other patches in the series), the memory assigned for BAR
region by the PCI host is mapped to the platform interrupt controller in
PCI Endpoint. Such that, whenever the PCI host writes to the BAR region, it
will trigger an IRQ in the Endpoint.

This kind of setup is available in other platforms like Qualcomm where the
mapping of a register region available in BAR0 and interrupt controller is
done in the hardware itself. So whenever the PCI host writes to that register
in BAR0, an IRQ will be delivered to the endpoint.

> Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
> have MSI controller. Setup doorbell address according to struct msi_msg.
> 
> So PCIe host can write this doorbell address to triger EP side's irq.
> 
> If no MSI controller exist, fall back to software polling.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 134 +++++++++++++++---
>  1 file changed, 112 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 1466dd1904175..ad4f7ec8a39fc 100644
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
> @@ -143,6 +144,8 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>  
>  	struct delayed_work cmd_handler;
> +
> +	int msi_virqbase;

db_base?

>  };
>  
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> @@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
> -	for (i = 1; i < ntb->db_count; i++) {
> +	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {

epf_db_phy is a wierd name. "phy" usually means the PHY controller (Physical
layer) in kernel. If you are referring to physicall address of the doorbell,
then you could use "phys".

>  		if (readl(ntb->epf_db + i * 4)) {
>  			if (readl(ntb->epf_db + i * 4))
>  				ntb->db |= 1 << (i - 1);
> @@ -454,11 +457,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	ctrl->num_mws = ntb->num_mws;
>  	ntb->spad_size = spad_size;
>  
> -	ctrl->db_entry_size = 4;
> -
>  	for (i = 0; i < ntb->db_count; i++) {
>  		ntb->reg->db_data[i] = 1 + i;
> -		ntb->reg->db_offset[i] = 0;
> +		ntb->reg->db_offset[i] = 4 * i;
>  	}
>  
>  	return 0;
> @@ -509,6 +510,28 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +static int epf_ntb_db_size(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *epc_features;
> +	size_t size = 4 * ntb->db_count;
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
>   * @ntb: NTB device that facilitates communication between HOST and vHOST
> @@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> -	void __iomem *mw_addr;
> +	void __iomem *mw_addr = NULL;
>  	enum pci_barno barno;
> -	size_t size = 4 * ntb->db_count;
> +	size_t size;
>  
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
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
> +	if (!ntb->epf_db_phy) {
> +		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> +		if (!mw_addr) {
> +			dev_err(dev, "Failed to allocate OB address\n");

Expand OB.

> +			return -ENOMEM;
> +		}
> +	} else {
> +		epf_bar->phys_addr = ntb->epf_db_phy;
> +		epf_bar->barno = barno;
> +		epf_bar->size = size;
>  	}
>  
>  	ntb->epf_db = mw_addr;
>  
> -	epf_bar = &ntb->epf->bar[barno];
> -
>  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
>  	if (ret) {
>  		dev_err(dev, "Doorbell BAR set failed\n");
> @@ -704,6 +725,74 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
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
> +	if (desc->msi_index == 0)
> +		ntb->epf_db_phy = round_down(addr, size);
> +
> +	reg->db_offset[desc->msi_index] = addr - ntb->epf_db_phy;
> +}
> +
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
> +		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
> +		return;
> +	}
> +
> +	dev_info(dev, "vntb use MSI as doorbell\n");
> +

Why are you using the interrupt controller as the MSI controller? Why not just
a plain interrupt controller?

> +	for (i = 0; i < ntb->db_count; i++) {
> +		virq = msi_get_virq(dev, i);
> +		ret = devm_request_irq(dev, virq,
> +			       epf_ntb_interrupt_handler, 0,
> +			       "ntb", ntb);

"ntb" as a IRQ name seems quite generic. You might want to prefix it with epf
or vntb...

Thanks,
Mani

> +
> +		if (ret)
> +			dev_err(dev, "devm_request_irq() failure\n");
> +
> +		if (!i)
> +			ntb->msi_virqbase = virq;
> +	}
> +}
> +
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
>   * @ntb: NTB device that facilitates communication between HOST and vHOST2
> @@ -1299,14 +1388,15 @@ static int epf_ntb_bind(struct pci_epf *epf)
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

-- 
மணிவண்ணன் சதாசிவம்

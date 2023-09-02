Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7651790513
	for <lists+linux-pci@lfdr.de>; Sat,  2 Sep 2023 06:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbjIBEwc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Sep 2023 00:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbjIBEwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Sep 2023 00:52:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE71704
        for <linux-pci@vger.kernel.org>; Fri,  1 Sep 2023 21:52:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0bae4da38so4111175ad.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Sep 2023 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693630346; x=1694235146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijD/QXgkfcmQQpjgZVWk02lSeb5Kah86yA9TYX6zx1I=;
        b=eXUrCH/NCbPAQb8WecToMDsXyi4d0slJHEPIq4M03moU+H9GjFla31Rx76ELE9nJFU
         WGHEJyAV/vv9n+TN9GIIa7tSv4hhJx5987N0o/xAo8YD4UNTphOfnq97meC8rNotAytC
         ah5HZ4ySfYhpEsxMTCkprLItsE8AypZmyU4Y6WyWeHSxFwYpkQaFoWo8d1ecRdAVmgMA
         1ZF82fYFluKN3AoKpkkxmPXhQPzPcDaezTRHtMXVjUDIj3bOqLl2gEM31QjpaFN0tW8N
         yeIY8ZLcernOQ3pCzyCujYap/zLMnVo3BNe8DydiLTQPNmvdwqcL7nTBy6ZEvGjmNxck
         W/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693630346; x=1694235146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijD/QXgkfcmQQpjgZVWk02lSeb5Kah86yA9TYX6zx1I=;
        b=jthfr1O9SgHiFdmqhBIiBjR9xdbJD4ujHaNTAt9+V+g622yliL5/F8g0xKFku0H5W0
         +7wN8iS1JdEgNKumYOSi5an53Y969uTIvDjDISAzWiYcfmpFWys6uZx1Cpz+/Bmp4xhA
         6YA9bd7x0DYqYay6CWWKvmkoGfbTIV+qCKrS8pq2BVnp0K0Y4mcvXZ7Osi2MuOZQo5ed
         75bTc7DbIvBO3FgWVch2nR8yq2aQTjgAe9oFs5lmsFaAczU8Ojjgynrb53Y62d+MN8ui
         i/GDM436MUMXgZ7zi6f4rmV1GvOpaZYLBm6ZhfSG1CXOogEosu+vo2ZXGzB3A6k/kzF0
         5uTA==
X-Gm-Message-State: AOJu0YwxtQIf953X+NLrHf6Tmu854qcQRWLngowdXxlZbLT+LbTq+pHr
        9+dDZaAizbvrqY4mw1oJLY56
X-Google-Smtp-Source: AGHT+IHn+lpzw9uFuVsUrK4hFksx30nUuJVmCY/9azhZGZuuOYfsE09NMsfHfbXcr11fLWIN9x+S/g==
X-Received: by 2002:a17:902:ce83:b0:1bc:2fe1:1821 with SMTP id f3-20020a170902ce8300b001bc2fe11821mr6157887plg.17.1693630345688;
        Fri, 01 Sep 2023 21:52:25 -0700 (PDT)
Received: from thinkpad ([117.217.187.8])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001aadd0d7364sm3794308plg.83.2023.09.01.21.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:52:24 -0700 (PDT)
Date:   Sat, 2 Sep 2023 10:22:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <20230902045214.GA2913@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426203436.1277307-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 04:34:34PM -0400, Frank Li wrote:
> This commit introduces a common method for sending messages from the Root Complex
> (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
> such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
> by the PCI host to the message address of the platform MSI interrupt controller
> in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
> an IRQ at the EP. This implementation serves as a common method for all endpoint
> function drivers.
> 
> However, it currently supports only one EP physical function due to limitations
> in ARM MSI/IMS readiness.
> 

I've provided generic comments below, but I will do one more thorough review
after seeing epf-test driver patch.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             |  16 ++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 355a6f56fcea..94ac82bf84c5 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -6,10 +6,12 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/irqreturn.h>

Why is this needed?

>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> @@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>  
> +static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)

static irqreturn_t

s/pci_epf_interrupt_handler/pci_epf_doorbell_handler

> +{
> +	struct pci_epf *epf = data;
> +
> +	if (epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
> +	struct pci_epf *epf;
> +
> +	/* Todo: Need check correct epf if multi epf supported */
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		if (epf->msg && desc->msi_index < epf->num_msgs)
> +			epf->msg[desc->msi_index] = *msg;
> +	}
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
> +{
> +	struct irq_domain *domain;
> +	struct pci_epc *epc;
> +	struct device *dev;
> +	int virq;
> +	int ret;
> +	int i;
> +
> +	epc = epf->epc;
> +	dev = &epc->dev;

"epc_dev" to make it explicit

> +
> +	/*
> +	 * Current only support 1 function.

What does this mean exactly? Even a single EPC can support multiple EPFs

> +	 * PCI IMS(interrupt message store) ARM support have not been
> +	 * ready yet.

No need to mention platform irq controller name.

> +	 */
> +	if (epc->function_num_map != 1)

Why can't you use, epf->func_no?

> +		return -EOPNOTSUPP;
> +
> +	domain = dev_get_msi_domain(dev->parent);
> +	if (!domain)
> +		return -EOPNTSUPP;

Newline

> +	dev_set_msi_domain(dev, domain);
> +
> +	/* use parent of_node to get device id information */
> +	dev->of_node = dev->parent->of_node;
> +

Why do you need of_node assignment inside EPF core?

> +	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
> +	if (!epf->msg)
> +		return -ENOMEM;
> +
> +	epf->num_msgs = num_msgs;
> +

Move this to the start of the function, after checks.

> +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Can't allocate MSI from system MSI controller\n");

"Failed to allocate MSI"

> +		goto err_mem;

err_free_mem

> +	}
> +
> +	for (i = 0; i < num_msgs; i++) {
> +		virq = msi_get_virq(dev, i);
> +		if (i == 0)
> +			epf->virq_base = virq;
> +
> +		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
> +				  "pci-epf-doorbell", epf);

IRQ name should have an index, otherwise all of them will have the same name.

> +
> +		if (ret) {
> +			dev_err(dev, "Failure request doorbell IRQ\n");

"Failed to request doorbell"

> +			goto err_irq;

err_free_irq

> +		}
> +	}
> +
> +	epf->num_msgs = num_msgs;

Newline

> +	return ret;
> +
> +err_irq:
> +	platform_msi_domain_free_irqs(dev);
> +err_mem:
> +	kfree(epf->msg);
> +	epf->msg = NULL;
> +	epf->num_msgs = 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> +
> +void pci_epf_free_doorbell(struct pci_epf *epf)
> +{
> +	struct pci_epc *epc;
> +	int i;
> +
> +	epc = epf->epc;
> +
> +	for (i = 0; i < epf->num_msgs; i++)
> +		free_irq(epf->virq_base + i, epf);
> +
> +	platform_msi_domain_free_irqs(&epc->dev);
> +	kfree(epf->msg);
> +	epf->msg = NULL;
> +	epf->num_msgs = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> +
>  static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  {
>  	struct config_group *group, *tmp;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index b8441db2fa52..e187e3ee48d2 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -75,6 +75,7 @@ struct pci_epf_ops {
>  struct pci_epc_event_ops {
>  	int (*core_init)(struct pci_epf *epf);
>  	int (*link_up)(struct pci_epf *epf);
> +	int (*doorbell)(struct pci_epf *epf, int index);
>  };
>  
>  /**
> @@ -173,6 +174,9 @@ struct pci_epf {
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
>  	const struct pci_epc_event_ops *event_ops;
> +	struct msi_msg *msg;
> +	u16 num_msgs;
> +	int virq_base;
>  };
>  
>  /**
> @@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> +void pci_epf_free_doorbell(struct pci_epf *epf);
> +
> +static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
> +{
> +	return epf->msg;
> +}
> +
> +static inline u16 epf_get_msg_num(struct pci_epf *epf)
> +{
> +	return epf->num_msgs;
> +}

I don't see a need for these two functions as they are doing just dereferences.

- Mani

>  #endif /* __LINUX_PCI_EPF_H */
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

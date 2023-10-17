Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312957CCAD4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJQShd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQShc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 14:37:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1F9E
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 11:37:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso3557851a12.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697567850; x=1698172650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fDIMPqihTJidR00sawm2Nr6O1yAKRnZhnAyaqVDW0po=;
        b=gw9SYMTx1VjeyOO2N2mVtknygAUZAH94dmQ5kTMONKDKD51x/W/ElnL6uJbniDBpuD
         ZgnXRcnEdd1t7d/QC8S5AGkEI2bSjdD56bGAyDTB/MbhVdCQYbug66KLD5WP0zw94krE
         x+WwCBqo6/ozpRYSFOXUyqHnXxSMYHwW86EwZ2jOC/NSWCj/GYUbboj7aNHRQw1NvyX1
         PYe3tgH6BcJR8a97F2dPY+1wD6f965Zq05WGJ3ZP3b+0WT2aAVkjGgu6DmEo9UYHE0m3
         8IHDJ4HlKBunB4YjaAP3FsvAtwU+RAc2Oazb2hQeTNBRVrzuuQ42mp6TjvyhPfaNQfy/
         6KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567850; x=1698172650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDIMPqihTJidR00sawm2Nr6O1yAKRnZhnAyaqVDW0po=;
        b=uXsJmIl8V1L0HOPoK275YWy9haoH20JHTwwxUh4uALnJH2G7cE2XATipAgpkZFrOsn
         Nh9rZoP5uJabCOFVAy9PLopq2fmnH5R3yukfkXNnFDrLk4XwHIwI0AjopKBYdNehUzcD
         TdipYEYZ+61urvfy+JwDMzdzom9JZprh1DFOTqPlalx05+ZZpGLRgcDzdEMjiDX0ZmxZ
         aymudlHJi/4DUrez35AunmwRoLk0ovN0otQ5o7Uq6/GIrufS/cJuA2YpH4xQ2OaIInnT
         XiMtFPvuBEi6i+U7zLixQWBSi3vjl6qL0v6RLUeelVTIu/4uxXTOPwRWFcKIsxTKn84J
         Akug==
X-Gm-Message-State: AOJu0YwMkxfNcmy9CPXTIpucuVvUFiXoOZprdkkSdw6RU7Z6MyXVvqym
        U3G+r3txmiBPQj75QSYI1Xs5
X-Google-Smtp-Source: AGHT+IGZc+AgmoxdQbyFgHaq0HpMKMawgaGe+zQRacb1kYCqnv0STvUbAj7qgu4yUBj9NSvPcrfVDw==
X-Received: by 2002:a05:6a20:1608:b0:14d:d9f8:83f8 with SMTP id l8-20020a056a20160800b0014dd9f883f8mr3663772pzj.1.1697567849901;
        Tue, 17 Oct 2023 11:37:29 -0700 (PDT)
Received: from thinkpad ([117.202.186.25])
        by smtp.gmail.com with ESMTPSA id i2-20020a63e442000000b00577d53c50f7sm211772pgk.75.2023.10.17.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:37:29 -0700 (PDT)
Date:   Wed, 18 Oct 2023 00:07:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <20231017183722.GB137137@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911220920.1817033-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> This commit introduces a common method for sending messages from the Root
> Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> for the BAR region by the PCI host to the message address of the platform
> MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes

"Doorbell feature is implemented by mapping the EP's MSI interrupt controller
message address to a dedicated BAR in the EPC core. It is the responsibility
of the EPF driver to pass the actual message data to be written by the host to
the doorbell BAR region through its own logic."

> to the BAR region, it triggers an IRQ at the EP. This implementation serves
> as a common method for all endpoint function drivers.
> 
> However, it currently supports only one EP physical function due to
> limitations in ARM MSI/IMS readiness.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
>  include/linux/pci-epc.h             |   6 +
>  include/linux/pci-epf.h             |   7 +
>  4 files changed, 249 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a4a8b0be6262..d336a99c6a94f 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> +#include <linux/msi.h>
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
> @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
>  
> +/**
> + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> + *			      the space.

"Allocate platform specific doorbell IRQs to be used by the host to trigger
doorbells on EP."

> + *
> + * @epc: the EPC device that need doorbell address and data from RC.

EPC device for which the doorbell needs to be allocated

> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + * @num_msgs: the total number of doorbell messages

s/num_msgs/num_db

> + *
> + * Return: 0 success, other is failure
> + */
> +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> +{
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return -EINVAL;
> +
> +	if (!epc->ops->alloc_doorbell)
> +		return 0;

You mentioned 0 is a success. So if there is no callback, you want to return
success?

> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);

Why can't you just call the generic function here and in other places instead of
implementing callbacks? I do not see a necessity for EPC specific callbacks. If
there is one, please specify.

> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> +
> +/**
> + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> + *
> + * @epc: the EPC device that need doorbell address and data from RC.

Same as above.

> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + *
> + * Return: 0 success, other is failure
> + */
> +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +		return;
> +
> +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> +		return;
> +
> +	if (!epc->ops->free_doorbell)
> +		return;
> +
> +	mutex_lock(&epc->lock);
> +	epc->ops->free_doorbell(epc, func_no, vfunc_no);

Same as suggested above.

> +	mutex_unlock(&epc->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> +
> +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> +{
> +	struct pci_epf *epf = data;
> +
> +	if (epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, irq - epf->virq_base);

Same as suggested above.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc = NULL;
> +	struct class_dev_iter iter;
> +	struct pci_epf *epf;
> +	struct device *dev;
> +
> +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> +	while ((dev = class_dev_iter_next(&iter))) {
> +		if (dev->parent != desc->dev)
> +			continue;
> +
> +		epc = to_pci_epc(dev);
> +
> +		class_dev_iter_exit(&iter);
> +		break;
> +	}
> +
> +	if (!epc)
> +		return;
> +
> +	/* Only support one EPF for doorbell */
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +

No need of this newline

> +	if (!epf)
> +		return;
> +
> +	if (epf->msg && desc->msi_index < epf->num_msgs)
> +		epf->msg[desc->msi_index] = *msg;
> +}
> +
> +

Remove extra newline

> +/**
> + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> + *                                    controller
> + *
> + * @epc: the EPC device that need doorbell address and data from RC.
> + * @func_no: the physical endpoint function number in the EPC device.
> + * @vfunc_no: the virtual endpoint function number in the physical function.
> + * @num_msgs: the total number of doorbell messages
> + *

Same comment as for pci_epc_alloc_doorbell()

> + * Remark: use this function only if EPC driver just register one EPC device.
> + *
> + * Return: 0 success, other is failure
> + */
> +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> +{
> +	struct pci_epf *epf;
> +	struct device *dev;
> +	int virq, last;
> +	int ret;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(epc))
> +		return -EINVAL;
> +
> +	/* Currently only support one func and one vfunc for doorbell */
> +	if (func_no || vfunc_no)
> +		return -EINVAL;
> +
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +	if (!epf)
> +		return -EINVAL;
> +
> +	dev = epc->dev.parent;
> +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate MSI\n");
> +		return -ENOMEM;
> +	}
> +
> +	last = -1;
> +	for (i = 0; i < num_msgs; i++) {

You should iterate over msi_desc as below:

        msi_lock_descs(dev);
        msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
		...
	}
	msi_unlock_descs(dev);

> +		virq = msi_get_virq(dev, i);
> +		if (i == 0)
> +			epf->virq_base = virq;
> +
> +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,

	request_irq(desc->irq, ...)

> +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to request doorbell\n");
> +			goto err_free_irq;
> +		}
> +		last = i;
> +	}
> +
> +	return 0;
> +
> +err_free_irq:
> +	for (i = 0; i < last; i++)
> +		kfree(free_irq(epf->virq_base + i, epf));
> +	platform_msi_domain_free_irqs(dev);
> +
> +	return -EINVAL;

	return ret;

> +}
> +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> +

[...]

> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 3f44b6aec4770..485c146a5efe2 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
>  	int (*link_up)(struct pci_epf *epf);
>  	int (*link_down)(struct pci_epf *epf);
>  	int (*bme)(struct pci_epf *epf);
> +	int (*doorbell)(struct pci_epf *epf, int index);

kdoc missing.

>  };
>  
>  /**
> @@ -180,6 +181,9 @@ struct pci_epf {
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
>  	const struct pci_epc_event_ops *event_ops;
> +	struct msi_msg *msg;
> +	u16 num_msgs;

num_db

You also need to add kdoc for each new member.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

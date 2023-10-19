Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D27CFD85
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 17:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjJSPEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbjJSPEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 11:04:53 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26C11F
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 08:04:49 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b5f0d658dso4694877eaf.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697727889; x=1698332689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIXhQZU8Z4kn0kT0kPBF+vVNN+HKrEeu0tgZww4gEls=;
        b=HgMmBU3b2evUTQfzY0c6xXCsI8ZO/dVibb2WtJis7G2nrLOhQubhTj47DtWoXKozsx
         vB6EX/nh3BiXf4wOrb8T2BljoJCXRFOWK+QcYUeOKZ3mT5Nv7sMFfF+T/YM8rInz4JJb
         LNcDgT8J/yjyv6BOLeIftYQfEaJYMk5bFICiXLlVVQWMA/0d4o7kbG0wViqGJNPFRz+y
         isLtFU+Ooov+Y9X8Q+ps5WatBgzrOYg01ox85JsMbWU1IWT+PvYeH7jTUxRdXlM7WTRR
         qRFpzqg+eibrDoNKZlJwbEbCwsBtw4O46SD9WOmmlZmPvylbWnoPTcvQc0p9sk9Ga39e
         INsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727889; x=1698332689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIXhQZU8Z4kn0kT0kPBF+vVNN+HKrEeu0tgZww4gEls=;
        b=XbP1PfcNV6dZNw5xCR3awXgKLU8aZ+E8+WKkyePpsIMudDKikVlne78RXLt4ZLLT+D
         UdODIxfPRE5a1noVDGRgU+YFNTKkaCay17nRL2Y6k863e27iClU9N/DZuZdnLDmGIRLa
         J8ufgsx6RbCkrFEn7xXdW/OLaqQg9MNMgA191vBARtjJ3TgnpykHHhkIu9dsj639pan3
         tV4UDsetQWUrgNtO3QS6cqhjxvvYpaAErS5dY7r+nYeq9ZqV7DOSdxJ6fiFNe5rVZX+J
         xYhAxdsUmnjvQcM2sbZv7OQ2biGYlf48p6UHQsH7mjixtHEQ1NKCoNIybxyEi++cQHBg
         zUUg==
X-Gm-Message-State: AOJu0YyOczpA+DtnjAYx3S7vOruu5k67M2OhkPQ0AeC255UxmnLJUKx+
        dvBP85jOSZvVd17Opm1HHyZV
X-Google-Smtp-Source: AGHT+IHswvGO/BsCpanzXCw3l9Yzeb9XsuqM1gWPXOnqP5h+AFTTxtYIt8BiUG5mY9q2I/pa9JygBg==
X-Received: by 2002:a05:6358:cb27:b0:142:fb84:92e6 with SMTP id gr39-20020a056358cb2700b00142fb8492e6mr2190669rwb.9.1697727888774;
        Thu, 19 Oct 2023 08:04:48 -0700 (PDT)
Received: from thinkpad ([117.202.186.40])
        by smtp.gmail.com with ESMTPSA id h18-20020aa79f52000000b00692b6fe1c7asm5384074pfr.179.2023.10.19.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:04:48 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:34:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
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
Message-ID: <20231019150441.GA7254@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-2-Frank.Li@nxp.com>
 <20231017183722.GB137137@thinkpad>
 <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS7YvWSlkQluPtg3@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 02:55:57PM -0400, Frank Li wrote:
> On Wed, Oct 18, 2023 at 12:07:22AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 11, 2023 at 06:09:16PM -0400, Frank Li wrote:
> > > This commit introduces a common method for sending messages from the Root
> > > Complex (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt
> > > controller, such as ARM GIC, as an EP doorbell. Maps the memory assigned
> > > for the BAR region by the PCI host to the message address of the platform
> > > MSI interrupt controller in the PCI EP. As a result, when the PCI RC writes
> > 
> > "Doorbell feature is implemented by mapping the EP's MSI interrupt controller
> > message address to a dedicated BAR in the EPC core. It is the responsibility
> > of the EPF driver to pass the actual message data to be written by the host to
> > the doorbell BAR region through its own logic."
> > 
> > > to the BAR region, it triggers an IRQ at the EP. This implementation serves
> > > as a common method for all endpoint function drivers.
> > > 
> > > However, it currently supports only one EP physical function due to
> > > limitations in ARM MSI/IMS readiness.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/pci-epc-core.c | 192 ++++++++++++++++++++++++++++
> > >  drivers/pci/endpoint/pci-epf-core.c |  44 +++++++
> > >  include/linux/pci-epc.h             |   6 +
> > >  include/linux/pci-epf.h             |   7 +
> > >  4 files changed, 249 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 5a4a8b0be6262..d336a99c6a94f 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/module.h>
> > >  
> > > +#include <linux/msi.h>
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > >  #include <linux/pci-ep-cfs.h>
> > > @@ -783,6 +784,197 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
> > >  
> > > +/**
> > > + * pci_epc_alloc_doorbell() - alloc an address space to let RC trigger EP side IRQ by write data to
> > > + *			      the space.
> > 
> > "Allocate platform specific doorbell IRQs to be used by the host to trigger
> > doorbells on EP."
> > 
> > > + *
> > > + * @epc: the EPC device that need doorbell address and data from RC.
> > 
> > EPC device for which the doorbell needs to be allocated
> > 
> > > + * @func_no: the physical endpoint function number in the EPC device.
> > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > + * @num_msgs: the total number of doorbell messages
> > 
> > s/num_msgs/num_db
> > 
> > > + *
> > > + * Return: 0 success, other is failure
> > > + */
> > > +int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > +		return -EINVAL;
> > > +
> > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > +		return -EINVAL;
> > > +
> > > +	if (!epc->ops->alloc_doorbell)
> > > +		return 0;
> > 
> > You mentioned 0 is a success. So if there is no callback, you want to return
> > success?
> > 
> > > +
> > > +	mutex_lock(&epc->lock);
> > > +	ret = epc->ops->alloc_doorbell(epc, func_no, vfunc_no, num_msgs);
> > 
> > Why can't you just call the generic function here and in other places instead of
> > implementing callbacks? I do not see a necessity for EPC specific callbacks. If
> > there is one, please specify.
> 
> 1. Refer v1 your comments.
> https://lore.kernel.org/imx/20230906145227.GC5930@thinkpad/

I do not find where I suggested the callback approach.

> 2. Maybe some ep controller have built-in doorbell support. Write to some
> address to trigger doorbell irq.
> 

We will handle it whenever such EP controllers arrive. Until then, let's keep it
simple.

- Mani

> Frank
> 
> > 
> > > +	mutex_unlock(&epc->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_alloc_doorbell);
> > > +
> > > +/**
> > > + * pci_epc_free_doorbell() - free resource allocated by pci_epc_alloc_doorbell()
> > > + *
> > > + * @epc: the EPC device that need doorbell address and data from RC.
> > 
> > Same as above.
> > 
> > > + * @func_no: the physical endpoint function number in the EPC device.
> > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > + *
> > > + * Return: 0 success, other is failure
> > > + */
> > > +void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > > +{
> > > +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> > > +		return;
> > > +
> > > +	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> > > +		return;
> > > +
> > > +	if (!epc->ops->free_doorbell)
> > > +		return;
> > > +
> > > +	mutex_lock(&epc->lock);
> > > +	epc->ops->free_doorbell(epc, func_no, vfunc_no);
> > 
> > Same as suggested above.
> > 
> > > +	mutex_unlock(&epc->lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_free_doorbell);
> > > +
> > > +static irqreturn_t pci_epf_generic_doorbell_handler(int irq, void *data)
> > > +{
> > > +	struct pci_epf *epf = data;
> > > +
> > > +	if (epf->event_ops && epf->event_ops->doorbell)
> > > +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> > 
> > Same as suggested above.
> > 
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static void pci_epc_generic_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > +{
> > > +	struct pci_epc *epc = NULL;
> > > +	struct class_dev_iter iter;
> > > +	struct pci_epf *epf;
> > > +	struct device *dev;
> > > +
> > > +	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> > > +	while ((dev = class_dev_iter_next(&iter))) {
> > > +		if (dev->parent != desc->dev)
> > > +			continue;
> > > +
> > > +		epc = to_pci_epc(dev);
> > > +
> > > +		class_dev_iter_exit(&iter);
> > > +		break;
> > > +	}
> > > +
> > > +	if (!epc)
> > > +		return;
> > > +
> > > +	/* Only support one EPF for doorbell */
> > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > +
> > 
> > No need of this newline
> > 
> > > +	if (!epf)
> > > +		return;
> > > +
> > > +	if (epf->msg && desc->msi_index < epf->num_msgs)
> > > +		epf->msg[desc->msi_index] = *msg;
> > > +}
> > > +
> > > +
> > 
> > Remove extra newline
> > 
> > > +/**
> > > + * pci_epc_generic_alloc_doorbell() - Common help function. Allocate address space from MSI
> > > + *                                    controller
> > > + *
> > > + * @epc: the EPC device that need doorbell address and data from RC.
> > > + * @func_no: the physical endpoint function number in the EPC device.
> > > + * @vfunc_no: the virtual endpoint function number in the physical function.
> > > + * @num_msgs: the total number of doorbell messages
> > > + *
> > 
> > Same comment as for pci_epc_alloc_doorbell()
> > 
> > > + * Remark: use this function only if EPC driver just register one EPC device.
> > > + *
> > > + * Return: 0 success, other is failure
> > > + */
> > > +int pci_epc_generic_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_msgs)
> > > +{
> > > +	struct pci_epf *epf;
> > > +	struct device *dev;
> > > +	int virq, last;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	if (IS_ERR_OR_NULL(epc))
> > > +		return -EINVAL;
> > > +
> > > +	/* Currently only support one func and one vfunc for doorbell */
> > > +	if (func_no || vfunc_no)
> > > +		return -EINVAL;
> > > +
> > > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > > +	if (!epf)
> > > +		return -EINVAL;
> > > +
> > > +	dev = epc->dev.parent;
> > > +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epc_generic_write_msi_msg);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to allocate MSI\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	last = -1;
> > > +	for (i = 0; i < num_msgs; i++) {
> > 
> > You should iterate over msi_desc as below:
> > 
> >         msi_lock_descs(dev);
> >         msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > 		...
> > 	}
> > 	msi_unlock_descs(dev);
> > 
> > > +		virq = msi_get_virq(dev, i);
> > > +		if (i == 0)
> > > +			epf->virq_base = virq;
> > > +
> > > +		ret = request_irq(virq, pci_epf_generic_doorbell_handler, 0,
> > 
> > 	request_irq(desc->irq, ...)
> > 
> > > +				  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i), epf);
> > > +
> > > +		if (ret) {
> > > +			dev_err(dev, "Failed to request doorbell\n");
> > > +			goto err_free_irq;
> > > +		}
> > > +		last = i;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_free_irq:
> > > +	for (i = 0; i < last; i++)
> > > +		kfree(free_irq(epf->virq_base + i, epf));
> > > +	platform_msi_domain_free_irqs(dev);
> > > +
> > > +	return -EINVAL;
> > 
> > 	return ret;
> > 
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_generic_alloc_doorbell);
> > > +
> > 
> > [...]
> > 
> > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > index 3f44b6aec4770..485c146a5efe2 100644
> > > --- a/include/linux/pci-epf.h
> > > +++ b/include/linux/pci-epf.h
> > > @@ -79,6 +79,7 @@ struct pci_epc_event_ops {
> > >  	int (*link_up)(struct pci_epf *epf);
> > >  	int (*link_down)(struct pci_epf *epf);
> > >  	int (*bme)(struct pci_epf *epf);
> > > +	int (*doorbell)(struct pci_epf *epf, int index);
> > 
> > kdoc missing.
> > 
> > >  };
> > >  
> > >  /**
> > > @@ -180,6 +181,9 @@ struct pci_epf {
> > >  	unsigned long		vfunction_num_map;
> > >  	struct list_head	pci_vepf;
> > >  	const struct pci_epc_event_ops *event_ops;
> > > +	struct msi_msg *msg;
> > > +	u16 num_msgs;
> > 
> > num_db
> > 
> > You also need to add kdoc for each new member.
> > 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

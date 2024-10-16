Return-Path: <linux-pci+bounces-14604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC399FE5F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7921F21F9D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51D139CFA;
	Wed, 16 Oct 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOOBQhQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8313AF2;
	Wed, 16 Oct 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042583; cv=none; b=e+yRUUdcP2qHzosGGo8IpkEoS9LvCtHkCB0FM5MskWF3z9fMWFLK41eM2WTjhdFwPF5fMdUNG+7PcsknRkGwjuoyzo2iEAdVvEwdJYAvtc00JqrGIwpdmWE1kiLTsSNS4t8fYDPEkcdSjCz8PS9sUKIBRGGxaqUwdPAsTLZaBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042583; c=relaxed/simple;
	bh=A7oJAbA2Nni7jbMx2AssAIey6XPhADZRVt3fJQeoJys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvScvHNNszWfaiffGMgNMg5GaF0b8PD8zHVq/b2rNk/x16eBFrBNa4566KG0M4R2lpuaPNROwPDGA3T4010VSXLxDgbb8pRUZ+Fy0yz3sGn9qveHLDcdIHvEmLL+TFEAUg20i95JSGHMhehZBv4Y6R/eGTHCcEwyqrv2poyTk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOOBQhQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79706C4CEC6;
	Wed, 16 Oct 2024 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042583;
	bh=A7oJAbA2Nni7jbMx2AssAIey6XPhADZRVt3fJQeoJys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OOOBQhQWdUdu/9aVDCAHE8GHqQ1+zMWt4OAnjAsZYILineyTOIeOqfO1G1NnvWwUT
	 a3KXeNp3Af/4i6IbJU3TKz0v5V7gBxudz6QGXoMDOovsQbTcbhUbcGhYsbH4+AVq37
	 Vob3RrhsdD9meJiPdXepGe/XM2RsP+y2DzBUpBZyXSsrOmyvxcHj5taVqLtV/dZYbs
	 ph0aB2Ux1yx/OSTS9wb4Kr5Fp8gzQ5QXK313ICI6TO+NlCn3Oqq+oogIiDHJm54aT0
	 CTXW7+DMaG2PjIJ5d7T198iH2PXqMX18PkFmZ8Xt170PpP4ROe9LaM88GId/RuredF
	 w3esiAdG8JjpA==
Message-ID: <97b7e1e7-cb2d-4324-aff5-55b872f2faf3@kernel.org>
Date: Wed, 16 Oct 2024 10:36:20 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
To: Frank Li <Frank.Li@nxp.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, maz@kernel.org,
 tglx@linutronix.de, jdmason@kudzu.us
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 7:07 AM, Frank Li wrote:
> Doorbell feature is implemented by mapping the EP's MSI interrupt
> controller message address to a dedicated BAR in the EPC core. It is the
> responsibility of the EPF driver to pass the actual message data to be
> written by the host to the doorbell BAR region through its own logic.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/Makefile     |   2 +-
>  drivers/pci/endpoint/pci-ep-msi.c | 162 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-ep-msi.h        |  15 ++++
>  include/linux/pci-epf.h           |   6 ++
>  4 files changed, 184 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> index 95b2fe47e3b06..a1ccce440c2c5 100644
> --- a/drivers/pci/endpoint/Makefile
> +++ b/drivers/pci/endpoint/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
>  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> -					   pci-epc-mem.o functions/
> +					   pci-epc-mem.o pci-ep-msi.o functions/
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> new file mode 100644
> index 0000000000000..534dcd05c435c
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Endpoint *Controller* (EPC) MSI library
> + *
> + * Copyright (C) 2024 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +

Stray blank line here.

> +#include <linux/msi.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci-ep-cfs.h>
> +#include <linux/pci-ep-msi.h>
> +
> +static irqreturn_t pci_epf_doorbell_handler(int irq, void *data)
> +{
> +	struct pci_epf *epf = data;
> +	struct msi_desc *desc = irq_get_msi_desc(irq);
> +
> +	if (desc && epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, desc->msi_index);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static bool pci_epc_match_parent(struct device *dev, void *param)
> +{
> +	return dev->parent == param;
> +}
> +
> +static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc __free(pci_epc_put) = NULL;
> +	struct pci_epf *epf;
> +
> +	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
> +

No need for the blank line here.

> +	if (!epc)
> +		return;
> +
> +	/* Only support one EPF for doorbell */
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +	if (!epf)
> +		return;
> +
> +	if (epf->msg && desc->msi_index < epf->num_db)

Change this to:

	if (epf && epf->msg && desc->msi_index < epf->num_db)

and then remove the "if(!epf) return;" above. Shorter code :)

> +		memcpy(epf->msg, msg, sizeof(*msg));
> +}
> +
> +static int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_db)
> +{
> +	struct msi_desc *desc, *failed_desc;
> +	struct pci_epf *epf;
> +	struct device *dev;
> +	int i = 0;
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc))
> +		return -EINVAL;

Is this really needed ?

> +
> +	/* Currently only support one func and one vfunc for doorbell */
> +	if (func_no || vfunc_no)
> +		return -EINVAL;
> +
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +	if (!epf)
> +		return -EINVAL;

Why do you need this ? epf is unused in this function...

> +
> +	dev = epc->dev.parent;
> +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate MSI\n");
> +		return -ENOMEM;

		return ret;

> +	}
> +
> +	scoped_guard(msi_descs, dev)

I personnally really dislike this... This adds one level of identation and
hides code. Really ugly in my opinion. But that is only that, my opinion. I
will let the maintainer decide on this.

> +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> +			ret = request_irq(desc->irq, pci_epf_doorbell_handler, 0,
> +					  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i++), epf);
> +			if (ret) {
> +				dev_err(dev, "Failed to request doorbell\n");
> +				failed_desc = desc;
> +				goto err_request_irq;
> +			}
> +		}
> +
> +	return 0;
> +
> +err_request_irq:
> +	scoped_guard(msi_descs, dev)
> +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> +			if (desc == failed_desc)
> +				break;
> +			kfree(free_irq(desc->irq, epf));

If request_irq() failed and you want to cleanup everything, I do not think you
need to track the failed_desc since free_irq() will return NULL if the irq was
not requested. That would simplify this code.

> +		}
> +
> +	platform_device_msi_free_irqs_all(epc->dev.parent);
> +
> +	return ret;
> +}
> +
> +static void pci_epc_free_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> +{
> +	struct msi_desc *desc;
> +	struct pci_epf *epf;
> +	struct device *dev;
> +
> +	dev = epc->dev.parent;

Nit: move the affectation to the declaration line:

	struct device *dev = epc->dev.parent;

> +
> +	scoped_guard(msi_descs, dev)
> +		msi_for_each_desc(desc, dev, MSI_DESC_ALL)
> +			kfree(free_irq(desc->irq, epf));
> +
> +	platform_device_msi_free_irqs_all(epc->dev.parent);
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> +	struct pci_epc *epc;
> +	struct device *dev;
> +	void *msg;
> +	int ret;
> +
> +	epc = epf->epc;
> +	dev = &epc->dev;

Same here: move this to the declaration lines.

> +
> +	guard(mutex)(&epc->lock);

Another code hiding trick... Having the calls to mutex_lock/unlock(&epc->lock)
would not complicate this code and makes things a lot more clear in my opinion...

But more importantly: you are taking the epc lock in a pci_epf_ function, which
is a little odd... Shouldn't this lock be taken in pci_epc_alloc_doorbell()
instead ?

> +
> +	msg = kcalloc(num_db, sizeof(struct msi_msg), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;

You can do this allocation before taking the epc mutex lock.

> +
> +	epf->num_db = num_db;
> +	epf->msg = msg;
> +
> +	ret = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_db);
> +	if (ret)
> +		kfree(msg);

Looking at this, it seems that pci_epc_alloc_doorbell() should allocate msg and
return a pointer to it (or ERR_PTR). This entire function would become:

	msg = pci_epc_alloc_doorbell(epc, epf->func_no, epf->vfunc_no, num_db);
	if (IS_ERR(msg))
		return PTR_ERR(msg);

	epf->num_db = num_db;
	epf->msg = msg;

	return 0;

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> +
> +void pci_epf_free_doorbell(struct pci_epf *epf)
> +{
> +	struct pci_epc *epc = epf->epc;
> +
> +	guard(mutex)(&epc->lock);

Same comment about the location of this lock. That should be in
pci_epc_free_doorbell() I think.

> +
> +	epc = epf->epc;

You did that at delaration time already. But this epc variable is used only
below so it is not really needed at all.

> +	pci_epc_free_doorbell(epc, epf->func_no, epf->vfunc_no);
> +
> +	kfree(epf->msg);

This also should be in pci_epc_free_doorbell. So something like:

	pci_epc_free_doorbell(epf->epc, epf->func_no, epf->vfunc_no, epf->msg);

to be consistent with the changed proposed above for the allloc function.

> +	epf->msg = NULL;
> +	epf->num_db = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
> new file mode 100644
> index 0000000000000..f0cfecf491199
> --- /dev/null
> +++ b/include/linux/pci-ep-msi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Endpoint *Function* side MSI header file
> + *
> + * Copyright (C) 2024 NXP
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#ifndef __PCI_EP_MSI__
> +#define __PCI_EP_MSI__
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> +void pci_epf_free_doorbell(struct pci_epf *epf);
> +
> +#endif /* __PCI_EP_MSI__ */

I do not see the point of this file. Why not add these function declarations to
include/linux/pci-epf.h to keep all EPF API together ?

> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 18a3aeb62ae4e..1e7e5eb4067d7 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -75,6 +75,7 @@ struct pci_epf_ops {
>   * @link_up: Callback for the EPC link up event
>   * @link_down: Callback for the EPC link down event
>   * @bus_master_enable: Callback for the EPC Bus Master Enable event
> + * @doorbell: Callback for EPC receive MSI from RC side
>   */
>  struct pci_epc_event_ops {
>  	int (*epc_init)(struct pci_epf *epf);
> @@ -82,6 +83,7 @@ struct pci_epc_event_ops {
>  	int (*link_up)(struct pci_epf *epf);
>  	int (*link_down)(struct pci_epf *epf);
>  	int (*bus_master_enable)(struct pci_epf *epf);
> +	int (*doorbell)(struct pci_epf *epf, int index);
>  };
>  
>  /**
> @@ -152,6 +154,8 @@ struct pci_epf_bar {
>   * @vfunction_num_map: bitmap to manage virtual function number
>   * @pci_vepf: list of virtual endpoint functions associated with this function
>   * @event_ops: Callbacks for capturing the EPC events
> + * @msg: data for MSI from RC side
> + * @num_db: number of doorbells
>   */
>  struct pci_epf {
>  	struct device		dev;
> @@ -182,6 +186,8 @@ struct pci_epf {
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
>  	const struct pci_epc_event_ops *event_ops;
> +	struct msi_msg *msg;
> +	u16 num_db;
>  };
>  
>  /**
> 


-- 
Damien Le Moal
Western Digital Research


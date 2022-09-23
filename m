Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE235E8502
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 23:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiIWVgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWVgk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 17:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9A13F71B;
        Fri, 23 Sep 2022 14:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 145B2B826A7;
        Fri, 23 Sep 2022 21:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B37BC433D6;
        Fri, 23 Sep 2022 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663968995;
        bh=Eg86Q/klFJzieYi/1ql2yElcwO79tGng61WDJNN4DxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K/h5WRk4Xh+imxHsP3h6kS2wswXW0arUKsz7kV3dD95P6ASiE23ltD7DcQKPael5H
         diO2Y5zYoNbB9hlIgBlaLEzAyZsxgpdano7WX+dzFxot38nVvH/bzwvKQQj82EaZlO
         8bYT+qLUS9ndCQ+L+XvZLbaUfhYnwPbVzNO3NlvQ8YxeTl5gK7Tg8eleU8B6w7Qiq2
         Djrf5BFVQMSzONwbCNF+/2OZH/hZpOhrAeepKjmn8BJT828Z2HA/Ksz7zeIwMIVuYh
         /LJmDYpD5DT9uhMGH5UA9/ec/Ee2QzpyWrnWOuyEB7qDq9qHAqZ7rE73GLK9jFZBo0
         w+cJvylzvrntw==
Date:   Fri, 23 Sep 2022 16:36:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [RFC PATCH v3 3/4] PCI/CMA: Initial support for Component
 Measurement and Authentication ECN
Message-ID: <20220923213634.GA1420285@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906111556.1544-4-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 12:15:55PM +0100, Jonathan Cameron wrote:
> This currently very much a PoC.  Currently the SPDM library only provides
> a single function to allow a challenge / authentication of the PCI EP.
> 
> SPDM exchanges must occur in one of a small set of valid squences over
> which the message digest used in authentication is built up.
> Placing that complexity in the SPDM library seems like a good way
> to enforce that logic, without having to do it for each transport.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/Kconfig     |  13 +++++
>  drivers/pci/Makefile    |   1 +
>  drivers/pci/cma.c       | 117 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-cma.h |  21 ++++++++
>  4 files changed, 152 insertions(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 55c028af4bd9..b25e97a1e771 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -118,6 +118,19 @@ config XEN_PCIDEV_FRONTEND
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_CMA
> +	tristate "PCI Component Measurement and Authentication"
> +	select PCI_DOE
> +	select ASN1_ENCODER
> +	select SPDM
> +	help
> +	  This enables library support for the PCI Component Measurement and
> +	  Authentication introduce in PCI r6.0 sec 6.31. A PCI DOE mailbox is
> +	  used as the transport for DMTF SPDM based attestation, measurement
> +	  and secure channel establishment.
> +
> +	  If built as a module will be called cma.ko.
> +
>  config PCI_ATS
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 2680e4c92f0a..d2e38b2baeae 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_CMA)		+= cma.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 000000000000..b38b7a688266
> --- /dev/null
> +++ b/drivers/pci/cma.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Component Measurement and Authentication was added as an ECN to the
> + * PCIe r5.0 spec.

It looks like PCIe r6.0, sec 6.31?  (Oh, I see that's what you mention
above in the Kconfig text :))  I have absolutely no idea what CMA is
about or how it works.  Other than pci_doe_submit_task(), nothing here
is recognizable to me as PCI-related and I can't tell what else, if
anything, is connected to something in the PCIe spec.

> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci-cma.h>
> +#include <linux/pci-doe.h>
> +#include <linux/spdm.h>
> +
> +#define PCI_DOE_PROTOCOL_CMA 1
> +/* Keyring that userspace can poke certs into */
> +static struct key *cma_keyring;
> +
> +static void cxl_doe_task_complete(struct pci_doe_task *task)
> +{
> +	complete(task->private);
> +}
> +
> +static int cma_spdm_ex(void *priv, struct spdm_exchange *spdm_ex)
> +{
> +	size_t request_padded_sz, response_padded_sz;
> +	struct completion c = COMPLETION_INITIALIZER_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot = {
> +			.vid = PCI_VENDOR_ID_PCI_SIG,
> +			.type = PCI_DOE_PROTOCOL_CMA,
> +		},
> +		.complete = cxl_doe_task_complete,
> +		.private = &c,
> +	};
> +	struct pci_doe_mb *doe = priv;
> +	int rc;
> +
> +	/* DOE requires that response and request are padded to a multiple of 4 bytes */

Wrap or shorten to fit in 80 columns.

> +	request_padded_sz = ALIGN(spdm_ex->request_sz, sizeof(u32));
> +	if (request_padded_sz != spdm_ex->request_sz) {
> +		task.request_pl = kzalloc(request_padded_sz, GFP_KERNEL);
> +		if (!task.request_pl)
> +			return -ENOMEM;
> +		memcpy(task.request_pl, spdm_ex->request, spdm_ex->request_sz);
> +		task.request_pl_sz = request_padded_sz;
> +	} else {
> +		task.request_pl = (u32 *)spdm_ex->request;
> +		task.request_pl_sz = spdm_ex->request_sz;
> +	}
> +
> +	response_padded_sz = ALIGN(spdm_ex->response_sz, sizeof(u32));
> +	if (response_padded_sz != spdm_ex->response_sz) {
> +		task.response_pl = kzalloc(response_padded_sz, GFP_KERNEL);
> +		if (!task.response_pl) {
> +			rc = -ENOMEM;
> +			goto err_free_req;
> +		}
> +		task.response_pl_sz = response_padded_sz;
> +	} else {
> +		task.response_pl = (u32 *)spdm_ex->response;
> +		task.response_pl_sz = spdm_ex->response_sz;
> +	}
> +
> +	rc = pci_doe_submit_task(doe, &task);
> +	if (rc < 0)
> +		goto err_free_rsp;
> +
> +	wait_for_completion(&c);
> +	if (response_padded_sz != spdm_ex->response_sz)
> +		memcpy(spdm_ex->response, task.response_pl, spdm_ex->response_sz);
> +
> +	rc = task.rv;
> +err_free_rsp:
> +	if (response_padded_sz != spdm_ex->response_sz)
> +		kfree(task.response_pl);
> +err_free_req:
> +	if (request_padded_sz != spdm_ex->request_sz)
> +		kfree(task.request_pl);
> +
> +	return rc;
> +}
> +
> +struct spdm_state *pci_cma_create(struct device *dev, struct pci_doe_mb *doe)
> +{
> +	return spdm_create(cma_spdm_ex, doe, dev, cma_keyring);
> +}
> +EXPORT_SYMBOL_GPL(pci_cma_create);
> +
> +void pci_cma_destroy(struct spdm_state *spdm_state)
> +{
> +	kfree(spdm_state);
> +}
> +EXPORT_SYMBOL_GPL(pci_cma_destroy);
> +
> +int pci_cma_authenticate(struct spdm_state *spdm_state)
> +{
> +	return spdm_authenticate(spdm_state);
> +}
> +EXPORT_SYMBOL_GPL(pci_cma_authenticate);
> +
> +__init static int cma_keyring_init(void)
> +{
> +	cma_keyring = keyring_alloc("_cma",
> +				    KUIDT_INIT(0), KGIDT_INIT(0),
> +				    current_cred(),
> +				    (KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				    KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE | KEY_USR_SEARCH,
> +				    KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP, NULL, NULL);
> +	if (IS_ERR(cma_keyring))
> +		pr_err("Could not allocate cma keyring\n");
> +
> +	return 0;
> +}
> +device_initcall(cma_keyring_init);
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pci-cma.h b/include/linux/pci-cma.h
> new file mode 100644
> index 000000000000..d2a0a84973bf
> --- /dev/null
> +++ b/include/linux/pci-cma.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Component Measurement and Authentication was added as an ECN to the
> + * PCIe r5.0 spec.

Update as well?

> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + */
> +
> +#ifndef _PCI_CMA_H_
> +#define _PCI_CMA_H_
> +struct pci_doe_mb;
> +struct spdm_state;
> +struct device;
> +
> +struct spdm_state *pci_cma_create(struct device *dev, struct pci_doe_mb *doe);
> +void pci_cma_destroy(struct spdm_state *spdm_state);
> +
> +int pci_cma_authenticate(struct spdm_state *spdm_state);
> +
> +#endif
> -- 
> 2.32.0
> 

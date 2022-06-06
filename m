Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FA53ED1A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiFFRma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiFFRm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 13:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA8B29CB1;
        Mon,  6 Jun 2022 10:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479146120E;
        Mon,  6 Jun 2022 17:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6AAC385A9;
        Mon,  6 Jun 2022 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654537342;
        bh=eyv00kTUr8ZViS74f5zUzu92HwY5qFYV3mKgjv2LgDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIFsOFGIiS1dchMVG/R5GQxyeRqh3ctWpC51jN27MyKcD1zuuvlsvpL9jrNKo+tYM
         GIX2waF5XWrP/BqX9JZjXxyUjXyUfWbrcQgLSob+IsGMXeHjW646yNXSGREJgiKLR9
         JIVOatkPoajcgZ4V5pWh5usKV+OMu7gQtRTadu+/oV84r9QjLaanFQZeUIYiFAA1R0
         u3yzOiz3sLIlG3qCMZE1uUjkfAsZPCzONK+JUzVnc4Hgq2sxVN2mPEigu6xYCfKKYl
         RyXtaA+G5jRYeLCi2XbYVIJMs5l/1rpYntVHQ/Cw81VGIhfscL4pSvcf4q7XTgUel7
         T1iN9tKzL86+g==
Date:   Mon, 6 Jun 2022 10:42:20 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220606174220.qohs5eaen2mjek5v@bwidawsk-mobl5>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605005049.2155874-5-ira.weiny@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-06-04 17:50:44, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of ports may drive this code
> into the pcie side.  In this imagined architecture the CXL port driver
> would then query into the PCI device for the DOE mailbox array.
> 
> For now this is good enough for the endpoints and the split is similar
> to the envisioned architecture where getting the mailbox array is
> separated from the various protocol needs.  For example, it is not
> anticipated that the CDAT code will need to move because it is only
> needed by the cxl_ports.
> 
> Likewise irq's are separated out in a similar design pattern to the
> PCIe port driver.  But a much simpler irq enabling flag is used and only
> DOE interrupts are supported.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V9:
> 	Bug fix: ensure DOE mailboxes are iterated before memdev add
> 	Ben Widawsky
> 		Set use_irq to false and just return on error.
> 		Don't return a value from devm_cxl_pci_create_doe()
> 		Skip allocating doe_mb array if there are no mailboxes
> 		Skip requesting irqs if none found.
> 	Ben/Jonathan Cameron
> 		s/num_irqs/max_irqs
> 
> Changes from V8:
> 	Move PCI_DOE selection to CXL_BUS to support future patches
> 	which move queries into the port code.
> 	Remove Auxiliary device arch
> 	Squash the functionality of the auxiliary driver into this
> 	patch.
> 	Split out the irq handling a bit.
> 
> Changes from V7:
> 	Minor code clean ups
> 	Rebased on cxl-pending
> 
> Changes from V6:
> 	Move all the auxiliary device stuff to the CXL layer
> 
> Changes from V5:
> 	Split the CXL specific stuff off from the PCI DOE create
> 	auxiliary device code.
> ---
>  drivers/cxl/Kconfig  |   1 +
>  drivers/cxl/cxlmem.h |   6 +++
>  drivers/cxl/pci.c    | 114 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index f64e3984689f..7adaaf80b302 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig CXL_BUS
>  	tristate "CXL (Compute Express Link) Devices Support"
>  	depends on PCI
> +	select PCI_DOE
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 60d10ee1e7fc..4d2764b865ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> + * @doe_mbs: PCI DOE mailbox array
> + * @num_mbs: Number of DOE mailboxes
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -224,6 +226,10 @@ struct cxl_dev_state {
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> +	bool doe_use_irq;
> +	struct pci_doe_mb **doe_mbs;
> +	int num_mbs;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5a0ae46d4989..72c7b535f5df 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -386,6 +387,116 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static void cxl_doe_destroy_mb(void *ds)
> +{
> +	struct cxl_dev_state *cxlds = ds;
> +	int i;
> +
> +	for (i = 0; i < cxlds->num_mbs; i++) {
> +		if (cxlds->doe_mbs[i])
> +			pci_doe_destroy_mb(cxlds->doe_mbs[i]);
> +	}
> +}
> +
> +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int max_irqs = 0;
> +	int off = 0;
> +	int rc;
> +
> +	/* Account for all the DOE vectors needed */
> +	pci_doe_for_each_off(pdev, off) {
> +		int irq = pci_doe_get_irq_num(pdev, off);
> +
> +		if (irq < 0)
> +			continue;
> +		max_irqs = max(max_irqs, irq + 1);
> +	}
> +
> +	if (!max_irqs)
> +		return;
> +
> +	cxlds->doe_use_irq = false;
> +
> +	/*
> +	 * Allocate enough vectors for the DOE's
> +	 */
> +	rc = pci_alloc_irq_vectors(pdev, max_irqs, max_irqs, PCI_IRQ_MSI |
> +							     PCI_IRQ_MSIX);
> +	if (rc != max_irqs) {
> +		pci_err(pdev, "Not enough interrupts; use polling\n");
> +		/* Some got allocated; clean them up */
> +		if (rc > 0)
> +			cxl_pci_free_irq_vectors(pdev);
> +		return;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +	if (rc)
> +		return;
> +
> +	cxlds->doe_use_irq = true;
> +}
> +
> +/**
> + * devm_cxl_pci_create_doe - Scan and set up DOE mailboxes
> + *
> + * @cxlds: The CXL device state
> + */
> +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 off = 0;
> +	int num_mbs = 0;
> +	int rc;
> +
> +	pci_doe_for_each_off(pdev, off)
> +		num_mbs++;
> +
> +	if (!num_mbs) {
> +		pci_dbg(pdev, "0 DOE mailbox's found\n");
> +		return;
> +	}
> +
> +	cxlds->doe_mbs = devm_kcalloc(dev, num_mbs, sizeof(*cxlds->doe_mbs),
> +				      GFP_KERNEL);
> +	if (!cxlds->doe_mbs)
> +		return;
> +
> +	pci_doe_for_each_off(pdev, off) {
> +		struct pci_doe_mb *doe_mb;
> +		int irq = -1;
> +
> +		if (cxlds->doe_use_irq)
> +			irq = pci_doe_get_irq_num(pdev, off);
> +
> +		doe_mb = pci_doe_create_mb(pdev, off, irq);
> +		if (IS_ERR(doe_mb)) {
> +			pci_err(pdev,
> +				"Failed to create MB object for MB @ %x\n",
> +				off);
> +			doe_mb = NULL;
> +		}
> +
> +		cxlds->doe_mbs[cxlds->num_mbs] = doe_mb;
> +		cxlds->num_mbs++;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, cxl_doe_destroy_mb, cxlds);
> +	if (rc)
> +		return;
> +
> +	pci_info(pdev, "Configured %d DOE mailbox's\n", cxlds->num_mbs);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -434,6 +545,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
>  
> +	cxl_alloc_irq_vectors(cxlds);
> +	devm_cxl_pci_create_doe(cxlds);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> -- 
> 2.35.1
> 

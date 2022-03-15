Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D954DA4CE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 22:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbiCOVtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352049AbiCOVtl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 17:49:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464313F92;
        Tue, 15 Mar 2022 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647380908; x=1678916908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAft5YeHr1CVffF2O5+59Xi/ukFqQR0kvS8hu/bL/+0=;
  b=aZLLsRWWAAp3r+gIfvPQHSuoL+Mt/Fo3lv7ePMWV/7MwsHJjy5pu6fXA
   hW3/Ud6VM08l++XjcnrCtCG4yzespK8tKrC/uP3hzT47WRFRUaLYuoTsg
   VEdQ93WmOA6oEG5NbtERzIMjnljS1a/MXikuCXIU255oPIHXy8kHVP89m
   utZ6RpP8WColT5v54AmLcOfqZFb4rNo+AZsNBKirDhdgYbwB7BMVQcl3T
   Rv4uvuQMKmeDeKjJJeEDW9MS4HOQg4ia1njxERV+S9CRFao9lvpGA2zQ2
   aKnM62nZ7rEDKRYjWB+hsCteF68HWz7G9WlhJpjshekItoFEiahc0DYl6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255259138"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="255259138"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="549751646"
Received: from jpgabald-mobl.amr.corp.intel.com (HELO localhost) ([10.212.75.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:48:22 -0700
Date:   Tue, 15 Mar 2022 14:48:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <YjEJpWXeXA65E62J@iweiny-desk3>
References: <20220201071952.900068-4-ira.weiny@intel.com>
 <20220203224027.GA103950@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203224027.GA103950@bhelgaas>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 04:40:27PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 31, 2022 at 11:19:45PM -0800, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> > 
> > Define an auxiliary device driver which control DOE auxiliary devices
> > registered on the auxiliary bus.
> > 
> > A DOE mailbox is allowed to support any number of protocols while some
> > DOE protocol specifications apply additional restrictions.
> > 
> > The protocols supported are queried and cached.  pci_doe_supports_prot()
> > can be used to determine if the DOE device supports the protocol
> > specified.
> > 
> > A synchronous interface is provided in pci_doe_exchange_sync() to
> > perform a single query / response exchange from the driver through the
> > device specified.
> > 
> > Testing was conducted against QEMU using:
> > 
> > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/
> > 
> > This code is based on Jonathan's V4 series here:
> > 
> > https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/
> 
> Details like references to previous versions can go below the "---"
> so they are omitted from the merged commit.  Many/most maintainers now
> include a Link: tag that facilitates tracing back from a commit to the
> mailing list history.

Done.

> 
> > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> >     Data Object Exchange (DOE) - Approved 12 March 2020
> 
> Please update the "PCI ECN" text above and this citation to PCIe r6.0,
> sec 6.30.  No need to reference the ECN now that it's part of the
> published spec.

Done.

> 
> > +config PCI_DOE_DRIVER
> > +	tristate "PCI Data Object Exchange (DOE) driver"
> > +	select AUXILIARY_BUS
> > +	help
> > +	  Driver for DOE auxiliary devices.
> > +
> > +	  DOE provides a simple mailbox in PCI config space that is used by a
> > +	  number of different protocols.  DOE is defined in the Data Object
> > +	  Exchange ECN to the PCIe r5.0 spec.
> 
> Not sure this is relevant in Kconfig help, but if it is, update the
> citation to PCIe r6.0, sec 6.30.

I removed it.  I agree it will probably not age well.

> 
> > +obj-$(CONFIG_PCI_DOE_DRIVER)	+= pci-doe.o
> >  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >  
> > +pci-doe-y := doe.o
> 
> Why do we need this doe.o to pci-doe.o dance?  Why not just rename
> doe.c to pci-doe.c?  It looks like that's what we do with pci-stub.c
> and pci-pf-stub.c, which are also tristate.

Not sure.  I think I may have just carried that from the cxl side when I moved
it here to pci.

I agree pci-doe is good.  I'll adjust the series as needed.

> 
> > +++ b/drivers/pci/doe.c
> > @@ -0,0 +1,675 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Data Object Exchange ECN
> > + * https://members.pcisig.com/wg/PCI-SIG/document/14143
> 
> Update citation.  Maybe copyright dates, too.



> 
> > + * Copyright (C) 2021 Huawei
> 
> > +/* Timeout of 1 second from 6.xx.1 (Operation), ECN - Data Object Exchange */
> 
> Update citation.

Done.

> 
> > +/**
> > + * struct pci_doe - A single DOE mailbox driver
> > + *
> > + * @doe_dev: The DOE Auxiliary device being driven
> > + * @abort_c: Completion used for initial abort handling
> > + * @irq: Interrupt used for signaling DOE ready or abort
> > + * @irq_name: Name used to identify the irq for a particular DOE
> 
> s/ irq / IRQ /

Done.

> 
> > +static int pci_doe_cache_protocols(struct pci_doe *doe)
> > +{
> > +	u8 index = 0;
> > +	int num_prots;
> > +	int rc;
> > +
> > +	/* Discovery protocol must always be supported and must report itself */
> > +	num_prots = 1;
> > +	doe->prots = devm_kcalloc(&doe->doe_dev->adev.dev, num_prots,
> > +				  sizeof(*doe->prots), GFP_KERNEL);
> > +	if (doe->prots == NULL)
> 
> More idiomatic (and as you did below):
> 
>   if (!doe->prots)

Done.

> 
> > +		return -ENOMEM;
> > +
> > +	do {
> > +		struct pci_doe_protocol *prot;
> > +
> > +		prot = &doe->prots[num_prots - 1];
> > +		rc = pci_doe_discovery(doe, &index, &prot->vid, &prot->type);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (index) {
> > +			struct pci_doe_protocol *prot_new;
> > +
> > +			num_prots++;
> > +			prot_new = devm_krealloc(&doe->doe_dev->adev.dev,
> > +						 doe->prots,
> > +						 sizeof(*doe->prots) *
> > +							num_prots,
> > +						 GFP_KERNEL);
> > +			if (prot_new == NULL)
> 
> Ditto.

Done.

> 
> > +				return -ENOMEM;
> > +			doe->prots = prot_new;
> > +		}
> > +	} while (index);
> > +
> > +	doe->num_prots = num_prots;
> > +	return 0;
> > +}
> 
> > +static int pci_doe_reg_irq(struct pci_doe *doe)
> > +{
> > +	struct pci_dev *pdev = doe->doe_dev->pdev;
> > +	bool poll = !pci_dev_msi_enabled(pdev);
> > +	int offset = doe->doe_dev->cap_offset;
> > +	int rc, irq;
> > +	u32 val;
> > +
> 
>   if (poll)
>     return 0;
> 
> or maybe just:
> 
>   if (!pci_dev_msi_enabled(pdev))
>     return 0;
> 
> No need to read PCI_DOE_CAP or indent all this code.

Good point. done.

> 
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > +
> > +	if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
> > +		irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
> > +		if (irq < 0)
> > +			return irq;
> > +
> > +		doe->irq_name = devm_kasprintf(&doe->doe_dev->adev.dev,
> > +						GFP_KERNEL,
> > +						"DOE[%s]",
> 
> Fill line.

Done.

> 
> > +						doe->doe_dev->adev.name);
> > +		if (!doe->irq_name)
> > +			return -ENOMEM;
> > +
> > +		rc = devm_request_irq(&pdev->dev, irq, pci_doe_irq, 0,
> > +				      doe->irq_name, doe);
> > +		if (rc)
> > +			return rc;
> > +
> > +		doe->irq = irq;
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> > +				       PCI_DOE_CTRL_INT_EN);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > +static int pci_doe_probe(struct auxiliary_device *aux_dev,
> > +			 const struct auxiliary_device_id *id)
> > +{
> > +	struct pci_doe_dev *doe_dev = container_of(aux_dev,
> > +					struct pci_doe_dev,
> > +					adev);
> 
> Fill line.

Done.

> 
> > +	struct pci_doe *doe;
> > +	int rc;
> > +
> > +	doe = devm_kzalloc(&aux_dev->dev, sizeof(*doe), GFP_KERNEL);
> > +	if (!doe)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&doe->state_lock);
> > +	init_completion(&doe->abort_c);
> > +	doe->doe_dev = doe_dev;
> > +	init_waitqueue_head(&doe->wq);
> > +	INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
> > +	dev_set_drvdata(&aux_dev->dev, doe);
> > +
> > +	rc = pci_doe_reg_irq(doe);
> 
> "request_irq" or "setup_irq" or something?  "reg" is a little
> ambiguous.

Ok pci_doe_request_irq() since we are wrapping devm_request_irq()

> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* Reset the mailbox by issuing an abort */
> > +	rc = pci_doe_abort(doe);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = pci_doe_cache_protocols(doe);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return 0;
> 
> Same as:
> 
>   return pci_doe_cache_protocols(doe);

Done.

> 
> > +static int __init pci_doe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	ret = auxiliary_driver_register(&pci_doe_auxiliary_drv);
> > +	if (ret) {
> > +		pr_err("Failed pci_doe auxiliary_driver_register() ret=%d\n",
> > +		       ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> 
> Same as:
> 
>   if (ret)
>     pr_err(...);
> 
>   return ret;

Done.

> 
> > +++ b/include/linux/pci-doe.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Data Object Exchange was added as an ECN to the PCIe r5.0 spec.
> 
> Update citation.

Done.

> 
> > +struct pci_doe_dev {
> > +	struct auxiliary_device adev;
> > +	struct pci_dev *pdev;
> > +	int cap_offset;
> 
> Can you name this "doe_cap", in the style of "msi_cap", "msix_cap",
> etc?

I can.  However, I feel I have to point out that msi[x]_cap both have comments
thusly:

        u8                      msi_cap;        /* MSI capability offset */
        u8                      msix_cap;       /* MSI-X capability offset */

Whereas cap_offset when read in the code is nicely self documenting.

...
        int offset = doe->doe_dev->cap_offset;
...

So I feel like it should be left as cap_offset;

Also there are 2 drivers which use cap_offset as well.


drivers/pci/hotplug/shpchp.h|102| u32 cap_offset;
drivers/pci/hotplug/shpchp_hpc.c|201| u32 cap_offset = ctrl->cap_offset;

drivers/pci/controller/pcie-altera.c|112| u32 cap_offset;               /* PCIe capability structure register offset */
drivers/pci/controller/pcie-altera.c|144| pcie->pcie_data->cap_offset +

And I don't think the comment on the altera device is needed...

So let me know if you feel strongly enough to change it.

Ira

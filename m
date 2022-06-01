Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB953B07C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiFAXCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiFAXCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 19:02:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B35DD0B;
        Wed,  1 Jun 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654124521; x=1685660521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oi2jkSGPrFS1UBjfoVd4uU8KXe2HD/zSiJtdnwRKxh8=;
  b=FpdStbt1PQdq3SDXdY63l1GHZLTb5cyPiLFtVnk0RpkMMnScxD38YrsR
   +E/xgEET5LhzChARV6D1GuknkeGN8hyQFyVALFOkeUdCeVyw6+iSc8AaZ
   xtcBxzXvaat/NXxb6NErCgxFW7ff9SWGIvgP2ImpmJVB/r3NW9tllqPkm
   WBbMosMrXwfI/0iFeF8FeAED3t5ZsuLDxt3DQ8oP8U+nHPjif4Z50Zfso
   5zN3FGRIz9TcA7A9+dhsSjvCN5ZkI3DZpy4GyTOeuZP3cAkMdsonueP3B
   IhQjGsUZ3EdT72fd88zfYMJeO+cWmDRn/lFtoIJhEbqBg5EiQQNiW7fBN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="263394050"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="263394050"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 16:01:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="577189437"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 16:01:58 -0700
Date:   Wed, 1 Jun 2022 16:01:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben@bwidawsk.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <Ypfv5WIRL9+0kafj@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-5-ira.weiny@intel.com>
 <20220531175020.efqfth7ubbyhoubp@mail.bwidawsk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531175020.efqfth7ubbyhoubp@mail.bwidawsk.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 10:50:20AM -0700, Ben Widawsky wrote:
> On 22-05-31 08:26:27, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DOE mailbox objects will be needed for various mailbox communications
> > with each memory device.
> > 
> > Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> > as found.
> > 
> > It is not anticipated that this is the final resting place for the
> > iteration of the DOE devices.  The support of ports may drive this code
> > into the pcie side.  In this imagined architecture the CXL port driver
> > would then query into the PCI device for the DOE mailbox array.
> 
> Not sure if direction has changed, but initially it would have been the cxl_pci
> driver who would query this and pass it along when the port driver probes.
> Personally, I've never had an issue with non cxl_pci drivers using PCI
> interfaces and semantics, but it is something we've taken specific care to
> avoid.

I really struggled with this and this is why the comment above was added.  I
agree with you but I think this actually belongs somewhere in the PCI code
eventually and the cxl_port should be grabbing the CDAT mailbox from there.

I really think that having the PCIe port driver iterate the DOE mailboxes and
then having either CXL or PCIe find the mailboxes they are interested in is the
way to go.

But this supports mailbox end points for now.

> 
> > 
> > For now this is good enough for the endpoints and the split is similar
> > to the envisioned architecture where getting the mailbox array is
> > separated from the various protocol needs.  For example, it is not
> > anticipated that the CDAT code will need to move because it is only
> > needed by the cxl_ports.
> > 
> > Likewise irq's are separated out in a similar design pattern to the
> > PCIe port driver.  But a much simpler irq enabling flag is used and only
> > DOE interrupts are supported.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V8:
> > 	Move PCI_DOE selection to CXL_BUS to support future patches
> > 	which move queries into the port code.
> > 	Remove Auxiliary device arch
> > 	Squash the functionality of the auxiliary driver into this
> > 	patch.
> > 	Split out the irq handling a bit.
> > 
> > Changes from V7:
> > 	Minor code clean ups
> > 	Rebased on cxl-pending
> > 
> > Changes from V6:
> > 	Move all the auxiliary device stuff to the CXL layer
> > 
> > Changes from V5:
> > 	Split the CXL specific stuff off from the PCI DOE create
> > 	auxiliary device code.
> > ---
> >  drivers/cxl/Kconfig  |   1 +
> >  drivers/cxl/cxlmem.h |   6 +++
> >  drivers/cxl/pci.c    | 111 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 118 insertions(+)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index f64e3984689f..7adaaf80b302 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -2,6 +2,7 @@
> >  menuconfig CXL_BUS
> >  	tristate "CXL (Compute Express Link) Devices Support"
> >  	depends on PCI
> > +	select PCI_DOE
> >  	help
> >  	  CXL is a bus that is electrically compatible with PCI Express, but
> >  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 60d10ee1e7fc..4d2764b865ab 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -191,6 +191,8 @@ struct cxl_endpoint_dvsec_info {
> >   * @component_reg_phys: register base of component registers
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> > + * @doe_mbs: PCI DOE mailbox array
> > + * @num_mbs: Number of DOE mailboxes
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> >   *
> >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > @@ -224,6 +226,10 @@ struct cxl_dev_state {
> >  	resource_size_t component_reg_phys;
> >  	u64 serial;
> >  
> > +	bool doe_use_irq;
> > +	struct pci_doe_mb **doe_mbs;
> > +	int num_mbs;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 5a0ae46d4989..131f89dec8e7 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <linux/io.h>
> >  #include "cxlmem.h"
> >  #include "cxlpci.h"
> > @@ -386,6 +387,113 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	return rc;
> >  }
> >  
> > +static void cxl_pci_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +static void cxl_doe_destroy_mb(void *ds)
> > +{
> > +	struct cxl_dev_state *cxlds = ds;
> > +	int i;
> > +
> > +	for (i = 0; i < cxlds->num_mbs; i++) {
> > +		if (cxlds->doe_mbs[i])
> > +			pci_doe_destroy_mb(cxlds->doe_mbs[i]);
> > +	}
> > +}
> > +
> > +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int num_irqs = 0;
> > +	int off = 0;
> > +	int rc;
> > +
> > +	/* Account for all the DOE vectors needed */
> > +	pci_doe_for_each_off(pdev, off) {
> > +		int irq = pci_doe_get_irq_num(pdev, off);
> > +
> > +		if (irq < 0)
> > +			continue;
> > +		num_irqs = max(num_irqs, irq + 1);
> 
> This seems overly complicated. Isn't it just num_irqs++?

See Jonathan's comment.  But I'll change it to 'max_irqs'.

> 
> > +	}
> > +
> > +	/*
> > +	 * Allocate enough vectors for the DOE's
> > +	 */
> > +	rc = pci_alloc_irq_vectors(pdev, num_irqs, num_irqs, PCI_IRQ_MSI |
> > +							     PCI_IRQ_MSIX);
> > +	if (rc != num_irqs) {
> > +		pci_err(pdev, "Not enough interrupts; use polling\n");
> > +		/* Some got allocated; clean them up */
> > +		if (rc > 0)
> > +			cxl_pci_free_irq_vectors(pdev);
> > +		cxlds->doe_use_irq = false;
> > +		return;
> > +	}
> > +
> > +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> > +	if (rc) {
> > +		cxlds->doe_use_irq = false;
> > +		return;
> > +	}
> > +
> > +	cxlds->doe_use_irq = true;
> 
> If you named it doe_poll, you could avoid having to do anything at the end of
> the function... If you felt like it.
> 
> if (failure)
> 	return;
> if (other_failure)
> 	return;
> 
> cxld->do_use_poll = false;

Actually I could just set false at the top and return on error.

Thanks for the suggestion.

> 
> > +}
> > +
> > +/**
> > + * devm_cxl_pci_create_doe - Scan and set up DOE mailboxes
> > + *
> > + * @cxlds: The CXL device state
> > + *
> > + * RETURNS: 0 on success -ERRNO on failure.
> > + */
> > +static int devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	u16 off = 0;
> > +	int num_mbs = 0;
> > +	int rc;
> > +
> > +	pci_doe_for_each_off(pdev, off)
> > +		num_mbs++;
> > +
> 
> Do you want to bail here if num_mbs == 0?

I do!  Thanks.  I need to skip using irq's above if none are found too.

> 
> > +	cxlds->doe_mbs = devm_kcalloc(dev, num_mbs, sizeof(*cxlds->doe_mbs),
> > +				      GFP_KERNEL);
> > +	if (!cxlds->doe_mbs)
> > +		return -ENOMEM;
> > +
> > +	pci_doe_for_each_off(pdev, off) {
> > +		struct pci_doe_mb *doe_mb;
> > +		int irq = -1;
> > +
> > +		if (cxlds->doe_use_irq)
> > +			irq = pci_doe_get_irq_num(pdev, off);
> > +
> > +		doe_mb = pci_doe_create_mb(pdev, off, irq);
> > +		if (IS_ERR(doe_mb)) {
> > +			pci_err(pdev,
> > +				"Failed to create MB object for MB @ %x\n",
> > +				off);
> > +			doe_mb = NULL;
> > +		}
> > +
> > +		cxlds->doe_mbs[cxlds->num_mbs] = doe_mb;
> > +		cxlds->num_mbs++;
> > +	}
> > +
> > +	rc = devm_add_action_or_reset(dev, cxl_doe_destroy_mb, cxlds);
> > +	if (rc)
> > +		return rc;
> > +
> > +	pci_info(pdev, "Configured %d DOE mailbox's\n", cxlds->num_mbs);
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -454,6 +562,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	cxl_alloc_irq_vectors(cxlds);
> > +	devm_cxl_pci_create_doe(cxlds);
> 
> If you're not going to check the return value, just make the functions void.

Yea too much rework and I forgot this.

Thanks,
Ira

> 
> > +
> >  	if (range_len(&cxlds->pmem_range) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> >  
> > -- 
> > 2.35.1
> > 

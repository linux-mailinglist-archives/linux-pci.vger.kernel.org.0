Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A951518F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiD2RY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiD2RY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 13:24:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AB4C790;
        Fri, 29 Apr 2022 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651252867; x=1682788867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDN4LTmiRFBu3yewHsXaqx2iqRnXy9xm2ypIZ36Kb28=;
  b=PhSXqXUVilFIPk6P1a2eWhFgUAfrSPYAfwn3AyoVvOPhBL7Dbc4NJjYv
   lgmprFH0G0HhoNonzQiYyCycAagq1ERkd5SMLmNbkJEhPhwktRdWZlJnZ
   hYzrSNi/+w5JaKlCaMMqjhuCQ8SIX35sfz9bqwWNvnM22XxfP7/6XYQ/N
   63LGENw2Uf+Re8J//I+xNX0kpt4daMiEWPu5HVd8vwvS56nDped55q6Gp
   /iN194BfS+qVCIrK1e0UTqJFRkhLvIPbbXzipGzCmnSta1tqJB+9j88oR
   kwTUZa7q3O+5Bba+dcYAw4eeXx10PmXwQvNtIYdZqDD46Xnrp/a0fjXu3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266869745"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266869745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:20:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="651838350"
Received: from nadelgad-mobl.amr.corp.intel.com (HELO localhost) ([10.212.108.243])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:20:54 -0700
Date:   Fri, 29 Apr 2022 10:20:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 04/10] cxl/pci: Create auxiliary devices for each DOE
 mailbox
Message-ID: <YmwedkzLrsOmsQt/@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-5-ira.weiny@intel.com>
 <20220429165502.00000d01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429165502.00000d01@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 04:55:02PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Apr 2022 13:32:31 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +
> > +/**
> > + * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
> > + *				mailboxes found
> > + *
> > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > + *
> > + * There is no coresponding destroy of these devices.  This function associates
> > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > + * association is device managed (devm_*) such that the DOE auxiliary device
> > + * lifetime is always less than or equal to the lifetime of the pci_dev.
> > + *
> > + * RETURNS: 0 on success -ERRNO on failure.
> > + */
> > +static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	bool use_irq = true;
> > +	int irqs = 0;
> > +	u16 off = 0;
> > +	int rc;
> > +
> > +	pci_doe_for_each_off(pdev, off)
> > +		irqs++;
> I believe this is insufficient because there may be other irqs in use
> on the device.

I did not think that was true for any current CXL device.  From what I could
tell all CXL devices would be covered by this simple calculation.  I left it to
the reader to determine if a new CXL device came along which needed other irq's
to lift this somewhere to cover those allocations.  I probably should have made
some comment.  Sorry.

> In a similar fashion to that done in pcie/portdrv_core.c
> I think we need to instead find the maximum msi/msix vector number
> by reading the config space.

I was not aware I could do that...

> Then we request one more vector
> than that max value to ensure the vector we need has been requested.

Yea at some point I figured this would be lifted out of here as part of a
larger 'allocate all the vectors for the device' function.

But for now this is the only place that needs irqs so I punted.  I can lift
this into something like

cxl_pci_alloc_irq_vectors(...) and then pass use_irq here.

But to move this series forward I would propose that
cxl_pci_alloc_irq_vectors() do what I'm doing here for now.

Ira

> 
> Jonathan
> 
> > +	pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
> > +
> > +	/*
> > +	 * Allocate enough vectors for the DOE's
> > +	 */
> > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
> > +						     PCI_IRQ_MSIX);
> > +	if (rc != irqs) {
> > +		pci_err(pdev,
> > +			"Not enough interrupts for all the DOEs; use polling\n");
> > +		use_irq = false;
> > +		/* Some got allocated; clean them up */
> > +		if (rc > 0)
> > +			cxl_pci_free_irq_vectors(pdev);
> > +	} else {
> > +		/*
> > +		 * Enabling bus mastering is require for MSI/MSIx.  It could be
> > +		 * done later within the DOE initialization, but as it
> > +		 * potentially has other impacts keep it here when setting up
> > +		 * the IRQ's.
> > +		 */
> > +		pci_set_master(pdev);
> > +		rc = devm_add_action_or_reset(dev,
> > +					      cxl_pci_free_irq_vectors,
> > +					      pdev);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	pci_doe_for_each_off(pdev, off) {
> > +		struct auxiliary_device *adev;
> > +		struct cxl_doe_dev *new_dev;
> > +		int id;
> > +
> > +		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
> > +		if (!new_dev)
> > +			return -ENOMEM;
> > +
> > +		new_dev->pdev = pdev;
> > +		new_dev->cap_offset = off;
> > +		new_dev->use_irq = use_irq;
> > +
> > +		/* Set up struct auxiliary_device */
> > +		adev = &new_dev->adev;
> > +		id = ida_alloc(&pci_doe_adev_ida, GFP_KERNEL);
> > +		if (id < 0) {
> > +			kfree(new_dev);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		adev->id = id;
> > +		adev->name = DOE_DEV_NAME;
> > +		adev->dev.release = cxl_pci_doe_dev_release;
> > +		adev->dev.parent = dev;
> > +
> > +		if (auxiliary_device_init(adev)) {
> > +			cxl_pci_doe_dev_release(&adev->dev);
> > +			return -EIO;
> > +		}
> > +
> > +		if (auxiliary_device_add(adev)) {
> > +			auxiliary_device_uninit(adev);
> > +			return -EIO;
> > +		}
> > +
> > +		rc = devm_add_action_or_reset(dev, cxl_pci_doe_destroy_device,
> > +					      adev);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -630,6 +753,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_pci_create_doe_devices(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> >  	cxl_dvsec_ranges(cxlds);
> >  
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> 

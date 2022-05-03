Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A487251889D
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiECPf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiECPfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 11:35:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987E42CC85;
        Tue,  3 May 2022 08:32:20 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt3mJ5dKcz67lKG;
        Tue,  3 May 2022 23:29:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:32:17 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 16:32:17 +0100
Date:   Tue, 3 May 2022 16:32:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 04/10] cxl/pci: Create auxiliary devices for each DOE
 mailbox
Message-ID: <20220503163215.00000246@huawei.com>
In-Reply-To: <YmwedkzLrsOmsQt/@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-5-ira.weiny@intel.com>
        <20220429165502.00000d01@huawei.com>
        <YmwedkzLrsOmsQt/@iweiny-desk3>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Apr 2022 10:20:54 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Apr 29, 2022 at 04:55:02PM +0100, Jonathan Cameron wrote:
> > On Thu, 14 Apr 2022 13:32:31 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >   
> 
> [snip]
> 
> > > +
> > > +/**
> > > + * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
> > > + *				mailboxes found
> > > + *
> > > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > > + *
> > > + * There is no coresponding destroy of these devices.  This function associates
> > > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > > + * association is device managed (devm_*) such that the DOE auxiliary device
> > > + * lifetime is always less than or equal to the lifetime of the pci_dev.
> > > + *
> > > + * RETURNS: 0 on success -ERRNO on failure.
> > > + */
> > > +static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	bool use_irq = true;
> > > +	int irqs = 0;
> > > +	u16 off = 0;
> > > +	int rc;
> > > +
> > > +	pci_doe_for_each_off(pdev, off)
> > > +		irqs++;  
> > I believe this is insufficient because there may be other irqs in use
> > on the device.  
> 
> I did not think that was true for any current CXL device.  From what I could
> tell all CXL devices would be covered by this simple calculation.  I left it to
> the reader to determine if a new CXL device came along which needed other irq's
> to lift this somewhere to cover those allocations.  I probably should have made
> some comment.  Sorry.
> 
> > In a similar fashion to that done in pcie/portdrv_core.c
> > I think we need to instead find the maximum msi/msix vector number
> > by reading the config space.  
> 
> I was not aware I could do that...
> 
> > Then we request one more vector
> > than that max value to ensure the vector we need has been requested.  
> 
> Yea at some point I figured this would be lifted out of here as part of a
> larger 'allocate all the vectors for the device' function.
> 
> But for now this is the only place that needs irqs so I punted.  I can lift
> this into something like
> 
> cxl_pci_alloc_irq_vectors(...) and then pass use_irq here.
> 
> But to move this series forward I would propose that
> cxl_pci_alloc_irq_vectors() do what I'm doing here for now.

Handling this right is pretty simple code e.g. equivalent of
https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/portdrv_core.c#L62
So my inclination would be to fix it now rather than leaving chance
of some odd failures later.

Jonathan

> 
> Ira
> 
> > 
> > Jonathan
> >   
> > > +	pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
> > > +
> > > +	/*
> > > +	 * Allocate enough vectors for the DOE's
> > > +	 */
> > > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
> > > +						     PCI_IRQ_MSIX);
> > > +	if (rc != irqs) {
> > > +		pci_err(pdev,
> > > +			"Not enough interrupts for all the DOEs; use polling\n");
> > > +		use_irq = false;
> > > +		/* Some got allocated; clean them up */
> > > +		if (rc > 0)
> > > +			cxl_pci_free_irq_vectors(pdev);
> > > +	} else {
> > > +		/*
> > > +		 * Enabling bus mastering is require for MSI/MSIx.  It could be
> > > +		 * done later within the DOE initialization, but as it
> > > +		 * potentially has other impacts keep it here when setting up
> > > +		 * the IRQ's.
> > > +		 */
> > > +		pci_set_master(pdev);
> > > +		rc = devm_add_action_or_reset(dev,
> > > +					      cxl_pci_free_irq_vectors,
> > > +					      pdev);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > > +	pci_doe_for_each_off(pdev, off) {
> > > +		struct auxiliary_device *adev;
> > > +		struct cxl_doe_dev *new_dev;
> > > +		int id;
> > > +
> > > +		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
> > > +		if (!new_dev)
> > > +			return -ENOMEM;
> > > +
> > > +		new_dev->pdev = pdev;
> > > +		new_dev->cap_offset = off;
> > > +		new_dev->use_irq = use_irq;
> > > +
> > > +		/* Set up struct auxiliary_device */
> > > +		adev = &new_dev->adev;
> > > +		id = ida_alloc(&pci_doe_adev_ida, GFP_KERNEL);
> > > +		if (id < 0) {
> > > +			kfree(new_dev);
> > > +			return -ENOMEM;
> > > +		}
> > > +
> > > +		adev->id = id;
> > > +		adev->name = DOE_DEV_NAME;
> > > +		adev->dev.release = cxl_pci_doe_dev_release;
> > > +		adev->dev.parent = dev;
> > > +
> > > +		if (auxiliary_device_init(adev)) {
> > > +			cxl_pci_doe_dev_release(&adev->dev);
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		if (auxiliary_device_add(adev)) {
> > > +			auxiliary_device_uninit(adev);
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		rc = devm_add_action_or_reset(dev, cxl_pci_doe_destroy_device,
> > > +					      adev);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct cxl_register_map map;
> > > @@ -630,6 +753,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	rc = cxl_pci_create_doe_devices(pdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	cxl_dvsec_ranges(cxlds);
> > >  
> > >  	cxlmd = devm_cxl_add_memdev(cxlds);  
> >   


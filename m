Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1DE561F55
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiF3Pcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiF3Pcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 11:32:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3F3EF0E;
        Thu, 30 Jun 2022 08:32:46 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYj4B5mtVz683Rr;
        Thu, 30 Jun 2022 23:31:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 17:32:43 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 16:32:42 +0100
Date:   Thu, 30 Jun 2022 16:32:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220630163240.00003596@Huawei.com>
In-Reply-To: <Yr01iZhuG5YHThDg@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-5-ira.weiny@intel.com>
        <20220628153317.00002e36@Huawei.com>
        <Yr01iZhuG5YHThDg@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Wed, 29 Jun 2022 22:32:57 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Jun 28, 2022 at 03:33:17PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Jun 2022 21:15:22 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > DOE mailbox objects will be needed for various mailbox communications
> > > with each memory device.
> > > 
> > > Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> > > as found.
> > > 
> > > It is not anticipated that this is the final resting place for the
> > > iteration of the DOE devices.  The support of switch ports will drive
> > > this code into the PCIe side.  In this imagined architecture the CXL
> > > port driver would then query into the PCI device for the DOE mailbox
> > > array.
> > > 
> > > For now creating the mailboxes in the CXL port is good enough for the
> > > endpoints.  Later PCIe ports will need to support this to support switch
> > > ports more generically.
> > > 
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > My main comment on this is that we should not paper over any errors in
> > DOE setup.  Those indicate a bug or hardware fault, so like anything similar
> > we should at very least document why it makes sense to continue.  In most
> > cases I'd argue it doesn't as something is very wrong.
> >   
> > > 
> > > ---
> > > Changes from V11:
> > > 	Drop review from: Ben Widawsky <bwidawsk@kernel.org>
> > > 	Remove irq code for now
> > > 	Adjust for pci_doe_get_int_msg_num()
> > > 	Adjust for pcim_doe_create_mb()
> > > 		(No longer need to handle the destroy.)
> > > 	Use xarray for DOE mailbox array
> > > 
> > > Changes from V9:
> > > 	Bug fix: ensure DOE mailboxes are iterated before memdev add
> > > 	Ben Widawsky
> > > 		Set use_irq to false and just return on error.
> > > 		Don't return a value from devm_cxl_pci_create_doe()
> > > 		Skip allocating doe_mb array if there are no mailboxes
> > > 		Skip requesting irqs if none found.
> > > 	Ben/Jonathan Cameron
> > > 		s/num_irqs/max_irqs
> > > 
> > > Changes from V8:
> > > 	Move PCI_DOE selection to CXL_BUS to support future patches
> > > 	which move queries into the port code.
> > > 	Remove Auxiliary device arch
> > > 	Squash the functionality of the auxiliary driver into this
> > > 	patch.
> > > 	Split out the irq handling a bit.
> > > 
> > > Changes from V7:
> > > 	Minor code clean ups
> > > 	Rebased on cxl-pending
> > > 
> > > Changes from V6:
> > > 	Move all the auxiliary device stuff to the CXL layer
> > > 
> > > Changes from V5:
> > > 	Split the CXL specific stuff off from the PCI DOE create
> > > 	auxiliary device code.
> > > ---
> > >  drivers/cxl/Kconfig  |  1 +
> > >  drivers/cxl/cxlmem.h |  3 +++
> > >  drivers/cxl/pci.c    | 37 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 41 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index f64e3984689f..7adaaf80b302 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -2,6 +2,7 @@
> > >  menuconfig CXL_BUS
> > >  	tristate "CXL (Compute Express Link) Devices Support"
> > >  	depends on PCI
> > > +	select PCI_DOE
> > >  	help
> > >  	  CXL is a bus that is electrically compatible with PCI Express, but
> > >  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 60d10ee1e7fc..360f282ef80c 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -191,6 +191,7 @@ struct cxl_endpoint_dvsec_info {
> > >   * @component_reg_phys: register base of component registers
> > >   * @info: Cached DVSEC information about the device.
> > >   * @serial: PCIe Device Serial Number
> > > + * @doe_mbs: PCI DOE mailbox array
> > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > >   *
> > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > @@ -224,6 +225,8 @@ struct cxl_dev_state {
> > >  	resource_size_t component_reg_phys;
> > >  	u64 serial;
> > >  
> > > +	struct xarray doe_mbs;
> > > +
> > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > >  };
> > >  
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 5a0ae46d4989..5821e6c1253b 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/list.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/pci-doe.h>
> > >  #include <linux/io.h>
> > >  #include "cxlmem.h"
> > >  #include "cxlpci.h"
> > > @@ -386,6 +387,37 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> > >  	return rc;
> > >  }
> > >  
> > > +static void cxl_pci_destroy_doe(void *mbs)
> > > +{
> > > +	struct xarray *xa = mbs;  
> > 
> > Local variable doesn't add anything...
> >   
> > > +
> > > +	xa_destroy(xa);
> > > +}
> > > +
> > > +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	u16 off = 0;
> > > +
> > > +	pci_doe_for_each_off(pdev, off) {
> > > +		struct pci_doe_mb *doe_mb;
> > > +
> > > +		doe_mb = pcim_doe_create_mb(pdev, off, -1);
> > > +		if (IS_ERR(doe_mb)) {
> > > +			pci_err(pdev,
> > > +				"Failed to create MB object for MB @ %x\n",
> > > +				off);  
> > 
> > Definitely at least need a comment for why papering over this failure is
> > fine.  My gut feeling is we shouldn't ignore it.  
> 
> I'm so confused at this point I don't really know any more.  :-/
> 
> >   
> > > +			doe_mb = NULL;  
> 
> This at least needs to be a continue.
> 
> > > +		}
> > > +
> > > +		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL))
> > > +			break;  
> > 
> > If we hit that break something has gone horribly wrong and we shouldn't
> > paper over it either.  We might have a partial list of DOEs and callers
> > after this will have no way of knowing it isn't the full list.  
> 
> I _thought_ that we did not care if some mailboxes failed or not.

I have a different view to Dan on this.  In my view if your hardware is
not working in any way at all scream like mad don't carry on... Dan
is keen to try to muddle onwards.

> 
> If CDAT is not supported on any of the mailboxes found then CDAT will not show
> up on sysfs (as per Dan's last comment).  If it was supported on a mailbox but
> no data is found the sysfs will show up but be 0 length.
> 
> At this layer I thought we agreed to skip over these errors.  If a protocol is
> needed at a higher layer and it is not found on any of the mailboxes the errors
> should show up in that layer.  In this series CDAT is not 100% necessary as
> devices can work without it.  So the errors were mostly paper'ed over in favor
> of just printing error messages and muddle on.
> 
> The xa_insert() deserves a pci_err() though.

That's probably the minimum we should do.  The xa_insert() failing is something
horrible going wrong in our software / host afterall.

> 
> And I'll add a comment indicating finding mailboxes is 'best effort' and higher
> layers may error out the device depending on necessity.  How about this?
> 
>         /* 
>          * Mailbox creation is best effort.  Higher layers must determine if
>          * the lack of a mailbox for their protocol is a device failure or not.
>          */

Good.

> 
> >   
> > > +
> > > +		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
> > > +	}
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct cxl_register_map map;
> > > @@ -408,6 +440,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (IS_ERR(cxlds))
> > >  		return PTR_ERR(cxlds);
> > >  
> > > +	xa_init(&cxlds->doe_mbs);
> > > +	devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs);  
> > 
> > _or_reset()?  If the devm registration itself fails we want to bail out cleanly.
> > It's vanishingly unlikely to happen, but we should still handle that case.
> >   
> 
> Actually no; xa_destroy does not need to be called at this point if we fail.

Ah ok, I'd missed that.

> However, I do need to check the return of devm_add_action and fails if it is
> not set.  Thanks again!
> 
> Ira
> 
> > > +
> > >  	cxlds->serial = pci_get_dsn(pdev);
> > >  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> > >  		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> > > @@ -434,6 +469,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  
> > >  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> > >  
> > > +	devm_cxl_pci_create_doe(cxlds);
> > > +
> > >  	rc = cxl_pci_setup_mailbox(cxlds);
> > >  	if (rc)
> > >  		return rc;  
> >   


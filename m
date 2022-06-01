Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA853A942
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbiFAOgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiFAOgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 10:36:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679D2409F;
        Wed,  1 Jun 2022 07:36:05 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCs610H4kz67xBN;
        Wed,  1 Jun 2022 22:31:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 1 Jun 2022 16:36:02 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 15:36:01 +0100
Date:   Wed, 1 Jun 2022 15:35:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben@bwidawsk.net>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V9 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220601153559.0000273b@Huawei.com>
In-Reply-To: <20220531175020.efqfth7ubbyhoubp@mail.bwidawsk.net>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
        <20220531152632.1397976-5-ira.weiny@intel.com>
        <20220531175020.efqfth7ubbyhoubp@mail.bwidawsk.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
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

On Tue, 31 May 2022 10:50:20 -0700
Ben Widawsky <ben@bwidawsk.net> wrote:

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

nope.  

There is no guarantee the irq values are near zero or contiguous.

If irq is 33 for example, it pretty much implies that there are 34 or more irq
vectors used for something on this device, but we don't know what the rest are for.

Trick is used in portdrv to deal with enabling all the irqs needed for the various
supported services, which might not be all the irqs the hardware provides.

Maybe worth renaming num_irqs as max_irq or something like that and postpone the +1 to
where it is used?

Jonathan

> 
> > +	}

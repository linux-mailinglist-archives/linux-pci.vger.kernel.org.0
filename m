Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69F557B554
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiGTLYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTLYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 07:24:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9E52FE7;
        Wed, 20 Jul 2022 04:24:30 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LntYT5pg4z687NT;
        Wed, 20 Jul 2022 19:21:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 13:24:27 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 12:24:26 +0100
Date:   Wed, 20 Jul 2022 12:24:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 3/7] PCI/DOE: Add DOE mailbox support functions
Message-ID: <20220720122423.00004ea6@Huawei.com>
In-Reply-To: <YtcC9qYo1lOGZ/83@iweiny-desk3>
References: <20220715030424.462963-1-ira.weiny@intel.com>
        <20220715030424.462963-4-ira.weiny@intel.com>
        <20220719173553.000067c6@Huawei.com>
        <YtcC9qYo1lOGZ/83@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 12:16:06 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Jul 19, 2022 at 05:35:53PM +0100, Jonathan Cameron wrote:
> > On Thu, 14 Jul 2022 20:04:20 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > > mailbox with standard protocol discovery.  Each mailbox is accessed
> > > through a DOE Extended Capability.
> > > 
> > > Each DOE mailbox must support the DOE discovery protocol in addition to
> > > any number of additional protocols.
> > > 
> > > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > > defined config space offset.  Functionality includes iterating,
> > > creating, query of supported protocol, and task submission.  Destruction
> > > of the mailboxes is device managed.
> > > 
> > > Cc: "Li, Ming" <ming4.li@intel.com>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > Hi Ira,
> > 
> > Thanks for persisting with this!
> > 
> > So, I think this works, but there is at least one 'sleep' I can't
> > see a purpose for.  I think it's just a left over from refactoring.
> > 
> > A few other more trivial things inline.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > >   
> > >>  # Endpoint library must be initialized before its users  
> > >  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > new file mode 100644
> > > index 000000000000..12c3762be22f
> > > --- /dev/null
> > > +++ b/drivers/pci/doe.c
> > > @@ -0,0 +1,546 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Data Object Exchange
> > > + *	PCIe r6.0, sec 6.30 DOE
> > > + *
> > > + * Copyright (C) 2021 Huawei
> > > + *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > + *
> > > + * Copyright (C) 2022 Intel Corporation
> > > + *	Ira Weiny <ira.weiny@intel.com>
> > > + */
> > > +
> > > +#define dev_fmt(fmt) "DOE: " fmt
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/jiffies.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/pci-doe.h>
> > > +#include <linux/workqueue.h>
> > > +
> > > +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> > > +
> > > +#define PCI_DOE_BUSY_MAX_RETRIES 16  
> > Left over from removed code.  
> 
> I think Dan may have taken these.  If so I'll send a clean up.  If not I can
> spin.  Let me check.
> 
Absolutely. All tiny improvements, so fine to go in next cycle given late timing.

> > > +/**
> > > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > > + *			     protocol
> > > + * @doe_mb: DOE mailbox capability to query
> > > + * @vid: Protocol Vendor ID
> > > + * @type: Protocol type
> > > + *
> > > + * RETURNS: True if the DOE mailbox supports the protocol specified
> > > + */
> > > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > > +{
> > > +	unsigned long index;
> > > +	void *entry;
> > > +
> > > +	/* The discovery protocol must always be supported */
> > > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > > +		return true;  
> > 
> > Given how cheap this look up is now it's all in xarray, we could drop this
> > 'optimization'.  I'm fairly sure the discovery protocol will always be
> > discovered (spec says it must be returned when calling itself as the fist
> > protocol).  
> 
> No we can't because this is called before the xarray is populated with the
> discovery protocol.  This was actually added not as an optimization but to
> allow the discovery protocol to run through the common query path.
> 

Ah.  I was too lazy to check if that was the case :)

Jonathan

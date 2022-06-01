Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24153AB0E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbiFAQbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356100AbiFAQbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 12:31:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F8F996A1;
        Wed,  1 Jun 2022 09:31:18 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCvl23pP8z689Jh;
        Thu,  2 Jun 2022 00:30:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:31:15 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 17:31:14 +0100
Date:   Wed, 1 Jun 2022 17:31:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <ben@bwidawsk.net>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V9 6/9] cxl/port: Read CDAT table
Message-ID: <20220601173113.000005a6@Huawei.com>
In-Reply-To: <20220601163540.00006978@Huawei.com>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
        <20220531152632.1397976-7-ira.weiny@intel.com>
        <20220601163540.00006978@Huawei.com>
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

On Wed, 1 Jun 2022 16:35:40 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 31 May 2022 08:26:29 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The OS will need CDAT data from CXL devices to properly set up
> > interleave sets.  Currently this is supported through a DOE mailbox
> > which supports CDAT.
> > 
> > Cache the CDAT data for later parsing.  Provide a sysfs binary attribute
> > to allow dumping of the CDAT.
> > 
> > Binary dumping is modeled on /sys/firmware/ACPI/tables/
> > 
> > The ability to dump this table will be very useful for emulation of real
> > devices once they become available as QEMU CXL type 3 device emulation will
> > be able to load this file in.
> > 
> > This does not support table updates at runtime. It will always provide
> > whatever was there when first cached. Handling of table updates can be
> > implemented later.
> > 
> > Finally create a complete list of DOE defines within cdat.h for code
> > wishing to decode the CDAT table.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >   
> 
> Fun question of ownership inline...

And a follow up due to triggering a bug that predated this series...

I'd send a fix, but I'm off on a long weekend shortly :)

> 
> ...
> 
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	struct device *dev = &port->dev;
> > +	size_t cdat_length;
> > +	int ret;
> > +
> > +	if (cxl_cdat_get_length(port, &cdat_length))
> > +		return;
> > +
> > +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);  
> 
> boom. See below for why :)
> 
> > +	if (!port->cdat.table) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	port->cdat.length = cdat_length;
> > +	ret = cxl_cdat_read_table(port, &port->cdat);
> > +	if (ret) {
> > +		devm_kfree(dev, port->cdat.table);
> > +		port->cdat.table = NULL;
> > +		port->cdat.length = 0;
> > +		ret = -EIO;
> > +		goto error;
> > +	}
> > +
> > +	return;
> > +error:
> > +	dev_err(dev, "CDAT data read error (%d)\n", ret);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 2e2bd65c1024..aa4229ddc1bc 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -320,7 +320,48 @@ static void cxl_port_release(struct device *dev)
> >  	kfree(port);
> >  }
> >  
> > +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> > +			 struct bin_attribute *bin_attr, char *buf,
> > +			 loff_t offset, size_t count)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_port *port = to_cxl_port(dev);
> > +
> > +	if (!port->cdat.table)
> > +		return 0;
> > +
> > +	return memory_read_from_buffer(buf, count, &offset,
> > +				       port->cdat.table,
> > +				       port->cdat.length);
> > +}
> > +
> > +static BIN_ATTR_RO(cdat, 0);
> > +
> > +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> > +					      struct bin_attribute *attr, int i)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_port *port = to_cxl_port(dev);
> > +
> > +	if ((attr == &bin_attr_cdat) && port->cdat.table)
> > +		return 0400;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> > +	&bin_attr_cdat,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group cxl_cdat_attribute_group = {
> > +	.name = "CDAT",
> > +	.bin_attrs = cxl_cdat_bin_attributes,
> > +	.is_bin_visible = cxl_port_bin_attr_is_visible,
> > +};
> > +
> >  static const struct attribute_group *cxl_port_attribute_groups[] = {
> > +	&cxl_cdat_attribute_group,o
> >  	&cxl_base_attribute_group,
> >  	NULL,
> >  };
> > @@ -462,6 +503,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  		return port;
> >  
> >  	cxl_find_cdat_mb(port);
> > +	/* Cache the data early to ensure is_visible() works */
> > +	read_cdat_data(port);  
> 
> This uses port as the 'device' for devm_ calls.
> Unfortunately if the port driver isn't loaded, it still "successfully" runs.
> Then if the port driver is probed, you get both a bunch of errors due to
> devm_ allocations on a device before the driver is loaded.
> 
> For extra fun it tries to probe the ports multiple times without freeing
> the index which is 'interesting'. We had this happen a while ago (unrelated
> to DOE) but this may be unrelated (or maybe related to the region stuff
> I'm carrying on my test tree)

So the extra devices are a result of the obvious initial path of
cxl_mem_probe() from module probe and down failing, then bus_rescan_devices
coming along from the pmem driver having another go... 

So next question is why don't the first set of endpointX devices get cleaned up
if the create_endpoint() in cxl/mem.c fails.

I think this is because the cxl_endpoint_autoremove() call hasn't yet happened
when we detect the failure to bind a driver and error out of cxl_mem_probe().

So, fix is probably to do the cxl_endpoint_autoremove() unconditionally
by moving it before the check on driver binding.

https://elixir.bootlin.com/linux/latest/source/drivers/cxl/mem.c#L67

Move it up a few lines.



> 
> As to the question of what the correct fix is...
> Maybe move them into the port driver probe but then is_visible
> won't work.  Or pass a pointer to the struct device *host down
> into read_cdat_data and __read_cdat_data calls to handle the
> allocation. (I tried this and it seems superficially fine).
> 
> Jonathan
> 
> 
> 
> >  
> >  	dev = &port->dev;
> >  	if (is_cxl_memdev(uport))
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 0a86be589ffc..531b77d296c7 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/bitops.h>
> >  #include <linux/io.h>
> > +#include "cdat.h"
> >  
> >  /**
> >   * DOC: cxl objects
> > @@ -268,6 +269,7 @@ struct cxl_nvdimm {
> >   * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> >   * @cdat_mb: Mailbox which supports the CDAT protocol
> > + * @cdat: Cached CDAT data
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -280,6 +282,7 @@ struct cxl_port {
> >  	bool dead;
> >  	unsigned int depth;
> >  	struct pci_doe_mb *cdat_mb;
> > +	struct cxl_cdat cdat;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 366b21bd1a01..35f0d4892eaa 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -75,4 +75,5 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> >  void cxl_find_cdat_mb(struct cxl_port *port);
> > +void read_cdat_data(struct cxl_port *port);
> >  #endif /* __CXL_PCI_H__ */  
> 


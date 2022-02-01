Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1A4A629B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbiBARiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 12:38:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4606 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiBARiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 12:38:06 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpBqB0j46z67NKJ;
        Wed,  2 Feb 2022 01:33:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 18:38:04 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 17:38:04 +0000
Date:   Tue, 1 Feb 2022 17:38:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220201173802.00000f87@Huawei.com>
In-Reply-To: <20220201163518.skfvwdesq2a6e77d@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220201153154.jpyxayuulbhdran4@intel.com>
        <20220201154941.00001ffd@Huawei.com>
        <20220201163518.skfvwdesq2a6e77d@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 08:35:18 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 22-02-01 15:49:41, Jonathan Cameron wrote:
> > On Tue, 1 Feb 2022 07:31:54 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > On 22-01-23 16:31:24, Dan Williams wrote:  
> > > > While CXL memory targets will have their own memory target node,
> > > > individual memory devices may be affinitized like other PCI devices.
> > > > Emit that attribute for memdevs.
> > > > 
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>    
> > > 
> > > This brings up an interesting question. Are all devices in a region affinitized
> > > to the same NUMA node? I think they must be - at which point, should this
> > > attribute be a part of a region, rather than a device?  
> > 
> > No particular reason why they should be in the same NUMA node
> > in general. People occasionally do memory interleave across memory
> > controllers on different CPU sockets (in extreme cases).
> > Whilst, at the interleave set level, that will have a single numa
> > domain, the individual devices making it up could be all over
> > the place and it will depend on the configuration.  
> 
> There's no such thing as a non-interleave set though. Everything is a region. A
> x1 region is a region with one device.

Well sort of.  That is the representation we are going with, but reality
is it's made up of a number of physical devices and those may have their
own numa domains and it maybe useful to a user / admin to know what those are
(as well as the domain of a resulting region..)


> 
> >   
> > >   
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
> > > >  drivers/cxl/core/memdev.c               |   17 +++++++++++++++++
> > > >  tools/testing/cxl/test/cxl.c            |    1 +
> > > >  3 files changed, 27 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > index 87c0e5e65322..0b51cfec0c66 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > @@ -34,6 +34,15 @@ Description:
> > > >  		capability. Mandatory for CXL devices, see CXL 2.0 8.1.12.2
> > > >  		Memory Device PCIe Capabilities and Extended Capabilities.
> > > >  
> > > > +What:		/sys/bus/cxl/devices/memX/numa_node
> > > > +Date:		January, 2022
> > > > +KernelVersion:	v5.18
> > > > +Contact:	linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +		(RO) If NUMA is enabled and the platform has affinitized the
> > > > +		host PCI device for this memory device, emit the CPU node
> > > > +		affinity for this device.
> > > > +    
> > > 
> > > I think you'd want to say something about the device actively decoding. Perhaps
> > > I'm mistaken though, can you affinitize without setting up HDM decoders for the
> > > device?  
> > 
> > It's possible for PCI devices (up to a bug I should dig out the fix for)
> > to be placed in their own NUMA domains, or gain them from the root ports / host
> > bridges.  The magic of generic initiators and fiddly ACPI DSDT files that
> > the bios might want to create.
> >   
> > >   
> > > >  What:		/sys/bus/cxl/devices/*/devtype
> > > >  Date:		June, 2021
> > > >  KernelVersion:	v5.14
> > > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > > index 1e574b052583..b2773664e407 100644
> > > > --- a/drivers/cxl/core/memdev.c
> > > > +++ b/drivers/cxl/core/memdev.c
> > > > @@ -99,11 +99,19 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
> > > >  }
> > > >  static DEVICE_ATTR_RO(serial);
> > > >  
> > > > +static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> > > > +			      char *buf)
> > > > +{
> > > > +	return sprintf(buf, "%d\n", dev_to_node(dev));
> > > > +}
> > > > +static DEVICE_ATTR_RO(numa_node);
> > > > +
> > > >  static struct attribute *cxl_memdev_attributes[] = {
> > > >  	&dev_attr_serial.attr,
> > > >  	&dev_attr_firmware_version.attr,
> > > >  	&dev_attr_payload_max.attr,
> > > >  	&dev_attr_label_storage_size.attr,
> > > > +	&dev_attr_numa_node.attr,
> > > >  	NULL,
> > > >  };
> > > >  
> > > > @@ -117,8 +125,17 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
> > > >  	NULL,
> > > >  };
> > > >  
> > > > +static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > > > +				  int n)
> > > > +{
> > > > +	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> > > > +		return 0;
> > > > +	return a->mode;
> > > > +}
> > > > +
> > > >  static struct attribute_group cxl_memdev_attribute_group = {
> > > >  	.attrs = cxl_memdev_attributes,
> > > > +	.is_visible = cxl_memdev_visible,
> > > >  };
> > > >  
> > > >  static struct attribute_group cxl_memdev_ram_attribute_group = {
> > > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > > index 40ed567952e6..cd2f20f2707f 100644
> > > > --- a/tools/testing/cxl/test/cxl.c
> > > > +++ b/tools/testing/cxl/test/cxl.c
> > > > @@ -583,6 +583,7 @@ static __init int cxl_test_init(void)
> > > >  		if (!pdev)
> > > >  			goto err_mem;
> > > >  		pdev->dev.parent = &port->dev;
> > > > +		set_dev_node(&pdev->dev, i % 2);
> > > >  
> > > >  		rc = platform_device_add(pdev);
> > > >  		if (rc) {
> > > >     
> >   


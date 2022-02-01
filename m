Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122EF4A6173
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 17:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiBAQfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 11:35:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:32707 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238499AbiBAQfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643733320; x=1675269320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpF7COJovkYbYvC7X7GP3ZoO/tWMEpVCOXGmRp5mRMo=;
  b=b2u5qPllv8qpi30eWeFS/W41wWxBCS7iNaKNnULMsv/5qy7vT7oRTDcN
   wZIMmAo/K1igcjQc/F0jpZeUxKsASvl/g8F4s7T1V3gTyxVzFIlNkzwZ/
   jrFIKuW3ppD4tmzCjEsvabktfgH/942dT/fuRgxNtRwbNlLsxwI+6bSNk
   RvEp4/VWZnRLz0xfXeLxJI4wyqfp5hIyeCqrY1KQ/RDAvduqqbsLr1qpD
   psrXupKDSK+TVQrL0OZMrEQvfGjIC/bSm/T0N7vD9FfLUVDn2+DawQGJL
   fNcMaQ6FrakYUxTqXbNuNHjOZO2Br5PFuuaP4IIBIk5acbWpi9ejlqnxD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246563228"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="246563228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 08:35:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619845696"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 08:35:19 -0800
Date:   Tue, 1 Feb 2022 08:35:18 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220201163518.skfvwdesq2a6e77d@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201153154.jpyxayuulbhdran4@intel.com>
 <20220201154941.00001ffd@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201154941.00001ffd@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-02-01 15:49:41, Jonathan Cameron wrote:
> On Tue, 1 Feb 2022 07:31:54 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 22-01-23 16:31:24, Dan Williams wrote:
> > > While CXL memory targets will have their own memory target node,
> > > individual memory devices may be affinitized like other PCI devices.
> > > Emit that attribute for memdevs.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > This brings up an interesting question. Are all devices in a region affinitized
> > to the same NUMA node? I think they must be - at which point, should this
> > attribute be a part of a region, rather than a device?
> 
> No particular reason why they should be in the same NUMA node
> in general. People occasionally do memory interleave across memory
> controllers on different CPU sockets (in extreme cases).
> Whilst, at the interleave set level, that will have a single numa
> domain, the individual devices making it up could be all over
> the place and it will depend on the configuration.

There's no such thing as a non-interleave set though. Everything is a region. A
x1 region is a region with one device.

> 
> > 
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
> > >  drivers/cxl/core/memdev.c               |   17 +++++++++++++++++
> > >  tools/testing/cxl/test/cxl.c            |    1 +
> > >  3 files changed, 27 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index 87c0e5e65322..0b51cfec0c66 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -34,6 +34,15 @@ Description:
> > >  		capability. Mandatory for CXL devices, see CXL 2.0 8.1.12.2
> > >  		Memory Device PCIe Capabilities and Extended Capabilities.
> > >  
> > > +What:		/sys/bus/cxl/devices/memX/numa_node
> > > +Date:		January, 2022
> > > +KernelVersion:	v5.18
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) If NUMA is enabled and the platform has affinitized the
> > > +		host PCI device for this memory device, emit the CPU node
> > > +		affinity for this device.
> > > +  
> > 
> > I think you'd want to say something about the device actively decoding. Perhaps
> > I'm mistaken though, can you affinitize without setting up HDM decoders for the
> > device?
> 
> It's possible for PCI devices (up to a bug I should dig out the fix for)
> to be placed in their own NUMA domains, or gain them from the root ports / host
> bridges.  The magic of generic initiators and fiddly ACPI DSDT files that
> the bios might want to create.
> 
> > 
> > >  What:		/sys/bus/cxl/devices/*/devtype
> > >  Date:		June, 2021
> > >  KernelVersion:	v5.14
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index 1e574b052583..b2773664e407 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -99,11 +99,19 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
> > >  }
> > >  static DEVICE_ATTR_RO(serial);
> > >  
> > > +static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> > > +			      char *buf)
> > > +{
> > > +	return sprintf(buf, "%d\n", dev_to_node(dev));
> > > +}
> > > +static DEVICE_ATTR_RO(numa_node);
> > > +
> > >  static struct attribute *cxl_memdev_attributes[] = {
> > >  	&dev_attr_serial.attr,
> > >  	&dev_attr_firmware_version.attr,
> > >  	&dev_attr_payload_max.attr,
> > >  	&dev_attr_label_storage_size.attr,
> > > +	&dev_attr_numa_node.attr,
> > >  	NULL,
> > >  };
> > >  
> > > @@ -117,8 +125,17 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
> > >  	NULL,
> > >  };
> > >  
> > > +static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > > +				  int n)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> > > +		return 0;
> > > +	return a->mode;
> > > +}
> > > +
> > >  static struct attribute_group cxl_memdev_attribute_group = {
> > >  	.attrs = cxl_memdev_attributes,
> > > +	.is_visible = cxl_memdev_visible,
> > >  };
> > >  
> > >  static struct attribute_group cxl_memdev_ram_attribute_group = {
> > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > index 40ed567952e6..cd2f20f2707f 100644
> > > --- a/tools/testing/cxl/test/cxl.c
> > > +++ b/tools/testing/cxl/test/cxl.c
> > > @@ -583,6 +583,7 @@ static __init int cxl_test_init(void)
> > >  		if (!pdev)
> > >  			goto err_mem;
> > >  		pdev->dev.parent = &port->dev;
> > > +		set_dev_node(&pdev->dev, i % 2);
> > >  
> > >  		rc = platform_device_add(pdev);
> > >  		if (rc) {
> > >   
> 

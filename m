Return-Path: <linux-pci+bounces-8344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C18FD437
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5380228225A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73351D53F;
	Wed,  5 Jun 2024 17:38:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4A621;
	Wed,  5 Jun 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609102; cv=none; b=IHeSq+39NhFzxKwzmGAGwU8xjraNtjkJvdz/UBlaZDIo0fBMcLqTq9ELuVVDLc3ale4B4OSn1wKtcyXySN6pioMXHWWeceZpooWGBubhY2VikobsXK/5Vt7x9oY1CTwlC5johOtRp1T/xz6zo6TPQGUERhz2qflmbaBB4hf1oYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609102; c=relaxed/simple;
	bh=5bJXo2/6ljIX7oR+8xAJek9uboHmy/4oe0KsQNTTB+o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQZ0zW6dUxCDv3bzv/cq3kf4LRL9unnksjC7p/r7q+ZJXiB06KwGqCntqqDUt2CHUmmuX7UH8LYue/Q2GQtjrgxEQqnmQd7LnSPnTFkJDjBaEhFFFT8IVKYVzSpBWqMU8md2OQBo+qcHwETl6XBgRCLZhSFNEPLN4qaA9OOZHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvZM92Yhzz6JBVL;
	Thu,  6 Jun 2024 01:33:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 519161400D9;
	Thu,  6 Jun 2024 01:38:16 +0800 (CST)
Received: from localhost (10.126.172.226) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 18:38:15 +0100
Date: Wed, 5 Jun 2024 18:38:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240605183815.0000680e@Huawei.com>
In-Reply-To: <OSAPR01MB71826C386ABCD27C0041EFEEBAF92@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
	<20240510073710.98953-3-kobayashi.da-06@fujitsu.com>
	<20240604173241.000009d9@Huawei.com>
	<OSAPR01MB71826C386ABCD27C0041EFEEBAF92@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 5 Jun 2024 07:21:44 +0000
"Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 10 May 2024 16:37:10 +0900
> > "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
> >   
> > > Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> > >
> > > In CXL1.1, the link status of the device is included in the RCRB mapped to
> > > the memory mapped register area. Critically, that arrangement makes the
> > > link status and control registers invisible to existing PCI user tooling.
> > >
> > > Export those registers via sysfs with the expectation that PCI user
> > > tooling will alternatively look for these sysfs files when attempting to
> > > access to these CXL 1.1 endpoints registers.  
> > 
> > The lspci support raced with this series and has landed.
> > 
> > https://github.com/pciutils/pciutils/commit/49efa87fcce4f7d5b351238668ae
> > 1d4491802b88
> > 
> > A few follow up comments on suggestion to cache the offset, not the register
> > value
> > (which might change over time)  
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > > ---
> > >  drivers/cxl/pci.c | 101  
> > ++++++++++++++++++++++++++++++++++++++++++++++  
> > >  1 file changed, 101 insertions(+)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 2ff361e756d6..c10797adde2c 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -786,6 +786,106 @@ static int cxl_event_config(struct pci_host_bridge  
> > *host_bridge,  
> > >  	return 0;
> > >  }
> > >
> > > +static ssize_t rcd_link_cap_show(struct device *dev,
> > > +				   struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> > > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > > +	struct device *endpoint_parent;
> > > +	struct cxl_dport *dport;
> > > +	struct cxl_port *port;
> > > +
> > > +	port = cxl_mem_find_port(cxlmd, &dport);
> > > +	if (!port)
> > > +		return -EINVAL;
> > > +
> > > +	endpoint_parent = port->uport_dev;
> > > +	if (!endpoint_parent)
> > > +		return -ENXIO;
> > > +
> > > +	guard(device)(endpoint_parent);
> > > +	if (!endpoint_parent->driver)
> > > +		return -ENXIO;
> > > +
> > > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);  
> > 
> > If you follow the suggestion of caching the offset, not the register
> > content then, these are all very similar. Define one common
> > function which takes a u8 offset and call that from each of the
> > functions.
> > 
> > If you stick to separate caches (and ensure they are up to date),
> > then you can add a utility function to take the dev here and
> > get you to the rcrb structure.  Then you can call that and only
> > have the final line in each instances of this code.
> >   
> 
> Thank you for your comment.
> 
> To confirm my understanding of the proposed implementation approach, 
> I would like to share my interpretation:
> 
> - The values stored in `cxl_rcrb_info` should be the offsets of the registers, 
> rather than the register values themselves.
> - Similar to aer, the values should be read from the memory-mapped region 
> using the offset when they are needed.
> - To achieve this, the offsets (like `cxl_rcrb_pcie_caps`) will be stored in `cxl_rcrb_info` 
> during initialization, and the memory-mapped region will be accessed within the `rcd_*_show()`
> functions where the values are actually used.
> - Accessing the memory-mapped region only requires the `struct device *dev`, 
> so a common utility function will be created and used for this purpose.
> 
> If the cost of accessing the memory-mapped region at runtime is not high, especially considering 
> the avoidance of the walk to find the offset, then I believe it is more reasonable to access 
> the memory-mapped region at runtime.
> 
> Could you let me know if there are any errors in my understanding.
> 
> If there are no issues, I will update the implementation with this approach 
> and submit a v8 patch (hopefully tomorrow).

Your description matches my intent. Looking forwards to v8.

Jonathan

> 
> > > +}
> > > +static DEVICE_ATTR_RO(rcd_link_cap);
> > > +
> > > +static ssize_t rcd_link_ctrl_show(struct device *dev,
> > > +				   struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> > > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > > +	struct device *endpoint_parent;
> > > +	struct cxl_dport *dport;
> > > +	struct cxl_port *port;
> > > +
> > > +	port = cxl_mem_find_port(cxlmd, &dport);
> > > +	if (!port)
> > > +		return -EINVAL;
> > > +
> > > +	endpoint_parent = port->uport_dev;
> > > +	if (!endpoint_parent)
> > > +		return -ENXIO;
> > > +
> > > +	guard(device)(endpoint_parent);
> > > +	if (!endpoint_parent->driver)
> > > +		return -ENXIO;
> > > +
> > > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkctrl);
> > > +}
> > > +static DEVICE_ATTR_RO(rcd_link_ctrl);
> > > +
> > > +static ssize_t rcd_link_status_show(struct device *dev,
> > > +				   struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> > > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > > +	struct device *endpoint_parent;
> > > +	struct cxl_dport *dport;
> > > +	struct cxl_port *port;
> > > +
> > > +	port = cxl_mem_find_port(cxlmd, &dport);
> > > +	if (!port)
> > > +		return -EINVAL;
> > > +
> > > +	endpoint_parent = port->uport_dev;
> > > +	if (!endpoint_parent)
> > > +		return -ENXIO;
> > > +
> > > +	guard(device)(endpoint_parent);
> > > +	if (!endpoint_parent->driver)
> > > +		return -ENXIO;
> > > +
> > > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);
> > > +}
> > > +static DEVICE_ATTR_RO(rcd_link_status);
> > > +
> > > +static struct attribute *cxl_rcd_attrs[] = {
> > > +		&dev_attr_rcd_link_cap.attr,
> > > +		&dev_attr_rcd_link_ctrl.attr,
> > > +		&dev_attr_rcd_link_status.attr,
> > > +		NULL
> > > +};
> > > +
> > > +static umode_t cxl_rcd_visible(struct kobject *kobj,
> > > +					  struct attribute *a, int n)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +
> > > +	if (is_cxl_restricted(pdev))
> > > +		return a->mode;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct attribute_group cxl_rcd_group = {
> > > +		.attrs = cxl_rcd_attrs,
> > > +		.is_visible = cxl_rcd_visible,
> > > +};
> > > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id  
> > *id)  
> > >  {
> > >  	struct pci_host_bridge *host_bridge =  
> > pci_find_host_bridge(pdev->bus);  
> > > @@ -969,6 +1069,7 @@ static struct pci_driver cxl_pci_driver = {
> > >  	.id_table		= cxl_mem_pci_tbl,
> > >  	.probe			= cxl_pci_probe,
> > >  	.err_handler		= &cxl_error_handlers,
> > > +	.dev_groups		= cxl_rcd_groups,
> > >  	.driver	= {
> > >  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> > >  	},  
> 



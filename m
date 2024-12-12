Return-Path: <linux-pci+bounces-18285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074259EE70A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B12833E6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912162144AA;
	Thu, 12 Dec 2024 12:47:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B612139A7
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007666; cv=none; b=A05YHd9Jv5gIY/CIUYirNELJNJxEsruJxpdwk1mW1+cMhj/cHHi+brJU4Oy24tJcFfWalWs+vSduCclu3TuoUnuqEdXdHActYh/FglI+tNzug+Oh4kT5b3GK3Y7hn97LKs+VlV9RMZMLnCmO5LZdp3ZUv+POHkuYERqRbEGgUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007666; c=relaxed/simple;
	bh=3Oq2B4upfnTicItT4ahHM10z9spwyteo4n6WmGt/jd8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/R+xqaNDSe7ubGupaFFdpm7GRVDQSEsi/vGSV8TygcXpGtobAOAQ38Ipcu4cyl8DttYP3FyQsvsI1Gvr0bRRCFmE7on2RVGGfEYoVcJFU+PsFWx/AwEEGDI7W48GWWe8VVYGQbwUMukTRY8QszCwqAulcGCMmmhcdCnMK2xVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8Bvj6N3Yz6K5n7;
	Thu, 12 Dec 2024 20:42:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5447A140114;
	Thu, 12 Dec 2024 20:47:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 13:47:38 +0100
Date: Thu, 12 Dec 2024 12:47:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
CC: "kw@linux.com" <kw@linux.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Message-ID: <20241212124736.00002d04@huawei.com>
In-Reply-To: <OSAPR01MB7182A97AD0B536DD214BCDEABA3F2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
	<20241210040826.11402-3-kobayashi.da-06@fujitsu.com>
	<20241211174334.00002adc@huawei.com>
	<OSAPR01MB7182A97AD0B536DD214BCDEABA3F2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Dec 2024 09:08:54 +0000
"Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:

> Jonathan Cameron wrote:
> > On Tue, 10 Dec 2024 13:08:21 +0900
> > "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
> >   
> > > Add support for PBEC (Power Budgeting Extended Capability) output to
> > > the PCIe driver. PBEC is defined in the PCIe specification(PCIe r6.0,
> > > sec 7.8.1) and is a standard method for obtaining device power
> > > consumption information.  
> > 
> > I'm curious why you chose to drive the interface from sysfs as opposed to just
> > querying how many there are boot and providing separate files for each data
> > register, potentially a set of files for each one for better readability.
> > 
> > Slightly irritating is that there is no 'count' register so you'd have to walk up or
> > bisect just to find out how many there actually readable.
> > Then use is_visible() to hide the remainder.
> > 
> > Look like it is an 8 bit data select register, so maybe 256 max?
> > That would give you things like
> > power_budget0_power
> > power_budget0_pm_state
> > etc
> > Or maybe drop the leading power given where we are so budget0_power etc
> > 
> > Mailboxes via sysfs are always a bit messy as there isn't really any locking etc.
> > 
> > Sorry I'm coming in rather late with this query given you are already at v5!
> > 
> > Jonathan
> >   
> Thank you for your valuable feedback and for taking the time to review my patch.
> 
> Regarding your proposed file structure:
> 
> budget0_power
> budget0_pm_state
> ...
> budget1_power
> budget1_pm_state
> ...
> budget2_xxx
> ...
> 
> Is this the correct format?

Yes. That is what I had mind.

> 
> In my understanding, implementing this would require 256 attributes corresponding to
> the DataSelectRegister, which seems overly redundant. Additionally, I was concerned
> about the mechanism of changing the DataSelectRegister each time a file is read.

I agree it is quite a large number of files, but there are larger sysfs interfaces
so I'm not that concerned. Do you have any data on how many entries are typically used?
We could use an is_visible() callback and register all 256, or we could do dynamic
allocation though that would require walking to find out what is there.

The implementation should cache the current dataselectregister value and only write it
if the value needs to change.  Sensible userspace software would just read all
the elements of each budgetX_* before moving on to the next one.

> 
> Therefore, I proposed this patch implementation, even though it might not be ideal.
> 
> If you have a suitable implementation to achieve your proposed structure, 
> I would greatly appreciate it if you could share it.
> 
> Upon further reflection, the issue of needing to change the DataSelectRegister could 
> potentially be avoided by initially retrieving and storing the register values for all indices.

Cacheing these is definitely an option to explore.  I'm not sure we would want to pay that cost
at boot, but if not we could do it on first touch.  The 0 value is reserved anyway so
if cached copy is 0, read it from the device and fill the cache.
We would need to read some at boot to figure out which should be visible, but
that would be logN of max entries at worse, rather than all 256.  If there are only
a few it would make sense to just read them all at boot.

Annoying there isn't a count register for these!

Jonathan




> 
> Thank you for pointing out the coding style issue, I'll fix it in the next patch.
> 
> > >
> > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-pci |  62 ++++++++
> > >  drivers/pci/pci-sysfs.c                 | 179  
> > ++++++++++++++++++++++++  
> > >  2 files changed, 241 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> > > b/Documentation/ABI/testing/sysfs-bus-pci
> > > index 7f63c7e97773..ec417ae20bc1 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > @@ -572,3 +572,65 @@ Description:
> > >  		enclosure-specific indications "specific0" to "specific7",
> > >  		hence the corresponding led class devices are unavailable if
> > >  		the DSM interface is used.
> > > +
> > > +What:		/sys/bus/pci/devices/.../power_budget
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file provides information about the PCIe power budget
> > > +		for the device. It is a read-only file that outputs the values
> > > +		of the Power Budgeting Data Register for each power state as  
> > a  
> > > +		series of 32-bit hexadecimal values. Each line represents a
> > > +		single Power Budgeting Data register entry, containing the
> > > +		power budget for a specific power state.
> > > +
> > > +		The specific interpretation of these values depends on the
> > > +		device and the PCIe specification. Refer to the PCIe
> > > +		specification for detailed information about the Power
> > > +		Budgeting Data register, including the encoding	of power
> > > +		states and the interpretation of Base Power and Data Scale.
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_data_select  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This is an 8-bit read/write register that selects the DWORD of
> > > +		power budgeting data that will be displayed in the
> > > +		Power Budgeting Data. The value starts at zero and  
> > incrementing  
> > > +		the index value selects the next DWORD.
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_power  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file provides the power consumption calculated by
> > > +		multiplying the base power by the data scale.
> > > +
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_pm_state  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file specifies the power management state of the  
> > operating  
> > > +		condition.
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_pm_substat
> > e  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file specifies the power management sub state of the
> > > +		operating condition.
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_type  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file specifies the type of the operating condition.
> > > +
> > > +
> > > +What:  
> > 	/sys/bus/pci/devices/.../power_budget/power_budget_rail  
> > > +Date:		December 2024
> > > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > > +Description:
> > > +		This file Specifies the thermal load or power rail of the
> > > +		operating condition.
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index
> > > 5d0f4db1cab7..89909633ad02 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -238,6 +238,155 @@ static ssize_t current_link_width_show(struct
> > > device *dev,  }  static DEVICE_ATTR_RO(current_link_width);  
> >   
> > > +
> > > +static ssize_t power_budget_rail_show(struct device *dev,
> > > +				       struct device_attribute *attr, char  
> > *buf) {  
> > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +	int pos, err;
> > > +	u32 data;
> > > +
> > > +	pos = pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);  
> > 
> > IIRC, this is not a cheap operation. I'd suggest storing it like we do for aer_cap
> > etc.
> >   
> > > +	if (!pos)
> > > +		return -EINVAL;
> > > +
> > > +	err = pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA, &data);
> > > +	if (err)
> > > +		return -EINVAL;
> > > +
> > > +	return sysfs_emit(buf, "%s\n",
> > > +  
> > 	pci_power_budget_rail_string(PCI_PWR_DATA_RAIL(data)));
> > 
> > Unusual indenting. Align it below b
> >   
> > > +}
> > > +static DEVICE_ATTR_RO(power_budget_rail);
> > > +
> > >  static ssize_t secondary_bus_number_show(struct device *dev,
> > >  					 struct device_attribute *attr,
> > >  					 char *buf)
> > > @@ -636,6 +785,16 @@ static struct attribute *pcie_dev_attrs[] = {
> > >  	NULL,
> > >  };
> > >
> > > +static struct attribute *pcie_pbec_attrs[] = {
> > > +	&dev_attr_power_budget_data_select.attr,
> > > +	&dev_attr_power_budget_power.attr,
> > > +	&dev_attr_power_budget_pm_state.attr,
> > > +	&dev_attr_power_budget_pm_substate.attr,
> > > +	&dev_attr_power_budget_rail.attr,
> > > +	&dev_attr_power_budget_type.attr,
> > > +	NULL,  
> > No need for comma on terminating entries as we will never add anything after
> > them.
> >   
> > > +};  
> 



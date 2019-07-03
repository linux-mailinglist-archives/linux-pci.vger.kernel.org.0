Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A145E751
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGCPDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 11:03:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:32220 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfGCPDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 11:03:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 08:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="184779863"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jul 2019 08:03:42 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jul 2019 18:03:41 +0300
Date:   Wed, 3 Jul 2019 18:03:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190703150341.GW2640@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
 <20190703133953.GK128603@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703133953.GK128603@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 08:39:53AM -0500, Bjorn Helgaas wrote:
> On Wed, May 29, 2019 at 01:49:42PM +0300, Mika Westerberg wrote:
> > PCIe root and downstream ports have link control register that can be
> > used disable the link from software. This can be useful for instance
> > when performing "software" hotplug on systems that do not support real
> > PCIe/ACPI hotplug.
> > 
> > For example when used with FPGA card we can burn a new FPGA image
> > without need to reboot the system.
> > 
> > First we remove the FGPA device from Linux PCI stack:
> > 
> >   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/0000:02:00.0/remove
> > 
> > Then we disable the link:
> > 
> >   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/link_disable
> > 
> > By doing this we prevent the kernel from accessing the hardware while we
> > burn the new FPGA image. 
> 
> What is the case where the kernel accesses the hardware?  You've
> already done the remove, so the pci_dev is gone.  Is this to protect
> against another user doing a rescan?  Or is there some spurious event
> during the FPGA update that causes an interrupt that causes pciehp to
> rescan?  Something else?

Protect against another user doing rescan.

> I guess this particular FPGA update must be done via some side channel
> (not the PCIe link)?  I assume there are other FPGA arrangements where
> the update *would* be done via the PCIe link, and we would just do a
> reset to make the update take effect.

In this setup the FPGA is programmed using side channel. I haven't seen
the actual system but I think it is some sort of FPGA programmer
connected to another system.

> > Once the new FPGA is burned we can re-enable
> > the link and rescan the new and possibly different device:
> > 
> >   # echo 0 > /sys/bus/pci/devices/0000:00:01.1/link_disable
> >   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/rescan
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  8 +++
> >  drivers/pci/pci-sysfs.c                 | 65 ++++++++++++++++++++++++-
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 8bfee557e50e..c93d6b9ab580 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -324,6 +324,14 @@ Description:
> >  		This is similar to /sys/bus/pci/drivers_autoprobe, but
> >  		affects only the VFs associated with a specific PF.
> >  
> > +What:		/sys/bus/pci/devices/.../link_disable
> > +Date:		September 2019
> > +Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
> > +Description:
> > +		PCIe root and downstream ports have this attribute. Writing
> > +		1 causes the link to downstream component be disabled.
> > +		Re-enabling the link happens by writing 0 instead.
> > +
> >  What:		/sys/bus/pci/devices/.../p2pmem/size
> >  Date:		November 2017
> >  Contact:	Logan Gunthorpe <logang@deltatee.com>
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 6d27475e39b2..dfcd21745192 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -218,6 +218,56 @@ static ssize_t current_link_width_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(current_link_width);
> >  
> > +static ssize_t link_disable_show(struct device *dev,
> > +				 struct device_attribute *attr, char *buf)
> > +{
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	u16 linkctl;
> > +	int ret;
> > +
> > +	ret = pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &linkctl);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	return sprintf(buf, "%d\n", !!(linkctl & PCI_EXP_LNKCTL_LD));
> > +}
> > +
> > +static ssize_t link_disable_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	u16 linkctl;
> > +	bool disable;
> > +	int ret;
> > +
> > +	ret = kstrtobool(buf, &disable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &linkctl);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	if (disable) {
> > +		if (linkctl & PCI_EXP_LNKCTL_LD)
> > +			goto out;
> > +		linkctl |= PCI_EXP_LNKCTL_LD;
> > +	} else {
> > +		if (!(linkctl & PCI_EXP_LNKCTL_LD))
> > +			goto out;
> > +		linkctl &= ~PCI_EXP_LNKCTL_LD;
> > +	}
> > +
> > +	ret = pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL, linkctl);
> > +	if (ret)
> > +		return ret;
> > +
> > +out:
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(link_disable);
> > +
> >  static ssize_t secondary_bus_number_show(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> > @@ -785,6 +835,7 @@ static struct attribute *pcie_dev_attrs[] = {
> >  	&dev_attr_current_link_width.attr,
> >  	&dev_attr_max_link_width.attr,
> >  	&dev_attr_max_link_speed.attr,
> > +	&dev_attr_link_disable.attr,
> >  	NULL,
> >  };
> >  
> > @@ -1656,8 +1707,20 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
> >  	struct device *dev = kobj_to_dev(kobj);
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  
> > -	if (pci_is_pcie(pdev))
> > +	if (pci_is_pcie(pdev)) {
> > +		if (a == &dev_attr_link_disable.attr) {
> > +			switch (pci_pcie_type(pdev)) {
> > +			case PCI_EXP_TYPE_ROOT_PORT:
> > +			case PCI_EXP_TYPE_DOWNSTREAM:
> 
> This is actually not completely reliable because there are weird
> systems that don't identify upstream/downstream ports correctly, e.g.,
> see d0751b98dfa3 ("PCI: Add dev->has_secondary_link to track
> downstream PCIe links") and c8fc9339409d ("PCI/ASPM: Use
> dev->has_secondary_link to find downstream links").

D'oh!

It never came to my mind that using pci_pcie_type() would not be
reliable. Thanks for pointing it out.

> I think I suggested the dev->has_secondary_link approach, but I now
> think that was a mistake because it means we have to remember to look
> at has_secondary_link instead of doing the obvious thing like your
> code.
> 
> set_pcie_port_type() detects those unusual topologies, and I think it
> would probably be better for it to just change the cached caps reg
> used by pci_pcie_type() so checking for PCI_EXP_TYPE_DOWNSTREAM does
> the right thing.

You mean modify set_pcie_port_type() to correct the type if it finds:

  type == PCI_EXP_TYPE_UPSTREAM && !pdev->has_secondary_link => type = PCI_EXP_TYPE_DOWNSTREAM

or

  type == PCI_EXP_TYPE_DOWNSTREAM && pdev->has_secondary_link => type = PCI_EXP_TYPE_UPSTREAM

? Assuming my understanding of pdev->has_secondary_link is correct.

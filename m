Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD680E476E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393290AbfJYJfB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 05:35:01 -0400
Received: from foss.arm.com ([217.140.110.172]:37826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394325AbfJYJfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 05:35:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08B428;
        Fri, 25 Oct 2019 02:34:59 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B933F71F;
        Fri, 25 Oct 2019 02:34:59 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:34:57 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191025093457.GY47056@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
 <20191021133849.GQ47056@e119886-lin.cambridge.arm.com>
 <6a209452-f569-4f6a-8aea-5c9f84167f5a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a209452-f569-4f6a-8aea-5c9f84167f5a@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 05:20:00PM +0800, Dilip Kota wrote:
> Hi Andrew Murray,
> 
> On 10/21/2019 9:38 PM, Andrew Murray wrote:
> > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > of changing link width and speed on the fly.
> > > So add the sysfs attributes to show and store the link
> > > properties.
> > > Add the respective link resize function in pcie DesignWare
> > > framework so that Intel PCIe driver can use during link
> > > width configuration on the fly.
> > > 
> > > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>

> > > +/*
> > > + * Link width change on the fly is not always successful.
> > > + * It also depends on the partner.
> > > + */
> > > +static ssize_t pcie_width_store(struct device *dev,
> > > +				struct device_attribute *attr,
> > > +				const char *buf, size_t len)
> > > +{
> > > +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> > > +	unsigned long val;
> > > +	int ret;
> > > +
> > > +	lpp = dev_get_drvdata(dev);
> > > +
> > > +	ret = kstrtoul(buf, 10, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (val > lpp->max_width)
> > > +		return -EINVAL;
> > > +
> > > +	/* HW auto bandwidth negotiation must be enabled */
> > > +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
> > > +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> > > +	dw_pcie_link_width_resize(&lpp->pci, val);
> > > +
> > > +	return len;
> > > +}
> > > +static DEVICE_ATTR_WO(pcie_width);
> > > +
> > > +static struct attribute *pcie_cfg_attrs[] = {
> > > +	&dev_attr_pcie_link_status.attr,
> > > +	&dev_attr_pcie_speed.attr,
> > > +	&dev_attr_pcie_width.attr,
> > > +	NULL,
> > > +};
> > Is there a reason that these are limited only to the Intel driver and
> > not the wider set of DWC drivers?
> > 
> > Is there anything specific here about the Intel GW driver?
> 
> Yes, they need intel_pcie_max_speed_setup() and pcie_link_gen_to_str().
> Once intel_pcie_max_speed_setup() moved to DesignWare framework (as per
> Bjorn Helgaas inputs) and use pcie_link_speed[] array instead of
> pcie_link_gen_to_str() (as per gustavo pimentel inputs) we can move this to
> PCIe DesignWare framework or to pci sysfs file.

I think the key concern here is this: If you introduce sysfs controls that
represent generic PCI concepts (such as changing the link speed) - the concept
isn't limited to a particular host controller, it's limited to PCI. Therefore
the sysfs control should also apply more widely to all PCI controllers. This
is important as otherwise you may end up getting a slightly different user
interface to achieve the same consequence depending on the host-controller in
use.

If each controller driver has a different way of doing things, then it lends
itself to having some set of ops that they can all implement. Or perhaps there
is a middle-ground solution where this applies just to DWC devices and not all
devices. 

Thanks,

Andrew Murray

> 
> Regards,
> Dilip
> 
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > +ATTRIBUTE_GROUPS(pcie_cfg);
> > > +
> > > +static int intel_pcie_sysfs_init(struct intel_pcie_port *lpp)
> > > +{
> > > +	return devm_device_add_groups(lpp->pci.dev, pcie_cfg_groups);
> > > +}
> > > +
> > >   static void __intel_pcie_remove(struct intel_pcie_port *lpp)
> > >   {
> > >   	intel_pcie_core_irq_disable(lpp);
> > > @@ -490,8 +591,17 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
> > >   {
> > >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >   	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
> > > +	int ret;
> > > -	return intel_pcie_host_setup(lpp);
> > > +	ret = intel_pcie_host_setup(lpp);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = intel_pcie_sysfs_init(lpp);
> > > +	if (ret)
> > > +		__intel_pcie_remove(lpp);
> > > +
> > > +	return ret;
> > >   }
> > >   int intel_pcie_msi_init(struct pcie_port *pp)
> > > -- 
> > > 2.11.0
> > > 

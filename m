Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8634747F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhCXJZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 05:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhCXJZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 05:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8946C61A03;
        Wed, 24 Mar 2021 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616577923;
        bh=O0a1n/S9dOJwgzqzEYVtbF/EMLMwvmSvIJcKg0dHGk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZe2UqDgmE3mBmxzcopgzJJ/qqPsLzWARBLPVf5MxeJY+HBk4VzFOeTC3U4sHVguB
         ZtYeUb5lqzxc7elP6qQQDU1ioSU8klOHkVDoUUlkOWFKYEe6FxHmcjni6UrYOprkmr
         A4zxm87IqwXlmv/Mihcfc2FclrfYiH3NPK6NWaS0=
Date:   Wed, 24 Mar 2021 10:25:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/5] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YFsFgO4Z+2E7VLN/@kroah.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
 <724f5d30e3a9b86448df7e32fb5ed1e814416368.1613150798.git.gustavo.pimentel@synopsys.com>
 <YFnmVEB86JcAENcN@kroah.com>
 <DM5PR12MB18355EDB515CE57C38ECF6D4DA639@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18355EDB515CE57C38ECF6D4DA639@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 09:15:46AM +0000, Gustavo Pimentel wrote:
> Hi Greg,
> 
> On Tue, Mar 23, 2021 at 13:0:4, Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Feb 12, 2021 at 06:28:03PM +0100, Gustavo Pimentel wrote:
> > > +static const struct attribute_group xdata_attr_group = {
> > > +	.attrs = default_attrs,
> > > +	.name = DW_XDATA_DRIVER_NAME,
> > > +};
> > 
> > ATTRIBUTE_GROUPS()?
> 
> Nicely catched!
> 
> > 
> > > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > > +			       const struct pci_device_id *pid)
> > > +{
> > > +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> > > +	struct dw_xdata *dw;
> > > +	u64 addr;
> > > +	int err;
> > > +
> > > +	/* Enable PCI device */
> > > +	err = pcim_enable_device(pdev);
> > > +	if (err) {
> > > +		pci_err(pdev, "enabling device failed\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Mapping PCI BAR regions */
> > > +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
> > > +	if (err) {
> > > +		pci_err(pdev, "xData BAR I/O remapping failed\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	pci_set_master(pdev);
> > > +
> > > +	/* Allocate memory */
> > > +	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> > > +	if (!dw)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Data structure initialization */
> > > +	mutex_init(&dw->mutex);
> > > +
> > > +	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
> > > +	if (!dw->rg_region.vaddr)
> > > +		return -ENOMEM;
> > > +
> > > +	dw->rg_region.vaddr += pdata->rg_off;
> > > +	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
> > > +	dw->rg_region.paddr += pdata->rg_off;
> > > +	dw->rg_region.sz = pdata->rg_sz;
> > > +
> > > +	dw->max_wr_len = pcie_get_mps(pdev);
> > > +	dw->max_wr_len >>= 2;
> > > +
> > > +	dw->max_rd_len = pcie_get_readrq(pdev);
> > > +	dw->max_rd_len >>= 2;
> > > +
> > > +	dw->pdev = pdev;
> > > +
> > > +	writel(0x0, &(__dw_regs(dw)->RAM_addr));
> > > +	writel(0x0, &(__dw_regs(dw)->RAM_port));
> > > +
> > > +	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> > > +	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
> > > +	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
> > > +	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
> > > +
> > > +	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
> > > +		dw->max_wr_len * 4, dw->max_rd_len * 4);
> > > +
> > > +	/* Saving data structure reference */
> > > +	pci_set_drvdata(pdev, dw);
> > > +
> > > +	/* Sysfs */
> > > +	err = sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);
> > 
> > You just raced with userspace and lost :(
> > 
> > Have the driver core properly create/remove your sysfs files, set the
> > default groups pointer in your driver and all will be fine.
> 
> I've gone around and around, searched in other drivers, but I'm not 
> understanding your PoV or what I should do. Can you throw me a bone here?
> I'm starting to pull my hair off, lol

Set the dev_groups field of the struct device_driver in your pci driver
structure and all should be fine.

But wait, why are you adding attributes to a pci device and not your
"own" device?  You should make a sub-device for this device-specific
things, otherwise it will be impossible to find these types of
attributes anywhere in sysfs.

> I would like to ask you about something, it's you the maintainer of misc 
> drivers right?

MAINTAINERS shows this so I guess it must be true...

> After fixing this issue, does this driver have a chance to be pulled on 
> 5.13?

No idea, I do not promise anything :)

thanks,

greg k-h

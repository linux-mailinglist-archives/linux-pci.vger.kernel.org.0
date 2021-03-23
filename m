Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F2345ED6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCWNA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 09:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhCWNAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 09:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E970619B7;
        Tue, 23 Mar 2021 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616504407;
        bh=Z99hjTVltFxCT8RpC7pfLGSJtN+CDHehM0LkOEDVDMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMHnG34GsYMxf+X5k6ixt6bYqR41UOiUipfgNHOKAVleoabz0V9McDGOpcsKsiLxP
         e6183mANGd5PjsOxEeT43mh0JPE0CE2CwjhR9Jik8BZXZZL58s6xxz3M51je1x50DL
         Cy5f/hAnPKXfAtvzLUnDQN9Y3lfrfdWFxctS1Wu0=
Date:   Tue, 23 Mar 2021 14:00:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/5] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YFnmVEB86JcAENcN@kroah.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
 <724f5d30e3a9b86448df7e32fb5ed1e814416368.1613150798.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724f5d30e3a9b86448df7e32fb5ed1e814416368.1613150798.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 12, 2021 at 06:28:03PM +0100, Gustavo Pimentel wrote:
> +static const struct attribute_group xdata_attr_group = {
> +	.attrs = default_attrs,
> +	.name = DW_XDATA_DRIVER_NAME,
> +};

ATTRIBUTE_GROUPS()?

> +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *pid)
> +{
> +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> +	struct dw_xdata *dw;
> +	u64 addr;
> +	int err;
> +
> +	/* Enable PCI device */
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		pci_err(pdev, "enabling device failed\n");
> +		return err;
> +	}
> +
> +	/* Mapping PCI BAR regions */
> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
> +	if (err) {
> +		pci_err(pdev, "xData BAR I/O remapping failed\n");
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	/* Allocate memory */
> +	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;
> +
> +	/* Data structure initialization */
> +	mutex_init(&dw->mutex);
> +
> +	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
> +	if (!dw->rg_region.vaddr)
> +		return -ENOMEM;
> +
> +	dw->rg_region.vaddr += pdata->rg_off;
> +	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
> +	dw->rg_region.paddr += pdata->rg_off;
> +	dw->rg_region.sz = pdata->rg_sz;
> +
> +	dw->max_wr_len = pcie_get_mps(pdev);
> +	dw->max_wr_len >>= 2;
> +
> +	dw->max_rd_len = pcie_get_readrq(pdev);
> +	dw->max_rd_len >>= 2;
> +
> +	dw->pdev = pdev;
> +
> +	writel(0x0, &(__dw_regs(dw)->RAM_addr));
> +	writel(0x0, &(__dw_regs(dw)->RAM_port));
> +
> +	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> +	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
> +	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
> +	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
> +
> +	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
> +		dw->max_wr_len * 4, dw->max_rd_len * 4);
> +
> +	/* Saving data structure reference */
> +	pci_set_drvdata(pdev, dw);
> +
> +	/* Sysfs */
> +	err = sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);

You just raced with userspace and lost :(

Have the driver core properly create/remove your sysfs files, set the
default groups pointer in your driver and all will be fine.

thanks,

greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7212C8B12
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgK3Rar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 12:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgK3Rar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 12:30:47 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9332076E;
        Mon, 30 Nov 2020 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606757406;
        bh=IToxAulcLFljIt9BT9SqHMDRczdFs12OnHYPP1zKJFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jGfZDrX4SkWN1omKwJldR/43kCrQeKgACf5gruqhAT2JYzX1CpNNNLy/xqb4G3zyJ
         OkymF/y5eo0iXBkXioJND067zPFbtxHvmI/h1vaab17xze4FZ2BU2XnReIqeI3vkat
         xHw5rG76uTucS1eFYYk8eCHtbIMQhF5lj0hNpCiU=
Date:   Mon, 30 Nov 2020 11:30:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, Lukas Wunner <lukas@wunner.de>
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
Message-ID: <20201130173005.GA1088958@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606113913.14736.37.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, pciehp power control question]

On Mon, Nov 23, 2020 at 02:45:13PM +0800, Jianjun Wang wrote:
> On Thu, 2020-11-19 at 14:28 -0600, Bjorn Helgaas wrote:
> > "Add new generation" really contains no information.  And "mediatek"
> > is already used for the pcie-mediatek.c driver, so we should have a
> > new tag for this new driver.  Include useful information in the
> > subject, e.g.,
> > 
> >   PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192

> > > +static int mtk_pcie_setup(struct mtk_pcie_port *port)
> > > +{
> > > +	struct device *dev = port->dev;
> > > +	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct resource *regs;
> > > +	int err;
> > > +
> > > +	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
> > > +	port->base = devm_ioremap_resource(dev, regs);
> > > +	if (IS_ERR(port->base)) {
> > > +		dev_notice(dev, "failed to map register base\n");
> > > +		return PTR_ERR(port->base);
> > > +	}
> > > +
> > > +	port->reg_base = regs->start;
> > > +
> > > +	/* Don't touch the hardware registers before power up */
> > > +	err = mtk_pcie_power_up(port);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Try link up */
> > > +	err = mtk_pcie_startup_port(port);
> > > +	if (err) {
> > > +		dev_notice(dev, "PCIe link down\n");
> > > +		goto err_setup;
> > 
> > Generally it should not be a fatal error if the link is not up at
> > probe-time.  You may be able to hot-add a device, or the device may
> > have some external power control that will power it up later.
> 
> This is for the power saving requirement. If there is no device
> connected with the PCIe slot, the PCIe MAC and PHY should be powered
> off.
> 
> Is there any standard flow to support power down the hardware at
> probe-time if no device is connected and power it up when hot-add a
> device?

That's a good question.  I assume this looks like a standard PCIe
hot-add event?

When you hot-add a device, does the Root Port generate a Presence
Detect Changed interrupt?  The pciehp driver should field that
interrupt and turn on power to the slot via the Power Controller
Control bit in the Slot Control register.

Does your hardware require something more than that to control the MAC
and PHY power?

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED17553986
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiFUS3q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUS3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 14:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE301132;
        Tue, 21 Jun 2022 11:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65078616DB;
        Tue, 21 Jun 2022 18:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B7AC3411C;
        Tue, 21 Jun 2022 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655836183;
        bh=G7roggXyRqJIPE3GVSCluJh8Ri8/QlqkXssG4u2339E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fGzXqUv3EBojH69GxvckOTbi2PU+J1a6j9wC9RP31QOa6OshrWLIZ8ngD/oDRmbe+
         STB6gJjKGI2Q0tjnaSDlRduGnGPtNPw8ncGbMEGtwFHYA6QZs3afxU9tjZv/Q9VxKW
         UViEPTiAgPevxo3dNDyWFJ2jHgyTsVZh+RUBleIV5bl+rMpdKbeYbTdDjW4aiPcYuq
         pZWAs7XyAFHjkqWYaPVjdXs+9CZQl7bRn8CUG2Cor1DYPAAzUMzmI+i4Juoed+5IYm
         i7ERvFQOM/DdCE9SsXOfnU9tbNfJGNpgVJqfLRpLMJlPc7/XuhybjSJfNjKTYTP7Fm
         gfamp3nX71ZwQ==
Date:   Tue, 21 Jun 2022 13:29:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220621182941.GA1322521@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620171347.35beffaudlik7euw@mobilestation>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 08:13:47PM +0300, Serge Semin wrote:
> On Wed, Jun 15, 2022 at 11:48:48AM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> > > trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> > > is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> > > turn is connected to the DWC 10G PHY. The whole system is supposed to be
> > > fed up with four clock sources: DBI peripheral clock, AXI application
> > > clocks and external PHY/core reference clock generating the 100MHz signal.
> > > In addition to that the platform provide a way to reset each part of the
> > > controller: sticky/non-sticky bits, host controller core, PIPE interface,
> > > PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> > > handle the GPIO-based PERST# signal.
> > > 
> > > Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> > > interface accessors which make sure the IO operations are dword-aligned.

> > > +struct dw_pcie_ops bt1_pcie_dw_ops = {
> > > +	.read_dbi = bt1_pcie_read_dbi,
> > > +	.write_dbi = bt1_pcie_write_dbi,
> > > +	.write_dbi2 = bt1_pcie_write_dbi2,
> > > +	.start_link = bt1_pcie_start_ltssm,
> > > +	.stop_link = bt1_pcie_stop_ltssm,
> > > +};

> > Please rename to "dw_pcie_ops" as most
> > drivers use. 
> 
> IMO matching the structure and its instance names is not a good idea.
> Other than confusing objects nature, at the very least it forces you to
> violate the local namespace convention. Thus in the line of the
> dw_pcie->ops initialization it looks like you use some generic
> operations while in fact you just refer to the locally defined
> DW PCIe ops instance with the generic variable name. Moreover AFAICS
> the latest platform drivers mainly use the vendor-specific prefix in
> the dw_pcie_ops structure instance including the ones acked by you,
> Lorenzo and Gustavo. What makes my code any different from them?

That's fair.  I suggest "bt1_pcie_ops" or "bt1_dw_pcie_ops" to match
the other drivers that include the driver name:

  intel_pcie_ops
  keembay_pcie_ops
  kirin_dw_pcie_ops
  tegra_dw_pcie_ops

They're not 100% consistent, but hopefully we can at least not make
things *less* consistent.

> > > +static int bt1_pcie_get_res(struct bt1_pcie *btpci)
> 
> > Can you name this something similar to what other drivers use?  There
> > are a couple *_pcie_get_resources() functions (normally called from
> > *_pcie_probe()), but no *_get_res() yet.
> 
> Earlier in this patchset I've introduced a new method to get
> the CSRs ranges, PCIe speed, NoF lanes, etc resources. See the patch:
> [PATCH v3 14/17] PCI: dwc: Introduce generic resources getter
> The method has been named as "dw_pcie_get_res()". So the locally
> defined function has been named to refer to that method. If you think
> that using the "_resources" suffix is better (IMO there is no
> significant difference) then we'll need to change the name there too.
> Do you?

Yes.  I don't think there's value in names being gratuitously
different.

> > > +	/* AXI-interface is configured with 64-bit address bus width */
> > > +	ret = dma_coerce_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> > > +					   DMA_BIT_MASK(64));
> 
> > Just to double-check since this is the first instance of
> > dma_coerce_mask_and_coherent() in drivers/pci -- I guess Baikal-T1 is
> > unique in needing this?
> 
> To be honest I've set it here just in case, seeing the dma_mask and
> coherent_dma_mask are left uninitialized in the Host bridge device
> instance, while it's still participate in the PCI devices hierarchy:
> 
> 1. platform_device.dev;
>                    | (<= devm_pci_alloc_host_bridge(dev))
>                    +---+
>                       &v
> 2. pci_host_bridge.dev.parent
>                    | (<= pci_register_host_bridge(bridge) or)
>                    | (<= pci_alloc_child_bus()              )
>                   &v
>            pci_bus.bridge
>                    +-------------------+
>                    |                   | (<= pci_setup_device())
>                    v                   v
> 3.     pci_bus.dev.parent  pci_dev.dev.parent
>                            pci_dev.dma_mask = 0xffffffff;
>                                    | (<= pci_device_add())
>                                    +----+
>                                        &v
>                            pci_dev->dev.dma_mask
>                            pci_dev->dev.coherent_dma_mask = 0xffffffffull;
> 
> So each device detected on the very first PCIe bus gets to have the
> PCI host bridge device as a parent. But AFAICS the PCI subsystem core
> code doesn't use the PCI host bridge DMA-mask and by default the
> dma_mask/coherent_dma_mask fields of each PCIe peripheral device are
> unconditionally initialized with DMA_BIT_MASK(32) (they are supposed
> to be overridden by the device-driver anyway). So to speak we can
> freely drop the dma_coerce_mask_and_coherent() method invocation from
> my driver if you say it is required and the PCI host bridge DMA parameter
> will never be used. What do you think?

I'd like the usage across drivers to be consistent unless there's a
hardware difference that requires something different.  So if you can
point to something different in bt1, great.  If not, do it the same as
the other drivers.

> > > +static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)
> > 
> > Can you name this something similar to what other drivers use?
> 
> For instance? (Please note, the link_stop/link_start callbacks are
> defined as separate methods above.) The current names correctly describe
> the methods logic. So I wouldn't want to fully change their names.

Do any other drivers contain similar logic?  If so, please use a
similar name.

> > > +	 * Application reset controls are trigger-based so de-assert the core
> > > +	 * resets only.
> > > +	 */
> > > +	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);

BTW, the comment says "de-assert" but the code looks like "assert".

> > > +	/* Make sure the reset is settled */
> > > +	usleep_range(1, 10);
> 
> > Is this duration related to something in the PCIe spec?  Or the DWC
> > spec? 
> 
> No. These durations are the chip-specific. Partly due to them being
> specific for each SoC we can't implement a generic bus reset
> procedure.
> 
> > I'd really like to use named constants when possible, although
> > we have a ton of bare magic numbers currently.
> > 
> > Similar for the poll timeouts and the "state settled" sleep below.
> 
> I don't really see much need in this parametrization since these
> numbers are used only once in the platform driver and their
> application is easily inferable from the code context.

Even if they are used only once, it's helpful when constants like this
can be connected to the spec or other justification for the specific
values.

> > > +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> > > +{
> > > +	struct bt1_pcie *btpci;
> > > +
> > > +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> > > +	if (!btpci)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	btpci->pdev = pdev;
> > > +
> > > +	platform_set_drvdata(pdev, btpci);
> > > +
> > > +	return btpci;
> 
> > I don't think it's worth splitting this into a separate function.  I
> > think it would be better to use the same structure as other dwc-based
> > drivers and keep this in bt1_pcie_probe().
> 
> Sorry, I disagree in this matter. Generally I don't like the most of
> the probe methods designed in the kernel well because after evolving
> in time they get to be a mess if incoherent initializations,
> allocations, requests, etc. Splitting it up into a set of smaller
> coherent methods makes the code much clearer.

There's definitely some tension between making one driver better and
making it different from all the others.  I'm all in favor of making
all the drivers better and more consistent.  I'm less in favor of
one-off improvements because consistency is extremely important for
maintenance.

> > > +static int bt1_pcie_add_dw_port(struct bt1_pcie *btpci)
> 
> > All other dwc-based drivers call dw_pcie_host_init() from either
> > *_pcie_probe() or *_add_pcie_port().  Please use a similar convention.
> 
> Not entirely. Tegra is an exception. So as before I don't think there
> is a real convention. Most likely it's a result of a lucky coincident.
> Moreover I don't really like such naming. Something like
> VENDOR_pcie_add_root_port() would be much better.

I stand corrected.  Of the 21 dw_pcie_host_init() calls, 13 are from
*_pcie_probe(), 7 are from *_add_pcie_port(), and tegra is from
tegra_pcie_init_controller().  I think the *_add_pcie_port() structure
is better because it makes room to support multiple root ports.

> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > 
> > Why do you need this when no other dwc-based drivers do?  Is Baikal-T1
> > different in this respect?
> 
> It's because eDMA engine embedded into the DW PCIe root port. 

Let's add a comment about the fact that this is needed because of the
eDMA engine.

> > > +static void bt1_pcie_del_dw_port(struct bt1_pcie *btpci)
> 
> > Can you call dw_pcie_host_deinit() from the same place as other
> > drivers?
> > 
> >   $ git grep -p dw_pcie_host_deinit drivers/pci/controller/dwc
> 
> Sorry I'd rather leave it as is. There are only four drivers using
> it and one of them don't follow what seems like a convention. I'd
> rather have my driver code coherent:
> bt1_pcie_add_pcie_port() is used to add the DW PCIe Root Port.
> and
> bt1_pcie_del_pcie_port() is used to remove the DW PCIe Root Port

I agree with your rationale.  Intel and kirin do:

  *_pcie_probe
    dw_pcie_host_init

  *_pcie_remove
    dw_pcie_host_deinit

and tegra is similar but from tegra_pcie_init_controller() and
tegra_pcie_deinit_controller().  Exynos is the odd one out and calls
dw_pcie_host_init() from exynos_add_pcie_port() but
dw_pcie_host_deinit() from exynos_pcie_remove().

Your model is better since it removes the "single root port"
assumption.  I would like the "bt1_pcie_add_port()" and
"bt1_pcie_del_port()" (or "bt1_pcie_remove_port()", which would be
slightly more parallel with "add") names to align with other drivers.

Bjorn

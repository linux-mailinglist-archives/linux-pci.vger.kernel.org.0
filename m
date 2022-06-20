Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011955229E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiFTRN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFTRNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 13:13:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7571E3D0;
        Mon, 20 Jun 2022 10:13:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g12so6561840ljk.11;
        Mon, 20 Jun 2022 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qNaQcswWWh5SmS/GVnmsQVot7JrA60YEJf97HcGejaI=;
        b=QSd2+/W7rSchc56J6SN7vY+wK7OAig5pgdpXhXIAV1OCG3IhVa95OoMQ4zTWVTX8Rm
         imQZPOVS9ivDHZWw0k/q0DNy7FRBWi/I3xDI6GT97J/fD4Msm6jB9FLINbq2SNDiyWRA
         +/Jixv+sClShs2oT9tbdU+OQ0g2qrejgV9QH+q3MtbaZhK4BQbwryd2vjgUYj+xx/4u7
         /alZ6bv6DDuaFaCoywrEO2hzAWG90vmMjiMfURQl14nUU1SOe60pDvmnOfQUIjuV4K7y
         MoKWsb+jW79+taoy3abi5KsBRppcULnNwRqTGAQZtu8B5ge5JcIJIpQjKU2jwrZBaKem
         0SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNaQcswWWh5SmS/GVnmsQVot7JrA60YEJf97HcGejaI=;
        b=kSwdjhKLbpOsqKe9kzRraX25HAhIqoDSWlH7eSqGaBSC0gyc6ctEk8gF9XfFOgvtLS
         isXaEMAS/YrZK5t0woCdCbSGLKF0t2NHAnVHrxkyqm1iG8Rg0QdPwYO8Yuvjw4sRPiRZ
         JgYo2Sv1gcrCJPCtCAt4y7XI27px61cWVACUbPuoCjgcx1MA0TKJ8dztIGOMQieRT+w9
         GfxMz2GDEaOa3gWzfWgAgppXu4gLsJt2WzaJFcEcTUbd6Y/V0c+UvD63lj7lp/16rJia
         IoHHxHJ8dELToXJAPT7Oj9f2GSQ9lp0GYCY4mS5iSm5YwtvW1+C5yLEfUM8ARDOzZvTK
         c24Q==
X-Gm-Message-State: AJIora/dIQW+WVembHkpykxCwBbUmGkmOY4y00uinJOPii8E+B0jH4Ac
        5nywg2jvXGJu7pBsX2ySBT8=
X-Google-Smtp-Source: AGRyM1snyStuPb1rykn3P2h1PYDVO619Y+jfDQBjfifbOQZD+FCrUffEAYOkBfBNJogHjL5zq6Dy7A==
X-Received: by 2002:a2e:a58a:0:b0:25a:61aa:cc65 with SMTP id m10-20020a2ea58a000000b0025a61aacc65mr6341195ljp.340.1655745230741;
        Mon, 20 Jun 2022 10:13:50 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id g20-20020a2ea4b4000000b0025a3902b523sm1675444ljm.67.2022.06.20.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:13:49 -0700 (PDT)
Date:   Mon, 20 Jun 2022 20:13:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20220620171347.35beffaudlik7euw@mobilestation>
References: <20220610085706.15741-18-Sergey.Semin@baikalelectronics.ru>
 <20220615164848.GA941930@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615164848.GA941930@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 11:48:48AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> > Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> > trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> > is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> > turn is connected to the DWC 10G PHY. The whole system is supposed to be
> > fed up with four clock sources: DBI peripheral clock, AXI application
> > clocks and external PHY/core reference clock generating the 100MHz signal.
> > In addition to that the platform provide a way to reset each part of the
> > controller: sticky/non-sticky bits, host controller core, PIPE interface,
> > PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> > handle the GPIO-based PERST# signal.
> > 
> > Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> > interface accessors which make sure the IO operations are dword-aligned.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> > +static int bt1_pcie_start_ltssm(struct dw_pcie *pci)
> > +{
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +	u32 val;
> > +	int ret;
> > +
> > +	/*
> > +	 * Enable LTSSM and make sure it was able to establish both PHY and
> > +	 * data links. This procedure shall work fine to reach 2.5 GT/s speed.
> > +	 */
> > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > +			   BT1_CCU_PCIE_LTSSM_EN, BT1_CCU_PCIE_LTSSM_EN);
> > +
> > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> > +				       (val & BT1_CCU_PCIE_SMLH_LINKUP),
> > +				       1000, 1000000);
> > +	if (ret) {
> > +		dev_err(pci->dev, "LTSSM failed to set PHY link up\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> > +				       (val & BT1_CCU_PCIE_RDLH_LINKUP),
> > +				       1000, 1000000);
> > +	if (ret) {
> > +		dev_err(pci->dev, "LTSSM failed to set data link up\n");
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Activate direct speed change after the link is established in an
> > +	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
> > +	 * This is required at least to get 8.0 GT/s speed.
> > +	 */
> > +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	val |= PORT_LOGIC_SPEED_CHANGE;
> > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> > +				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
> > +				       1000, 1000000);
> > +	if (ret)
> > +		dev_err(pci->dev, "LTSSM failed to get into L0 state\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static void bt1_pcie_stop_ltssm(struct dw_pcie *pci)
> > +{
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +
> > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> > +}
> > +
> > +struct dw_pcie_ops bt1_pcie_dw_ops = {
> > +	.read_dbi = bt1_pcie_read_dbi,
> > +	.write_dbi = bt1_pcie_write_dbi,
> > +	.write_dbi2 = bt1_pcie_write_dbi2,
> > +	.start_link = bt1_pcie_start_ltssm,
> > +	.stop_link = bt1_pcie_stop_ltssm,
> > +};
> 

> Should be static and const. 

Right. No idea how come this has slipped in through my hands.

> Please rename to "dw_pcie_ops" as most
> drivers use. 

IMO matching the structure and its instance names is not a good idea.
Other than confusing objects nature, at the very least it forces you to
violate the local namespace convention. Thus in the line of the
dw_pcie->ops initialization it looks like you use some generic
operations while in fact you just refer to the locally defined
DW PCIe ops instance with the generic variable name. Moreover AFAICS
the latest platform drivers mainly use the vendor-specific prefix in
the dw_pcie_ops structure instance including the ones acked by you,
Lorenzo and Gustavo. What makes my code any different from them?

> Please rename bt1_pcie_start_ltssm() and
> bt1_pcie_stop_ltssm() to bt1_pcie_start_link() and
> bt1_pcie_stop_link() for consistency with other drivers to make
> maintenance easier.

I believe there were no such requirement to use the particular suffix
in these callbacks, but it turned to be a nice coincident that almost
all the drivers have used the same naming convention.) Anyway let's
not brake the naturally evolved harmony and use the same suffixes in
my driver too. Thanks for noticing this.

> 
> > +static struct pci_ops bt1_pcie_ops = {
> > +	.map_bus = dw_pcie_own_conf_map_bus,
> > +	.read = pci_generic_config_read32,
> > +	.write = pci_generic_config_write32,
> > +};
> > +
> > +static int bt1_pcie_get_res(struct bt1_pcie *btpci)
> 

> Can you name this something similar to what other drivers use?  There
> are a couple *_pcie_get_resources() functions (normally called from
> *_pcie_probe()), but no *_get_res() yet.

Earlier in this patchset I've introduced a new method to get
the CSRs ranges, PCIe speed, NoF lanes, etc resources. See the patch:
[PATCH v3 14/17] PCI: dwc: Introduce generic resources getter
The method has been named as "dw_pcie_get_res()". So the locally
defined function has been named to refer to that method. If you think
that using the "_resources" suffix is better (IMO there is no
significant difference) then we'll need to change the name there too.
Do you?

> 
> > +{
> > +	struct device *dev = btpci->dw.dev;
> > +	int i, ret;
> > +
> > +	/* DBI access is supposed to be performed by the dword-aligned IOs */
> > +	btpci->dw.pp.bridge->ops = &bt1_pcie_ops;
> > +
> > +	/* AXI-interface is configured with 64-bit address bus width */
> > +	ret = dma_coerce_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> > +					   DMA_BIT_MASK(64));
> 

> Just to double-check since this is the first instance of
> dma_coerce_mask_and_coherent() in drivers/pci -- I guess Baikal-T1 is
> unique in needing this?

To be honest I've set it here just in case, seeing the dma_mask and
coherent_dma_mask are left uninitialized in the Host bridge device
instance, while it's still participate in the PCI devices hierarchy:

1. platform_device.dev;
                   | (<= devm_pci_alloc_host_bridge(dev))
                   +---+
                      &v
2. pci_host_bridge.dev.parent
                   | (<= pci_register_host_bridge(bridge) or)
                   | (<= pci_alloc_child_bus()              )
                  &v
           pci_bus.bridge
                   +-------------------+
                   |                   | (<= pci_setup_device())
                   v                   v
3.     pci_bus.dev.parent  pci_dev.dev.parent
                           pci_dev.dma_mask = 0xffffffff;
                                   | (<= pci_device_add())
                                   +----+
                                       &v
                           pci_dev->dev.dma_mask
                           pci_dev->dev.coherent_dma_mask = 0xffffffffull;

So each device detected on the very first PCIe bus gets to have the
PCI host bridge device as a parent. But AFAICS the PCI subsystem core
code doesn't use the PCI host bridge DMA-mask and by default the
dma_mask/coherent_dma_mask fields of each PCIe peripheral device are
unconditionally initialized with DMA_BIT_MASK(32) (they are supposed
to be overridden by the device-driver anyway). So to speak we can
freely drop the dma_coerce_mask_and_coherent() method invocation from
my driver if you say it is required and the PCI host bridge DMA parameter
will never be used. What do you think?

As a side note regarding the way the DMA-capability is initialized in
the kernel PCI subsystem. The real magic happens in the
bus->dma_configure() callback, which in case of the OF-based platform
parses the dma-ranges property of the parental OF-nodes in order to
get the dev->bus_dma_limit and dev->dma_range_map maps - the maps of
the CPU memory as seen by the PCIe devices. So in case of the direct
DMA mapping both dev->dma_range_map and dev->dma_mask get to be
important since the smallest non-zero value is taken as the upper
limit of the device DMA-capability (see the dma_capable() inliner
implementation). So to speak my worries were related with the
dev->dma_mask usage. Should some driver/PCI subsystem core
dereferences it taken from the PCI host bridge, the kernel will crash.
That's why I've added the dma_coerce_mask_and_coherent() method
invocation here in the first place.

> 
> > +	if (ret) {
> > +		ret = dma_set_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> > +						DMA_BIT_MASK(32));
> 

> Also the first instance of dma_set_mask_and_coherent() in dwc-based
> drivers, so double-checking here, too.

I can drop it if you insist so. (Please see my comment above.)

> 
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* These CSRs are in MMIO so we won't check the regmap-methods status */
> > +	btpci->sys_regs =
> > +		syscon_regmap_lookup_by_phandle(dev->of_node, "baikal,bt1-syscon");
> > +	if (IS_ERR(btpci->sys_regs))
> > +		return dev_err_probe(dev, PTR_ERR(btpci->sys_regs),
> > +				     "Failed to get syscon\n");
> > +
> > +	/* Make sure all the required resources have been specified */
> > +	for (i = 0; i < BT1_PCIE_NUM_APP_CLKS; i++) {
> > +		if (!btpci->dw.app_clks[bt1_pcie_app_clks[i]].clk) {
> > +			dev_err(dev, "App clocks set is incomplete\n");
> > +			return -ENOENT;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < BT1_PCIE_NUM_CORE_CLKS; i++) {
> > +		if (!btpci->dw.core_clks[bt1_pcie_core_clks[i]].clk) {
> > +			dev_err(dev, "Core clocks set is incomplete\n");
> > +			return -ENOENT;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < BT1_PCIE_NUM_APP_RSTS; i++) {
> > +		if (!btpci->dw.app_rsts[bt1_pcie_app_rsts[i]].rstc) {
> > +			dev_err(dev, "App resets set is incomplete\n");
> > +			return -ENOENT;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < BT1_PCIE_NUM_CORE_RSTS; i++) {
> > +		if (!btpci->dw.core_rsts[bt1_pcie_core_rsts[i]].rstc) {
> > +			dev_err(dev, "Core resets set is incomplete\n");
> > +			return -ENOENT;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +

> > +static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)
> 
> Can you name this something similar to what other drivers use?

For instance? (Please note, the link_stop/link_start callbacks are
defined as separate methods above.) The current names correctly describe
the methods logic. So I wouldn't want to fully change their names.

> 
> > +{
> > +	struct device *dev = btpci->dw.dev;
> > +	struct dw_pcie *pci = &btpci->dw;
> > +	int ret;
> > +
> > +	/* Disable LTSSM for sure */
> > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> > +
> > +	/*
> > +	 * Application reset controls are trigger-based so de-assert the core
> > +	 * resets only.
> > +	 */
> > +	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);
> > +	if (ret)
> > +		dev_err(dev, "Failed to assert core resets\n");
> > +
> > +	/*
> > +	 * Clocks are disabled by default at least in accordance with the clk
> > +	 * enable counter value on init stage.
> > +	 */
> > +	if (!init) {
> > +		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> > +
> > +		clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> > +	}
> > +
> > +	/* The peripheral devices are unavailable anyway so reset them too */
> > +	gpiod_set_value_cansleep(pci->pe_rst, 1);
> > +
> > +	/* Make sure the reset is settled */
> > +	usleep_range(1, 10);
> 

> Is this duration related to something in the PCIe spec?  Or the DWC
> spec? 

No. These durations are the chip-specific. Partly due to them being
specific for each SoC we can't implement a generic bus reset
procedure.

> I'd really like to use named constants when possible, although
> we have a ton of bare magic numbers currently.
> 
> Similar for the poll timeouts and the "state settled" sleep below.

I don't really see much need in this parametrization since these
numbers are used only once in the platform driver and their
application is easily inferable from the code context.

> 
> > +}
> > +
> > +/*
> > + * Implements the cold reset procedure in accordance with the reference manual
> > + * and available PM signals.
> > + */
> > +static int bt1_pcie_cold_start_bus(struct bt1_pcie *btpci)
> > +{
> > +	struct device *dev = btpci->dw.dev;
> > +	struct dw_pcie *pci = &btpci->dw;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* First get out of the Power/Hot reset state */
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert PHY reset\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert hot reset\n");
> > +		goto err_assert_pwr_rst;
> > +	}
> > +
> > +	/* Wait for the PM-core to stop requesting the PHY reset */
> > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> > +				       !(val & BT1_CCU_PCIE_REQ_PHY_RST), 1, 1000);
> > +	if (ret) {
> > +		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");
> > +		goto err_assert_hot_rst;
> > +	}
> > +
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert PHY reset\n");
> > +		goto err_assert_hot_rst;
> > +	}
> > +
> > +	/* Clocks can be now enabled, but the ref one is crucial at this stage */
> > +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable app clocks\n");
> > +		goto err_assert_phy_rst;
> > +	}
> > +
> > +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable ref clocks\n");
> > +		goto err_disable_app_clk;
> > +	}
> > +
> > +	/* Wait for the PM to stop requesting the controller core reset */
> > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> > +				       !(val & BT1_CCU_PCIE_REQ_CORE_RST), 1, 1000);
> > +	if (ret) {
> > +		dev_err(dev, "Timed out waiting for PM to stop core resetting\n");
> > +		goto err_disable_core_clk;
> > +	}
> > +
> > +	/* PCS-PIPE interface and controller core can be now activated */
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert PIPE reset\n");
> > +		goto err_disable_core_clk;
> > +	}
> > +
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert core reset\n");
> > +		goto err_assert_pipe_rst;
> > +	}
> > +
> > +	/* It's recommended to reset the core and application logic together */
> > +	ret = reset_control_bulk_reset(DW_PCIE_NUM_APP_RSTS, pci->app_rsts);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to reset app domain\n");
> > +		goto err_assert_core_rst;
> > +	}
> > +
> > +	/* Sticky/Non-sticky CSR flags can be now unreset too */
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert sticky reset\n");
> > +		goto err_assert_core_rst;
> > +	}
> > +
> > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_NON_STICKY_RST].rstc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to deassert non-sticky reset\n");
> > +		goto err_assert_sticky_rst;
> > +	}
> > +
> > +	/* Activate the PCIe bus peripheral devices */
> > +	gpiod_set_value_cansleep(pci->pe_rst, 0);
> > +
> > +	/* Make sure the state is settled (LTSSM is still disabled though) */
> > +	usleep_range(1, 10);
> > +
> > +	return 0;
> > +
> > +err_assert_sticky_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> > +
> > +err_assert_core_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> > +
> > +err_assert_pipe_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> > +
> > +err_disable_core_clk:
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> > +
> > +err_disable_app_clk:
> > +	clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> > +
> > +err_assert_phy_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> > +
> > +err_assert_hot_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> > +
> > +err_assert_pwr_rst:
> > +	reset_control_assert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +	int ret;
> > +
> > +	ret = bt1_pcie_get_res(btpci);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bt1_pcie_full_stop_bus(btpci, true);
> > +
> > +	return bt1_pcie_cold_start_bus(btpci);
> 

> Generally I think the get_res-type stuff happens elsewhere.  I'm not
> an expert in that, but this doesn't look much like other
> *_pcie_host_init() functions, which mainly deal with enabling clocks,
> reset assertion/deassertion, PHY init, interrupt enable, etc.
> 
> Maybe this is connected with your new common clocks/resets properties.
> I'm certainly in favor of making as much of that common as is
> practical!  I hope we can take advantage of that and make more
> consistency across the dwc-based drivers as well.

Right, the bt1_pcie_get_res() method is now makes sure that all the
clocks and resets have been requested since the generic resource
getter uses the optional-version of the clocks/resets request methods.

> 
> > +}
> > +
> > +static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +
> > +	bt1_pcie_full_stop_bus(btpci, false);
> > +}
> > +
> > +struct dw_pcie_host_ops bt1_pcie_host_ops = {
> > +	.host_init = bt1_pcie_host_init,
> > +	.host_deinit = bt1_pcie_host_deinit,
> > +};
> > +
> > +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> > +{
> > +	struct bt1_pcie *btpci;
> > +
> > +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> > +	if (!btpci)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	btpci->pdev = pdev;
> > +
> > +	platform_set_drvdata(pdev, btpci);
> > +
> > +	return btpci;
> 

> I don't think it's worth splitting this into a separate function.  I
> think it would be better to use the same structure as other dwc-based
> drivers and keep this in bt1_pcie_probe().

Sorry, I disagree in this matter. Generally I don't like the most of
the probe methods designed in the kernel well because after evolving
in time they get to be a mess if incoherent initializations,
allocations, requests, etc. Splitting it up into a set of smaller
coherent methods makes the code much clearer.

> 
> > +}
> > +
> > +static int bt1_pcie_add_dw_port(struct bt1_pcie *btpci)
> 

> All other dwc-based drivers call dw_pcie_host_init() from either
> *_pcie_probe() or *_add_pcie_port().  Please use a similar convention.

Not entirely. Tegra is an exception. So as before I don't think there
is a real convention. Most likely it's a result of a lucky coincident.
Moreover I don't really like such naming. Something like
VENDOR_pcie_add_root_port() would be much better.

Anyway since changing it to a more suitable naming would be too tiresome,
I'll change the name as you request.

> 
> > +{
> > +	struct device *dev = &btpci->pdev->dev;
> > +	int ret;
> > +

> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> 
> Why do you need this when no other dwc-based drivers do?  Is Baikal-T1
> different in this respect?

It's because eDMA engine embedded into the DW PCIe root port. Please
see my patchset:
Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/
and the next particular patch of that series:
Link: https://lore.kernel.org/linux-pci/20220610091459.17612-23-Sergey.Semin@baikalelectronics.ru/

The PCIe peripheral device drivers may wish to use eDMA embedded into
the Root Port. In that case they can use the
dmaengine_get_dma_device() method to get the core device of the
DMA-engine for the memory mapping. That device must have the
DMA-parameters properly configured in order for the DMA mapping
effectively working. In case of the Local eDMA platform setup (eDMA
embedded into the Root Port/Endpoint and accessible from the
CPU/Application side) the DMA-parameters are copied (see the patch
I've listed above) from the platform device. That's why I need the
dma_set_mask_and_coherent() method invocation here. Should I omit it
dma_mask will be left of 32-bits wide and SWIOTLB will be used in
order to reach the memory above 4G.

Please note we can't use dma_set_mask_and_coherent() in the generic
part of the DW PCIe driver since the DMA capability and the
eDMA-accessible memory region is the platform specific settings. So by
default all the eDMA-capable DW PCIe drivers will be left with the
eDMA engine working with the 4GB memory only.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	btpci->dw.version = DW_PCIE_VER_460A;
> > +	btpci->dw.dev = dev;
> > +	btpci->dw.ops = &bt1_pcie_dw_ops;
> > +
> > +	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> > +	btpci->dw.pp.ops = &bt1_pcie_host_ops;
> > +
> > +	dw_pcie_cap_set(&btpci->dw, REQ_RES);
> > +
> > +	ret = dw_pcie_host_init(&btpci->dw.pp);
> > +	if (ret)
> > +		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static void bt1_pcie_del_dw_port(struct bt1_pcie *btpci)
> 

> Can you call dw_pcie_host_deinit() from the same place as other
> drivers?
> 
>   $ git grep -p dw_pcie_host_deinit drivers/pci/controller/dwc

Sorry I'd rather leave it as is. There are only four drivers using
it and one of them don't follow what seems like a convention. I'd
rather have my driver code coherent:
bt1_pcie_add_pcie_port() is used to add the DW PCIe Root Port.
and
bt1_pcie_del_pcie_port() is used to remove the DW PCIe Root Port

-Sergey.

> 
> > +{
> > +	dw_pcie_host_deinit(&btpci->dw.pp);
> > +}
> > +
> > +static int bt1_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct bt1_pcie *btpci;
> > +
> > +	btpci = bt1_pcie_create_data(pdev);
> > +	if (IS_ERR(btpci))
> > +		return PTR_ERR(btpci);
> > +
> > +	return bt1_pcie_add_dw_port(btpci);
> > +}
> > +
> > +static int bt1_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> > +
> > +	bt1_pcie_del_dw_port(btpci);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id bt1_pcie_of_match[] = {
> > +	{ .compatible = "baikal,bt1-pcie" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> > +
> > +static struct platform_driver bt1_pcie_driver = {
> > +	.probe = bt1_pcie_probe,
> > +	.remove = bt1_pcie_remove,
> > +	.driver = {
> > +		.name	= "bt1-pcie",
> > +		.of_match_table = bt1_pcie_of_match,
> > +	},
> > +};
> > +module_platform_driver(bt1_pcie_driver);
> > +
> > +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> > +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.35.1
> > 

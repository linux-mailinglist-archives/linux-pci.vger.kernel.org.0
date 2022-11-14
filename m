Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149C6287F7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 19:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiKNSMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 13:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiKNSMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 13:12:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCA240A6;
        Mon, 14 Nov 2022 10:12:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FDB4B81107;
        Mon, 14 Nov 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBE7C433D6;
        Mon, 14 Nov 2022 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668449531;
        bh=qh0gRgbQK79Hf0/8eiwdHvs3TEjJaV+eZ/ALB3DJmNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/pnUWGxqLbDGd4kLE+5z4D1Xdd7BRZuK5eswGrZNk6uFN8awRjWPhK6LNOUAVnvs
         S7E8FaneYsIPfnS/4ilXz08Jofmj4TeSwpBZGLGt3+OjXG00pM2PjKs5y51pF1wdAr
         nzr8PjoX4D3BQVp34Dt5+7JqYNnhtxFVzvhUmo5rfKZR5VIRvV0BNA7CnG9bcdJOP+
         wmM0hkPSWyggp9zoqwl+VgSM1Y7bnFmMr1Iww6rbptz8tICic5ETKnW5ZKDAcmi50A
         sQfVtBQqje8O1717FrigTpAA01q9f+M/mJM2Cb4nrMm60jY4ZNY81YRoGH81ONVIPy
         aVh5vR7XlZu/w==
Date:   Mon, 14 Nov 2022 23:41:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20221114181155.GD5305@thinkpad>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-21-Sergey.Semin@baikalelectronics.ru>
 <20221114073135.GH3869@thinkpad>
 <20221114112059.vmfidrpawddvyvgl@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114112059.vmfidrpawddvyvgl@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 02:20:59PM +0300, Serge Semin wrote:
> On Mon, Nov 14, 2022 at 01:01:35PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Nov 13, 2022 at 10:13:01PM +0300, Serge Semin wrote:
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
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v2:
> > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > 
> > > Changelog v3:
> > > - Use the clocks/resets handlers defined in the DW PCIe core descriptor.
> > >   (@Rob)
> > > - Redefine PCI host bridge config space accessors with the generic
> > >   pci_generic_config_read32() and pci_generic_config_write32() methods.
> > >   (@Rob)
> > > 
> > > Changelog v4:
> > > - Drop PCIBIOS_* macros usage. (@Rob)
> > > - Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
> > >   instances. (@Bjorn)
> > > - Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
> > > - Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
> > > - Use start_link/stop_link suffixes in the corresponding callbacks.
> > >   (@Bjorn)
> > > - Change the get_res() method suffix to being get_resources(). (@Bjorn)
> > > - Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
> > > - Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
> > >   kernel device instance. (@Bjorn)
> > > - Add the comment above the dma_set_mask_and_coherent() method usage
> > >   regarding the controller eDMA feature. (@Bjorn)
> > > - Fix the comment above the core reset controls assertion. (@Bjorn)
> > > - Replace delays and timeout numeric literals with macros. (@Bjorn)
> > > 
> > > Changelog v6:
> > > - Move the DMA-mask setup to the eDMA driver. (@Robin)
> > > 
> > > Changelog v7:
> > > - Replace if-then-dev_err_probe-return statement with just
> > > return-dev_err_probe one.
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig    |   9 +
> > >  drivers/pci/controller/dwc/Makefile   |   1 +
> > >  drivers/pci/controller/dwc/pcie-bt1.c | 643 ++++++++++++++++++++++++++
> > >  3 files changed, 653 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 62ce3abf0f19..771b8b146623 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -222,6 +222,15 @@ config PCIE_ARTPEC6_EP
> > >  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
> > >  	  endpoint mode. This uses the DesignWare core.
> > >  
> > > +config PCIE_BT1
> > > +	tristate "Baikal-T1 PCIe controller"
> > 
> 
> > Wondering why cannot this be "PCIE_BAIKAL"? Are you sure that this same driver
> > cannot be reused for other Baikal SoCs in future?
> 
> Well, there are at least two SoCs: Baikal-M1 and Baikal-S1, which
> comprise the Synopsys DW PCIe Host IP-core on boards. But both of them
> have different versions of the controller (4.70a and 5.40a, meanwhile
> Baikal-T1 has 4.60a) and the clocks/reset/link
> enable/disable/establish procedures are also different. So I have much
> doubt we should be adding a support for all of them in a single driver
> because the only common part for them most likely will be just the
> probe and remove methods.) Thus having a generic driver name in the
> kernel will cause a confusion (or will require so submit a pre-requisite
> config/driver renaming patch) should we decide to submit the drivers
> for the new controllers.
> 

Most of the PCIe IPs out there have a single driver for a family/manufacturer.
Unless the IP changes drastically (like a different core), we add a separate
driver for that.

If you look at the Qcom driver, we have clubbed the support for dozens of SoCs
that differ by clock/resets/link and each will be identified by a separate
devicetree compatible. Here all the SoCs have synopsys based IP but only their
resources are different, so grouping them together in a single driver makes
sense.

> > 
> > > +	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> > > +	depends on PCI_MSI_IRQ_DOMAIN
> > > +	select PCIE_DW_HOST
> > > +	help
> > > +	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> > > +	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> > > +
> > >  config PCIE_ROCKCHIP_DW_HOST
> > >  	bool "Rockchip DesignWare PCIe controller"
> > >  	select PCIE_DW
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index 8ba7b67f5e50..bf5c311875a1 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> > >  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> > >  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> > >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> > > +obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> > >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> > >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > > diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> > > new file mode 100644
> > > index 000000000000..3346770e6654
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > > @@ -0,0 +1,643 @@

[...]

> > > +/*
> > > + * Baikal-T1 MMIO space must be read/written by the dword-aligned
> > > + * instructions. Note the methods are optimized to have the dword operations
> > > + * performed with minimum overhead as the most frequently used ones.
> > > + */
> > > +static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
> > > +{
> > > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > > +
> > > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > > +		return -EINVAL;
> > > +
> > > +	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
> > 
> 
> > Why can't you use the _relaxed variants?
> 
> As a part of a nitpick fix I could, but in this case I don't think
> it's very much necessary and IMO it still can be dangerous, since the
> IO-accessors utilization is hidden behind the wrapper, which then is
> used not only in the LLDD, but in the generic driver too. So depending
> on the DW PCIe core driver implementation the strong ordering might be
> required if not at the current stage, but in future. So I'd rather be on
> the safe side in this case especially seeing it won't give us much
> performance gain at runtime since the method is mainly used during the
> probe/initialization process.
> 

Well, I don't see any danger in making this as the relaxed version and that's
why asked. For the safe side of things, we could always use the non-relaxed
version everywhere ;)

> > 
> > > +	if (size == 4) {
> > > +		return 0;
> > > +	} else if (size == 2) {
> > > +		*val &= 0xffff;
> > > +		return 0;
> > > +	} else if (size == 1) {
> > > +		*val &= 0xff;
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > 
> > [...]
> > 
> > > +/*
> > > + * Implements the cold reset procedure in accordance with the reference manual
> > > + * and available PM signals.
> > > + */
> > > +static int bt1_pcie_cold_start_bus(struct bt1_pcie *btpci)
> > > +{
> > > +	struct device *dev = btpci->dw.dev;
> > > +	struct dw_pcie *pci = &btpci->dw;
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	/* First get out of the Power/Hot reset state */
> > > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to deassert PHY reset\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to deassert hot reset\n");
> > > +		goto err_assert_pwr_rst;
> > > +	}
> > > +
> > > +	/* Wait for the PM-core to stop requesting the PHY reset */
> > 
> 
> > What is PM core here? By first look I thought you are referring to Linux PM
> > core framework.
> 
> See the DW PCIe HW-manual. The IP-core has it's own PM-controller.
> 

Oh, I was not aware of that...

> > 
> > > +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> > > +				       !(val & BT1_CCU_PCIE_REQ_PHY_RST),
> > > +				       BT1_PCIE_REQ_DELAY_US, BT1_PCIE_REQ_TIMEOUT_US);
> > > +	if (ret) {
> > > +		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");
> > 
> > With relation to my above comment, this log might be confusing.
> 
> See above.

[...]

> > > +static const struct of_device_id bt1_pcie_of_match[] = {
> > > +	{ .compatible = "baikal,bt1-pcie" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> > > +
> > > +static struct platform_driver bt1_pcie_driver = {
> > > +	.probe = bt1_pcie_probe,
> > > +	.remove = bt1_pcie_remove,
> > > +	.driver = {
> > > +		.name	= "bt1-pcie",
> > > +		.of_match_table = bt1_pcie_of_match,
> > 
> 
> > You might also want to add PROBE_ASYNCHRONOUS flag to allow parallel probing of
> > drivers while the dwc core waits for PHY link to be up in dw_pcie_wait_for_link().
> 
> Thanks for reminding me about that flag (though it's
> PROBE_PREFER_ASYNCHRONOUS).

Ah, yes!

> I was thinking to add it after getting
> read the Rob' comment here
> https://patchwork.kernel.org/project/linux-pci/patch/20220913101237.4337-1-vidyas@nvidia.com/#25035943
> But then successfully forgot about it. It works well on our platform
> and even saves us of 0.5 seconds of the bootup time if no device is
> attached to the PCIe controller. No kidding, it's indeed good
> suggestion since the whole bootup time is of about 3 seconds. So we'll
> be able to reduce it for about 13%. I'll provide this update on v8.
> 

Cool!

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani 
> > 
> > > +	},
> > > +};
> > > +module_platform_driver(bt1_pcie_driver);
> > > +
> > > +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> > > +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.38.1
> > > 
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

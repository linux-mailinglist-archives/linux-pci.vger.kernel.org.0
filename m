Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6376287CA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiKNSEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 13:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiKNSDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 13:03:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126C82B622;
        Mon, 14 Nov 2022 10:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73FB0B8107E;
        Mon, 14 Nov 2022 18:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BABC433D7;
        Mon, 14 Nov 2022 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668448924;
        bh=WprjM543i7GuzvRawzwImksjZFno/T5c11rRzQwvdN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ufxdo9ZC0XbnM1xLOLuwupjOaKv/wn9KPbldhQSLzjCYN6jjiMkHq1LfD4NUG0LJN
         7Ylj3PIj68cKRaD+wrxBfQ0cy0h8uFK9RAOCheSR/aCJCc/JfGKYiIK4dneAjQPb3F
         n4futn2ACU2MRErO4roUgoXFAHgOQwoQR0ZqzbCWWE4qQITAIythPpQ/dRkWMk+JMU
         XUIuGw8PIkClNFd7+o7k9H9bEAJ3mL7CpLltYsTSG9Z7a5DgxT0AVtz8acNv5MCRa1
         iRQnaX71urjtPSqK8wQD4Kte2BrjTDrCiYM5ig6DacS9a4HDw/NUXNBU4oZ3b5H+8W
         SVitR4CfJrBKQ==
Date:   Mon, 14 Nov 2022 23:31:48 +0530
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
Subject: Re: [PATCH v7 19/20] PCI: dwc: Introduce generic platform clocks and
 resets
Message-ID: <20221114180148.GC5305@thinkpad>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-20-Sergey.Semin@baikalelectronics.ru>
 <20221114070115.GG3869@thinkpad>
 <20221114093759.kyxdb4ijfvm4bytk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114093759.kyxdb4ijfvm4bytk@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 12:37:59PM +0300, Serge Semin wrote:
> On Mon, Nov 14, 2022 at 12:31:15PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Nov 13, 2022 at 10:13:00PM +0300, Serge Semin wrote:
> > > Currently almost each platform driver uses its own resets and clocks
> > > naming in order to get the corresponding descriptors. It makes the code
> > > harder to maintain and comprehend especially seeing the DWC PCIe core main
> > > resets and clocks signals set hasn't changed much for about at least one
> > > major IP-core release. So in order to organize things around these signals
> > > we suggest to create a generic interface for them in accordance with the
> > > naming introduced in the DWC PCIe IP-core reference manual:
> > > 
> > > Application clocks:
> > > - "dbi"  - data bus interface clock (on some DWC PCIe platforms it's
> > >            referred as "pclk", "pcie", "sys", "ahb", "cfg", "iface",
> > >            "gio", "reg", "pcie_apb_sys");
> > > - "mstr" - AXI-bus master interface clock (some DWC PCIe glue drivers
> > >            refer to this clock as "port", "bus", "pcie_bus",
> > >            "bus_master/master_bus/axi_m", "pcie_aclk");
> > > - "slv"  - AXI-bus slave interface clock (also called as "port", "bus",
> > >            "pcie_bus", "bus_slave/slave_bus/axi_s", "pcie_aclk",
> > >            "pcie_inbound_axi").
> > > 
> > > Core clocks:
> > > - "pipe" - core-PCS PIPE interface clock coming from external PHY (it's
> > >            normally named by the platform drivers as just "pipe");
> > > - "core" - primary clock of the controller (none of the platform drivers
> > >            declare such a clock but in accordance with the ref. manual
> > >            the devices may have it separately specified);
> > > - "aux"  - auxiliary PMC domain clock (it is named by some platforms as
> > >            "pcie_aux" and just "aux");
> > > - "ref"  - Generic reference clock (it is a generic clock source, which
> > >            can be used as a signal source for multiple interfaces, some
> > >            platforms call it as "ref", "general", "pcie_phy",
> > >            "pcie_phy_ref").
> > > 
> > > Application resets:
> > > - "dbi"  - Data-bus interface reset (it's CSR interface clock and is
> > >            normally called as "apb" though technically it's not APB but
> > >            DWC PCIe-specific interface);
> > > - "mstr" - AXI-bus master reset (some platforms call it as "port", "apps",
> > >            "bus", "axi_m");
> > > - "slv"  - ABI-bus slave reset (some platforms call it as "port", "apps",
> > >            "bus", "axi_s").
> > > 
> > > Core resets:
> > > - "non-sticky" - non-sticky CSR flags reset;
> > > - "sticky"     - sticky CSR flags reset;
> > > - "pipe"       - PIPE-interface (Core-PCS) logic reset (some platforms
> > >                  call it just "pipe");
> > > - "core"       - controller primary reset (resets everything except PMC
> > >                  module, some platforms refer to this signal as "soft",
> > >                  "pci");
> > > - "phy"        - PCS/PHY block reset (strictly speaking it is normally
> > >                  connected to the input of an external block, but the
> > >                  reference manual says it must be available for the PMC
> > >                  working correctly, some existing platforms call it
> > >                  "pciephy", "phy", "link");
> > > - "hot"        - PMC hot reset signal (also called as "sleep");
> > > - "pwr"        - cold reset signal (can be referred as "pwr", "turnoff").
> > > 
> > > Bus reset:
> > > - "perst" - PCIe standard signal used to reset the PCIe peripheral
> > >             devices.
> > > 
> > > As you can see each platform uses it's own naming for basically the same
> > > set of the signals. In the framework of this commit we suggest to add a
> > > set of the clocks and reset signals resources, corresponding names and
> > > identifiers for each denoted entity. At current stage the platforms will
> > > be able to use the provided infrastructure to automatically request all
> > > these resources and manipulate with them in the Host/EP init callbacks.
> > > Alas it isn't that easy to create a common cold/hot reset procedure due to
> > > too many platform-specifics in the procedure, like the external flags
> > > exposure and the delays requirement.
> > > 
> > 
> 
> > I'm not really sure if this generification is going to help. For instance, in
> > Qcom platforms we have some required clocks and some optional clocks and that
> > too differs with each SoC. For sure you can add logic in the core dwc driver to
> > handle those cases but that starting to do that will add a pile of mess to the
> > dwc driver.
> 
> It will help to place the order to the clock and reset naming, which
> in its turn will improve the driver readability and maintainability.
> Almost all the platforms get/check clocks and resets from the
> same set defined in the DW PCIe HW-manual (including the Qcom ones).
> The difference just in the names the developers used. Since the names
> is a contract (a part of the DT-bindings) which can't be changed that
> easy, we can't just update the already available drivers. But at the
> very least we can unify the DT-bindings and the resources names
> defined in there (which is already done and acked by Rob), provide a
> generic driver API and persuade the new drivers developers to be using
> the interface with already available names.
> 
> As I already said many times for the last year. The clocks are mainly
> the same, but the way they are used to enable the interfaces (timings,
> order, etc) can be platform-specific. It's possible for the
> HW-designers in the framework of their platforms to re-use a
> clocks/resets generation module provided by Synopsys, but even
> Synopsys says that it's not always applicable. So practically the
> platform-designers prefer to omit the module and provide a direct
> control to the clocks and resets wires. Our platform is another
> example of such approach.
> 
> Note you are still able to check whether the corresponding
> clocks/resets are available for your device just by checking the
> pointers.
> 
> > 
> > IMO, if the dwc driver is not going to use these clocks, like controlling the
> > clocks/resets, then there is no point in keeping the resource acquiring part in
> > it.
> 
> Baikal-T1 will use these clocks and resets. The generic DWC PCIe
> Host/EP driver will provide a simple and ready-to-use API to request
> and check the clocks and resets. The new drivers will supposed to use
> it too. Thus eventually we'll get at least the modern drivers using
> the same names which will make the DW PCIe driver more readable and
> maintainable. Meanwhile the old drivers alas will have to be left
> with their platform-specific names since we can't change the
> DT-bindings.
> 
> In anyway all of these has already been discussed with Rob. Here is
> what he said:
> 
> On Mon, May 16, 2022 at 05:29:20PM -0500, Rob Herring wrote:
> > No doubt there is way to much variation here (ummm, Qcom!). Some 
> > standardization of names in (new) bindings would be good. That's where 
> > we should be defining names IMO.
> 
> > On the driver side, I'd like to see the DW core handle clocks/resets/phys 
> > at least for the easy cases of just turn on/off all the clocks and 
> > toggle all resets. Perhaps even more minimally, move the clk/reset 
> > struct pointers to the DWC core.
> 
> Due to the platform-specific order and timings I don't think it's
> possible to create some generic clocks/resets enable/disable method.
> It could be done, but it will be too complex with many-platform specific
> hooks, callbacks, flags, etc. I even can't think of such interface
> even for already available drivers, not to say for some future designs.
> But the names and the handlers storage could be unified for sure.
> 
> Note eventually, if anybody would be concerned about a full
> unification, the already available drivers could be converted to using
> the provided here API just on the level of the clock/reset IDs, but
> the names will have to be left as is alas.
> 
> Also note my very first version of this patch provided just the clocks
> and reset names and their IDs without the corresponding resource
> request. Rob suggested to at least provide a generic request
> procedure. That's what I did in one of the subsequent patchset
> revisions.
> 

Okay then. I failed to go through the previous discussions, sorry about that.

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v3:
> > > - Add a method to at least request the generic clocks and resets. (@Rob)
> > > - Add GPIO-based PERST# signal support.
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 91 ++++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h | 42 +++++++++
> > >  2 files changed, 133 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index d31f9d41d5cb..1e06ccf2dc9e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -10,7 +10,9 @@
> > >  
> > >  #include <linux/align.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/ioport.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_platform.h>
> > > @@ -20,11 +22,89 @@
> > >  #include "../../pci.h"
> > >  #include "pcie-designware.h"
> > >  
> > > +static const char * const dw_pcie_app_clks[DW_PCIE_NUM_APP_CLKS] = {
> > > +	[DW_PCIE_DBI_CLK] = "dbi",
> > > +	[DW_PCIE_MSTR_CLK] = "mstr",
> > > +	[DW_PCIE_SLV_CLK] = "slv",
> > > +};
> > > +
> > > +static const char * const dw_pcie_core_clks[DW_PCIE_NUM_CORE_CLKS] = {
> > > +	[DW_PCIE_PIPE_CLK] = "pipe",
> > > +	[DW_PCIE_CORE_CLK] = "core",
> > > +	[DW_PCIE_AUX_CLK] = "aux",
> > > +	[DW_PCIE_REF_CLK] = "ref",
> > > +};
> > > +
> > > +static const char * const dw_pcie_app_rsts[DW_PCIE_NUM_APP_RSTS] = {
> > > +	[DW_PCIE_DBI_RST] = "dbi",
> > > +	[DW_PCIE_MSTR_RST] = "mstr",
> > > +	[DW_PCIE_SLV_RST] = "slv",
> > > +};
> > > +
> > > +static const char * const dw_pcie_core_rsts[DW_PCIE_NUM_CORE_RSTS] = {
> > > +	[DW_PCIE_NON_STICKY_RST] = "non-sticky",
> > > +	[DW_PCIE_STICKY_RST] = "sticky",
> > > +	[DW_PCIE_CORE_RST] = "core",
> > > +	[DW_PCIE_PIPE_RST] = "pipe",
> > > +	[DW_PCIE_PHY_RST] = "phy",
> > > +	[DW_PCIE_HOT_RST] = "hot",
> > > +	[DW_PCIE_PWR_RST] = "pwr",
> > > +};
> > > +
> > > +static int dw_pcie_get_clocks(struct dw_pcie *pci)
> > > +{
> > > +	int i, ret;
> > > +
> > > +	for (i = 0; i < DW_PCIE_NUM_APP_CLKS; i++)
> > > +		pci->app_clks[i].id = dw_pcie_app_clks[i];
> > > +
> > > +	for (i = 0; i < DW_PCIE_NUM_CORE_CLKS; i++)
> > > +		pci->core_clks[i].id = dw_pcie_core_clks[i];
> > > +
> > > +	ret = devm_clk_bulk_get_optional(pci->dev, DW_PCIE_NUM_APP_CLKS,
> > > +					 pci->app_clks);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return devm_clk_bulk_get_optional(pci->dev, DW_PCIE_NUM_CORE_CLKS,
> > > +					  pci->core_clks);
> > > +}
> > > +
> > > +static int dw_pcie_get_resets(struct dw_pcie *pci)
> > > +{
> > > +	int i, ret;
> > > +
> > > +	for (i = 0; i < DW_PCIE_NUM_APP_RSTS; i++)
> > > +		pci->app_rsts[i].id = dw_pcie_app_rsts[i];
> > > +
> > > +	for (i = 0; i < DW_PCIE_NUM_CORE_RSTS; i++)
> > > +		pci->core_rsts[i].id = dw_pcie_core_rsts[i];
> > > +
> > > +	ret = devm_reset_control_bulk_get_optional_shared(pci->dev,
> > > +							  DW_PCIE_NUM_APP_RSTS,
> > > +							  pci->app_rsts);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_reset_control_bulk_get_optional_exclusive(pci->dev,
> > > +							     DW_PCIE_NUM_CORE_RSTS,
> > > +							     pci->core_rsts);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pci->pe_rst = devm_gpiod_get_optional(pci->dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(pci->pe_rst))
> > > +		return PTR_ERR(pci->pe_rst);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  int dw_pcie_get_resources(struct dw_pcie *pci)
> > >  {
> > >  	struct platform_device *pdev = to_platform_device(pci->dev);
> > >  	struct device_node *np = dev_of_node(pci->dev);
> > >  	struct resource *res;
> > > +	int ret;
> > >  
> > >  	if (!pci->dbi_base) {
> > >  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> > > @@ -62,6 +142,17 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > >  	if (!pci->atu_size)
> > >  		pci->atu_size = SZ_4K;
> > >  
> > > +	/* LLDD is supposed to manually switch the clocks and resets state */
> > > +	if (dw_pcie_cap_is(pci, REQ_RES)) {
> > > +		ret = dw_pcie_get_clocks(pci);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = dw_pcie_get_resets(pci);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	if (pci->link_gen < 1)
> > >  		pci->link_gen = of_pci_get_max_link_speed(np);
> > >  
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 081f169e6021..393dfb931df6 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -13,10 +13,13 @@
> > >  
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > >  #include <linux/dma-mapping.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/reset.h>
> > >  
> > >  #include <linux/pci-epc.h>
> > >  #include <linux/pci-epf.h>
> > > @@ -45,6 +48,7 @@
> > >  	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
> > >  
> > >  /* DWC PCIe controller capabilities */
> > > +#define DW_PCIE_CAP_REQ_RES		0
> > >  #define DW_PCIE_CAP_IATU_UNROLL		1
> > >  #define DW_PCIE_CAP_CDM_CHECK		2
> > >  
> > > @@ -233,6 +237,39 @@ enum dw_pcie_device_mode {
> > >  	DW_PCIE_RC_TYPE,
> > >  };
> > >  
> > > +enum dw_pcie_app_clk {
> > > +	DW_PCIE_DBI_CLK,
> > > +	DW_PCIE_MSTR_CLK,
> > > +	DW_PCIE_SLV_CLK,
> > > +	DW_PCIE_NUM_APP_CLKS
> > > +};
> > > +
> > > +enum dw_pcie_core_clk {
> > > +	DW_PCIE_PIPE_CLK,
> > > +	DW_PCIE_CORE_CLK,
> > > +	DW_PCIE_AUX_CLK,
> > > +	DW_PCIE_REF_CLK,
> > > +	DW_PCIE_NUM_CORE_CLKS
> > > +};
> > > +
> > > +enum dw_pcie_app_rst {
> > > +	DW_PCIE_DBI_RST,
> > > +	DW_PCIE_MSTR_RST,
> > > +	DW_PCIE_SLV_RST,
> > > +	DW_PCIE_NUM_APP_RSTS
> > > +};
> > > +
> > > +enum dw_pcie_core_rst {
> > > +	DW_PCIE_NON_STICKY_RST,
> > > +	DW_PCIE_STICKY_RST,
> > > +	DW_PCIE_CORE_RST,
> > > +	DW_PCIE_PIPE_RST,
> > > +	DW_PCIE_PHY_RST,
> > > +	DW_PCIE_HOT_RST,
> > > +	DW_PCIE_PWR_RST,
> > > +	DW_PCIE_NUM_CORE_RSTS
> > > +};
> > > +
> > >  struct dw_pcie_host_ops {
> > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > @@ -332,6 +369,11 @@ struct dw_pcie {
> > >  	int			num_lanes;
> > >  	int			link_gen;
> > >  	u8			n_fts[2];
> > > +	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
> > > +	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
> > > +	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> > > +	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> > > +	struct gpio_desc		*pe_rst;
> > >  };
> > >  
> > >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> > > -- 
> > > 2.38.1
> > > 
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

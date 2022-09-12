Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1219B5B522E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiILAUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 20:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiILAUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 20:20:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58241C106;
        Sun, 11 Sep 2022 17:20:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s10so8107168ljp.5;
        Sun, 11 Sep 2022 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vhTpDu/aUmKaN2qAXIVmjxPjx/AwoLdd4DmpWhyn7Y0=;
        b=NsZnGJh3mGbFQhu/6RdC4n4Y8+ykc3D7UxPjqrL+CtCpa5Ivv8zCf6RtGiW/GOqTke
         8f05bsMGFqmsEfiJeyClpMRGqHqparTZQgsONL2wx84yQ5wbUUieJQ273BYvQodoxyaa
         dRBHBg9HoLsqBC6j9EvBOwjdcmeZJsahVvC/LcK0uONTLvkNlreqsgN3j6MskBkp+6vY
         zd9xRNYmeeF8sBsbgXbA9BO75Zpi+dfI1mja3LgP/r99DH13P/VrenIwJyJXb506SNOX
         ZTvRax/sMmpSysxTOZH6zW8BoSichCwPnA5aTMIUkOOlEIxMeIOXz8b7rFiuYJnVPmLc
         89jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vhTpDu/aUmKaN2qAXIVmjxPjx/AwoLdd4DmpWhyn7Y0=;
        b=VdrnDxamIi2lkwy30aeXn8yud5Q06MVPQXDAQ95AbrorQUIFyNWz9BgOzCO2Xsq1DX
         HaMsZ4CihBzGejecHeT5fdia6A4nvIebJQIVotU0/slwnfd5yiicfXiukULH4tRtSX81
         KJ5G6b7Uy1pvWtu2XElUKBrmS5SLYydet5ZsgGV8WjGTFPFRPmsm0XrgLRG4ZXx/RwCZ
         XUgL85UphxokL5woZzv7VHS2ZqH55Aa4nBpe8Mw2mFsOirmq1c6qclrNpxhPyRNsF4qR
         RYqcfGxn30yJYIlhFs71CR1Ix6UI69AKNZXGF247q2nN/vwgxYiVMOzvlnVqmiXgye5X
         JdIA==
X-Gm-Message-State: ACgBeo3HHogAJ3C5iSRB3XApR28M2ploeY12b0bOVGqzMtD75U4ssZIf
        yA4gWxJ+B1jj3Td0UO92ULw=
X-Google-Smtp-Source: AA6agR5bpumjtvQUS2gJEPKuKRYtWVkEJ48erAhvDFPqGr3csz/zAd/2akZ45XUgvmOVMB1AsGbjIQ==
X-Received: by 2002:a05:651c:211:b0:26b:e743:b4b0 with SMTP id y17-20020a05651c021100b0026be743b4b0mr3853072ljn.527.1662942040943;
        Sun, 11 Sep 2022 17:20:40 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e28-20020a19501c000000b0048cf7e8145asm766642lfb.117.2022.09.11.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:20:40 -0700 (PDT)
Date:   Mon, 12 Sep 2022 03:20:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     William McVicker <willmcvicker@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220912002038.clxh25itw73dqrhs@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <Ywz4KEkJwrE4yDBe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywz4KEkJwrE4yDBe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 05:32:24PM +0000, William McVicker wrote:
> On 08/29/2022, Lorenzo Pieralisi wrote:
> > [+Robin, Will - please jump to DMA mask set-up]
> > 
> > On Mon, Aug 22, 2022 at 09:47:01PM +0300, Serge Semin wrote:
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
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig    |   9 +
> > >  drivers/pci/controller/dwc/Makefile   |   1 +
> > >  drivers/pci/controller/dwc/pcie-bt1.c | 653 ++++++++++++++++++++++++++
> > >  3 files changed, 663 insertions(+)
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
> > > index 000000000000..86b230575ddc
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > > @@ -0,0 +1,653 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > > + *
> > > + * Authors:
> > > + *   Vadim Vlasov <Vadim.Vlasov@baikalelectronics.ru>
> > > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > + *
> > > + * Baikal-T1 PCIe controller driver
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +
> > > +/* Baikal-T1 System CCU control registers */
> > > +#define BT1_CCU_PCIE_CLKC			0x140
> > > +#define BT1_CCU_PCIE_REQ_PCS_CLK		BIT(16)
> > > +#define BT1_CCU_PCIE_REQ_MAC_CLK		BIT(17)
> > > +#define BT1_CCU_PCIE_REQ_PIPE_CLK		BIT(18)
> > > +
> > > +#define BT1_CCU_PCIE_RSTC			0x144
> > > +#define BT1_CCU_PCIE_REQ_LINK_RST		BIT(13)
> > > +#define BT1_CCU_PCIE_REQ_SMLH_RST		BIT(14)
> > > +#define BT1_CCU_PCIE_REQ_PHY_RST		BIT(16)
> > > +#define BT1_CCU_PCIE_REQ_CORE_RST		BIT(24)
> > > +#define BT1_CCU_PCIE_REQ_STICKY_RST		BIT(26)
> > > +#define BT1_CCU_PCIE_REQ_NSTICKY_RST		BIT(27)
> > > +
> > > +#define BT1_CCU_PCIE_PMSC			0x148
> > > +#define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
> > > +#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
> > > +#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
> > > +#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
> > > +#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
> > > +#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
> > > +#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
> > > +#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
> > > +#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
> > > +#define BT1_CCU_PCIE_LTSSM_L0			0x11
> > > +#define BT1_CCU_PCIE_LTSSM_L0S			0x12
> > > +#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
> > > +#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
> > > +#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
> > > +#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
> > > +#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
> > > +#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
> > > +#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
> > > +#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
> > > +#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
> > > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
> > > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
> > > +#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
> > > +#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
> > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
> > 
> > You could make this an enum and define only the states
> > that are actually used.
> > 
> > [...]
> > 
> > > +
> > > +/* Generic Baikal-T1 PCIe interface resources */
> > > +#define BT1_PCIE_NUM_APP_CLKS			ARRAY_SIZE(bt1_pcie_app_clks)
> > > +#define BT1_PCIE_NUM_CORE_CLKS			ARRAY_SIZE(bt1_pcie_core_clks)
> > > +#define BT1_PCIE_NUM_APP_RSTS			ARRAY_SIZE(bt1_pcie_app_rsts)
> > > +#define BT1_PCIE_NUM_CORE_RSTS			ARRAY_SIZE(bt1_pcie_core_rsts)
> > > +
> > > +/* PCIe bus setup delays and timeouts */
> > > +#define BT1_PCIE_RST_DELAY_MS			100
> > > +#define BT1_PCIE_RUN_DELAY_US			100
> > > +#define BT1_PCIE_REQ_DELAY_US			1
> > > +#define BT1_PCIE_REQ_TIMEOUT_US			1000
> > > +#define BT1_PCIE_LNK_DELAY_US			1000
> > > +#define BT1_PCIE_LNK_TIMEOUT_US			1000000
> > > +
> > > +static const enum dw_pcie_app_clk bt1_pcie_app_clks[] = {
> > > +	DW_PCIE_DBI_CLK, DW_PCIE_MSTR_CLK, DW_PCIE_SLV_CLK,
> > > +};
> > > +
> > > +static const enum dw_pcie_core_clk bt1_pcie_core_clks[] = {
> > > +	DW_PCIE_REF_CLK,
> > > +};
> > > +
> > > +static const enum dw_pcie_app_rst bt1_pcie_app_rsts[] = {
> > > +	DW_PCIE_MSTR_RST, DW_PCIE_SLV_RST,
> > > +};
> > > +
> > > +static const enum dw_pcie_core_rst bt1_pcie_core_rsts[] = {
> > > +	DW_PCIE_NON_STICKY_RST, DW_PCIE_STICKY_RST, DW_PCIE_CORE_RST,
> > > +	DW_PCIE_PIPE_RST, DW_PCIE_PHY_RST, DW_PCIE_HOT_RST, DW_PCIE_PWR_RST,
> > > +};
> > 
> > I wonder whether we could allocate the rst/clks in DWC dynamically,
> > by using these configuration arrays.
> > 
> > > +
> > > +struct bt1_pcie {
> > > +	struct dw_pcie dw;
> > > +	struct platform_device *pdev;
> > > +	struct regmap *sys_regs;
> > > +};
> > > +#define to_bt1_pcie(_dw) container_of(_dw, struct bt1_pcie, dw)
> > > +
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
> > Is it always safe to read more than requested ?
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
> > > +static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
> > > +{
> > > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > > +	u32 tmp, mask;
> > > +
> > > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > > +		return -EINVAL;
> > > +
> > > +	if (size == 4) {
> > > +		writel(val, addr);
> > > +		return 0;
> > > +	} else if (size == 2 || size == 1) {
> > > +		mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
> > > +		tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
> > > +		tmp |= (val & mask) << ofs * BITS_PER_BYTE;
> > > +		writel(tmp, addr - ofs);
> > > +		return 0;
> > > +	}
> > 
> > Same question read/modify/write, is it always safe to do it
> > regardless of size ?
> > 
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static u32 bt1_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > +			     size_t size)
> > > +{
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	ret = bt1_pcie_read_mmio(base + reg, size, &val);
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "Read DBI address failed\n");
> > > +		return ~0U;
> > 
> > Is this a special magic value the DWC core is expecting ?
> > 
> > Does it clash with a _valid_ return value ?
> > 
> > > +	}
> > > +
> > > +	return val;
> > > +}
> > > +
> > > +static void bt1_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > +			       size_t size, u32 val)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > > +	if (ret)
> > > +		dev_err(pci->dev, "Write DBI address failed\n");
> > > +}
> > > +
> > > +static void bt1_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > +				size_t size, u32 val)
> > > +{
> > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > +	int ret;
> > > +
> > > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > > +			   BT1_CCU_PCIE_DBI2_MODE, BT1_CCU_PCIE_DBI2_MODE);
> > > +
> > > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > > +	if (ret)
> > > +		dev_err(pci->dev, "Write DBI2 address failed\n");
> > > +
> > > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > > +			   BT1_CCU_PCIE_DBI2_MODE, 0);
> > 
> > IIUC the regmap_update_bits() set up decoding for DBI2. Hopefully the
> > DBI/DBI2 writes are sequentialized, this is a question valid also
> > for other DWC controllers.
> > 
> > What I want to say is, the regmap update in this function sets the
> > DWC HW in a way that can decode DBI2 (please correct me if I am wrong),
> > between the two _update_bits() no DBI access should happen because
> > it just would not work.
> > 
> > It is a question.
> > 
> > > +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > +	int ret;
> > > +
> > > +	ret = bt1_pcie_get_resources(btpci);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	bt1_pcie_full_stop_bus(btpci, true);
> > > +
> > > +	return bt1_pcie_cold_start_bus(btpci);
> > > +}
> > > +
> > > +static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > +
> > > +	bt1_pcie_full_stop_bus(btpci, false);
> > > +}
> > > +
> > > +static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
> > > +	.host_init = bt1_pcie_host_init,
> > > +	.host_deinit = bt1_pcie_host_deinit,
> > > +};
> > > +
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
> > > +}
> > > +
> > > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > > +{
> > > +	struct device *dev = &btpci->pdev->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * DW PCIe Root Port controller is equipped with eDMA capable of
> > > +	 * working with the 64-bit memory addresses.
> > > +	 */
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		return ret;
> > 
> > Is this the right place to set the DMA mask for the host controller
> > embedded DMA controller (actually, the dev pointer is the _host_
> > controller device) ?
> > 
> > How this is going to play when combined with:
> > 
> > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> > 
> > It is getting a bit confusing. I believe the code in the link
> > above sets the mask so that through the DMA API we are capable
> > of getting an MSI doorbell virtual address whose physical address
> > can be addressed by the endpoint; this through the DMA API.
> > 
> > This patch is setting the DMA mask for a different reason, namely
> > setting the host controller embedded DMA controller addressing
> > capabilities.
> > 
> > AFAICS - both approaches set the mask for the same device - now
> > the question is about which one is legitimate and how to handle
> > the other.
> 

> Since the mask is being set before calling dw_pcie_host_init() and the
> msi_host_init op is not set, setting the mask here won't have any affect due to
> the fact that dw_pcie_msi_host_init() unconditionally sets the DMA mask.

Good note. Indeed the dw_pcie_msi_host_init() method forces the device
DMA-mask being 32-bits. It's absolutely wrong. First the iMSI-RX
engine doesn't perform any DMA. Second the 32-bit mask set by default
anyway. Third that most likely causes significant performance drop (or
even the mapping failures) since the DMAs performed by the PCIe-bus
peripheral devices to the memory above 4GB will be bounced buffered to
the 4GB limit if SWIOTLB/CMA is enabled.

> AFAIK,
> you don't technically need a 64-bit address, right?

No. I actually need it. It's a DMA-engine after all.

> If your platform disables
> 32-bit allocations, then you'll need to set the MSI capabilities flag to
> support a 64-bit allocation for when the 32-bit allocation fails in the host
> controller driver.
> 
> Here is how I'm doing that with the Exynos PCIe driver during probe before
> calling dw_pcie_host_init():
> 
> 	dw_pcie_dbi_ro_wr_en(exynos_pcie->pci);
> 	offset = dw_pcie_find_capability(exynos_pcie->pci, PCI_CAP_ID_MSI);
> 	cap = dw_pcie_readw_dbi(exynos_pcie->pci, offset + PCI_MSI_FLAGS);
> 
> 	/* Enable MSI with 64-bit support */
> 	cap |= PCI_MSI_FLAGS_ENABLE | PCI_MSI_FLAGS_64BIT;
> 	dw_pcie_writew_dbi(exynos_pcie->pci, offset + PCI_MSI_FLAGS, cap);
> 	dw_pcie_dbi_ro_wr_dis(exynos_pcie->pci);

Don't really see how that helps to you. The native MSI capability
isn't used neither in the Exynos driver nor in the DW PCIe driver
core.

> 
> I hope that helps!

Thanks for the suggestion regarding the DMA-mask anyway.

-Sergey

> 
> Regards,
> Will
> 
> > 
> > > +
> > > +	btpci->dw.version = DW_PCIE_VER_460A;
> > > +	btpci->dw.dev = dev;
> > > +	btpci->dw.ops = &bt1_pcie_ops;
> > > +
> > > +	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> > > +	btpci->dw.pp.ops = &bt1_pcie_host_ops;
> > > +
> > > +	dw_pcie_cap_set(&btpci->dw, REQ_RES);
> > > +
> > > +	ret = dw_pcie_host_init(&btpci->dw.pp);
> > > +	if (ret)
> > > +		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void bt1_pcie_del_port(struct bt1_pcie *btpci)
> > > +{
> > > +	dw_pcie_host_deinit(&btpci->dw.pp);
> > > +}
> > > +
> > > +static int bt1_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct bt1_pcie *btpci;
> > > +
> > > +	btpci = bt1_pcie_create_data(pdev);
> > 
> > Do we really need a function for that ? I am not too
> > bothered but I think it is overkill.
> > 
> > Thanks,
> > Lorenzo
> > 
> > > +	if (IS_ERR(btpci))
> > > +		return PTR_ERR(btpci);
> > > +
> > > +	return bt1_pcie_add_port(btpci);
> > > +}
> > > +
> > > +static int bt1_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> > > +
> > > +	bt1_pcie_del_port(btpci);
> > > +
> > > +	return 0;
> > > +}
> > > +
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
> > > +	},
> > > +};
> > > +module_platform_driver(bt1_pcie_driver);
> > > +
> > > +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> > > +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.35.1
> > > 

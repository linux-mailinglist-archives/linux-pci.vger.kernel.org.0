Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8325B5222
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 02:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiILACZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 20:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiILACU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 20:02:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DA1F2E7;
        Sun, 11 Sep 2022 17:02:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so992892lfo.7;
        Sun, 11 Sep 2022 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FnFlkTgK1ZLP7Tax2YDP9EtGnvSs+6uINAlndTmCg5A=;
        b=VhW7OB/rYMyXCMy1AUIDUgGPEstRYLaGj1a+WbEjlyIuhY9lDOPSpqSLFsVRlThHDd
         Xvkjzwq+52n2kXrmoH5XoWr5vbPihUQ9Cd5jrsowFrM6sa6BbxFwfJId5cQlO1p4jc+V
         8vve9T1u0XpzI5Hivk9kjOwzKk/cv80xFQU1gh1vV9t9NOp0PbosRpsDMG8/rH9d+2Qv
         9gjcNkKK0Xf77V7JJvrGQXUZbA0MYBP7tMLmTND1vP6yTUkq4zqdnZmljJ+HTuttWac9
         fIIFumQSTYEaphj0iU0zHs8UahPem7Vp5Skl1E9jpxfihzRcWoTTRYuKJIkNg4pAFNiu
         HpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FnFlkTgK1ZLP7Tax2YDP9EtGnvSs+6uINAlndTmCg5A=;
        b=BBA5UgFuFX/5S+RIeEqiE4R6wSyitwcdPsgdkkS/t7zZ4CB8+JfToZNBZXuvuO/BIu
         SaATSAocA7G5vb5n7JxWqBwKVuwavoH1snJ33eD8q8xUBrlWTmtifC4PZJIipmGQJEkJ
         dSEBUg9gZNl+OUElqY1bIU1JO8QlG4dJDvuRlEUV5tMj2e/uMoXvYqdCCTKdKky9ZpBm
         ud28JdXm54dOh3SHexiH51J+kjza10lxI49msoUZBbKYhXNh8N1bBw6k7HpgvASWy5ML
         XJEZNY9VJhLxAkFifZSKja7fg6MxKp/d28WgY5a+mxGmLc+7TjqXm3ZsMk7eNUG7U5aJ
         lnrg==
X-Gm-Message-State: ACgBeo3tprgKc5uH77aLGuJjgV+KxpAcWA+DiIgJu4N8OUENpbmTsWHn
        BWdfVE/PxN4iUNsRyhn7fAA=
X-Google-Smtp-Source: AA6agR4YopcCBLaI1b4L0C4rVK7KYzDrfmJqN/eBlR8YTnk3rFia5pLGVUXLZsi7mYYJmmh+Hz7wdw==
X-Received: by 2002:a05:6512:32c9:b0:492:f53d:9c1 with SMTP id f9-20020a05651232c900b00492f53d09c1mr7771256lfg.127.1662940935368;
        Sun, 11 Sep 2022 17:02:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id du7-20020a056512298700b00498f67cbfa9sm770233lfb.22.2022.09.11.17.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:02:14 -0700 (PDT)
Date:   Mon, 12 Sep 2022 03:02:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        willmcvicker@google.com
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220912000211.ct6asuhhmnatje5e@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzbARMkb/69+l2d@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 05:28:01PM +0200, Lorenzo Pieralisi wrote:
> [+Robin, Will - please jump to DMA mask set-up]
> 
> On Mon, Aug 22, 2022 at 09:47:01PM +0300, Serge Semin wrote:
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
> > 
> > ---
> > 
> > Changelog v2:
> > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > 
> > Changelog v3:
> > - Use the clocks/resets handlers defined in the DW PCIe core descriptor.
> >   (@Rob)
> > - Redefine PCI host bridge config space accessors with the generic
> >   pci_generic_config_read32() and pci_generic_config_write32() methods.
> >   (@Rob)
> > 
> > Changelog v4:
> > - Drop PCIBIOS_* macros usage. (@Rob)
> > - Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
> >   instances. (@Bjorn)
> > - Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
> > - Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
> > - Use start_link/stop_link suffixes in the corresponding callbacks.
> >   (@Bjorn)
> > - Change the get_res() method suffix to being get_resources(). (@Bjorn)
> > - Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
> > - Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
> >   kernel device instance. (@Bjorn)
> > - Add the comment above the dma_set_mask_and_coherent() method usage
> >   regarding the controller eDMA feature. (@Bjorn)
> > - Fix the comment above the core reset controls assertion. (@Bjorn)
> > - Replace delays and timeout numeric literals with macros. (@Bjorn)
> > ---
> >  drivers/pci/controller/dwc/Kconfig    |   9 +
> >  drivers/pci/controller/dwc/Makefile   |   1 +
> >  drivers/pci/controller/dwc/pcie-bt1.c | 653 ++++++++++++++++++++++++++
> >  3 files changed, 663 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 62ce3abf0f19..771b8b146623 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -222,6 +222,15 @@ config PCIE_ARTPEC6_EP
> >  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
> >  	  endpoint mode. This uses the DesignWare core.
> >  
> > +config PCIE_BT1
> > +	tristate "Baikal-T1 PCIe controller"
> > +	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> > +	depends on PCI_MSI_IRQ_DOMAIN
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> > +	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> > +
> >  config PCIE_ROCKCHIP_DW_HOST
> >  	bool "Rockchip DesignWare PCIe controller"
> >  	select PCIE_DW
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 8ba7b67f5e50..bf5c311875a1 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> >  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> >  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> > +obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> > new file mode 100644
> > index 000000000000..86b230575ddc
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > @@ -0,0 +1,653 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Authors:
> > + *   Vadim Vlasov <Vadim.Vlasov@baikalelectronics.ru>
> > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > + *
> > + * Baikal-T1 PCIe controller driver
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +/* Baikal-T1 System CCU control registers */
> > +#define BT1_CCU_PCIE_CLKC			0x140
> > +#define BT1_CCU_PCIE_REQ_PCS_CLK		BIT(16)
> > +#define BT1_CCU_PCIE_REQ_MAC_CLK		BIT(17)
> > +#define BT1_CCU_PCIE_REQ_PIPE_CLK		BIT(18)
> > +
> > +#define BT1_CCU_PCIE_RSTC			0x144
> > +#define BT1_CCU_PCIE_REQ_LINK_RST		BIT(13)
> > +#define BT1_CCU_PCIE_REQ_SMLH_RST		BIT(14)
> > +#define BT1_CCU_PCIE_REQ_PHY_RST		BIT(16)
> > +#define BT1_CCU_PCIE_REQ_CORE_RST		BIT(24)
> > +#define BT1_CCU_PCIE_REQ_STICKY_RST		BIT(26)
> > +#define BT1_CCU_PCIE_REQ_NSTICKY_RST		BIT(27)
> > +
> > +#define BT1_CCU_PCIE_PMSC			0x148
> > +#define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
> > +#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
> > +#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
> > +#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
> > +#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
> > +#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
> > +#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
> > +#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
> > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
> > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
> > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
> > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
> > +#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
> > +#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
> > +#define BT1_CCU_PCIE_LTSSM_L0			0x11
> > +#define BT1_CCU_PCIE_LTSSM_L0S			0x12
> > +#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
> > +#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
> > +#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
> > +#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
> > +#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
> > +#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
> > +#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
> > +#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
> > +#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
> > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
> > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
> > +#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
> > +#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
> > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
> 

> You could make this an enum and define only the states
> that are actually used.

I'd prefer to leave it as is.

> 
> [...]
> 
> > +
> > +/* Generic Baikal-T1 PCIe interface resources */
> > +#define BT1_PCIE_NUM_APP_CLKS			ARRAY_SIZE(bt1_pcie_app_clks)
> > +#define BT1_PCIE_NUM_CORE_CLKS			ARRAY_SIZE(bt1_pcie_core_clks)
> > +#define BT1_PCIE_NUM_APP_RSTS			ARRAY_SIZE(bt1_pcie_app_rsts)
> > +#define BT1_PCIE_NUM_CORE_RSTS			ARRAY_SIZE(bt1_pcie_core_rsts)
> > +
> > +/* PCIe bus setup delays and timeouts */
> > +#define BT1_PCIE_RST_DELAY_MS			100
> > +#define BT1_PCIE_RUN_DELAY_US			100
> > +#define BT1_PCIE_REQ_DELAY_US			1
> > +#define BT1_PCIE_REQ_TIMEOUT_US			1000
> > +#define BT1_PCIE_LNK_DELAY_US			1000
> > +#define BT1_PCIE_LNK_TIMEOUT_US			1000000
> > +
> > +static const enum dw_pcie_app_clk bt1_pcie_app_clks[] = {
> > +	DW_PCIE_DBI_CLK, DW_PCIE_MSTR_CLK, DW_PCIE_SLV_CLK,
> > +};
> > +
> > +static const enum dw_pcie_core_clk bt1_pcie_core_clks[] = {
> > +	DW_PCIE_REF_CLK,
> > +};
> > +
> > +static const enum dw_pcie_app_rst bt1_pcie_app_rsts[] = {
> > +	DW_PCIE_MSTR_RST, DW_PCIE_SLV_RST,
> > +};
> > +
> > +static const enum dw_pcie_core_rst bt1_pcie_core_rsts[] = {
> > +	DW_PCIE_NON_STICKY_RST, DW_PCIE_STICKY_RST, DW_PCIE_CORE_RST,
> > +	DW_PCIE_PIPE_RST, DW_PCIE_PHY_RST, DW_PCIE_HOT_RST, DW_PCIE_PWR_RST,
> > +};
> 

> I wonder whether we could allocate the rst/clks in DWC dynamically,
> by using these configuration arrays.

The resets and clocks are now requested by means of the bulk API in the
dw_pcie_get_resources() method. So they are already dynamically
allocated. What these config arrays are needed for is to make sure the
required resets and clocks have been retrieved and in order to access the
requested handlers.

> 
> > +
> > +struct bt1_pcie {
> > +	struct dw_pcie dw;
> > +	struct platform_device *pdev;
> > +	struct regmap *sys_regs;
> > +};
> > +#define to_bt1_pcie(_dw) container_of(_dw, struct bt1_pcie, dw)
> > +
> > +/*
> > + * Baikal-T1 MMIO space must be read/written by the dword-aligned
> > + * instructions. Note the methods are optimized to have the dword operations
> > + * performed with minimum overhead as the most frequently used ones.
> > + */
> > +static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
> > +{
> > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > +
> > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > +		return -EINVAL;
> > +
> > +	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
> 

> Is it always safe to read more than requested ?

This question is kind of contradicting. No matter whether it's safe or
not we just can't perform the IOs with size other than of the dword
size. Doing otherwise will cause the bus access error.

> 
> > +	if (size == 4) {
> > +		return 0;
> > +	} else if (size == 2) {
> > +		*val &= 0xffff;
> > +		return 0;
> > +	} else if (size == 1) {
> > +		*val &= 0xff;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
> > +{
> > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > +	u32 tmp, mask;
> > +
> > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > +		return -EINVAL;
> > +
> > +	if (size == 4) {
> > +		writel(val, addr);
> > +		return 0;
> > +	} else if (size == 2 || size == 1) {
> > +		mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
> > +		tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
> > +		tmp |= (val & mask) << ofs * BITS_PER_BYTE;
> > +		writel(tmp, addr - ofs);
> > +		return 0;
> > +	}
> 

> Same question read/modify/write, is it always safe to do it
> regardless of size ?

ditto

> 
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static u32 bt1_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > +			     size_t size)
> > +{
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = bt1_pcie_read_mmio(base + reg, size, &val);
> > +	if (ret) {
> > +		dev_err(pci->dev, "Read DBI address failed\n");
> > +		return ~0U;
> 

> Is this a special magic value the DWC core is expecting ?
> 
> Does it clash with a _valid_ return value ?

It's a normal return value if the PCIe IO wasn't successful. In this
particular case there is no actual PCIe-bus IO though, but there are
conditions which can cause the errors. So the error status is still
sanity checked. This part was already commented by Rob here:
https://lore.kernel.org/linux-pci/20220615171045.GD1413880-robh@kernel.org/
my response was:
https://lore.kernel.org/linux-pci/20220619203904.h7q2eb7e4ctsujsk@mobilestation/

> 
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static void bt1_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > +			       size_t size, u32 val)
> > +{
> > +	int ret;
> > +
> > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > +	if (ret)
> > +		dev_err(pci->dev, "Write DBI address failed\n");
> > +}
> > +
> > +static void bt1_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > +				size_t size, u32 val)
> > +{
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +	int ret;
> > +
> > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > +			   BT1_CCU_PCIE_DBI2_MODE, BT1_CCU_PCIE_DBI2_MODE);
> > +
> > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > +	if (ret)
> > +		dev_err(pci->dev, "Write DBI2 address failed\n");
> > +
> > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > +			   BT1_CCU_PCIE_DBI2_MODE, 0);
> 

> IIUC the regmap_update_bits() set up decoding for DBI2.

Right and then switches it back off.

> Hopefully the
> DBI/DBI2 writes are sequentialized, this is a question valid also
> for other DWC controllers.

In general you are right, but not in particular case of the DW PCIe
Root Ports. So the concurrent access to DBI and DBI2 won't cause any
problem.

> 
> What I want to say is, the regmap update in this function sets the
> DWC HW in a way that can decode DBI2 (please correct me if I am wrong),

Right.

> between the two _update_bits() no DBI access should happen because
> it just would not work.

No. Because in case of the DW PCIe Root Ports, DBI and DBI2 are almost
identical. The difference is only in two CSR fields which turn to be
R/W in DBI2 instead of being RO in DBI. Other than that the DBI and
DBI2 spaces are identical. That's why we don't need any software-based
synchronization between the DBI/DBI2 accesses.

Moreover we won't need to worry about the synchronisation at all if
DBI2 is mapped via a separate reg-space (see dw_pcie.dbi_base2 field)
because any concurrency is resolved behind the scene by means of the
DBI bus HW implementation.

> 
> It is a question.

The situation gets to be more complex in case of DW PCIe End-points
because some of the DBI CSRs change semantics in DBI2. At the very
least it concerns the TYPE0_HDR.{BAR0-BAR5} registers, which determine
the corresponding BARx size and whether it is enabled in DBI2 (see the
reset_bar() and set_bar() methods implementation in
drivers/pci/controller/dwc/pcie-designware-ep.c). But my controller is
the Root Port controller, so the denoted peculiarity doesn't concern
it.

> 
> > +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > +	int ret;
> > +
> > +	ret = bt1_pcie_get_resources(btpci);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bt1_pcie_full_stop_bus(btpci, true);
> > +
> > +	return bt1_pcie_cold_start_bus(btpci);
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
> > +static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
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
> > +}
> > +
> > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > +{
> > +	struct device *dev = &btpci->pdev->dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * DW PCIe Root Port controller is equipped with eDMA capable of
> > +	 * working with the 64-bit memory addresses.
> > +	 */
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (ret)
> > +		return ret;
> 

> Is this the right place to set the DMA mask for the host controller
> embedded DMA controller (actually, the dev pointer is the _host_
> controller device) ?

Yes it's. The DMA controller is embedded into the PCIe Root Port
controller. It CSRs are accessed via either the same CSR space or via
a separate space but synchronously clocked by the same clock source
(it's called unrolled iATU/eDMA mode). The memory range the
controller is capable to reach is platform specific. So the glue
driver is the best place to set the device DMA-mask. (For instance the
DW PCIe master AXI-bus width is selected by means of the
MASTER_BUS_ADDR_WIDTH parameter of the DW PCIe IP-core.)

> 
> How this is going to play when combined with:
> 
> https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> 
> It is getting a bit confusing. I believe the code in the link
> above sets the mask so that through the DMA API we are capable
> of getting an MSI doorbell virtual address whose physical address
> can be addressed by the endpoint; this through the DMA API.

I don't really understand why the code in the link above tries to
analyze the MSI capability of the DW PCIe Root Port in the framework
of the dw_pcie_msi_host_init() method. The method utilizes the iMSI-RX
engine which is specific to the DW PCIe AXI-bus controller
implementation. It has nothing to do with the PCIe MSI capability
normally available over the standard PCIe config space.

As Rob correctly noted here
https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com
MSI TLPs never reaches the system memory. (But I would add that this
only concerns the iMSI-RX engine.) So no matter which memory
allocated and where, the only thing that matters is the PCIe-bus
address specified to the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI CSRs,
which are the DW PCIe-specific and both are always available thus
supporting the 64-bit messages in any case. So if we had a way to just
reserve a PCIe-bus address range which at the same time wouldn't have
a system memory behind, we could have used the reserved range to
initialize the iMSI-RX MSI-address without need to allocate any
DMA-able memory at all. That's why the commit 07940c369a6b ("PCI: dwc:
Fix MSI page leakage in suspend/resume") was absolutely correct.

> 
> This patch is setting the DMA mask for a different reason, namely
> setting the host controller embedded DMA controller addressing
> capabilities.

AFAIU what is done in that patch is incorrect.

> 
> AFAICS - both approaches set the mask for the same device - now
> the question is about which one is legitimate and how to handle
> the other.

That's simple. Mine is legitimate for sure. Another one isn't.

> 
> > +
> > +	btpci->dw.version = DW_PCIE_VER_460A;
> > +	btpci->dw.dev = dev;
> > +	btpci->dw.ops = &bt1_pcie_ops;
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
> > +static void bt1_pcie_del_port(struct bt1_pcie *btpci)
> > +{
> > +	dw_pcie_host_deinit(&btpci->dw.pp);
> > +}
> > +
> > +static int bt1_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct bt1_pcie *btpci;
> > +
> > +	btpci = bt1_pcie_create_data(pdev);
> 

> Do we really need a function for that ? I am not too
> bothered but I think it is overkill.

I prefer splitting the probe method up into a set of small and
coherent methods. It IMO improves the code readability for just no
price since the compiler will embed the single-time used static
methods anyway.

-Sergey

> 
> Thanks,
> Lorenzo
> 
> > +	if (IS_ERR(btpci))
> > +		return PTR_ERR(btpci);
> > +
> > +	return bt1_pcie_add_port(btpci);
> > +}
> > +
> > +static int bt1_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> > +
> > +	bt1_pcie_del_port(btpci);
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

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5376057282B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiGLVCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 17:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiGLVBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 17:01:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FB8FD26;
        Tue, 12 Jul 2022 13:58:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp17so8108229lfb.3;
        Tue, 12 Jul 2022 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6sBzFjOiHlV8vVDIn/eYVGOMRxr3OKGwWgkIb5VmgNg=;
        b=avhG/pe9SZAKNzJR2YWz1tMwJIVeLbPkojvToceEQUfIGr2ITtexx2U+zdN8hXfnFs
         MPYGwsDv3I12j6CivBYRQA22wrnPJoI5gsfB6JMYRbVVEMMaqzrEiVQvK1irhDg/LF01
         +hN23gQ4xAkPctihra+EfsebBAe0XP4ff9sbVDSbbKEL74LnUd8cJnxqZkqxP4mh1pfB
         /I6jtM7sCPhPvOxoNKimLsSMHpax/qtVLmuu2pIu07wsoQQJkuomJfhqJU5qCCBPrYlJ
         LIbzu94Z5kspv0TSp28J/WooVxtnCkDLcaubJqrP+0K5ZK1iZv1dbjTDjufwhY+4TwGN
         Q+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sBzFjOiHlV8vVDIn/eYVGOMRxr3OKGwWgkIb5VmgNg=;
        b=3v4FbdLF4W3QaJ+0ootLWqtiyj3Xk287PKh4fuBD5BATdIm44+38uL+R2qyPKA+yXf
         CG5GMh9knoRgRG7Vd44JH0FmzgGqQ2GuHd8hrYYCpM0RGJht0qODPiih5s5GWTghN3t1
         4wrB92GPpZ2FMcZ6cIkf3aftfMRoIvpVAz2k0RsOwj6rpGem1H1w9y45j+ALU6RLgwjI
         0Q3F/XElBRMvyP+8CGMhPMZ+HxLNwc0VB+QpTKIvevDRpBkfeKkPlDGh8e2I7rTlPj6k
         e3JkEquIDKOSLdSicEc0gunH/tGYgeBMKQIjUGQCCWQquum60sapsAcyI1ToMopLBduH
         TIuQ==
X-Gm-Message-State: AJIora+jZCTMcSn1lx7vHK7aKhhCSDFKvuA4loSSbvKjA0klFoMyy811
        blTmzPItqffRAKmn9GviWYQ=
X-Google-Smtp-Source: AGRyM1tKa2STbkcYPpfEDLHsge+Nw4tFtk3LnKAlA/tzxZ8+uq/YBZ04ebILjGxRHTTz4C+7QuZEuw==
X-Received: by 2002:ac2:4214:0:b0:481:6399:eaae with SMTP id y20-20020ac24214000000b004816399eaaemr16073851lfh.634.1657659518419;
        Tue, 12 Jul 2022 13:58:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v23-20020a056512349700b00486c14f0fe1sm2394863lfr.11.2022.07.12.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:58:37 -0700 (PDT)
Date:   Tue, 12 Jul 2022 23:58:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220712205835.u77ndps55bwgy5vv@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-18-Sergey.Semin@baikalelectronics.ru>
 <20220615171045.GD1413880-robh@kernel.org>
 <20220619203904.h7q2eb7e4ctsujsk@mobilestation>
 <20220712202907.GN1823936-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712202907.GN1823936-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 02:29:07PM -0600, Rob Herring wrote:
> On Sun, Jun 19, 2022 at 11:39:04PM +0300, Serge Semin wrote:
> > On Wed, Jun 15, 2022 at 11:10:45AM -0600, Rob Herring wrote:
> > > On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> > > > trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> > > > is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> > > > turn is connected to the DWC 10G PHY. The whole system is supposed to be
> > > > fed up with four clock sources: DBI peripheral clock, AXI application
> > > > clocks and external PHY/core reference clock generating the 100MHz signal.
> > > > In addition to that the platform provide a way to reset each part of the
> > > > controller: sticky/non-sticky bits, host controller core, PIPE interface,
> > > > PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> > > > handle the GPIO-based PERST# signal.
> > > > 
> > > > Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> > > > interface accessors which make sure the IO operations are dword-aligned.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v2:
> > > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > > 
> > > > Changelog v3:
> > > > - Use the clocks/resets handlers defined in the DW PCIe core descriptor.
> > > >   (@Rob)
> > > > - Redefine PCI host bridge config space accessors with the generic
> > > >   pci_generic_config_read32() and pci_generic_config_write32() methods.
> > > >   (@Rob)
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig    |   9 +
> > > >  drivers/pci/controller/dwc/Makefile   |   1 +
> > > >  drivers/pci/controller/dwc/pcie-bt1.c | 649 ++++++++++++++++++++++++++
> > > >  3 files changed, 659 insertions(+)
> > > >  create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > index 62ce3abf0f19..771b8b146623 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -222,6 +222,15 @@ config PCIE_ARTPEC6_EP
> > > >  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
> > > >  	  endpoint mode. This uses the DesignWare core.
> > > >  
> > > > +config PCIE_BT1
> > > > +	tristate "Baikal-T1 PCIe controller"
> > > > +	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> > > > +	depends on PCI_MSI_IRQ_DOMAIN
> > > > +	select PCIE_DW_HOST
> > > > +	help
> > > > +	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> > > > +	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> > > > +
> > > >  config PCIE_ROCKCHIP_DW_HOST
> > > >  	bool "Rockchip DesignWare PCIe controller"
> > > >  	select PCIE_DW
> > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > > index 8ba7b67f5e50..bf5c311875a1 100644
> > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> > > >  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> > > >  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> > > >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> > > > +obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> > > >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> > > >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > > >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > > > diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> > > > new file mode 100644
> > > > index 000000000000..03f035743b78
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> > > > @@ -0,0 +1,649 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> > > > + *
> > > > + * Authors:
> > > > + *   Vadim Vlasov <Vadim.Vlasov@baikalelectronics.ru>
> > > > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > + *
> > > > + * Baikal-T1 PCIe controller driver
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/bits.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/reset.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#include "pcie-designware.h"
> > > > +
> > > > +/* Baikal-T1 System CCU control registers */
> > > > +#define BT1_CCU_PCIE_CLKC			0x140
> > > > +#define BT1_CCU_PCIE_REQ_PCS_CLK		BIT(16)
> > > > +#define BT1_CCU_PCIE_REQ_MAC_CLK		BIT(17)
> > > > +#define BT1_CCU_PCIE_REQ_PIPE_CLK		BIT(18)
> > > > +
> > > > +#define BT1_CCU_PCIE_RSTC			0x144
> > > > +#define BT1_CCU_PCIE_REQ_LINK_RST		BIT(13)
> > > > +#define BT1_CCU_PCIE_REQ_SMLH_RST		BIT(14)
> > > > +#define BT1_CCU_PCIE_REQ_PHY_RST		BIT(16)
> > > > +#define BT1_CCU_PCIE_REQ_CORE_RST		BIT(24)
> > > > +#define BT1_CCU_PCIE_REQ_STICKY_RST		BIT(26)
> > > > +#define BT1_CCU_PCIE_REQ_NSTICKY_RST		BIT(27)
> > > > +
> > > > +#define BT1_CCU_PCIE_PMSC			0x148
> > > > +#define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
> > > > +#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
> > > > +#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
> > > > +#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
> > > > +#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
> > > > +#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
> > > > +#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
> > > > +#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
> > > > +#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
> > > > +#define BT1_CCU_PCIE_LTSSM_L0			0x11
> > > > +#define BT1_CCU_PCIE_LTSSM_L0S			0x12
> > > > +#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
> > > > +#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
> > > > +#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
> > > > +#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
> > > > +#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
> > > > +#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
> > > > +#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
> > > > +#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
> > > > +#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
> > > > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
> > > > +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
> > > > +#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
> > > > +#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
> > > > +#define BT1_CCU_PCIE_SMLH_LINKUP		BIT(6)
> > > > +#define BT1_CCU_PCIE_RDLH_LINKUP		BIT(7)
> > > > +#define BT1_CCU_PCIE_PM_LINKSTATE_L0S		BIT(8)
> > > > +#define BT1_CCU_PCIE_PM_LINKSTATE_L1		BIT(9)
> > > > +#define BT1_CCU_PCIE_PM_LINKSTATE_L2		BIT(10)
> > > > +#define BT1_CCU_PCIE_L1_PENDING			BIT(12)
> > > > +#define BT1_CCU_PCIE_REQ_EXIT_L1		BIT(14)
> > > > +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ		BIT(15)
> > > > +#define BT1_CCU_PCIE_PM_DSTAT_MASK		GENMASK(18, 16)
> > > > +#define BT1_CCU_PCIE_PM_PME_EN			BIT(20)
> > > > +#define BT1_CCU_PCIE_PM_PME_STATUS		BIT(21)
> > > > +#define BT1_CCU_PCIE_AUX_PM_EN			BIT(22)
> > > > +#define BT1_CCU_PCIE_AUX_PWR_DET		BIT(23)
> > > > +#define BT1_CCU_PCIE_WAKE_DET			BIT(24)
> > > > +#define BT1_CCU_PCIE_TURNOFF_REQ		BIT(30)
> > > > +#define BT1_CCU_PCIE_TURNOFF_ACK		BIT(31)
> > > > +
> > > > +#define BT1_CCU_PCIE_GENC			0x14c
> > > > +#define BT1_CCU_PCIE_LTSSM_EN			BIT(1)
> > > > +#define BT1_CCU_PCIE_DBI2_MODE			BIT(2)
> > > > +#define BT1_CCU_PCIE_MGMT_EN			BIT(3)
> > > > +#define BT1_CCU_PCIE_RXLANE_FLIP_EN		BIT(16)
> > > > +#define BT1_CCU_PCIE_TXLANE_FLIP_EN		BIT(17)
> > > > +#define BT1_CCU_PCIE_SLV_XFER_PEND		BIT(24)
> > > > +#define BT1_CCU_PCIE_RCV_XFER_PEND		BIT(25)
> > > > +#define BT1_CCU_PCIE_DBI_XFER_PEND		BIT(26)
> > > > +#define BT1_CCU_PCIE_DMA_XFER_PEND		BIT(27)
> > > > +
> > > > +#define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
> > > > +({ \
> > > > +	int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
> > > > +	__state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= BT1_CCU_PCIE_LTSSM_L2_WAKE; \
> > > > +})
> > > > +
> > > > +/* Baikal-T1 PCIe specific control registers */
> > > > +#define BT1_PCIE_AXI2MGM_LANENUM		0xd04
> > > > +#define BT1_PCIE_AXI2MGM_LANESEL_MASK		GENMASK(3, 0)
> > > > +
> > > > +#define BT1_PCIE_AXI2MGM_ADDRCTL		0xd08
> > > > +#define BT1_PCIE_AXI2MGM_PHYREG_ADDR_MASK	GENMASK(20, 0)
> > > > +#define BT1_PCIE_AXI2MGM_READ_FLAG		BIT(29)
> > > > +#define BT1_PCIE_AXI2MGM_DONE			BIT(30)
> > > > +#define BT1_PCIE_AXI2MGM_BUSY			BIT(31)
> > > > +
> > > > +#define BT1_PCIE_AXI2MGM_WRITEDATA		0xd0c
> > > > +#define BT1_PCIE_AXI2MGM_WDATA			GENMASK(15, 0)
> > > > +
> > > > +#define BT1_PCIE_AXI2MGM_READDATA		0xd10
> > > > +#define BT1_PCIE_AXI2MGM_RDATA			GENMASK(15, 0)
> > > > +
> > > > +/* Generic Baikal-T1 PCIe interface resources */
> > > > +#define BT1_PCIE_NUM_APP_CLKS			ARRAY_SIZE(bt1_pcie_app_clks)
> > > > +#define BT1_PCIE_NUM_CORE_CLKS			ARRAY_SIZE(bt1_pcie_core_clks)
> > > > +#define BT1_PCIE_NUM_APP_RSTS			ARRAY_SIZE(bt1_pcie_app_rsts)
> > > > +#define BT1_PCIE_NUM_CORE_RSTS			ARRAY_SIZE(bt1_pcie_core_rsts)
> > > > +
> > > > +static const enum dw_pcie_app_clk bt1_pcie_app_clks[] = {
> > > > +	DW_PCIE_DBI_CLK, DW_PCIE_MSTR_CLK, DW_PCIE_SLV_CLK,
> > > > +};
> > > > +
> > > > +static const enum dw_pcie_core_clk bt1_pcie_core_clks[] = {
> > > > +	DW_PCIE_REF_CLK,
> > > > +};
> > > > +
> > > > +static const enum dw_pcie_app_rst bt1_pcie_app_rsts[] = {
> > > > +	DW_PCIE_MSTR_RST, DW_PCIE_SLV_RST,
> > > > +};
> > > > +
> > > > +static const enum dw_pcie_core_rst bt1_pcie_core_rsts[] = {
> > > > +	DW_PCIE_NON_STICKY_RST, DW_PCIE_STICKY_RST, DW_PCIE_CORE_RST,
> > > > +	DW_PCIE_PIPE_RST, DW_PCIE_PHY_RST, DW_PCIE_HOT_RST, DW_PCIE_PWR_RST,
> > > > +};
> > > > +
> > > > +struct bt1_pcie {
> > > > +	struct dw_pcie dw;
> > > > +	struct platform_device *pdev;
> > > > +	struct regmap *sys_regs;
> > > > +};
> > > > +#define to_bt1_pcie(_dw) container_of(_dw, struct bt1_pcie, dw)
> > > > +
> > > > +/*
> > > > + * Baikal-T1 MMIO space must be read/written by the dword-aligned
> > > > + * instructions. Note the methods are optimized to have the dword operations
> > > > + * performed with minimum overhead as the most frequently used ones.
> > > > + */
> > > > +static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
> > > > +{
> > > > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > > > +
> > > > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > > > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > > 
> > 
> > > This isn't for PCI config space accessors, don't use PCIBIOS_*. We 
> > > really want to get rid of those.
> > 
> > Ok. I'll drop the PCIBIOS_* macros usage from here.
> > 
> > > 
> > > You are in control of all the accesses, so the error conditions should 
> > > never happen, don't need to be checked, and don't need to be returned.
> > 
> > not entirely. I'd prefer to keep the error-condition check here because the
> > methods are the core of the callbacks called from the generic part of the
> > DW PCIe driver which if get to regress in making the unsupported IO
> > accesses will be easier to debug should the sanity check is performed.
> 

> Actually, this will get called for the config accessor path, so you need 
> to keep it as-is. We do want to push the PCIBIOS_* error codes out of 
> the drivers though...

Please clarify. By saying "keep it as-is" did you mean to keep the
PCIBIOS_* macros usage here?

Note bt1_pcie_read_mmio() and bt1_pcie_write_mmio() methods we are
talking about are used to access the DW PCIe DBI interface only in the
framework of the internal DW PCIe controller driver code. At least
AFAICS from the current DW PCIe driver implementation they won't be
called by the PCIe subsystem core neither explicitly nor implicitly.
So you were right using the PCIBIOS_* macros here wasn't required.

-Sergey

> 
> Rob

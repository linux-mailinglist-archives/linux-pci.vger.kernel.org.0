Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E043302AA2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 19:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbhAYSqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 13:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbhAYSqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 13:46:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2320522DFB;
        Mon, 25 Jan 2021 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611600344;
        bh=Z0PYkD5c8k6V+L+B6WcLlwfL+2n9gR6KhmRw0jJXIlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAjAaIRatmibVWZrqxhrA/wafXH0y9jZSaTxrxsPjuYzcBqELg5GSXY/hHJIfeT0n
         Ow0qoLYVHRIBadT7JqOv3CmqlQLEBWbX00eZ1wf97Fk03eH2PQA0mmtWpWDXnRZZGM
         nKYAjbF7HG07gMlCOTP5ErrdEfu6+ot8H4ENWqpnN3F95f2W0vpGREmkcRZ8PnXH5E
         mVNlXIQ2a9FOCq+2Hp4DvsfJLiRfya8VaUwmOgb7ZE0XG/EkqgEG9u8Ll/8KJtwTyA
         uSXarDER2z+3KIBFVz97OL9klmlWeb83MNwemtU3yDkOvTZrxKLgcCwpafRE7Imn9c
         vjk9snNlD9cqw==
Date:   Mon, 25 Jan 2021 20:45:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     xxm <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: rockchip: add DesignWare based PCIe
 controller
Message-ID: <20210125184541.GJ579511@unreal>
References: <20210125024824.634583-1-xxm@rock-chips.com>
 <20210125024927.634634-1-xxm@rock-chips.com>
 <20210125054836.GB579511@unreal>
 <0b65ca38-ff7a-f9cd-5406-1f275fbbecd1@rock-chips.com>
 <20210125090129.GF579511@unreal>
 <e7ed6586-06f3-52e3-b2db-38887a5a37e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ed6586-06f3-52e3-b2db-38887a5a37e4@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 03:53:38PM +0000, Robin Murphy wrote:
> On 2021-01-25 09:01, Leon Romanovsky wrote:
> > On Mon, Jan 25, 2021 at 02:40:10PM +0800, xxm wrote:
> > > Hi Leon,
> > >
> > > Thanks for your reply.
> > >
> > > 在 2021/1/25 13:48, Leon Romanovsky 写道:
> > > > On Mon, Jan 25, 2021 at 10:49:27AM +0800, Simon Xue wrote:
> > > > > pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
> > > > > is Rockchip designed IP which is only used for RK3399. So all the following
> > > > > non-RK3399 SoCs should use this driver.
> > > > >
> > > > > Signed-off-by: Simon Xue <xxm@rock-chips.com>
> > > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/Kconfig            |   9 +
> > > > >    drivers/pci/controller/dwc/Makefile           |   1 +
> > > > >    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 286 ++++++++++++++++++
> > > > >    3 files changed, 296 insertions(+)
> > > > >    create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > > index 22c5529e9a65..aee408fe9283 100644
> > > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > > @@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
> > > > >    	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
> > > > >    	  endpoint mode. This uses the DesignWare core.
> > > > >
> > > > > +config PCIE_ROCKCHIP_DW_HOST
> > > > > +	bool "Rockchip DesignWare PCIe controller"
> > > > > +	select PCIE_DW
> > > > > +	select PCIE_DW_HOST
> > > > > +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> > > > > +	depends on OF
> > > > > +	help
> > > > > +	  Enables support for the DW PCIe controller in the Rockchip SoC.
> > > > > +
> > > > >    config PCIE_INTEL_GW
> > > > >    	bool "Intel Gateway PCIe host controller support"
> > > > >    	depends on OF && (X86 || COMPILE_TEST)
> > > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > > > index a751553fa0db..30eef8e9ee8a 100644
> > > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > > @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> > > > >    obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> > > > >    obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> > > > >    obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> > > > > +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
> > > > >    obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
> > > > >    obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
> > > > >    obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > new file mode 100644
> > > > > index 000000000000..07f6d1cd5853
> > > > > --- /dev/null
> > > > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > @@ -0,0 +1,286 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * PCIe host controller driver for Rockchip SoCs
> > > > > + *
> > > > > + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> > > > > + *		http://www.rock-chips.com
> > > > > + *
> > > > > + * Author: Simon Xue <xxm@rock-chips.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > > +#include <linux/mfd/syscon.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/phy/phy.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/reset.h>
> > > > > +
> > > > > +#include "pcie-designware.h"
> > > > > +
> > > > > +/*
> > > > > + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> > > > > + * mask for the lower 16 bits.  This allows atomic updates
> > > > > + * of the register without locking.
> > > > > + */
> > > > This is correct only for the variables that naturally aligned, I imagine
> > > > that this is the case here and in the Linux, but better do not write comments
> > > > in the code that are not accurate.
> > >
> > > Ok, will remove.
> > > I wonder what it would be when outside the Linux? Could you share some information?
> >
> > The C standard says nothing about atomicity, integer assignment maybe atomic,
> > maybe it isn’t. There is no guarantee, plain integer assignment in C is non-atomic
> > by definition.
> >
> > The atomicity of u32 is very dependent on hardware vendor, memory model and compiler,
> > for example x86 and ARMs guarantee atomicity for u32. This is why I said that probably
> > here (Linux) it is ok and you are not alone in expecting lockless write.
>
> Huh? What do variables and the abstract machine of the C language
> environment have to do with the definition of *hardware MMIO registers*? We
> don't write to registers with plain integer assignment of u32, we use
> writel() (precisely in order to bypass that abstract C environment).
>
> I appreciate that the comment is not universally true if taken completely
> out of context, but I that's true of pretty much all comments ever. If
> someone really were trying to learn basic programming principles from random
> comments in Linux drivers, then it's already a bit late for us to try and
> save them from themselves.

So what? Does it mean that new code should have comments that are not
correct? As you can see from this conversation, even the author didn't
know what u32 isn’t guaranteed to be atomic, so yes, the comments should
be correct.

Thanks

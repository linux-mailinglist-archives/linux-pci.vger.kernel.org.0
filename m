Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589C3BBE7F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhGEO5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 10:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEO5C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jul 2021 10:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CDF6193E;
        Mon,  5 Jul 2021 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625496865;
        bh=cTE4jjitBw76LXGlub+WjJE0NqAc0YXnD/MQgU/ZcXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAFgp2myU3/dAMA6STmoue6t5YFjHeuwpwXHYoruXE+GbugKRY586VVhYlBhCrn+h
         qdU4RSgBRpbBYQvq27z59OVPgllx/PMbkLmAZGGcK2mwBr0Zm0RNnF6/TRE3v8IgBd
         BT76/P9trT4zz2qngYE+eCV7O6EAMlX1cEJtdhzVJKFjF7jR2QOWRUWgEH+oeKUCtl
         ZXx3abeTWJWegUVYgiCt+xTrO5poDXvxsQZwrCMivPm1kV4ZbI5lMc/bR4zGeEQNgF
         k18+SJoBtyP/eBWjmp5yutIgKnVu/ISlTlg6YRaGAZz/yY/eqif7x45Cg81LtS4JoS
         HoLGhUvjbGZcQ==
Date:   Mon, 5 Jul 2021 16:54:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] PCI: dwc: pcie-kirin: add support for Kirin
 970 PCIe controller
Message-ID: <20210705165420.3ed66bcd@coco.lan>
In-Reply-To: <CAL_JsqK7_hAw4aacHyiqJWE6zSWiMez5695+deaCSHfeWuX-XA@mail.gmail.com>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
        <4c9d6581478aa966698758c0420933f5defab4dd.1612335031.git.mchehab+huawei@kernel.org>
        <CAL_JsqK7_hAw4aacHyiqJWE6zSWiMez5695+deaCSHfeWuX-XA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Em Wed, 3 Feb 2021 08:34:21 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Feb 3, 2021 at 1:02 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Add support for HiSilicon Kirin 970 (hi3670) SoC PCIe controller, based
> > on Synopsys DesignWare PCIe controller IP.
> >

> > +/* kirin970 pciephy register */
> > +#define SOC_PCIEPHY_MMC1PLL_CTRL1  0xc04
> > +#define SOC_PCIEPHY_MMC1PLL_CTRL16 0xC40
> > +#define SOC_PCIEPHY_MMC1PLL_CTRL17 0xC44
> > +#define SOC_PCIEPHY_MMC1PLL_CTRL20 0xC50
> > +#define SOC_PCIEPHY_MMC1PLL_CTRL21 0xC54
> > +#define SOC_PCIEPHY_MMC1PLL_STAT0  0xE00  
> 
> This looks like it is almost all phy related. I think it should all be
> moved to a separate phy driver. Yes, we have some other PCI drivers
> controlling their phys directly where the phy registers are
> intermingled with the PCI host registers, but I think those either
> predate the phy subsystem or are really simple. I also have a dream to
> move all the phy control to the DWC core code.

I'm looking into it right now, but it sounds that splitting the PHY
part of the driver can't be done on a DT backward-compatible way.

See, the current pcie-kirin has already a PHY driver for Kirin 960
embedded on it. So, before adding PHY support to the driver, we need
to split the current driver on two, placing the PHY part of pcie-kirin.c
into a drivers/phy/hisilicon/phy-hi3660-pcie.c driver, as the current
code contain lots of PHY code already on it. See, for instance the priv
driver struct:

	struct kirin_pcie {
		struct dw_pcie	*pci;
		void __iomem	*apb_base;
		void __iomem	*phy_base;
		struct regmap	*crgctrl;
		struct regmap	*sysctrl;
		struct clk	*apb_sys_clk;
		struct clk	*apb_phy_clk;
		struct clk	*phy_ref_clk;
		struct clk	*pcie_aclk;
		struct clk	*pcie_aux_clk;
		int		gpio_id_reset;
	};

There are at three PHY-related fields there:

		- an iomem region: phy_base
		- two clocks: phy_ref_clk and apb_phy_clk

Yet, right now, they're all declared under this DT property at
arch/arm64/boot/dts/hisilicon/hi3660.dtsi:

	pcie@f4000000 {
                compatible = "hisilicon,kirin960-pcie";
		reg = <0x0 0xf4000000 0x0 0x1000>,
                      <0x0 0xff3fe000 0x0 0x1000>,
                      <0x0 0xf3f20000 0x0 0x40000>,
                      <0x0 0xf5000000 0x0 0x2000>;
                reg-names = "dbi", "apb", "phy", "config";
	...
		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
                         <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
                         <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
                         <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
                         <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
                clock-names = "pcie_phy_ref", "pcie_aux",
                          "pcie_apb_phy", "pcie_apb_sys",
                          "pcie_aclk";
	...
	};

If we split the PHY out of this driver, the above would be, instead:

	pcie_phy: pcie-phy@f3f2000 {
		compatible = "";
		reg = <0xf3f200000 0x40000>;

		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
                         <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
                clock-names = "pcie_phy_ref", "pcie_apb_phy";
	}

	pcie@f4000000 {
                compatible = "hisilicon,kirin960-pcie";
		reg = <0x0 0xf4000000 0x0 0x1000>,
                      <0x0 0xff3fe000 0x0 0x1000>,
                      <0x0 0xf5000000 0x0 0x2000>;
                reg-names = "dbi", "apb", "config";
	...
		clocks = <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
                         <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
                         <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
                clock-names = "pcie_aux", "pcie_apb_sys",
                              "pcie_aclk";

		phys = <&pcie_phy>;
	...
	};

Would a change like that be accepted? If not, IMO the best would be to
also merge the Hikey 970 PHY inside the same driver, in order to avoid
DT regressions.

Thanks,
Mauro

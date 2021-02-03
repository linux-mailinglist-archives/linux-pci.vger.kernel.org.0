Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354C330E16E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBCRtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 12:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBCRty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 12:49:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C0AF64E4F;
        Wed,  3 Feb 2021 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612374550;
        bh=6CznY1FXj7k3RwGkQFAAulMB6ojMSoQVIBIO2Qjc6o0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AobGhKXyP1r/NWHMedmVJNLbRzh0vg39oHBqreGBdtr9Yu9HKiOOlUSytyeaahge0
         31DyW8QvtFLmHQcQ0+s3U4XW5MUcnBIfbj6kru0SqsASkSkBd3oodS9kjgbe40DzZ5
         SeBTLpxeOvF4oGFIzmdmbcm8XE7iUejWK4+rJ0sI6bxs9yDKiZdG2H1unbnmXPIjCC
         phZIaK7ZjmFCyDphOxIefu8b27mW2/++52sz1F+VU/WDI2InRew4QUKcvUilellspU
         OnWiFuS0Xe/bbnL59cSBp90RQWZ7lVJHPT0kd+KnBuXfhKLp69pcL29oj0l700Mnzr
         MrxD4XhmfBypQ==
Date:   Wed, 3 Feb 2021 18:49:04 +0100
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
Message-ID: <20210203184904.5f6b5f3b@coco.lan>
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
> > [mchehab+huawei@kernel.org: fix merge conflicts]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-kirin.c | 723 +++++++++++++++++++++++-
> >  1 file changed, 707 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index 026fd1e42a55..5925d2b345a8 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -29,6 +29,7 @@
> >  #define to_kirin_pcie(x) dev_get_drvdata((x)->dev)
> >
> >  #define REF_CLK_FREQ                   100000000
> > +#define AXI_CLK_FREQ                   207500000
> >
> >  /* PCIe ELBI registers */
> >  #define SOC_PCIECTRL_CTRL0_ADDR                0x000
> > @@ -60,6 +61,65 @@
> >  #define PCIE_DEBOUNCE_PARAM    0xF0F400
> >  #define PCIE_OE_BYPASS         (0x3 << 28)
> >
> > +/* PCIe CTRL registers */
> > +#define SOC_PCIECTRL_CTRL0_ADDR   0x000
> > +#define SOC_PCIECTRL_CTRL1_ADDR   0x004
> > +#define SOC_PCIECTRL_CTRL7_ADDR   0x01c
> > +#define SOC_PCIECTRL_CTRL12_ADDR  0x030
> > +#define SOC_PCIECTRL_CTRL20_ADDR  0x050
> > +#define SOC_PCIECTRL_CTRL21_ADDR  0x054
> > +#define SOC_PCIECTRL_STATE0_ADDR  0x400
> > +
> > +/* PCIe PHY registers */
> > +#define SOC_PCIEPHY_CTRL0_ADDR    0x000
> > +#define SOC_PCIEPHY_CTRL1_ADDR    0x004
> > +#define SOC_PCIEPHY_CTRL2_ADDR    0x008
> > +#define SOC_PCIEPHY_CTRL3_ADDR    0x00c
> > +#define SOC_PCIEPHY_CTRL38_ADDR   0x0098
> > +#define SOC_PCIEPHY_STATE0_ADDR   0x400
> > +
> > +#define PCIE_LINKUP_ENABLE            (0x8020)
> > +#define PCIE_ELBI_SLV_DBI_ENABLE      (0x1 << 21)
> > +#define PCIE_LTSSM_ENABLE_BIT         (0x1 << 11)
> > +#define PCIEPHY_RESET_BIT             (0x1 << 17)
> > +#define PCIEPHY_PIPE_LINE0_RESET_BIT  (0x1 << 19)
> > +
> > +#define PORT_MSI_CTRL_ADDR            0x820
> > +#define PORT_MSI_CTRL_UPPER_ADDR      0x824
> > +#define PORT_MSI_CTRL_INT0_ENABLE     0x828  
> 
> These are common DWC 'port logic' registers. I think the core DWC
> should handle them if not already.

I'll double-check if are there something that can be dropped.

> 
> > +
> > +#define EYEPARAM_NOCFG 0xFFFFFFFF
> > +#define RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1 0x3001
> > +#define SUP_DIG_LVL_OVRD_IN 0xf
> > +#define LANEN_DIG_ASIC_TX_OVRD_IN_1 0x1002
> > +#define LANEN_DIG_ASIC_TX_OVRD_IN_2 0x1003
> > +
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

Yeah, it sounds so. I'll check how hard would be to split this code
into a phy driver on a separate patch.

> > +struct kirin_pcie_ops {
> > +       long (*get_resource)(struct kirin_pcie *kirin_pcie,
> > +                            struct platform_device *pdev);
> > +       int (*power_on)(struct kirin_pcie *kirin_pcie);  
> 
> Never need to power off?

This driver uses devm_*() to allocate its resources, and doesn't
even uses builtin_platform_driver(kirin_pcie_driver) to register.

So, at the current state, it doesn't need a poweroff.

This "power_on" method is actually the device-specific part of
the probe: depending on the compatible, it either runs the Kirin 960
or the new Kirin 970 variant.

I'll try to double-check this when trying to split the PHY logic
from the driver.

> > +static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> > +                                     struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *apb;
> > +       struct resource *phy;
> > +       struct resource *dbi;
> > +       int ret;
> > +
> > +       apb = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
> > +       kirin_pcie->apb_base = devm_ioremap_resource(dev, apb);
> > +       if (IS_ERR(kirin_pcie->apb_base))
> > +               return PTR_ERR(kirin_pcie->apb_base);
> > +
> > +       phy = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> > +       kirin_pcie->phy_base = devm_ioremap_resource(dev, phy);
> > +       if (IS_ERR(kirin_pcie->phy_base))
> > +               return PTR_ERR(kirin_pcie->phy_base);
> > +
> > +       dbi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> > +       kirin_pcie->pci->dbi_base = devm_ioremap_resource(dev, dbi);  
> 
> The DWC core handles this now.

Yes. This is addressed on this patch:

	[PATCH v2 07/11] PCI: dwc: pcie-kirin: place common init code altogether

> > +       if (IS_ERR(kirin_pcie->pci->dbi_base))
> > +               return PTR_ERR(kirin_pcie->pci->dbi_base);
> > +
> > +       kirin970_pcie_get_eyeparam(kirin_pcie);
> > +
> > +       kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
> > +                                               "switch,reset-gpios", 0);
> > +       if (kirin_pcie->gpio_id_reset[0] < 0)
> > +               return -ENODEV;
> > +
> > +       kirin_pcie->gpio_id_reset[1] = of_get_named_gpio(dev->of_node,
> > +                                               "eth,reset-gpios", 0);
> > +       if (kirin_pcie->gpio_id_reset[1] < 0)
> > +               return -ENODEV;
> > +
> > +       kirin_pcie->gpio_id_reset[2] = of_get_named_gpio(dev->of_node,
> > +                                               "m_2,reset-gpios", 0);
> > +       if (kirin_pcie->gpio_id_reset[2] < 0)
> > +               return -ENODEV;
> > +
> > +       kirin_pcie->gpio_id_reset[3] = of_get_named_gpio(dev->of_node,
> > +                                               "mini1,reset-gpios", 0);
> > +       if (kirin_pcie->gpio_id_reset[3] < 0)  
> 
> I've already explained how all this is wrong.

This patch:

	[PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple reset GPIOs

Changes the above to, instead, get all the PERST# reset from "reset-gpios":

	kirin_pcie->n_gpio_resets = of_gpio_named_count(np, "reset-gpios");
	if (kirin_pcie->n_gpio_resets > MAX_GPIO_RESETS) {
		dev_err(dev, "Too many GPIO resets!\n");
		return -EINVAL;
	}
	for (i = 0; i < kirin_pcie->n_gpio_resets; i++) {
		kirin_pcie->gpio_id_reset[i] = of_get_named_gpio(dev->of_node,
							    "reset-gpios", i);
		if (kirin_pcie->gpio_id_reset[i] < 0)
			return kirin_pcie->gpio_id_reset[i];

		sprintf(name, "pcie_perst_%d", i);
		kirin_pcie->reset_names[i] = devm_kstrdup_const(dev, name,
								GFP_KERNEL);
		if (!kirin_pcie->reset_names[i])
			return -ENOMEM;
	}

They're all handled altogether inside the driver.

> > @@ -431,6 +1124,9 @@ static int kirin_pcie_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >         }
> >
> > +       of_id = of_match_node(kirin_pcie_match, dev->of_node);
> > +       ops = (struct kirin_pcie_ops *)of_id->data;  
> 
> of_device_get_match_data()

Ok.

Thanks,
Mauro

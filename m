Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2923034A34E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 09:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCZIkD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 04:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhCZIjm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 04:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86CAB619BB;
        Fri, 26 Mar 2021 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616747982;
        bh=+wb5b5oRQGDTigmzHdt1l9UCuT1gNoKZ2eYfjxeiYVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwttunlxS5iT1c/6hyWCK6C2IzcgMJpD/kh0yM65NraB3A+4l5rcH1P2acgcxgBrC
         LgNpMFNQJFVjlFLrMgEw5pXvcsAp8jbufj549ZL7g7/wRPy3t26FCMrAgUwSaJsc30
         /vwUHGdmyfFEgmjas3wDiqmBq9txm305xyU8SnK5o87XFo6JA+M2dY2+Il//UqFgTK
         fpx9a9ZWAtUg5IXCP6IbV+LTUZpaZ049Fxp2nw9A6velZ6PhwANBXghOGbrKQEbHPq
         oB+l1WtGLFHRLiRUDKe2tT/LbaQkAilbTNOa7HmihrcY4PclgF3ZQAgCg5AkzODcvR
         Hf9SIGhQRzdhg==
Date:   Fri, 26 Mar 2021 09:39:36 +0100
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
Message-ID: <20210326093936.02ba3a03@coco.lan>
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

Please notice that this patch was not written by me, but, instead,
by Mannivannan. So, I can't change it. What I can certainly do is to
write a separate patch at the end of this series moving the Kirin 970
phy to a separate driver. Would this be accepted?

Btw, what should be done with the Kirin 960 PHY code that it is
already embedded on this driver, and whose some of the DT properties
are for its phy layer? 

Thanks,
Mauro

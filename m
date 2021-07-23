Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96C3D34DB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhGWGMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 02:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234016AbhGWGMz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 02:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 667CC60EAF;
        Fri, 23 Jul 2021 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627023209;
        bh=i/e+XBZGOkWZNaLp+nA3drrDdTCcSoIelGV0Vb8DGms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBJ5ercP3IT1desg2VZxfq5I/5w/GyFetU1f9uz7a2F9PcHbCjs6fWzcL+DBgkz3C
         GHDINhYxB8XiGeSW54g8pjpN9Hd52FtvsmE5xeifjTjX9/Gd9rNU8qju+5oN0ONvvy
         xl8nEKsf4l0H8uHfr1ZJBWdgbd6OwWxmzmKRhtLK5WfTl3xetYhvWIWLIQ8r6cB3A7
         Yz/Y3zLVDMLkbvLE7iaCR813yyTO7O5BsefNAaSnu6Z0U1NNHOHPfznpw6xBwxvz1Q
         IPzGnyqlXseKOIOpUe9l/UErgvlQbvOQYi57ignd+s9cO0qUMVaVGXryEkIgto9yWT
         H089jumynWHdw==
Date:   Fri, 23 Jul 2021 08:53:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 08/10] arm64: dts: HiSilicon: Add support for HiKey
 970 PCIe controller hardware
Message-ID: <20210723085318.243f155f@coco.lan>
In-Reply-To: <20210722133628.GC4446@workstation>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
        <20210722133628.GC4446@workstation>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Thu, 22 Jul 2021 19:06:28 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> escreveu:

> On Wed, Jul 21, 2021 at 10:39:10AM +0200, Mauro Carvalho Chehab wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Add DTS bindings for the HiKey 970 board's PCIe hardware.
> > 
> > Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
> >  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
> >  drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
> >  3 files changed, 71 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > index 1f228612192c..6dfcfcfeedae 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > @@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
> >  			#clock-cells = <1>;
> >  		};
> >  
> > +		pmctrl: pmctrl@fff31000 {
> > +			compatible = "hisilicon,hi3670-pmctrl", "syscon";
> > +			reg = <0x0 0xfff31000 0x0 0x1000>;
> > +			#clock-cells = <1>;
> > +		};
> > +  
> 
> Irrelevant change to this patch.

Huh?

This is used by PCIe PHY, as part of the power on procedures:

	+static int hi3670_pcie_noc_power(struct hi3670_pcie_phy *phy, bool enable)
	+{
	+       struct device *dev = phy->dev;
	+       u32 time = 100;
	+       unsigned int val = NOC_PW_MASK;
	+       int rst;
	+
	+       if (enable)
	+               val = NOC_PW_MASK | NOC_PW_SET_BIT;
	+       else
	+               val = NOC_PW_MASK;
	+       rst = enable ? 1 : 0;
	+
	+       regmap_write(phy->pmctrl, NOC_POWER_IDLEREQ_1, val);



> 
> >  		iomcu: iomcu@ffd7e000 {
> >  			compatible = "hisilicon,hi3670-iomcu", "syscon";
> >  			reg = <0x0 0xffd7e000 0x0 0x1000>;
> > @@ -660,6 +666,71 @@ gpio28: gpio@fff1d000 {
> >  			clock-names = "apb_pclk";
> >  		};
> >    
> 
> [...]
> 
> > +			#interrupt-cells = <1>;
> > +			interrupts = <0 283 4>;  
> 
> Use the DT flag for interrupts instead of hardcoded value

Do you mean like this?

	interrupts = <0 283 IRQ_TYPE_LEVEL_HIGH>;

> 
> > +			interrupt-names = "msi";
> > +			interrupt-map-mask = <0 0 0 7>;
> > +			interrupt-map = <0x0 0 0 1
> > +					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0x0 0 0 2
> > +					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0x0 0 0 3
> > +					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> > +					<0x0 0 0 4
> > +					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> > +
> >  		/* UFS */
> >  		ufs: ufs@ff3c0000 {
> >  			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
> > diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > index 48c739eacba0..03452e627641 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> > @@ -73,7 +73,6 @@ ldo33: LDO33 { /* PEX8606 */
> >  					regulator-name = "ldo33";
> >  					regulator-min-microvolt = <2500000>;
> >  					regulator-max-microvolt = <3300000>;
> > -					regulator-boot-on;  
> 
> Again, irrelevant.

I'll move it to the USB patch series, where the PMIC is added.

> 
> >  				};
> >  
> >  				ldo34: LDO34 { /* GPS AUX IN VDD */
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index bfc0513f7b15..9dad14929538 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -347,18 +347,6 @@ static const struct regmap_config pcie_kirin_regmap_conf = {
> >  	.reg_stride = 4,
> >  };
> >  
> > -/* Registers in PCIeCTRL */
> > -static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
> > -					 u32 val, u32 reg)
> > -{
> > -	writel(val, kirin_pcie->apb_base + reg);
> > -}
> > -
> > -static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> > -{
> > -	return readl(kirin_pcie->apb_base + reg);
> > -}
> > -  
> 
> Same here...

This hunk should be on patch 03/10. Probably some rebase added it here by
mistake. I'll fix it on v8.

Thanks,
Mauro

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF13DE547
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHCE0G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234056AbhHCEZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 00:25:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E149561158;
        Tue,  3 Aug 2021 04:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627964736;
        bh=SkJpApRxFG/jXxtvFIyQH90yLQk7myOrmz5Wih/Vuyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awMZtxBCR6GUxLWOagGdN/FDay6Jkz15CQMKxFG2yTgIVUsUx6vsnK4JcbxpWjx+1
         kQlCkP6FyuwBM9ub3ON2S7ZlW9f6TjNRAwq+9Q0EaM6rh4Iu38cnCwt5hUjIPJPc0k
         Ci84LWZzZ8CPkAXX0/HqHVO0n6U8fiiksBaVVgjBF1ZiMPygfuk7eOwfZNz5vmCpGx
         7MgVnlsV0tv6tKMWYwZtuCn60lFP+MPUOPsqjlelHwIjM2MtAGF/fgHqBuKmc0sDVK
         X1c69ifh+ndYVuRVbQ2B0qXpp745y3R1qrUx+UZnOEIN4HzEbUgKnfcx+K3Lwlt/aK
         IsMAS/UCBLbpA==
Date:   Tue, 3 Aug 2021 06:25:28 +0200
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
Message-ID: <20210803062528.0a264682@coco.lan>
In-Reply-To: <20210724041150.GA4053@thinkpad>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
        <20210722133628.GC4446@workstation>
        <20210723085318.243f155f@coco.lan>
        <20210724041150.GA4053@thinkpad>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Sat, 24 Jul 2021 09:41:50 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> escreveu:

> On Fri, Jul 23, 2021 at 08:53:18AM +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 22 Jul 2021 19:06:28 +0530
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> escreveu:
> >   
> > > On Wed, Jul 21, 2021 at 10:39:10AM +0200, Mauro Carvalho Chehab wrote:  
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > Add DTS bindings for the HiKey 970 board's PCIe hardware.
> > > > 
> > > > Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
> > > >  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
> > > >  drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
> > > >  3 files changed, 71 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > > index 1f228612192c..6dfcfcfeedae 100644
> > > > --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > > +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > > @@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
> > > >  			#clock-cells = <1>;
> > > >  		};
> > > >  
> > > > +		pmctrl: pmctrl@fff31000 {
> > > > +			compatible = "hisilicon,hi3670-pmctrl", "syscon";
> > > > +			reg = <0x0 0xfff31000 0x0 0x1000>;
> > > > +			#clock-cells = <1>;
> > > > +		};
> > > > +    
> > > 
> > > Irrelevant change to this patch.  
> > 
> > Huh?
> > 
> > This is used by PCIe PHY, as part of the power on procedures:
> > 
> > 	+static int hi3670_pcie_noc_power(struct hi3670_pcie_phy *phy, bool enable)
> > 	+{
> > 	+       struct device *dev = phy->dev;
> > 	+       u32 time = 100;
> > 	+       unsigned int val = NOC_PW_MASK;
> > 	+       int rst;
> > 	+
> > 	+       if (enable)
> > 	+               val = NOC_PW_MASK | NOC_PW_SET_BIT;
> > 	+       else
> > 	+               val = NOC_PW_MASK;
> > 	+       rst = enable ? 1 : 0;
> > 	+
> > 	+       regmap_write(phy->pmctrl, NOC_POWER_IDLEREQ_1, val);
> > 
> >   
> 
> Ah... you're hardcoding the syscon compatible in driver. Sorry missed that.
> 
> But if these syscon nodes are independent memory regions or belong to non
> PCI/PHY memory map, you could've fetched the reference through a DT property
> along with the offset then used it in driver.
> 
> Like,
> 
> 	pcie_phy: pcie-phy@fc000000 {
> 		...
> 		hisilicon,noc-power-regs = <&pmctrl 0x38c>;
> 		hisilicon,sctrl-cmos-regs = <&sctrl 0x60>;
> 		...
> 	};
> 
> The benefit of doing this way is, if the pmctrl, sctrl register layout changes
> in future, you can handle it without any issues.

Interesting approach, but probably overkill. I mean, the register mapping
here should be the same for all Kirin 970 PHY based devices. A PHY for a 
different SoC will likely have other differences than just those two regs.

Regards,
Mauro

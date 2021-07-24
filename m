Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8583D44C2
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 06:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGXDbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 23:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhGXDba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 23:31:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9846C061575
        for <linux-pci@vger.kernel.org>; Fri, 23 Jul 2021 21:12:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so5220372plr.13
        for <linux-pci@vger.kernel.org>; Fri, 23 Jul 2021 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUphzkjUs+f4n/CtLJYGpw/KLAKzYjnMeedmlil2VfU=;
        b=zTJH4iNYY4OUanJzT20qn/k2Y3F7vryjGfoUP8T44ogvs/tbifGEMY8h92eSXNX79z
         drsWuep/h7XBbGu3TOJ5aAMylJhOHGZgNCoffJn5naPY94gNxUp6YbNj4a6FV+Bq6YF/
         cih62d1jmupILuZyU2u/sQed37mBAe//xyFWp/N4qy0oBjqDp9w5N3THpSmK6CMYx1HW
         1xpPcZdXB+b5Vjo3BTseCh0qU8Eng7QVRBu9u7S3j4KZFTfGgRy0+iLGoRJP+0e3KODF
         tgqobbIMhJ/zhfyHjS41YJCtoBIQsvjpGoPvQr8MOw2o0pcM5pa8nhP3o6dRc1tdrHbT
         iE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUphzkjUs+f4n/CtLJYGpw/KLAKzYjnMeedmlil2VfU=;
        b=hhSvuIGqC4NBAHSqBZYlom5j8NdXPuEKqnys6/T5UR7JMkIGA9f609dP/ovR92QWAj
         3+88MXnWZBHUB9isJdhnQdV3k3YfDQ48PmpUrHMSo4MHtTeXFH55fQqPQn3VIpWBXXEQ
         PL36ok4dXMnuuhjofnhYwALCWk1PV6g5cTcNtwEOUtT6d1jtv6WVYRcOltuZRjZbV4tI
         lgzDpBEiCo1mgSTP1PrduqaFlGORwCvxtzGF3V3lcdlYkpPWRrXW7ch3HV60uZwboJ7x
         80N+CygmmenqxioOxtsgZGCycKyNx+JUBfpxKeJvM8JFsgSVlb9aw3gcT1sj/5Eoq+jg
         Gr6w==
X-Gm-Message-State: AOAM530TzF1SfZYhCPxO9nAbkdbVqrYk+CNY1yU8iXXCqf3f1PiaGIwX
        SR+SUtcqZGYQQvR7qPlJoBL5
X-Google-Smtp-Source: ABdhPJyF8KwnLqCkSTt9iDq9FhsyJmhA8Jj9Zs+eo6AdGTjl2rCUNhFYnLMiGShGiRUHgcl8UBEiwQ==
X-Received: by 2002:a63:a01:: with SMTP id 1mr7721060pgk.360.1627099921090;
        Fri, 23 Jul 2021 21:12:01 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d0b:3004:b3d2:21bb:b6c1:27fa])
        by smtp.gmail.com with ESMTPSA id b1sm7319151pjn.11.2021.07.23.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 21:11:59 -0700 (PDT)
Date:   Sat, 24 Jul 2021 09:41:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 08/10] arm64: dts: HiSilicon: Add support for HiKey
 970 PCIe controller hardware
Message-ID: <20210724041150.GA4053@thinkpad>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
 <20210722133628.GC4446@workstation>
 <20210723085318.243f155f@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723085318.243f155f@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 08:53:18AM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 22 Jul 2021 19:06:28 +0530
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> escreveu:
> 
> > On Wed, Jul 21, 2021 at 10:39:10AM +0200, Mauro Carvalho Chehab wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Add DTS bindings for the HiKey 970 board's PCIe hardware.
> > > 
> > > Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
> > >  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
> > >  drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
> > >  3 files changed, 71 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > index 1f228612192c..6dfcfcfeedae 100644
> > > --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> > > @@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
> > >  			#clock-cells = <1>;
> > >  		};
> > >  
> > > +		pmctrl: pmctrl@fff31000 {
> > > +			compatible = "hisilicon,hi3670-pmctrl", "syscon";
> > > +			reg = <0x0 0xfff31000 0x0 0x1000>;
> > > +			#clock-cells = <1>;
> > > +		};
> > > +  
> > 
> > Irrelevant change to this patch.
> 
> Huh?
> 
> This is used by PCIe PHY, as part of the power on procedures:
> 
> 	+static int hi3670_pcie_noc_power(struct hi3670_pcie_phy *phy, bool enable)
> 	+{
> 	+       struct device *dev = phy->dev;
> 	+       u32 time = 100;
> 	+       unsigned int val = NOC_PW_MASK;
> 	+       int rst;
> 	+
> 	+       if (enable)
> 	+               val = NOC_PW_MASK | NOC_PW_SET_BIT;
> 	+       else
> 	+               val = NOC_PW_MASK;
> 	+       rst = enable ? 1 : 0;
> 	+
> 	+       regmap_write(phy->pmctrl, NOC_POWER_IDLEREQ_1, val);
> 
> 

Ah... you're hardcoding the syscon compatible in driver. Sorry missed that.

But if these syscon nodes are independent memory regions or belong to non
PCI/PHY memory map, you could've fetched the reference through a DT property
along with the offset then used it in driver.

Like,

	pcie_phy: pcie-phy@fc000000 {
		...
		hisilicon,noc-power-regs = <&pmctrl 0x38c>;
		hisilicon,sctrl-cmos-regs = <&sctrl 0x60>;
		...
	};

The benefit of doing this way is, if the pmctrl, sctrl register layout changes
in future, you can handle it without any issues.

> 
> > 
> > >  		iomcu: iomcu@ffd7e000 {
> > >  			compatible = "hisilicon,hi3670-iomcu", "syscon";
> > >  			reg = <0x0 0xffd7e000 0x0 0x1000>;
> > > @@ -660,6 +666,71 @@ gpio28: gpio@fff1d000 {
> > >  			clock-names = "apb_pclk";
> > >  		};
> > >    
> > 
> > [...]
> > 
> > > +			#interrupt-cells = <1>;
> > > +			interrupts = <0 283 4>;  
> > 
> > Use the DT flag for interrupts instead of hardcoded value
> 
> Do you mean like this?
> 
> 	interrupts = <0 283 IRQ_TYPE_LEVEL_HIGH>;
> 

yes but you could also use,

	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;

Thanks,
Mani

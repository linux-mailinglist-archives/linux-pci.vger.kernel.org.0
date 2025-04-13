Return-Path: <linux-pci+bounces-25726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2907A87233
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74461892145
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC526ADD;
	Sun, 13 Apr 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2DhXvoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FF1A23B5
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744553596; cv=none; b=pthbMMQUO4H9aaZjb48pnXtlo5DD5zLe2vpBDIZ1mmsOjG4glsbcX70bXD37pTd+csiePzNRZN+OyMxJ5M0iRwBCiDgeNBQ4UHWLc1Wbw9RUkGwWZadbpdNxGGmNwE/e2w1OObJ3g5+RFWeD0k18SdWbeIrE4ft6rL3AxqW6/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744553596; c=relaxed/simple;
	bh=MTMySu9l51fD2dVWjJvZtk9X2dn/X/Lj8ZL927kSy8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufsHVFY2Sr6izKFDEA+p2yKxYgmxECHDKsQeBJK6+MuM3MImVDSCfwpHESJsoLEeC8Z5amoamzXMZYMXO1Bu9zh/KHfAFz0AzOC5Hp8sFV8Ug/A6Grv4qs+tx2r9wI+efIyjOHlZ7oYDNy+IkzFd7CgI/LO8lBQHccJB5+ff9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2DhXvoo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736b0c68092so2914907b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744553594; x=1745158394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDGkU74MBhCdgJJMoNaDSjeUhoyAzk0gL7nqKzTZvSA=;
        b=v2DhXvooC0z7Ir5vHkjNGKIxyclQ9T4G4R172mNvayB6/lcS0UHTylVJ287LpTKHfL
         S6eEj8m7GwjI8fDkAQ+/QdqNslXTk/RQG/7ASRL8+XCgoE6K/lF1NmxLf4ONuxGRt2Ss
         7l2YkPZemij9tdnXKjNvdoGhwiQH/cV2y4AFlCGQXMfKCH8hy4IJpFwC4JNnxdWTRmIx
         AJqlLL3j9wclLo7ToAmrNv+X9X9x8QMChVAu4P5K8X3CA2T6KCVjP0Rzwj7wpQ7DHEpT
         QxWaqGhhmcN1k8fnGxsTo7DYOhPJ5RrpOpRUJtZeAUrHms+C1LcciIpwRI3o98ZjGTMY
         Ziog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744553594; x=1745158394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDGkU74MBhCdgJJMoNaDSjeUhoyAzk0gL7nqKzTZvSA=;
        b=G17kWUfehsxnjFJmVLe8Gn64jdFqoMAX+k6eaBku4chu5QCxjrO4cP9CeT99a2+bKB
         WuVfvy52d9AI9vq9n+UVEe2FzmudGKIe3hXi1sS3rkzEt/p0iBHqNBM+K/h91Ubd4yM6
         T5qyxRUKfFe98tIpvHfvx0l2nJ5DOQK0sLWROKneTGYKTMgI6CwNNe+1vqFznMwW46a8
         fl2PzVG30zbwumRu0o2L9OIYpRLlDBbjxxu/hH1pkhfqM+RShXlecwNiKTTiOCdK6Xpf
         QBnHVF8Rhxc4Hnd9Angme+/2iMMQoHwGi2S8NNXvQNv2PDSte/TwSxh/ivKj5kszHsj5
         qiAg==
X-Forwarded-Encrypted: i=1; AJvYcCVv0bdBTZMX7o9yMbNdlWdi6kcdt95DWl3sBEjLh9FZPX68UEZjVavaBqAGOscKb+7txiM6fnlP2Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzcTk26obSIFLH0pL7Sur+L8pKo2O4WKNNAcCujB26F2ih/wm
	8kBItLBtHpIoRpbYjvkbVRzdgJkzFACozUVGLP76hw4ANNptj/QU9YTa1B75qg==
X-Gm-Gg: ASbGncvFuUPcSqEvCTtMM7UMvUdg6MK4PCbkSWvov/AgYf7rkpUZ4gTx3Ecu2GwKv96
	SVdkiXxTBdwh6IGqVQtT9n4Iy4mKEPGe5s1Um2gie/StCtWUNMFyn1s///9GCvLL+Avb1KjW+WK
	urnF+v8hVcJrwAlo/5527G7CWweYctgyRyV4Hg+rXBQlS48XLGjVFDP5ms5qXZaB69H0BRJtRuS
	cps0JpbK816pfhf6IAGJLe+Hfv0tde63WxmkwcGpkzKX5T0HCWO0WgHZVMsTNGc6wKTecWCg4lu
	1GDL/gkvf+wnZ21u7HWGXFGjwoR/3oUFURNokZ6KkvVU7jqIjHfv
X-Google-Smtp-Source: AGHT+IG3KsEC7opdxKauuCqzbkQebp3bxI0hJGkx4B9uTAWlK9jJFs28Sw9U9lh+D1sRPZ4sMA2Hkw==
X-Received: by 2002:a05:6a00:4644:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73bd12b1315mr12154297b3a.23.1744553593852;
        Sun, 13 Apr 2025 07:13:13 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c33bfsm4979324b3a.42.2025.04.13.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 07:13:12 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:43:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 18255117159@163.com, 
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com, 
	thomas.richard@bootlin.com, bwawrzyn@cisco.com, linux-pci@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 4/4] PCI: j721e: Add support to build as a loadable
 module
Message-ID: <6bi5gul3sqvycmkf6cwokkvownjffaf2tkonjlefo2d7cautwx@uhfexzgz3okp>
References: <20250330083914.529222-1-s-vadapalli@ti.com>
 <20250330083914.529222-5-s-vadapalli@ti.com>
 <zsxnx7biwogov5dw5yiafkgk6tsrtspac75bjbrca5uevweaim@ly67hwfyk7qh>
 <20250409064227.ctzznnb2shaygxhm@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409064227.ctzznnb2shaygxhm@uda0492258>

On Wed, Apr 09, 2025 at 12:12:27PM +0530, Siddharth Vadapalli wrote:
> On Wed, Apr 09, 2025 at 12:06:35PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Sun, Mar 30, 2025 at 02:09:14PM +0530, Siddharth Vadapalli wrote:
> > > The 'pci-j721e.c' driver is the application/glue/wrapper driver for the
> > > Cadence PCIe Controllers on TI SoCs. Implement support for building it as a
> > > loadable module.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > v1:
> > > https://lore.kernel.org/r/20250307103128.3287497-5-s-vadapalli@ti.com/
> > > Changes since v1:
> > > - Based on feedback from Thomas at:
> > >   https://lore.kernel.org/r/88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com/
> > >   the "check" for a non-NULL "pcie-refclk" in j721e_pcie_remove() has been
> > >   dropped.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  drivers/pci/controller/cadence/Kconfig     |  6 ++--
> > >  drivers/pci/controller/cadence/pci-j721e.c | 33 +++++++++++++++++++++-
> > >  2 files changed, 35 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > index 82b58096eea0..72d7d264d6c3 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
> > >  	  different vendors SoCs.
> > >  
> > >  config PCI_J721E
> > > -	bool
> > > +	tristate
> > >  
> > >  config PCI_J721E_HOST
> > > -	bool "TI J721E PCIe controller (host mode)"
> > > +	tristate "TI J721E PCIe controller (host mode)"
> > >  	depends on ARCH_K3 || COMPILE_TEST
> > >  	depends on OF
> > >  	select PCIE_CADENCE_HOST
> > > @@ -57,7 +57,7 @@ config PCI_J721E_HOST
> > >  	  core.
> > >  
> > >  config PCI_J721E_EP
> > > -	bool "TI J721E PCIe controller (endpoint mode)"
> > > +	tristate "TI J721E PCIe controller (endpoint mode)"
> > >  	depends on ARCH_K3 || COMPILE_TEST
> > >  	depends on OF
> > >  	depends on PCI_ENDPOINT
> > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > index ef1cfdae33bb..8bffcd31729c 100644
> > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/platform_device.h>
> > > @@ -27,6 +28,7 @@
> > >  #define cdns_pcie_to_rc(p) container_of(p, struct cdns_pcie_rc, pcie)
> > >  
> > >  #define ENABLE_REG_SYS_2	0x108
> > > +#define ENABLE_CLR_REG_SYS_2	0x308
> > >  #define STATUS_REG_SYS_2	0x508
> > >  #define STATUS_CLR_REG_SYS_2	0x708
> > >  #define LINK_DOWN		BIT(1)
> > > @@ -116,6 +118,15 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
> > >  	return IRQ_HANDLED;
> > >  }
> > >  
> > > +static void j721e_pcie_disable_link_irq(struct j721e_pcie *pcie)
> > > +{
> > > +	u32 reg;
> > > +
> > > +	reg = j721e_pcie_intd_readl(pcie, ENABLE_CLR_REG_SYS_2);
> > > +	reg |= pcie->linkdown_irq_regfield;
> > > +	j721e_pcie_intd_writel(pcie, ENABLE_CLR_REG_SYS_2, reg);
> > > +}
> > > +
> > >  static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
> > >  {
> > >  	u32 reg;
> > > @@ -633,9 +644,25 @@ static void j721e_pcie_remove(struct platform_device *pdev)
> > >  	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
> > >  	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
> > >  	struct device *dev = &pdev->dev;
> > > +	struct cdns_pcie_ep *ep;
> > > +	struct cdns_pcie_rc *rc;
> > > +
> > > +	if (pcie->mode == PCI_MODE_RC) {
> > > +		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
> > > +		cdns_pcie_host_disable(rc);
> > > +	} else {
> > > +		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
> > > +		cdns_pcie_ep_disable(ep);
> > > +	}
> > > +
> > > +	if (pcie->reset_gpio) {
> > > +		msleep(PCIE_T_PVPERL_MS);
> > 
> > There is no point in adding a delay before PERST# assertion.
> 
> True :)
> 
> > 
> > > +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > 
> > This is not PERST# assert, isn't it? Typo?
> 
> It is PERST# assert.

Since the reset-gpios polarity is defined as GPIO_ACTIVE_HIGH in DT (which is
wrong unless you have an external component that changes polarity), for PERST#
assert, you need to set 0. If you set 1, then PERST# will be signalled as
deassert.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


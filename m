Return-Path: <linux-pci+bounces-22064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31AA40460
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6272707830
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42255588F;
	Sat, 22 Feb 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiNGo1xG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827D4F218;
	Sat, 22 Feb 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185046; cv=none; b=N7MaCeVDNL5m5JCXparcjAZvzmiBhIbms/zSdAjWYdcEzCtzWv+7YCd+Ks4d4NmKgGOxQJosIRm+puRnYoXCkKyb7hUYps8vRkE9EHZmu8WDw4Mp7plrIFJ2Y/Gap3HkLe0POZlZ/8+q3qX0PM5Wj5XuBpuMAV7RNShX+r44dxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185046; c=relaxed/simple;
	bh=rVIkEHAtGYkLu2/McHlDwK6UU1jTxU5sHLOBbtEgOcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+nEv0sQZU5/7aVbepCZSXiSmbS6yodaCq+qLuAo3C65u4nrw2c3wn5nNqT58Ml8omhybJFDrtyzlHlfHMRK4dpBnB0Fz2s+GwzR/xvOhcd+7lVgKT2iVRdYbttpqO4sw+RbUWGaAn8yKgZpMNr2DXqX21Ku1r0IuYuRr8e84HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiNGo1xG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0818add57so278321685a.3;
        Fri, 21 Feb 2025 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740185044; x=1740789844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mfYiMV8kidUXmGLYF/BaWuuheQWf14kVQL8yo9io9o=;
        b=MiNGo1xGrOm5yGnRjX+SIWdDC1Hkg+VhVqaNgCjjGyX6oDSWBsteOtz0ObMIUxkWza
         PRZ5QR9gXMP7YQcEtkKs5V3OPE91AyeKMTpL60OgYyOlYSY113TOF/4PFFjPBPmkoiLm
         kDqlVlEmuvNIYlI4ykoHD5G2HWIc9MF5YKJODaLcAOR2rNBVM1CvGvE/rTe4kx9VIl2W
         qRtiahxxDad5ZQ2/GCFseMT0aFI4hN8C14uANH7phKmBfhlp6JSPB5kt9JJoUg5UArfi
         rbVMIzbzx+DIwW59ChQrwsiSl/iOwanNKMB3GhZ3JB1ojyLPb2TsnERJnBhxosssIjpq
         QpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740185044; x=1740789844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mfYiMV8kidUXmGLYF/BaWuuheQWf14kVQL8yo9io9o=;
        b=eWxwCndAg6vzwHeb7msdtveAU4JplTNQLFSVG5arjgAQ/gwfLY/sD0dlGyFLRBlP0M
         Yt/RsKxaWXlKX7ipSCOq/CNx62s8HTmL738mdkCJ0Y+KZkPLvJIrlETvDn4KXK7Ohc8h
         LN8r5x/9t3Ld9jG6xcTipl82VyQ9JXpQWyqmmZmnfX3YtH+aZDOB3HEfYPtmxO5QqA4Z
         Y2600QGdmqXVNXRyLif7SypmQHykUoC9pf5CJMERnUwvCIaFHZC6dAcJggM2gc/i2XiT
         mM5fiZkrM77yNHuKyr4Ts4QL6grG5lzDHOAIwL6PCdMthFxDyR2LH8oUWm3WBBYr88nm
         yDpg==
X-Forwarded-Encrypted: i=1; AJvYcCUMJZA1IIwKxWpW2Q/kfCny1VOuIV/nzt7+A5OMtaZIWZslJMrsfvrjnBHfPJ8o6c0cM1MGWmv2nke6@vger.kernel.org, AJvYcCUsKPoeOT5kwHHcP5x8QCAV6cv8+TrBmlGp5uha8vzpgSDSBtDUoxgWQHIu0zkdtR3KrOrbO/jV8ulr@vger.kernel.org, AJvYcCUuk93UqWHBuw6IRpE0AXnNe68wKjC4hFZYhjVFUcToCUpZtT2Gx6VtBCSOOS081NK5EUyuwRVOguYFIQ9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6n1qdpyCmvtxn1DS2EvRaPBUk/ZX7A0aVP7QYYDigUf7E8hrt
	1oeMv2eXm2G47+K8o7T0JMhWPYYWa7GAu2ZmHTk8CmGUKs4BhQ/7
X-Gm-Gg: ASbGnct4LsVTr/KCV5bYWNsPCsFTizsjy/qu7TBxdUgOYdgTRGXF6975D+0uO4MYx0V
	5rSnbYf+daOtowHk3xMtejN1V2K8GqNvtygktYoEJnBDezEvA2zIithBZAWMigaeodMuP5qxz/G
	C5VbpkaPZzFd82wJ2zIRtTCsT+kyGPKj4SQWtdBuG3kUZaSJxHAyzHPPtw36IgNfzkCpXem962n
	Jtd7Ct/+IsMJiL2dh0Zma53062Dh5ZQtkQ52P11Q2EShZLeEGFka1hz8dUmjjwxzbIk5NVlRv12
	OA==
X-Google-Smtp-Source: AGHT+IFzV+P0z5pv+ZCpM8NN+jOatwS5dJ8bp2X5/A+AMv3Hu8hpM6OiyB0lB2UVj8l8h5auvYUeaw==
X-Received: by 2002:a05:620a:801b:b0:7c0:c42a:7078 with SMTP id af79cd13be357-7c0cf96d0f1mr710092885a.52.1740185043862;
        Fri, 21 Feb 2025 16:44:03 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c096443dc4sm721179685a.60.2025.02.21.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:44:02 -0800 (PST)
Date: Sat, 22 Feb 2025 08:43:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Niklas Cassel <cassel@kernel.org>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <fanm6m6fx6cqwalhdvrxmjzsluiyptbvrwbi5ufwbqmxsf62xl@lntprhkjv6tm>
References: <20250221013758.370936-3-inochiama@gmail.com>
 <20250221234958.GA372914@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221234958.GA372914@bhelgaas>

On Fri, Feb 21, 2025 at 05:49:58PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 21, 2025 at 09:37:56AM +0800, Inochi Amaoto wrote:
> > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> 
> > @@ -341,6 +341,16 @@ config PCIE_ROCKCHIP_DW_EP
> >  	  Enables support for the DesignWare PCIe controller in the
> >  	  Rockchip SoC (except RK3399) to work in endpoint mode.
> >  
> > +config PCIE_SOPHGO_DW
> > +	bool "SOPHGO DesignWare PCIe controller"
> 
> What's the canonical styling of "SOPHGO"?  I see "Sophgo" in the
> subject line and in Chen Wang's SG2042 series.  Pick the official
> styling and use it consistently.
> 

This is my mistake. It should be "Sophgo", I will change it.

> Reorder this so the menuconfig menu items remain alphabetically
> sorted.
> 

I think this order is applied to the entry title in menuconfig,
and is not the config key? If so, I will change it.

> > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	depends on OF
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Enables support for the DesignWare PCIe controller in the
> > +	  SOPHGO SoC.
> > +
> >  config PCI_EXYNOS
> >  	tristate "Samsung Exynos PCIe controller"
> >  	depends on ARCH_EXYNOS || COMPILE_TEST
> 
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for Sophgo SoCs.
> 
> Looks too generic, since Chen Wang's series says Sophgo SG2042 SoC is
> Cadence-based, so this driver apparently doesn't cover all Sophgo
> SoCs.
> 

OK, I will change the description to point it only cover
the controller based on the DesignWare core.

> > + *
> 
> Spurious blank line.
> 
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/property.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
> > +
> > +#define PCIE_INT_SIGNAL			0xc48
> > +#define PCIE_INT_EN			0xca0
> > +
> > +#define PCIE_SIGNAL_INTX_SHIFT		5
> > +#define PCIE_INT_EN_INTX_SHIFT		1
> 
> Define masks with GENMASK() and get rid of the _SHIFT #defines.
> 
> > +#define PCIE_INT_EN_INT_SII		BIT(0)
> > +#define PCIE_INT_EN_INT_INTA		BIT(1)
> > +#define PCIE_INT_EN_INT_INTB		BIT(2)
> > +#define PCIE_INT_EN_INT_INTC		BIT(3)
> > +#define PCIE_INT_EN_INT_INTD		BIT(4)
> 
> These are unused, drop them.
> 
> > +#define PCIE_INT_EN_INT_MSI		BIT(5)
> > +
> > +struct sophgo_pcie {
> > +	struct dw_pcie pci;
> > +	void __iomem *app_base;
> > +	struct clk_bulk_data *clks;
> > +	unsigned int clk_cnt;
> > +	struct reset_control *rst;
> > +	struct irq_domain *irq_domain;
> 
> Indent the member names to align vertically as most other drivers do.
> 
> > +};
> > +
> > +static int sophgo_pcie_readl_app(struct sophgo_pcie *sophgo, u32 reg)
> > +{
> > +	return readl_relaxed(sophgo->app_base + reg);
> > +}
> > +
> > +static void sophgo_pcie_writel_app(struct sophgo_pcie *sophgo, u32 val, u32 reg)
> > +{
> > +	writel_relaxed(val, sophgo->app_base + reg);
> > +}
> > +
> > +static void sophgo_pcie_intx_handler(struct irq_desc *desc)
> > +{
> > +	struct dw_pcie_rp *pp = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> > +	unsigned long hwirq = PCIE_SIGNAL_INTX_SHIFT;
> > +	unsigned long reg;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	reg = sophgo_pcie_readl_app(sophgo, PCIE_INT_SIGNAL);
> > +
> > +	for_each_set_bit_from(hwirq, &reg, PCI_NUM_INTX + PCIE_SIGNAL_INTX_SHIFT)
> 
> Use FIELD_GET() here and iterate through PCI_NUM_INTX.  Then you don't
> need for_each_set_bit_from() and shouldn't need PCIE_SIGNAL_INTX_SHIFT
> here and below.
> 

OK, I will change it

> > +		generic_handle_domain_irq(sophgo->irq_domain,
> > +					  hwirq - PCIE_SIGNAL_INTX_SHIFT);
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void sophgo_intx_mask(struct irq_data *d)
> > +{
> > +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&pp->lock, flags);
> > +
> > +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> > +	val &= ~BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);
> 
> FIELD_PREP().
> 
> > +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> > +
> > +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> > +};
> > +
> > +static void sophgo_intx_unmask(struct irq_data *d)
> > +{
> > +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> > +	unsigned long flags;
> > +	u32 val;
> > +
> > +	raw_spin_lock_irqsave(&pp->lock, flags);
> > +
> > +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> > +	val |= BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);
> 
> Ditto.
> 
> > +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> > +
> > +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> > +};
> > +
> > +static void sophgo_intx_eoi(struct irq_data *d)
> > +{
> > +}
> > +
> > +static struct irq_chip sophgo_intx_irq_chip = {
> > +	.name			= "INTx",
> > +	.irq_mask		= sophgo_intx_mask,
> > +	.irq_unmask		= sophgo_intx_unmask,
> > +	.irq_eoi		= sophgo_intx_eoi,
> 
> Name these ending with the irq_chip field names, e.g.,
> sophgo_intx_irq_mask(), to make them easier to find with grep.
> 
> Bjorn

Thanks, I will take all the comments and improve the driver.

Regards,
Inochi


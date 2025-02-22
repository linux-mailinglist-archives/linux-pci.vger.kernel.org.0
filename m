Return-Path: <linux-pci+bounces-22060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D51A40424
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDDA3B4781
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6567127456;
	Sat, 22 Feb 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no1WIsy3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA032E40E;
	Sat, 22 Feb 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184225; cv=none; b=ZSwTaZlB+pmZ56qwttq/B4x9wo+gCTTuDszT9HJvByDCU4q8PAeAh7bsihS5txm0TtIXxpBsMnZ7PfGu15fCF6BNvlo8BuZkMU4prKZdXE180pJalH29pCK0HpyV6H2Ooql4lZDmKnxdCsMOOBz1jrX7GHyQSP8rzfMd+J6jwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184225; c=relaxed/simple;
	bh=KuzXW3kq2XXsM0NjjSzvtwehF2ywXjUmDWXyxtz1xpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6ZV6cEYv62jLthautzO67UDzvpEVKbb4y95FBHE+/hx2hLPl/SN0eFnIffhOVaZ0hi5uBmlosigfDXPahyEiH5w3Iz38/bzJc+/SPJ809svntnbtvQgCnyYLXBbQ8kO8L22IWAGxpvOdgqaa/pGpZvOsjA0JD2t7a5onBmdZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no1WIsy3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e6719e6e82so21825696d6.2;
        Fri, 21 Feb 2025 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740184222; x=1740789022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jZqoRf6sss+7D2DNzyKiOZnwgWa7edWmqX7FcgvgLo=;
        b=no1WIsy39oepxauNmUtVDIPQ2kiVMj/f+7SvUOJRgf9c3MY0xFkfRGxFZ6n/rKV0zv
         LNyv2+2tLW8ahLIIlSxXRRZKRGRfDBZPK/F71w0NjgZstVS7a4xp9NEJAcQ4JqHFO9Uv
         N+paojog2h2x+5PWUzySS4LXDv/DhjuvpcYM2N1NIpoptjP/PmYWOJiLF/7HrnQT6fEd
         huDMNz8+5CfAlpK+p5oJo6rEle9KGA7+N4zVMCNUpRrnti5kDWvpFEfVnB10roBzb1R9
         lzzpCTHuxB4nP8TK/iYESyWfQ+6o4p3Ikl73MpSKmJkyyifyYE29nPnE2ZSWvb6MrpDM
         x/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184222; x=1740789022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jZqoRf6sss+7D2DNzyKiOZnwgWa7edWmqX7FcgvgLo=;
        b=LCSWn4QonJXPg6qDqLeNPAdfMftGG//MMj+hUDb/eHPl8JMvhUwF+IAdmKePsKngWO
         wQxRK/yasg7+6m4ffRd4YV//aDgj1ZDrxsivYObav6NWkb5W98PrmBnHPleNhpJD9JWJ
         zx4/ZoJ+oDc+KjmUIJw3es7CqiVvmW+udwiiZOj0ho8ioOqmxCyqdF7ocIvZpd16KjjU
         pGkL2oQICDS8AMrschpDOfX6639D8NmETkxT95GGa1SqXKrItch8UOLLUdDNwpZHXb8A
         89AptWB/Cee8AOWmHJhG4yz3ZY0B8ssPmf7MqRUY3w+P8aB262RfIMz/MI3IQOgcXb6w
         LmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXJdwdsWg0Fvx3ehigYJpqr5rMU9qwTJz305s18HZVQU3+Vnwpkm5BwlzRuuRj6XNe3nymb7d/jW8cL@vger.kernel.org, AJvYcCXRqtHKqfsmf8aEoaq3uY9gVv6Ys1AyRtDqn39wIHBf6sxFdkfyP+g0DGQv/0AuP7rV1iH7OegmQUHx9UeV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35XmZM9p/dBx2ioFBnHevlMY6o/bycAPrgMm6FWO5uZF8UVko
	CTmzK6RB3udkXghB8nFMxN/5qpEN2pJXxm3YGszcbi/eyDxE0Kme
X-Gm-Gg: ASbGncsPFR33rxQvWYBFOXMMGfTQQ2Opv+ZUq8QGlCSic2K77VsJABbXNGEr5xzx/Vw
	HTs3REQIGxOYR3agCZ8SuzU03c7txJvk2ds0xGl3Wg16S6Lu9Ym+ALub2O4u8kWxMGBkEQIkcMi
	/CA3/8irL6KDl0fMwJMvLCETyfc4T9bT0KxI8erEgtpmByKipoHeaI2drOlkTqLg2q/kPS8ld5N
	oE3r19TgFnpU8lJ6r7LMfLOftMWI9+wYOIVKqwwxLIa7dHq1Ri1dQYq9eZDoaEDKE8iDXAQNQd9
	gQ==
X-Google-Smtp-Source: AGHT+IGzSztHttj2eqWBMxKIMx7sJIW+3HS3UjtU9KRJWKyCjr0SAYSd6roWKk1avtZ7VxOsb59iBA==
X-Received: by 2002:a05:6214:d65:b0:6e4:2f90:a9ca with SMTP id 6a1803df08f44-6e6b0036108mr76427546d6.3.1740184222448;
        Fri, 21 Feb 2025 16:30:22 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c0a71326b4sm586886485a.4.2025.02.21.16.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:30:21 -0800 (PST)
Date: Sat, 22 Feb 2025 08:30:04 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Niklas Cassel <cassel@kernel.org>, Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <sbvui5ezehqtfxttga62jlkyzytnwq4fzra3kxfmbmqtxigfyx@zuzs2hcaymmv>
References: <20250221013758.370936-1-inochiama@gmail.com>
 <20250221013758.370936-3-inochiama@gmail.com>
 <d31a48ebfc0f91de615af75e313caa6afbdd597d.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31a48ebfc0f91de615af75e313caa6afbdd597d.camel@pengutronix.de>

On Fri, Feb 21, 2025 at 10:07:54AM +0100, Philipp Zabel wrote:
> On Fr, 2025-02-21 at 09:37 +0800, Inochi Amaoto wrote:
> > Add support for DesignWare-based PCIe controller in SG2044 SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig          |  10 +
> >  drivers/pci/controller/dwc/Makefile         |   1 +
> >  drivers/pci/controller/dwc/pcie-dw-sophgo.c | 282 ++++++++++++++++++++
> >  3 files changed, 293 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
> > 
> [...]
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-sophgo.c b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
> > new file mode 100644
> > index 000000000000..a4ca4f1e26e0
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-dw-sophgo.c
> > @@ -0,0 +1,282 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe host controller driver for Sophgo SoCs.
> > + *
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
> 
> Drop this ...
> 
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
> > +
> > +#define PCIE_INT_SIGNAL			0xc48
> > +#define PCIE_INT_EN			0xca0
> > +
> > +#define PCIE_SIGNAL_INTX_SHIFT		5
> > +
> > +#define PCIE_INT_EN_INTX_SHIFT		1
> > +#define PCIE_INT_EN_INT_SII		BIT(0)
> > +#define PCIE_INT_EN_INT_INTA		BIT(1)
> > +#define PCIE_INT_EN_INT_INTB		BIT(2)
> > +#define PCIE_INT_EN_INT_INTC		BIT(3)
> > +#define PCIE_INT_EN_INT_INTD		BIT(4)
> > +#define PCIE_INT_EN_INT_MSI		BIT(5)
> > +
> > +struct sophgo_pcie {
> > +	struct dw_pcie pci;
> > +	void __iomem *app_base;
> > +	struct clk_bulk_data *clks;
> > +	unsigned int clk_cnt;
> > +	struct reset_control *rst;
> 
> ... and this. It is unused.
> 
> 
> regards
> Philipp

Thanks, I will remove this.

Regards,
Inochi


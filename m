Return-Path: <linux-pci+bounces-20246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B32A197B7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA01188CE44
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8021422E;
	Wed, 22 Jan 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cROGzRaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE904A18
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567303; cv=none; b=nIoJeduUH7L1TegH3XNcVR+5usDgqC1qaUauSrtUq6mUG3o4mDwMb7BtXxJOAIW41zaCC2W7UIn4F9Rn2Wfc8PbU+VZ5hDnbUmr5eUNxyLt/wg5nn0MIsifNyvjvij4lwmkNJ40qbGG0CxtMltNX3D00HdBRyDMpGCWWe3mAWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567303; c=relaxed/simple;
	bh=wmMHhrl/gI6vUafoflEH4OsxrpkM163DYP32d66VNUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgL1+DfS45FCVcPM3sQme5F0d4eJnXjNcKMY6Bt0EQf+NNVZFP1EZyTDtzXh5d7VT7GvJ0Sf5lrvSCmZsQ2oYcXLzaeTAJGISvzn+XyZPikaCjnSZbJMhS9bFrJWD7LjgRsHbpDyRTqoULDfbyNvLHzmQ8wXctjXHw5/w0pdi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cROGzRaT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21661be2c2dso131847095ad.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737567300; x=1738172100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IAEG7j3YoAapRtz5l9O6FiT3v3lTn5Cx8ci+PI4OmP8=;
        b=cROGzRaT6d40SEa2R0uRSbHN5l0bQ0iOSbnM2wjITZESs1mgmT5D4EiVMUbN0Gtdla
         dJWH5+n/7ZpIip3O2yzpht+s0lh352KyGb2e9RHlZCmFtwKgE9uer+ygFhyxm/vp/aWw
         2Aa6wR8ArDAoUy9h3P63U+eYfDitkiqTEmqmDC0ZB7RoLHUhVcaYiirem8vIRG2QpHBo
         AIgi7ndtZPgUtpP4aNg6qVRQOdt5N69/5veO9wofunlAbcVh8MTx8kMfnzZTnnYhkED1
         o7WTYhk8AlU7Ga2T9jmQPnGMq7P8OVinuBG5wlYMY1CoJM24oGAt6k7n8hyJDaZY1nfr
         orwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567300; x=1738172100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAEG7j3YoAapRtz5l9O6FiT3v3lTn5Cx8ci+PI4OmP8=;
        b=vSXubUQhgKm9q8pS6vUhcuJDp9/A+yKxxWbIHqzysNxc7nllXOx6fFynfX2BJMoPcR
         RjOX+7EomTRf9P6n64vjpmb05ZzVcjgT8hRoeNK+rWS7S5sjX7SoZ4PyAQz3APvtGocN
         v7hknpFhVMlB61ootpltp+Ljb2QJ+usyON4Dy1kcVuxqtQIMeamSJDOp/NmCBL8YZTtW
         NEWyOUE69c40Rd0E7IFOZ++nBva9Rw1SQOMQlEKD2XvbWXenGbtRu7ZwrQcVfLwT2j14
         izHLQGMgSrHQR7cbZjld/Q6tvJ88HT95LLdJap+Iy10sXnRadpqsaJsq/5H8qpz+St1h
         ZdZg==
X-Forwarded-Encrypted: i=1; AJvYcCVlmHmbMn9WKAdO4LiGF/GaYMKyl7nsrhT36iKilMrGUl/P7AdolQ7sP57l8pqGXelNTHsUwQ5EWpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynmf3eQ70uSgYQNcc/hXVGSLm+in3ZQWRUIqXy55TvXxMvh3Jj
	N7JDyMsKJQhV8tmqWfYM7UtIWN9TTRIpgmlSuzM/Ur/TJKIouLDvA56TH9XhqQ==
X-Gm-Gg: ASbGncvzs/A0oDWtoyEYwMImK9Xf5JBdy9fckffBxp2piAAqTfamLJDPYcjitxfHe0c
	cVQxa9dMzn71tLfTR1p1hCRkczm1pqzv+pytBRxspDIHGGKCd/Wy++zAUNazIJOgYXu9LEGQuWE
	I4oFn1+xxTXgDjOeBdtrymSwHIvtCqSe5LChFMdECoeh3gF9t7cKcSyhh/E4hP62m/PaxKUlVid
	+KsR5FtugVkq0OfqNu89PSuahdr7kIj1f8IsvvjzRNfX915P80qdjBn4FIKHfmydx7cqGak39EJ
	MFog
X-Google-Smtp-Source: AGHT+IE8NIEOlYRScPXYRwjMD5LqVC4ujNKCuJjI3vvVMMsUgArz6g9GAHMD2cEjtZmCMQ2tnFfX6w==
X-Received: by 2002:a17:902:e548:b0:215:e98c:c5bb with SMTP id d9443c01a7336-21c3555353dmr341753835ad.28.1737567300134;
        Wed, 22 Jan 2025 09:35:00 -0800 (PST)
Received: from thinkpad ([36.255.17.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d6b298dsm98301135ad.245.2025.01.22.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:34:59 -0800 (PST)
Date: Wed, 22 Jan 2025 23:04:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen Wang <unicorn_wang@outlook.com>, maz@kernel.org
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250122173451.5c7pdchnyee7iy6t@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
 <20250119122353.v3tzitthmu5tu3dg@thinkpad>
 <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>

+ Marc (for the IRQCHIP implementation review)

On Wed, Jan 22, 2025 at 09:28:12PM +0800, Chen Wang wrote:
> 
> On 2025/1/19 20:23, Manivannan Sadhasivam wrote:
> > On Wed, Jan 15, 2025 at 03:06:57PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add support for PCIe controller in SG2042 SoC. The controller
> > > uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> > > PCIe controller will work in host mode only.
> > > 
> > Please add more info about the IP. Like IP revision, PCIe Gen, lane count,
> > etc...
> ok.
> > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > ---
> > >   drivers/pci/controller/cadence/Kconfig       |  13 +
> > >   drivers/pci/controller/cadence/Makefile      |   1 +
> > >   drivers/pci/controller/cadence/pcie-sg2042.c | 528 +++++++++++++++++++
> > >   3 files changed, 542 insertions(+)
> > >   create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> > > 
> > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > index 8a0044bb3989..292eb2b20e9c 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -42,6 +42,18 @@ config PCIE_CADENCE_PLAT_EP
> > >   	  endpoint mode. This PCIe controller may be embedded into many
> > >   	  different vendors SoCs.
> > > +config PCIE_SG2042
> > > +	bool "Sophgo SG2042 PCIe controller (host mode)"
> > > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > > +	depends on OF
> > > +	select IRQ_MSI_LIB
> > > +	select PCI_MSI
> > > +	select PCIE_CADENCE_HOST
> > > +	help
> > > +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> > > +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> > > +	  PCIe core.
> > > +
> > >   config PCI_J721E
> > >   	bool
> > > @@ -67,4 +79,5 @@ config PCI_J721E_EP
> > >   	  Say Y here if you want to support the TI J721E PCIe platform
> > >   	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> > >   	  core.
> > > +
> > Spurious newline.
> 
> oops, I will fix this.
> 
> [......]
> 
> > > +/*
> > > + * SG2042 PCIe controller supports two ways to report MSI:
> > > + *
> > > + * - Method A, the PCIe controller implements an MSI interrupt controller
> > > + *   inside, and connect to PLIC upward through one interrupt line.
> > > + *   Provides memory-mapped MSI address, and by programming the upper 32
> > > + *   bits of the address to zero, it can be compatible with old PCIe devices
> > > + *   that only support 32-bit MSI address.
> > > + *
> > > + * - Method B, the PCIe controller connects to PLIC upward through an
> > > + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
> > > + *   controller provides multiple(up to 32) interrupt sources to PLIC.
> > > + *   Compared with the first method, the advantage is that the interrupt
> > > + *   source is expanded, but because for SG2042, the MSI address provided by
> > > + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
> > > + *   it is not compatible with old PCIe devices that only support 32-bit MSI
> > > + *   address.
> > > + *
> > > + * Method A & B can be configured in DTS, default is Method B.
> > How to configure them? I can only see "sophgo,sg2042-msi" in the binding.
> 
> 
> The value of the msi-parent attribute is used in dts to distinguish them,
> for example:
> 
> ```dts
> 
> msi: msi-controller@7030010300 {
>     ......
> };
> 
> pcie_rc0: pcie@7060000000 {
>     msi-parent = <&msi>;
> };
> 
> pcie_rc1: pcie@7062000000 {
>     ......
>     msi-parent = <&msi_pcie>;
>     msi_pcie: interrupt-controller {
>         ......
>     };
> };
> 
> ```
> 
> Which means:
> 
> pcie_rc0 uses Method B
> 
> pcie_rc1 uses Method A.
> 

Ok. you mentioned 'default method' which is not accurate since the choice
obviously depends on DT. Maybe you should say, 'commonly used method'? But both
the binding and dts patches make use of in-built MSI controller only (method A).

In general, for MSI implementations inside the PCIe IP, we don't usually add a
dedicated devicetree node since the IP is the same. But in your reply to the my
question on the bindings patch, you said it is a separate IP. I'm confused now.

> [......]
> 
> > > +struct sg2042_pcie {
> > > +	struct cdns_pcie	*cdns_pcie;
> > > +
> > > +	struct regmap		*syscon;
> > > +
> > > +	u32			link_id;
> > > +
> > > +	struct irq_domain	*msi_domain;
> > > +
> > > +	int			msi_irq;
> > > +
> > > +	dma_addr_t		msi_phys;
> > > +	void			*msi_virt;
> > > +
> > > +	u32			num_applied_vecs; /* used to speed up ISR */
> > > +
> > Get rid of the newline between struct members, please.
> ok
> > > +	raw_spinlock_t		msi_lock;
> > > +	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> > > +};
> > > +
> > [...]
> > 
> > > +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
> > > +				 struct device_node *msi_node)
> > > +{
> > > +	struct device *dev = pcie->cdns_pcie->dev;
> > > +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > > +	struct irq_domain *parent_domain;
> > > +	int ret = 0;
> > > +
> > > +	if (!of_property_read_bool(msi_node, "msi-controller"))
> > > +		return -ENODEV;
> > > +
> > > +	ret = of_irq_get_byname(msi_node, "msi");
> > > +	if (ret <= 0) {
> > > +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
> > > +		return ret;
> > > +	}
> > > +	pcie->msi_irq = ret;
> > > +
> > > +	irq_set_chained_handler_and_data(pcie->msi_irq,
> > > +					 sg2042_pcie_msi_chained_isr, pcie);
> > > +
> > > +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
> > > +						 &sg2042_pcie_msi_domain_ops, pcie);
> > > +	if (!parent_domain) {
> > > +		dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
> > > +		return -ENOMEM;
> > > +	}
> > > +	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
> > > +
> > The MSI controller is wired to PLIC isn't it? If so, why can't you use
> > hierarchial MSI domain implementation as like other controller drivers?
> 
> The method used here is somewhat similar to dw_pcie_allocate_domains() in
> drivers/pci/controller/dwc/pcie-designware-host.c. This MSI controller is
> about Method A, the PCIe controller implements an MSI interrupt controller
> inside, and connect to PLIC upward through only ONE interrupt line. Because
> MSI to PLIC is multiple to one, I use linear mode here and use chained ISR
> to handle the interrupts.
> 

Hmm, ok. I'm not an IRQCHIP expert, but I'll defer to Marc to review the IRQCHIP
implementation part.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-20624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786BDA24A54
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EF33A808D
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0C1C5D5E;
	Sat,  1 Feb 2025 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQuPtk6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7431C3C1D
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427066; cv=none; b=PtEpn81cjHsqdTdekel917hy11G+FUgk6OD0mC4e7V5M+u937kjM7HoZSyuZgYWmstRWQ3nhQKWEFk5xZ3jLX+vYq3hNPBpQdCPxSk/P/dDsJBYmBGSOCKAMkE5UjGBYdizN9vE5Zq7YC0RfDx/N3clywtj+vutBUerQlB5woMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427066; c=relaxed/simple;
	bh=p7YVW+j6bHUXRuQHE6OjfYeY6IdwUfvCSmTJomUJ1Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAmvt0FleZcGRVXB39LDRFiBnpnPFvAp1EdNvbdlcpbO8flakK5qTDphVOoD+RnKlVF17DoZO+8/K9hOn5U/WO6GWheiZAqmpgGbt8phlTrNJWj4F0fHCuNFFo+4dP+JfHmGeGUpaFEGjXr5hRfbAC/MNJetQ4l57PNWDP/jQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQuPtk6t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21631789fcdso53932295ad.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Feb 2025 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738427063; x=1739031863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+/SlZdRr1M7HSrZTiZ0VPEmgsxQ7Zl2ARURjx1K2Fn4=;
        b=CQuPtk6t7se+E+w6hKgQyZTVzBy6SWPme82v1PNs9w4Z2fsNLD+3QgQ6/U8+0WFm4P
         WnyIBiKLQOgSMVuqt1PhXdhOM9+g/s18dozTCLJIv4Ey96uX5Miz/iuPMYgUs/4t7fmN
         clHFyrOwyhS0BaQzftGRjtNbVZX6YpyilVYygOeQScMhqbPEkxdbYlHq9mums0hKY4Qh
         aN7B2uY80fezsendRSkBkp1I0E5fvBJJHSLAaWTtomKak7ztTtDudrSo9lv8goBSzM0r
         c21+r/7KNkpApXCkny/JTdThAgou1LepcnfILjrfQNzSR0kDOLj5nYTLevPra1jZ1aJf
         Xwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738427063; x=1739031863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/SlZdRr1M7HSrZTiZ0VPEmgsxQ7Zl2ARURjx1K2Fn4=;
        b=UW+yYPvWW8uxWVeiUd1OVkTHPYw8AUHrP6BtvAc2SktZA/zRnU601sJCshrJFyExA2
         /ATHw4zVs5jUE7JLwtI0czV83WC6XbIWujDCjrpcPAfMSDlcQFvORFDUA+2r8x4Rz1bx
         cB7I9c9CefVz0jozYsMiE7xRGeUTKcawsDK+iYGaMmkSrj56DAG00flB5LnwyF5oGO61
         t0s68Q+xJymRD09XOrjszXS917fkZZW/5NEwS/ivM8+FmRuwOi8z0lPve5Cb53eyLAmO
         DTPOE/GWjKtnvKVPOpx0h4prCHelq0qZl1Bfb479FtpTcUWqBXo3fS1SMNGl4wXxb9f9
         dL8g==
X-Forwarded-Encrypted: i=1; AJvYcCUWUwmkHbNV83WZZoiiwzQ9nS0Kipyh5vkcd8/0BTLhZTGxw2ukKXRGPOO9zaR6Qe4VNCJbmhOV3WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkySozFmv53EwDa4NlEqu/EKp8NcrYvasYOWJ7GxcuUcHPb7GU
	MPq8nwarhw8N2EdmckVKagdA7wFji/lzAadMip31SjSgZOB59ob/HhG4h7BMGw==
X-Gm-Gg: ASbGncvQuq7ovIuyLkuJbbEBdsj6f9FSE3TlqOfnx9m/+F6M3gh2GvjqeGjmup6bv7K
	lP/IySG0D/R8Q9+8LUtzAv+KWtnDnjyRG0lR1Spf0oledfVmHnzqRAjU+MmKtTopauUcPUDzul2
	408ZgRwUWC0bF6cKnwDh5oxOxMCAGHKhT/kA+Y5dCrNLkKBoh37WPTcPrAeb64JcUIAasjM9LZZ
	DIdNyP+OjtNNf7jYKWTIPScEZv5DUXgJhwoi+iID0dyIa0ShJhgM9x0U2RA3BGiDmdR+hffDnu9
	SlB42uX0uqRzbCKTxEBUlpxlP+M=
X-Google-Smtp-Source: AGHT+IE7Xhm/VWe/QJf6N7cUAvTlX15tknWeDZsD/+Udr/QgfOM2wxbeGfGoigXJsEw8AWMYmJz50g==
X-Received: by 2002:a05:6a21:8cc9:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1ed872d5091mr18416087637.2.1738427062783;
        Sat, 01 Feb 2025 08:24:22 -0800 (PST)
Received: from thinkpad ([120.56.202.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6539fc4sm5262880b3a.73.2025.02.01.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:24:22 -0800 (PST)
Date: Sat, 1 Feb 2025 21:54:16 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Message-ID: <20250201162416.azp4slqqeabo2xyl@thinkpad>
References: <9e629b1779c2cb9c6fa34347ac16f9b4e2241430.camel@mediatek.com>
 <20250128004150.GA183319@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128004150.GA183319@bhelgaas>

On Mon, Jan 27, 2025 at 06:41:50PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 23, 2025 at 08:11:19AM +0000, Jianjun Wang (王建军) wrote:
> > On Wed, 2025-01-15 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> > > > Remove the usage of virt_to_phys, as it will cause sparse warnings
> > > > when
> > > > building on some platforms.
> > > 
> > > Strange. What are those warnings and platforms?
> > 
> > There are some warning messages when building tests with different
> > configs on different platforms (e.g., allmodconfig.arm,
> > allmodconfig.i386, allmodconfig.mips, etc.):
> > 
> > pcie-mediatek.c:399:40: sparse: warning: incorrect type in argument 1
> > (different address spaces)
> > pcie-mediatek.c:399:40: sparse:    expected void const volatile *x
> > pcie-mediatek.c:399:40: sparse:    got void [noderef] __iomem *
> > pcie-mediatek.c:515:44: sparse: warning: incorrect type in argument 1
> > (different address spaces)
> > pcie-mediatek.c:515:44: sparse:    expected void const volatile *x
> > pcie-mediatek.c:515:44: sparse:    got void [noderef] __iomem *
> >
> > > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek.c | 19 ++++++++++++-------
> > > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pcie-mediatek.c
> > > > b/drivers/pci/controller/pcie-mediatek.c
> > > > index 3bcfc4e58ba2..dc1e5fd6c7aa 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > > @@ -178,6 +178,7 @@ struct mtk_pcie_soc {
> > > >   * @phy: pointer to PHY control block
> > > >   * @slot: port slot
> > > >   * @irq: GIC irq
> > > > + * @msg_addr: MSI message address
> > > >   * @irq_domain: legacy INTx IRQ domain
> > > >   * @inner_domain: inner IRQ domain
> > > >   * @msi_domain: MSI IRQ domain
> > > > @@ -198,6 +199,7 @@ struct mtk_pcie_port {
> > > >       struct phy *phy;
> > > >       u32 slot;
> > > >       int irq;
> > > > +     phys_addr_t msg_addr;
> > > >       struct irq_domain *irq_domain;
> > > >       struct irq_domain *inner_domain;
> > > >       struct irq_domain *msi_domain;
> > > > @@ -393,12 +395,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
> > > >  static void mtk_compose_msi_msg(struct irq_data *data, struct
> > > > msi_msg *msg)
> > > >  {
> > > >       struct mtk_pcie_port *port =
> > > > irq_data_get_irq_chip_data(data);
> > > > -     phys_addr_t addr;
> > > > 
> > > >       /* MT2712/MT7622 only support 32-bit MSI addresses */
> > > > -     addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> 
> Thanks for working on this!  We should definitely try to get rid of
> virt_to_phys().
> 
> > > >       msg->address_hi = 0;
> > > > -     msg->address_lo = lower_32_bits(addr);
> > > > +     msg->address_lo = lower_32_bits(port->msg_addr);
> > > > 
> > > >       msg->data = data->hwirq;
> > > > 
> > > > @@ -510,10 +510,8 @@ static int
> > > > mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
> > > >  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > > >  {
> > > >       u32 val;
> > > > -     phys_addr_t msg_addr;
> > > > 
> > > > -     msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > > -     val = lower_32_bits(msg_addr);
> > > > +     val = lower_32_bits(port->msg_addr);
> > > >       writel(val, port->base + PCIE_IMSI_ADDR);
> > > > 
> > > >       val = readl(port->base + PCIE_INT_MASK);
> > > > @@ -913,6 +911,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie
> > > > *pcie,
> > > >       struct mtk_pcie_port *port;
> > > >       struct device *dev = pcie->dev;
> > > >       struct platform_device *pdev = to_platform_device(dev);
> > > > +     struct resource *regs;
> > > >       char name[10];
> > > >       int err;
> > > > 
> > > > @@ -921,12 +920,18 @@ static int mtk_pcie_parse_port(struct
> > > > mtk_pcie *pcie,
> > > >               return -ENOMEM;
> > > > 
> > > >       snprintf(name, sizeof(name), "port%d", slot);
> > > > -     port->base = devm_platform_ioremap_resource_byname(pdev,
> > > > name);
> > > > +     regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > name);
> > > > +     if (!regs)
> > > > +             return -EINVAL;
> > > > +
> > > > +     port->base = devm_ioremap_resource(dev, regs);
> > > >       if (IS_ERR(port->base)) {
> > > >               dev_err(dev, "failed to map port%d base\n", slot);
> > > >               return PTR_ERR(port->base);
> > > >       }
> > > > 
> > > > +     port->msg_addr = regs->start + PCIE_MSI_VECTOR;
> 
> I think this still assumes that a CPU physical address (regs->start)
> is the same as the PCI bus address used for MSI, so this doesn't seem
> like the right solution to me.
> 
> Apparently they happen to be the same on this platform because (I
> assume) MSIs actually do work, but it's not a good pattern for drivers
> to copy.  I think what we really need is a dma_addr_t, and I think
> there are one or two PCI controller drivers that do that.
> 

I don't see why we would need 'dma_addr_t' here. The MSI address is a static
physical address on this platform and that is not a DMA address. Other drivers
can *only* copy this pattern if they also have the physical address allocated
for MSI.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-20424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F6A202A8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A193A230E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AE14286;
	Tue, 28 Jan 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcC4HA2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40308EAF6;
	Tue, 28 Jan 2025 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024915; cv=none; b=M6LWPEwxJtZ0f7VkhBj7sH6ahGpMy9vo289jkGprfb/eQyuvB6OVix6PmSu/3iSnH6AqFByyVMnn279QYfv3PTezsy3gLmaYys5YLAqqCzmvcaDysR2vrS0RjyeW2Tb1bqUt+8jq3klRUFQ/S044I9sU7NnmO930STfeTzUSAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024915; c=relaxed/simple;
	bh=oCREAUY8j++SAnl6wUczMC3oNy5q6RrIqFAVM4y07BE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JrI5s0L7XDP759JuqR2IpHCgF5iR4Moza+MO+XmOMC3V4v9e69dHDnypQeED38lnhnHHz70v3SdQkgWu/yCOaJFT3gTtfi8WvJGWh3KX5stLF7k63KXCFcMl2HT70aPbYdoa4usoRwDurO43crcCr4ferP3nM7hmqgmnhtzA95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcC4HA2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB84C4CED2;
	Tue, 28 Jan 2025 00:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738024913;
	bh=oCREAUY8j++SAnl6wUczMC3oNy5q6RrIqFAVM4y07BE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FcC4HA2QignI5R4l3o/YmS/xowOZeJHr7dmscyJpxRRDZJJ8H+mzQhSEf5Q9S7Xzr
	 4ifN0P6MJa3gw9931ZBKIXO1o4Aq07ec9kFAhcBSi1Sd7NllrHZegL6x9x0eJyveM/
	 hHHkrqdFGN7GDsUCOwEPL+UTwjLnprHlnBqmkUNxRe1dJynjm4AQB1EWOi0oZhho44
	 aHezCFuTHaiuHA2S5M0Bq5Oi/zC3cnj6r+g8TkJoXaxBfLuyyvEefdckFdjICAZsGz
	 6sZa+wAVFAxNak08KCU1njcZk64JeDlhV+/Av9uJEuy4iGFLxTGJRs+pULMOabLmbc
	 +z9ApykI++BTA==
Date: Mon, 27 Jan 2025 18:41:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20250128004150.GA183319@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e629b1779c2cb9c6fa34347ac16f9b4e2241430.camel@mediatek.com>

On Thu, Jan 23, 2025 at 08:11:19AM +0000, Jianjun Wang (王建军) wrote:
> On Wed, 2025-01-15 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> > > Remove the usage of virt_to_phys, as it will cause sparse warnings
> > > when
> > > building on some platforms.
> > 
> > Strange. What are those warnings and platforms?
> 
> There are some warning messages when building tests with different
> configs on different platforms (e.g., allmodconfig.arm,
> allmodconfig.i386, allmodconfig.mips, etc.):
> 
> pcie-mediatek.c:399:40: sparse: warning: incorrect type in argument 1
> (different address spaces)
> pcie-mediatek.c:399:40: sparse:    expected void const volatile *x
> pcie-mediatek.c:399:40: sparse:    got void [noderef] __iomem *
> pcie-mediatek.c:515:44: sparse: warning: incorrect type in argument 1
> (different address spaces)
> pcie-mediatek.c:515:44: sparse:    expected void const volatile *x
> pcie-mediatek.c:515:44: sparse:    got void [noderef] __iomem *
>
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c
> > > b/drivers/pci/controller/pcie-mediatek.c
> > > index 3bcfc4e58ba2..dc1e5fd6c7aa 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -178,6 +178,7 @@ struct mtk_pcie_soc {
> > >   * @phy: pointer to PHY control block
> > >   * @slot: port slot
> > >   * @irq: GIC irq
> > > + * @msg_addr: MSI message address
> > >   * @irq_domain: legacy INTx IRQ domain
> > >   * @inner_domain: inner IRQ domain
> > >   * @msi_domain: MSI IRQ domain
> > > @@ -198,6 +199,7 @@ struct mtk_pcie_port {
> > >       struct phy *phy;
> > >       u32 slot;
> > >       int irq;
> > > +     phys_addr_t msg_addr;
> > >       struct irq_domain *irq_domain;
> > >       struct irq_domain *inner_domain;
> > >       struct irq_domain *msi_domain;
> > > @@ -393,12 +395,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
> > >  static void mtk_compose_msi_msg(struct irq_data *data, struct
> > > msi_msg *msg)
> > >  {
> > >       struct mtk_pcie_port *port =
> > > irq_data_get_irq_chip_data(data);
> > > -     phys_addr_t addr;
> > > 
> > >       /* MT2712/MT7622 only support 32-bit MSI addresses */
> > > -     addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);

Thanks for working on this!  We should definitely try to get rid of
virt_to_phys().

> > >       msg->address_hi = 0;
> > > -     msg->address_lo = lower_32_bits(addr);
> > > +     msg->address_lo = lower_32_bits(port->msg_addr);
> > > 
> > >       msg->data = data->hwirq;
> > > 
> > > @@ -510,10 +510,8 @@ static int
> > > mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
> > >  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > >  {
> > >       u32 val;
> > > -     phys_addr_t msg_addr;
> > > 
> > > -     msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > -     val = lower_32_bits(msg_addr);
> > > +     val = lower_32_bits(port->msg_addr);
> > >       writel(val, port->base + PCIE_IMSI_ADDR);
> > > 
> > >       val = readl(port->base + PCIE_INT_MASK);
> > > @@ -913,6 +911,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie
> > > *pcie,
> > >       struct mtk_pcie_port *port;
> > >       struct device *dev = pcie->dev;
> > >       struct platform_device *pdev = to_platform_device(dev);
> > > +     struct resource *regs;
> > >       char name[10];
> > >       int err;
> > > 
> > > @@ -921,12 +920,18 @@ static int mtk_pcie_parse_port(struct
> > > mtk_pcie *pcie,
> > >               return -ENOMEM;
> > > 
> > >       snprintf(name, sizeof(name), "port%d", slot);
> > > -     port->base = devm_platform_ioremap_resource_byname(pdev,
> > > name);
> > > +     regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > name);
> > > +     if (!regs)
> > > +             return -EINVAL;
> > > +
> > > +     port->base = devm_ioremap_resource(dev, regs);
> > >       if (IS_ERR(port->base)) {
> > >               dev_err(dev, "failed to map port%d base\n", slot);
> > >               return PTR_ERR(port->base);
> > >       }
> > > 
> > > +     port->msg_addr = regs->start + PCIE_MSI_VECTOR;

I think this still assumes that a CPU physical address (regs->start)
is the same as the PCI bus address used for MSI, so this doesn't seem
like the right solution to me.

Apparently they happen to be the same on this platform because (I
assume) MSIs actually do work, but it's not a good pattern for drivers
to copy.  I think what we really need is a dma_addr_t, and I think
there are one or two PCI controller drivers that do that.

> > >       snprintf(name, sizeof(name), "sys_ck%d", slot);
> > >       port->sys_ck = devm_clk_get(dev, name);
> > >       if (IS_ERR(port->sys_ck)) {
> > > --
> > > 2.46.0
> > > 
> > 
> > --
> > மணிவண்ணன் சதாசிவம்


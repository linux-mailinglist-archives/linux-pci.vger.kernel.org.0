Return-Path: <linux-pci+bounces-10094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2892D97F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F6282768
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC682C7E;
	Wed, 10 Jul 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+BNFP2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924315E88;
	Wed, 10 Jul 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640913; cv=none; b=opl1wmD5LFl2CcHl2eWxBHqgnvnQ9rDGDfd1rEXktdXuWJToytpajYb0o/+81blfw4tGwjUk4+CvwucvJMJG/apFZfJc7b+1n195kZUVcNUJa9S+uyldK1ypE+H1q/CGp4CEGIwMpRwTZghu30SKOXi5g29DcqUZjytTy/EY8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640913; c=relaxed/simple;
	bh=XhQRF5UFco4b8sHe0w5DuTqYrq5XvTZ+7qMoY5GC1cY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iodEqSOCW/XquB+fXk6z29HpocHZdq20+qnkzlvPfWypLDZxvz13dRGTPCEojamIKnNmz1646su23ahKGeuCuceld1k/CYx1S5mq0irb4qOPhNImUg6+D55GIyJrOfnQNBe5Fij+bATGd5LpjT4s9NkilnXSWWK7Qx6MUchMjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+BNFP2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A9CC32781;
	Wed, 10 Jul 2024 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720640912;
	bh=XhQRF5UFco4b8sHe0w5DuTqYrq5XvTZ+7qMoY5GC1cY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g+BNFP2iIcvstd2oGpRAoM3V5PXWP69kXLn6JnzG/TqTCLFcbl+OYmE8Q9DF83B7Q
	 MVckDciTYFAogF0BVSIqv3fMB4g/pmX2dd2VMs6nkjjiP6LaBDFWGfkF9QNE9ArB8G
	 cM2hG65N7yXXt54lV2FkrlnCNt4krjPdD6CC47SbkuKUcmEfUhfnQPg8ptnJZi9JVz
	 l6bZF1DsQWcEKG5KT+BZQM+zNuXOId6ymIU3L3A8EjCmrfg3Nq50xer99a+hJnomLl
	 FiaVzL117RNozitipajNxrYE2usIyVvN5UbZyZbKzkcvvyDGnOVHWiinjZCrB2YXES
	 pVHwfOjkqr1Og==
Date: Wed, 10 Jul 2024 14:48:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Message-ID: <20240710194830.GA255085@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6=nOf_cSv7K3hS3jdXsGcWR7Go30EFyZeqxYNQKhtH8A@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:04:24AM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Wed, Jul 10, 2024 at 5:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Jun 12, 2024 at 02:53:15PM +0800, Huacai Chen wrote:
> > > LS7A chipset can be used as a downstream bridge which connected to a
> > > high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
> > > upward port. We should always enable MSI caps of this port, otherwise
> > > downstream devices cannot use MSI.
> >
> > Can you clarify this topology a bit?  Since DEV_LS7A_PCIE_PORT5
> > apparently has a class of PCI_CLASS_BRIDGE_HOST, I guess that in PCIe
> > terms, it is basically a PCI host bridge (Root Complex, if you prefer)
> > that is materialized as a PCI Endpoint?
>
> Now most of the existing LoongArch CPUs don't have an integrated PCIe
> RC, instead they have HyperTransport controllers. But the latest CPU
> (Loongson-3C6000) has an integrated PCIe RC and removed
> HyperTransport.
> 
> LS7A bridge can work together with both old (HT) CPUs and new (PCIe)
> CPUs. If it is connected to an old CPU, its upstream port is a HT
> port, and DEV_LS7A_PCIE_PORT5 works as a normal downstream PCIe port.
> If it is connected to a new CPU, DEV_LS7A_PCIE_PORT5 works as an
> upstream port (the class code becomes PCI_CLASS_BRIDGE_HOST) and the
> HT port is idle.

What does lspci look like for both the old HT and the new PCIe CPUs?

With the old HT CPU, I imagine this:

  [LS7A includes a HT port that doesn't appear as a PCI device and
  basically implements a PCIe Root Complex]
  00:00.0 Root Port to [bus 01-1f] (DEV_LS7A_PCIE_PORT5)

With a new PCIe CPU, if DEV_LS7A_PCIE_PORT5 is a PCIe Upstream Port,
it would be part of a switch, so I'm imagining something like this:

  00:00.0 Root Port to [bus 01-1f] (integrated into Loongson-3C6000)
  01:00.0 Upstream Port to [bus 02-1f] (DEV_LS7A_PCIE_PORT5)
  02:00.0 Downstream Port to [bus 03-1f] (part of the LS7A switch)

In both cases, 00:00.0 and 01:00.0 (DEV_LS7A_PCIE_PORT5) would be a
Type 1 device that is enumerated as a PCI-to-PCI bridge, which would
normally have a Class Code of 0x0604 (PCI_CLASS_BRIDGE_PCI).

But you're saying DEV_LS7A_PCIE_PORT5 has a Class Code of
PCI_CLASS_BRIDGE_HOST, which is 0x0600.  That would normally be a Type
0 device and would not have a secondary bus.

> > I'm curious about what's going on here because the normal PCI MSI
> > support should set PCI_MSI_FLAGS_ENABLE since it's completely
> > specified by the spec, which says it controls whether *this function*
> > can use MSI.
> >
> > But in this case PCI_MSI_FLAGS_ENABLE seems to have non-architected
> > behavior of controlling MSI from *other* devices below this host
> > bridge?  That's a little bit weird too because MSI looks like DMA to
> > any bridges upstream from the device that is using MSI, and the Bus
> > Master Enable bit in those bridges controls whether they forward those
> > MSI DMA accesses upstream.  And of course the PCI core should already
> > make sure those bridges have Bus Master Enable set when downstream
> > devices use MSI.
>
> In my opinion this is a hardware bug, when DEV_LS7A_PCIE_PORT5 works
> as a host bridge, it should enable MSI automatically. But
> unfortunately hardware doesn't behave like this, so we need a quirk
> here.

I'm fine with the quirk to work around this issue.  But the commit log
is confusing.

> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Sheng Wu <wusheng@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/pci/controller/pci-loongson.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > > index 8b34ccff073a..ffc581605834 100644
> > > --- a/drivers/pci/controller/pci-loongson.c
> > > +++ b/drivers/pci/controller/pci-loongson.c
> > > @@ -163,6 +163,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> > >                       DEV_LS7A_HDMI, loongson_pci_pin_quirk);
> > >
> > > +static void loongson_pci_msi_quirk(struct pci_dev *dev)
> > > +{
> > > +     u16 val, class = dev->class >> 8;
> > > +
> > > +     if (class == PCI_CLASS_BRIDGE_HOST) {
> > > +             pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &val);
> > > +             val |= PCI_MSI_FLAGS_ENABLE;
> > > +             pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, val);
> > > +     }
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
> > > +
> > >  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
> > >  {
> > >       struct pci_config_window *cfg;
> > > --
> > > 2.43.0
> > >


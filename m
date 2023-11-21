Return-Path: <linux-pci+bounces-70-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBD7F3938
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 23:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763D01F228C8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0379584F0;
	Tue, 21 Nov 2023 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WMZcCrfT"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2C3FA1;
	Tue, 21 Nov 2023 14:34:12 -0800 (PST)
Received: from skinsburskii. (unknown [131.107.159.175])
	by linux.microsoft.com (Postfix) with ESMTPSA id 39B2120B74C0;
	Tue, 21 Nov 2023 14:34:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39B2120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700606052;
	bh=mA21u0SDYN0cTZPy2oKF3AgLd7FQiOH8cg8pH+DcV9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMZcCrfT9hxbdGnpIQWOxTnUJny2Y0lCYMw1xX8KKHBD7kW2ILHyW/bgw4yZrsmbz
	 ErvcL1CFacnNag0qo5GCEEspHP360qfL0dQFyCm6AlFehxpsOXN8g3vLDaiU7cXEv5
	 wbDTTPIYBnW7zTnvQqNQVVMnbxNVnDrC/3oilEcA=
Date: Tue, 21 Nov 2023 14:34:10 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, skinsburskii@gmail.com
Subject: Re: [PATCH] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Message-ID: <20231121223410.GA23977@skinsburskii.>
References: <20231121220556.GA21969@skinsburskii.>
 <20231121222325.GA260057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121222325.GA260057@bhelgaas>

On Tue, Nov 21, 2023 at 04:23:25PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 21, 2023 at 02:05:56PM -0800, Stanislav Kinsburskii wrote:
> > On Tue, Nov 21, 2023 at 03:37:55PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 20, 2023 at 03:40:33PM -0800, Stanislav Kinsburskii wrote:
> > > > Explicitly cast __iomem pointer to const void* with __force to fix the
> > > > following warning:
> > > > 
> > > >   warning: incorrect type in argument 1 (different address spaces)
> > > >      expected void const volatile *address
> > > >      got void [noderef] __iomem *
> > > 
> > > I have two questions about this:
> > > 
> > >   1) There's no other use of __force in drivers/pci, so I don't know
> > >   what's special about pcie-mediatek.c.  There should be a way to fix
> > >   the types so it's not needed.
> > 
> > __force suppreses the following sparse warning:
> > 
> >     warning: cast removes address space '__iomem' of expression
> 
> I'm suggesting that the cast is a band-aid that covers up a type
> mismatch, and there shouldn't be a mismatch in the first place.
> 
> > >   2) virt_to_phys() is not quite right to begin with because what we
> > >   want is a *bus* address, not the CPU physical address we get from
> > >   virt_to_phys().  Obviously the current platforms that use this must
> > >   not apply any offset between bus and CPU physical addresses, but
> > >   it's not something we should rely on.
> > > 
> > >   There are only three drivers (pci-aardvark.c, pcie-xilinx.c, and
> > >   this one) that use virt_to_phys(), and they're all slightly wrong
> > >   here.
> > > 
> > > The *_compose_msi_msg() methods could use a little more consistency
> > > across the board.
> > 
> > Could you elaborate on what do you suggest?
> > Should virt_to_phys() be simply removed?
> 
> The DMA API (Documentation/core-api/dma-api.rst) is the usual way to
> get bus addresses, since an MSI is basically a DMA on the PCI bus.
> 
> https://lore.kernel.org/linux-pci/20230914203146.GA77870@bhelgaas/
> 
> Nobody is very motivated to fix these, I guess ;)  I sort of hate to
> just throw in a cast to shut up the warning because it doesn't really
> solve the problem.
> 

This is fair.
However I have neither expertize to assess, no hardware to test such intrusive
changes.
I guess it's a no-op then, is it?

> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > > index 66a8f73296fc..27f0f79810a1 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > > @@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > > >  	phys_addr_t addr;
> > > >  
> > > >  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> > > > -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > > +	addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> > > >  	msg->address_hi = 0;
> > > >  	msg->address_lo = lower_32_bits(addr);
> > > >  
> > > > @@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > > >  	u32 val;
> > > >  	phys_addr_t msg_addr;
> > > >  
> > > > -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > > +	msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> > > >  	val = lower_32_bits(msg_addr);
> > > >  	writel(val, port->base + PCIE_IMSI_ADDR);


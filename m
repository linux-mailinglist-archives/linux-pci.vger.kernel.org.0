Return-Path: <linux-pci+bounces-68-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D57F38DC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 23:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2D32829A4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A15644C;
	Tue, 21 Nov 2023 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AkLb6wzb"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 489FE10C9;
	Tue, 21 Nov 2023 14:05:59 -0800 (PST)
Received: from skinsburskii. (unknown [131.107.159.175])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2EA5820B74C0;
	Tue, 21 Nov 2023 14:05:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EA5820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700604358;
	bh=rtyIaO0ftqOt8/Ba0EA0J2h51r5MdPZqAucb2u8dkig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkLb6wzbi6/WneEHAw8OZyPVFN9DnDZeBhPSjl6hw/37GifoDgNNAXT9FjM64Z/qY
	 f/DiSNRbPU5xJxAnKZb91MqyzcqpJedgYx4oMWrlZFXXPOLFQpH3cow0Rf4jslsKDo
	 3E35rVsQohMzlITXkjKIJiL4RInM7/hC0sDAhkx8=
Date: Tue, 21 Nov 2023 14:05:56 -0800
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
Message-ID: <20231121220556.GA21969@skinsburskii.>
References: <170052362584.21270.8345708191142620624.stgit@skinsburskii.>
 <20231121213755.GA258354@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121213755.GA258354@bhelgaas>

On Tue, Nov 21, 2023 at 03:37:55PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 20, 2023 at 03:40:33PM -0800, Stanislav Kinsburskii wrote:
> > Explicitly cast __iomem pointer to const void* with __force to fix the
> > following warning:
> > 
> >   warning: incorrect type in argument 1 (different address spaces)
> >      expected void const volatile *address
> >      got void [noderef] __iomem *
> 
> I have two questions about this:
> 
>   1) There's no other use of __force in drivers/pci, so I don't know
>   what's special about pcie-mediatek.c.  There should be a way to fix
>   the types so it's not needed.
> 

__force suppreses the following sparse warning:

    warning: cast removes address space '__iomem' of expression

>   2) virt_to_phys() is not quite right to begin with because what we
>   want is a *bus* address, not the CPU physical address we get from
>   virt_to_phys().  Obviously the current platforms that use this must
>   not apply any offset between bus and CPU physical addresses, but
>   it's not something we should rely on.
> 
>   There are only three drivers (pci-aardvark.c, pcie-xilinx.c, and
>   this one) that use virt_to_phys(), and they're all slightly wrong
>   here.
> 
> The *_compose_msi_msg() methods could use a little more consistency
> across the board.
> 

Could you elaborate on what do you suggest?
Should virt_to_phys() be simply removed?

> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 66a8f73296fc..27f0f79810a1 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >  	phys_addr_t addr;
> >  
> >  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> > -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +	addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> >  	msg->address_hi = 0;
> >  	msg->address_lo = lower_32_bits(addr);
> >  
> > @@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> >  	u32 val;
> >  	phys_addr_t msg_addr;
> >  
> > -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +	msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> >  	val = lower_32_bits(msg_addr);
> >  	writel(val, port->base + PCIE_IMSI_ADDR);
> >  
> > 
> > 
> > 


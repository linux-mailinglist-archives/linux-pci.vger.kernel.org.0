Return-Path: <linux-pci+bounces-20675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19CA2630F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F3B1633D9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6707A1ADC98;
	Mon,  3 Feb 2025 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLhSkgfr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A8194AEC;
	Mon,  3 Feb 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608769; cv=none; b=Ehd01ywIF6P7QlG+xxVPWwbN48J4Wi/EZzuiaY9/A/ldJtM9+MePTVP63CkT/7QCaV99A/ZjWN2W6vdJvvejU0x++/4aEU3JCYjlBGbjrRNQ5BojR1+gQHp8TqcJOYwhUQgUVRSwdma6LJaxK8LkppqXbDmUAQ6ToSgUQ2MUZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608769; c=relaxed/simple;
	bh=cp8ezIVsa4VCsFDICxF3SyrDQWm0vPmWgmthTsoKoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SIeuMQOhLrbgT8/8cGa9zAXJf3rfiPqWDVNrlGWlHgbNVLmiIkLHLVlKJVLON7Ba1YGbugO+vd+3EEIZwqvCb0Xf5AUZPHKiy6OTDLO/qZeClJcytaLXt7aYyoduXAqkNFy8WoR8ihVZ0hOyu4Hd8FnV3csf+ANETssi/Y1pPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLhSkgfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7286AC4CED2;
	Mon,  3 Feb 2025 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738608768;
	bh=cp8ezIVsa4VCsFDICxF3SyrDQWm0vPmWgmthTsoKoqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sLhSkgfrtiXM1d6scqupsldIN28bx0T9WxyPXfHVo8A0P9qumifaHA8ihb8wOmVW/
	 1B9v11/JtaUgT+dJGbOGTr/1gn+6qbtl9NnxCBwzjSoWBh0Uh3xhgO6GUgHFHd9x6z
	 9eAGB33aOGE2z2GmO4QOBh/YZhLxRQKa4R9q5fHpT1S/M5BZhwxFZjbrgnnUB5D1H+
	 tyV/Dj5wFHfMY4zuEYR71SaN1vCa3bNp/LPdDqcd1fMxaJXjY1lNInCsO6jjwM1Ia9
	 OgaFs8I2iicsAKZ2HsG8xcDp4G7eZBDYuMYUGEtIj06JlRFSWOpYhECw3427VyhAVP
	 QWWr9nrS2c2qA==
Date: Mon, 3 Feb 2025 12:52:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20250203185246.GA794570@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203175049.idxegqqsfwf4dmvq@thinkpad>

On Mon, Feb 03, 2025 at 11:20:49PM +0530, manivannan.sadhasivam@linaro.org wrote:
> On Sat, Feb 01, 2025 at 11:07:40AM -0600, Bjorn Helgaas wrote:
> > On Sat, Feb 01, 2025 at 09:54:16PM +0530, manivannan.sadhasivam@linaro.org wrote:
> > > On Mon, Jan 27, 2025 at 06:41:50PM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Jan 23, 2025 at 08:11:19AM +0000, Jianjun Wang (王建军) wrote:
> > > > > On Wed, 2025-01-15 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> > > > > > > Remove the usage of virt_to_phys, as it will cause sparse warnings
> > > > > > > when
> > > > > > > building on some platforms.
> > 
> > > > > > >       snprintf(name, sizeof(name), "port%d", slot);
> > > > > > > -     port->base = devm_platform_ioremap_resource_byname(pdev,
> > > > > > > name);
> > > > > > > +     regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > > > > name);
> > > > > > > +     if (!regs)
> > > > > > > +             return -EINVAL;
> > > > > > > +
> > > > > > > +     port->base = devm_ioremap_resource(dev, regs);
> > > > > > >       if (IS_ERR(port->base)) {
> > > > > > >               dev_err(dev, "failed to map port%d base\n", slot);
> > > > > > >               return PTR_ERR(port->base);
> > > > > > >       }
> > > > > > > 
> > > > > > > +     port->msg_addr = regs->start + PCIE_MSI_VECTOR;
> > > > 
> > > > I think this still assumes that a CPU physical address
> > > > (regs->start) is the same as the PCI bus address used for MSI, so
> > > > this doesn't seem like the right solution to me.

Apart from the question of what type should be used, what do you think
about this part?  I don't think we should assume that the address on
PCI is identical to the CPU physical address.  IOMMUs and (I assume)
iATUs can make them different, can't they?  If so, this looks like an
implicit assumption that PCI bus==CPU physical, and I think we should
make that a little more explicit somehow.

> > > > Apparently they happen to be the same on this platform because (I
> > > > assume) MSIs actually do work, but it's not a good pattern for
> > > > drivers to copy.  I think what we really need is a dma_addr_t, and
> > > > I think there are one or two PCI controller drivers that do that.
> > > 
> > > I don't see why we would need 'dma_addr_t' here. The MSI address is
> > > a static physical address on this platform and that is not a DMA
> > > address. Other drivers can *only* copy this pattern if they also
> > > have the physical address allocated for MSI.
> > 
> > Isn't an MSI on PCI just a DMA write to a certain address?
> 
> That's from the endpoint prespective when it triggers MSI.
> 
> > My assumption is that if you put an analyzer on that link, an MSI
> > from a device would be structurally indistinguishable from a DMA
> > write from the device.  The MSI uses a different address, but
> > doesn't it use the same size and kind of address, at least from
> > the PCIe protocol perspective?
> 
> Yeah, but in this case the address allocated to MSI belongs to a
> hardcoded region in the host memory (not allocated by the DMA APIs
> which will have the region attributed as DMA capable). So it doesn't
> belong to the DMA domain, and we cannot use 'dma_addr_t'.

Doesn't .irq_compose_msi_msg() build the Message Address/Data pair
that is programmed into a device's MSI Capability or MSI-X Table?
The device will eventually use that to initiate a DMA write to that
address.

In that sense, I would argue that the Message Address does belong to
the DMA domain.  I don't think the size of the address (32 vs 64 bits)
is determined by the CPU physical address size (phys_addr_t); it's
determined by the size of DMA addresses.

Bjorn


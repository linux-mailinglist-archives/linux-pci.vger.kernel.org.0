Return-Path: <linux-pci+bounces-9123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC9913567
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385DD1F2229A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DA182DA;
	Sat, 22 Jun 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9mvHtCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD41B809;
	Sat, 22 Jun 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077932; cv=none; b=nM0641lOjom3Nq2EyUbWexPi+S1NXeeVBTqAk9sQ2Nt2DghG4eDQtK8GrEjXGKxMIHE6H6xjKMS3n0my78bA+91QQL0J6o7dX+JWUu6h7/gwxX6n6TlCVU6ceNG+xpBZXm0ZAuqvMxw8ot5DJirGAKMT/3Cw9iDe/7k2fzHnnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077932; c=relaxed/simple;
	bh=TyUOhzxcr9V/zXXt0kOkoFjgFLAVdQ3V+wqNdOnW53I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c7mE3beSLYygkFQWYq3GsY0fV03NtfcAbSqpfCZGnsnnm4+awd08ZE4L/Am+RwOvLw40WmQoADxtu4EwUHcEIMN9vCjDUJ17rLsjTTb4tCtD75HIVLcewt57DUoBTZwjT6WZQZoOeXqUOPZM11T4w2jHHuRkgErt4QO9JoTzoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9mvHtCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8082BC3277B;
	Sat, 22 Jun 2024 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719077931;
	bh=TyUOhzxcr9V/zXXt0kOkoFjgFLAVdQ3V+wqNdOnW53I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r9mvHtCqNRIg/BUKz+Sy6CNfVfsNS0NK6FyDI4xTFdmfuIJ8akoh3IWK4OdsoXTxW
	 JEBrtNkNdwwY3w040z4PNRQnaB16T1olz2yp1q97fzGeP3ySqF7leOFGn/XHW2Ddvx
	 XFcJ+PzlT7ZqMC75aaph73axnOzz++zb5KPDXg5AtJ5A+u7jqNFLoKMzNj++adY3da
	 ROfMoLuuUF+eljmEHYnf/GIQk+x3dF2GjA4yqs5CP2QgKH5kjQUZEhveCYD0jXIY8J
	 WZbQsWz8Sq0UoZ4RoiVYFXdefvWgLGUsQOO5cisfb96PSwUjUbof+BNytQHYunLSFh
	 sgLm6rVuztpzw==
Date: Sat, 22 Jun 2024 12:38:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240622173849.GA1432357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621224321.GA1410825@bhelgaas>

On Fri, Jun 21, 2024 at 05:43:21PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2024 at 06:29:48PM -0400, Frank Li wrote:
> > On Mon, Jun 17, 2024 at 10:26:36AM -0400, Frank Li wrote:
> > > On Thu, Jun 13, 2024 at 05:41:25PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 06, 2024 at 04:24:17PM -0400, Frank Li wrote:
> > > > > On Mon, Jun 03, 2024 at 04:07:55PM -0400, Frank Li wrote:
> > > > > > On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > > > > > > > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > > > > > > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > > > > > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > > > > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > > > > > > >
> > > > > > > > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > > > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > > > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > > > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > > > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > > > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > > > > > > > controller is utilized as a fallback.
> > > > > > > > > > > >
> > > > > > > > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > > > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > > > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > > > > > > > Settings (DTS).
> > > > > > > > > > >
> > > > > > > > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > > > > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > > > > > > > function names, bitmap tracking, code structure, etc.
> > > > > > > > > > >
> > > > > > > > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > > > > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > > > > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > > > > > > > this notifier.
> > > > > > > > > >
> > > > > > > > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > > > > > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > > > > > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > > > > > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > > > > > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > > > > > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > > > > > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > > > > > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > > > > > > >
> > > > > > > > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > > > > > > > see that the LUT CSR accesses use IMX95_* definitions.
> > > > > > > >
> > > > > > > > Yes, it convert 16bit RID to 6bit stream id.
> > > > > > >
> > > > > > > IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> > > > > > > feature.
> > > > > >
> > > > > > Yes, it is i.MX feature. But I think other vendor should have similar
> > > > > > situation if use old arm smmu.
> > > > > >
> > > > > > >
> > > > > > > > > > If it's really necessary to do this programming from Linux, then there's
> > > > > > > > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > > > > > > > the rest of the kernel believes that what the DT said at boot time was
> > > > > > > > > > already a property of the hardware. It would be a lot more logical, and
> > > > > > > > > > likely simpler, for the driver to just read the relevant map property and
> > > > > > > > > > program the entire LUT to match, all in one go at controller probe time.
> > > > > > > > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > > > > > > > program address-translation LUTs for inbound windows.
> > > > > > > > > >
> > > > > > > > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > > > > > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > > > > > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > > > > > > > further notifiers from running at that point - the device will still be
> > > > > > > > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > > > > > > > without the controller being correctly programmed, which at best won't work
> > > > > > > > > > and at worst may break the whole system.
> > > > > > > > >
> > > > > > > > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > > > > > > > device-add time?  I'm guessing maybe not because apparently there is a
> > > > > > > > > risk of running out of LUT entries?
> > > > > > > >
> > > > > > > > It is not good idea to depend on boot loader so much.
> > > > > > >
> > > > > > > I meant "could this be programmed once when the Linux imx host
> > > > > > > controller driver is probed?"  But from the below, it sounds like
> > > > > > > that's not possible in general because you don't have enough stream
> > > > > > > IDs to do that.
> > > > > >
> > > > > > Oh! sorry miss understand what your means. It is possible like what I did
> > > > > > at v3 version. But I think it is not good enough.
> > > > > >
> > > > > > >
> > > > > > > > Some hot plug devics
> > > > > > > > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > > > > > > > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > > > > > > > controllers. each have 8 stream id. If use uboot assign it static, each
> > > > > > > > PCIe controller have below 8 devices.  It will be failrue one controller
> > > > > > > > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > > > > > > > controller can work.
> > > > > > > >
> > > > > > > > Although we have not so much devices now,  this way give us possility to
> > > > > > > > improve it in future.
> > > > > > > >
> > > > > > > > > It sounds like the consequences of running out of LUT entries are
> > > > > > > > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > > > > > > > that's possible, I think we need to figure out how to prevent the
> > > > > > > > > device from being used, not just dev_warn() about it.
> > > > > > > >
> > > > > > > > Yes, but so far, we have not met such problem now. We can improve it when
> > > > > > > > we really face such problem.
> > > > > > >
> > > > > > > If this controller can only support DMA from a limited number of
> > > > > > > endpoints below it, I think we should figure out how to enforce that
> > > > > > > directly.  Maybe we can prevent drivers from enabling bus mastering or
> > > > > > > something.  I'm not happy with the idea of waiting for and debugging a
> > > > > > > report of data corruption.
> > > > > >
> > > > > > It may add a pre-add hook function to pci bridge. let me do more research.
> > > > >
> > > > > Hi Bjorn:
> > > > >
> > > > > int pci_setup_device(struct pci_dev *dev)
> > > > > {
> > > > > 	dev->error_state = pci_channel_io_normal;
> > > > > 	...
> > > > > 	pci_fixup_device(pci_fixup_early, dev);
> > > > >
> > > > > 	^^^ I can add fixup hook for pci_fixup_early. If not resource,
> > > > > I can set dev->error_state to pci_channel_io_frozen or
> > > > > pci_channel_io_perm_failure
> > > > >
> > > > > 	And add below check here after call hook function.
> > > > >
> > > > > 	if (dev->error_state != pci_channel_io_normal)
> > > > > 		return -EIO;
> > > > >
> > > > > }
> > > > >
> > > > > How do you think this method? If you agree, I can continue search device
> > > > > remove hook up.
> > > >
> > > > I think this would mean the device would not appear to be enumerated
> > > > at all, right?  I.e., it wouldn't show up in lspci?  And we couldn't
> > > > use even a pure programmed IO driver with no DMA or MSI?
> > >
> > > Make sense. Let me do more research on this.
> > >
> > > Frank
> > > >
> > > > I wonder if we should have a function pointer in struct
> > > > pci_host_bridge, kind of like the existing ->map_irq(), where we could
> > > > do host bridge-specific setup when enumerating a PCI device.
> > 
> > Consider some device may no use MSI or DMA. It'd better set LUT when
> > allocate msi irq. I think insert a irq-domain in irq hierarchy.
> > 
> > static const struct irq_domain_ops lut_pcie_msi_domain_ops = {
> >         .alloc  = lut_pcie_irq_domain_alloc,
> >         .free   = lut_pcie_irq_domain_free,
> > };
> > 
> > int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> > {
> >         struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> > 
> >         pp->irq_domain = irq_domain_create_hierarchy(...)
> > 
> >         pp->msi_domain = pci_msi_create_irq_domain(...);
> > 
> >         return 0;
> > }
> > 
> > Manage lut stream id in lut_pcie_irq_domain_alloc() and
> > lut_pcie_irq_domain_free().
> > 
> > So failure happen only when driver use MSI and no-stream ID avaiable. It
> > should be better than failure when add devices. Some devices may not use
> > at all.
> 
> I'm not an IRQ expert, but it sounds plausible.  There might even be
> an opportunity to fall back to INTx if there's no stream ID available
> for MSI?

Sorry, I think this was a half-baked thought.  Exhaustion of stream
IDs should be an uncommon situation, and the important thing is to
prevent terrible things from happening.

I don't think it's worth bending over backwards to make everything
possible limp along.  If it's easy to just make the device
inaccessible, that's fine.  If there's a simple way to make it
available but keep from enabling bus mastering, we could do that too,
but only if it's really simple.


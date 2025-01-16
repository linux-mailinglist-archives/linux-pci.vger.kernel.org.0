Return-Path: <linux-pci+bounces-20014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DDA14292
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164FD7A16C9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80319236EAE;
	Thu, 16 Jan 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoV7mDUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424692361DE;
	Thu, 16 Jan 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056760; cv=none; b=ESpEUJMKntRsikShYWQa9LN2QLKcL+JiD59P9E4souDBZjMv6evOyX2T78z364vA8tcK19qeP9EOeicloIW9Z9y6lsOkSLINoOPZfdJO5lh57jpUAJWj6oP254Z1QZgWnxf8g7OLRgtvYU5xOBhO2t8S54NvRkZFYwoOgj5KjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056760; c=relaxed/simple;
	bh=Z4fTIg6gNmMApeJJjsSAkuq+axk4BmTLC+837MYkmZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m4PWA+0zkuPX0H6taOf7sCj1YVlD6Va6ccKIrD9rcxsX9t5/PsBjhHdnot8VyhegRxPqFK6/eLDtpys5WVJmMMkbZ+Uu6l+mXJmqKkok413pdogd38MGvjDiuPVaLw8pHr47EwgHPc1z+uSckNcxdKayBg6BrtbUonfXfquzc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoV7mDUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E612C4CED6;
	Thu, 16 Jan 2025 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737056759;
	bh=Z4fTIg6gNmMApeJJjsSAkuq+axk4BmTLC+837MYkmZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uoV7mDUaO8Z9fQ26Wjz7CGcfFE60n7XzpxVLPVL80QvFwQD2MVJRuo+jNp9GXmPRE
	 eBNuhB05yUxnq9M7Iguyr+CJtIknO1LFb2yeBbrbMj5lap/A4TgzQTBc7EjggHsQVe
	 O8OF7wyRjUDtN9rB3qqwsnl/mD+SEs69u8fW+kP+TcQy1Ivl5LOq23YjBPZf+DXZ+G
	 UU4JaZ1OsNhluhNQcU8mOBCbPVP2l0BFUevxymztwp4JPpFrDbdZe6AecmwhojKYeo
	 Cy94X450HJrsI78uEBOsYIL8c2wJ5izJRHuvs1REjUNdBsOWF5qmWhgnvhTYPp3CA2
	 Jl3xWRqrOeTbQ==
Date: Thu, 16 Jan 2025 13:45:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <20250116194558.GA595994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4lKIJ8nDst7rqCs@lizhi-Precision-Tower-5810>

On Thu, Jan 16, 2025 at 01:04:16PM -0500, Frank Li wrote:
> On Thu, Jan 16, 2025 at 09:32:39AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
> > >                    Endpoint
> > >   ┌───────────────────────────────────────────────┐
> > >   │                             pcie-ep@5f010000  │
> > >   │                             ┌────────────────┐│
> > >   │                             │   Endpoint     ││
> > >   │                             │   PCIe         ││
> > >   │                             │   Controller   ││
> > >   │           bus@5f000000      │                ││
> > >   │           ┌──────────┐      │                ││
> > >   │           │          │ Outbound Transfer     ││
> > >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> > >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> > >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> > >   ││     │CPU │          │0x8000_0000            ││
> > >   │└─────┘Addr└──────────┘      │                ││
> > >   │       0x7000_0000           └────────────────┘│
> > >   └───────────────────────────────────────────────┘
> > >
> > > Use 'ranges' property in DT to configure the iATU outbound window address.
> > > The bus fabric generally passes the same address to the PCIe EP controller,
> > > but some bus fabrics map the address before sending it to the PCIe EP
> > > controller.
> > >
> > > Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> > > fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> > > input address and map to PCI address 0xA000_0000.
> > >
> > > Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> > > the device tree provides this information, preferring a common method.
> > >
> > > bus@5f000000 {
> > > 	compatible = "simple-bus";
> > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > >
> > > 	pcie-ep@5f010000 {
> > > 		reg = <0x80000000 0x10000000>;
> > > 		reg-names ="addr_space";
> > > 		...
> > > 	};
> > > 	...
> > > };
> > >
> > > 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> > > address.
> >
> > Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
> > describe the translation for the window from bus addr 0x8000_0000 to
> > PCI addr 0xA000_0000?
> 
> Needn't 'ranges' under pcie-ep@5f010000 because history reason. DWC use
> reg-names "addr_space" descript outbound windows space.

If reg-name "addr_space" is used instead of 'ranges' for some
historical reason, we should mention that in the commit log so people
don't assume that this difference is the way it's *supposed* to be
done.

I only see "addr_space" mentioned in
Documentation/devicetree/bindings/pci/*-ep.yaml, so I assume
this "addr_space" usage only applies to endpoints?  

> > > Use `of_property_read_reg()` to obtain the bus address and set it to the
> > > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> >
> > Why is this different from [1], where parent_bus_addr comes from the
> > 'ranges' property?  Isn't this the same exact kind of address
> > translation for both RC and EP mode?
> 
> The method is the same, but space means is difference.
> 
> RC side:
>    regs, 1: controller register, 2: config space, (although it should be
> in ranges)
>    ranges, (IO range and Memory range).
> 
> EP side:
>    regs, 1: controller register, 2: outbound windows space.("addr_space")
> 
> All regs need call of_property_read_reg() to get untranslated address.
> ranges:  use "parent_bus_addr" in [1].

I think we should at least use the same name ("parent_bus_addr", not
"bus_addr_base") and probably also figure out a wrapper or similar way
to use 'ranges' for future endpoint drivers and fall back to
"addr_space" for DWC.

> > [1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com

> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -410,6 +410,7 @@ struct dw_pcie_ep {
> > >  	struct list_head	func_list;
> > >  	const struct dw_pcie_ep_ops *ops;
> > >  	phys_addr_t		phys_base;
> > > +	u64			bus_addr_base;
> > >  	size_t			addr_size;
> > >  	size_t			page_size;
> > >  	u8			bar_to_atu[PCI_STD_NUM_BARS];


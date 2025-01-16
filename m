Return-Path: <linux-pci+bounces-20021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAFA144B9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE61168F53
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D22419F3;
	Thu, 16 Jan 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szH71zQE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1C1D7E54;
	Thu, 16 Jan 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067744; cv=none; b=eAW2wBKQGE4i0T9Ph+5SwwGnKRI5mRLhpNyp7lwnQMP2IenKdqYI98YgnVUU326XfuOEo9YRlUAYA0jmBYNQuk5l/tNC9P67y4QH8GbPk8lwnjMAYym1eZlprdnSNuyNEx8Hg7uloLbSy7+bvbAJ3p2eByfIram8tRprGil1H8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067744; c=relaxed/simple;
	bh=5aThHilBPblCgfz/BgJ0mgjfS1hGQLJWECyx+bt7Wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h4mrVO8gGyxzIQm6ac8BX6tQgQ4gk2AeVnDGLPOg6G++t3ZWtoauCAquNULUcPdKoHH+JfZAREALGRTv7UXNImyTZzAqc9Y/LDnQxX1/Bw2YEEUoxAZ5wKI0GqZRsw+mJtT2T6C+qVxMeIkbSWJN61tF1S/28msqK8+MAZ3SgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szH71zQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD02C4CED6;
	Thu, 16 Jan 2025 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737067744;
	bh=5aThHilBPblCgfz/BgJ0mgjfS1hGQLJWECyx+bt7Wt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=szH71zQEi99amVjmugt5JvwXVGZ+pHOC18l1Q3auVKFW/ZAPJDY42oap4KZ82aiY+
	 gjkfq/RF3lhECK8PSywzROXubYGQyzvw2tUXdzMc3GyHx18tWlc6MoSyxouoCuqslY
	 F6wK7L7kbao7cwJg09R+JlwmmSVBswp8QDIL8JZRybxm62s5l+ZC1Iw5hll5y86Gtm
	 HWoIoBjPagiX5tawGzfr3aQzJbXl94B6fySIbLUIIVcez2xiSB0ktxVQ5Pg2yqbpbx
	 wXT/lV/5PjfbUkAIYeSiogqzX03X6RU14RyyGGA9soRDPKqUTTTi711X6fAtnCf0Zt
	 c9FqqjDAf48AA==
Date: Thu, 16 Jan 2025 16:49:02 -0600
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
Message-ID: <20250116224902.GA614046@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4ll5Ktyh5kmTzsd@lizhi-Precision-Tower-5810>

On Thu, Jan 16, 2025 at 03:02:44PM -0500, Frank Li wrote:
> On Thu, Jan 16, 2025 at 01:45:58PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 16, 2025 at 01:04:16PM -0500, Frank Li wrote:
> > > On Thu, Jan 16, 2025 at 09:32:39AM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
> > > > >                    Endpoint
> > > > >   ┌───────────────────────────────────────────────┐
> > > > >   │                             pcie-ep@5f010000  │
> > > > >   │                             ┌────────────────┐│
> > > > >   │                             │   Endpoint     ││
> > > > >   │                             │   PCIe         ││
> > > > >   │                             │   Controller   ││
> > > > >   │           bus@5f000000      │                ││
> > > > >   │           ┌──────────┐      │                ││
> > > > >   │           │          │ Outbound Transfer     ││
> > > > >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> > > > >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> > > > >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> > > > >   ││     │CPU │          │0x8000_0000            ││
> > > > >   │└─────┘Addr└──────────┘      │                ││
> > > > >   │       0x7000_0000           └────────────────┘│
> > > > >   └───────────────────────────────────────────────┘
> > > > >
> > > > > Use 'ranges' property in DT to configure the iATU outbound window address.
> > > > > The bus fabric generally passes the same address to the PCIe EP controller,
> > > > > but some bus fabrics map the address before sending it to the PCIe EP
> > > > > controller.
> > > > >
> > > > > Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> > > > > fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> > > > > input address and map to PCI address 0xA000_0000.
> > > > >
> > > > > Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> > > > > the device tree provides this information, preferring a common method.
> > > > >
> > > > > bus@5f000000 {
> > > > > 	compatible = "simple-bus";
> > > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > > >
> > > > > 	pcie-ep@5f010000 {
> > > > > 		reg = <0x80000000 0x10000000>;
> > > > > 		reg-names ="addr_space";
> > > > > 		...
> > > > > 	};
> > > > > 	...
> > > > > };
> > > > >
> > > > > 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> > > > > address.
> > > >
> > > > Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
> > > > describe the translation for the window from bus addr 0x8000_0000 to
> > > > PCI addr 0xA000_0000?
> > >
> > > Needn't 'ranges' under pcie-ep@5f010000 because history reason. DWC use
> > > reg-names "addr_space" descript outbound windows space.
> >
> > If reg-name "addr_space" is used instead of 'ranges' for some
> > historical reason, we should mention that in the commit log so people
> > don't assume that this difference is the way it's *supposed* to be
> > done.
> 
> How about add comments after
> 
> reg-names ="addr_space"; // Indicate EP outbound windows space instead use
> ranges by histortical reason.

OK, that seems reasonable.

Where does the 0xA000_0000 PCI address come from?  I assume that's in
DT somewhere too?

Is there a binding in the tree that would take advantage of this patch
that I can look at?  arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi 
has bus@5f000000 that does this translation, but I don't see any
endpoint mode that uses it.

> > > All regs need call of_property_read_reg() to get untranslated address.
> > > ranges:  use "parent_bus_addr" in [1].
> >
> > I think we should at least use the same name ("parent_bus_addr", not
> > "bus_addr_base") and probably also figure out a wrapper or similar way
> > to use 'ranges' for future endpoint drivers and fall back to
> > "addr_space" for DWC.
> 
> Okay for name parent_bus_addr.
> Do you need me to respin it? Or you change it by yourself?

I can do that.

Bjorn

> > > > [1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com


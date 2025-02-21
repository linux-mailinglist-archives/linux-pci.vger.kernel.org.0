Return-Path: <linux-pci+bounces-22021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88610A3FEE3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 19:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842903A9426
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA125332C;
	Fri, 21 Feb 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSsUI0O/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C5253329;
	Fri, 21 Feb 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162695; cv=none; b=H6yvkXY3MGJn9lyA1GSQIsdSNME9tRLrF0wvy21+Vp9P6DYHyvnw5BwMnoMGRjUiXsDSYGdhjVP/A6GJtyt/5bg1VwuBMGhpVMN1DUXTrQeAjYxyYAdgqa/B5qlu/oKFBFyhwEL0taQDEHqIci63QMTMEkNhK7P2BU369PTqo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162695; c=relaxed/simple;
	bh=w9dzlHwE4zOZSXrrOMFXhcyCGCwY0q2gs3vSEVl5ROo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OIhzoCmOzVdPIcSJ/7iHZ0rEmssVX6WXBl+QlHPnbDm0mQ2+AH8J/T8ATqbn4A911g6RAP5yFJRRvfmId2fKWFT1095brp6pT1saJMyRYr9H59+4RsXkC80ssccEfz9SMhfU3rt9/7kmDOznUlSAdMFiSu94szwzzobtuSTWpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSsUI0O/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F4CC4CED6;
	Fri, 21 Feb 2025 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740162694;
	bh=w9dzlHwE4zOZSXrrOMFXhcyCGCwY0q2gs3vSEVl5ROo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TSsUI0O/LPq4tUi+VtJdBejS0VyBbnZ9CEQNTq6bY3jWmDeMZfurbKC+P/JikOtij
	 VvFnMYIIAlWnK42mwCiGL8Fr36g/om3oZRKfQ+X8Ze0QKjeykT31YPfp+XgAFjmzmL
	 PYcjuUSFIt8oVFLrci4VItDo0qKSxr5YDZJ5zw11zKtY4muX2F8VxrChohhPPqm5rX
	 +7hRYvXXSbUUEfo+cY07eMcnrMPTK1+vVgZy3jNk4z8HeRoMKkanA9k6ge3pj+YIpD
	 Ba6EU1qw4JLJ9EXASUOk5rpXPSWnRm+wCZfc//WkJnFrHSZvWQkc1O3/lOMr1/5Z0K
	 GHTSL2mAKWmKQ==
Date: Fri, 21 Feb 2025 12:31:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Frank Li <Frank.li@nxp.com>, upstream <upstream@airoha.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8y?= =?utf-8?Q?=5D_PCI?=
 =?utf-8?Q?=3A?= mediatek-gen3: Configure PBUS_CSR registers for EN7581 SoC
Message-ID: <20250221183131.GA353053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR03MB6341ACD4DADDB280A8ACAA29FFC72@SG2PR03MB6341.apcprd03.prod.outlook.com>

On Fri, Feb 21, 2025 at 09:30:40AM +0000, Hui Ma (马慧) wrote:
> > On Thu, Feb 20, 2025 at 08:54:06PM +0100, Lorenzo Bianconi wrote:
> > > On Feb 20, Bjorn Helgaas wrote:
> > > > On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > > > > Configure PBus base address and address mask to allow the hw to 
> > > > > detect if a given address is on PCIE0, PCIE1 or PCIE2.
> > 
> > > > > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > > > > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > > > > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > > > > +	((_n) == 2 ? 0x28000000 :	\
> > > > > +	 (_n) == 1 ? 0x24000000 : 0x20000000)
> > > > 
> > > > Are these addresses something that should be expressed in devicetree?
> > > 
> > > Do you have any example/pointer for it?
> > > 
> > > > It seems unusual to encode addresses directly in a driver.
> > > 
> > > AFAIK they are fixed for EN7581 SoC.
> > 
> > So this is used to detect if a given address is on PCIE0, PCIE1 or
> > PCIE2.  What does that mean?  There are no other mentions of PCIE0
> > etc in the driver, but maybe they match up to "pcie0/1/2" in
> > arch/arm64/boot/dts/mediatek/mt7988a.dtsi?
> > 
> > It looks like you use PCIE_EN7581_PBUS_ADDR(slot), where "slot"
> > came from of_get_pci_domain_nr(), which suggests that these might
> > be three separate Root Ports?
> 
> >I was using pci_domain to detect the specific PCIe controller
> >(something similar to what is done here [0]) but I agree with
> >Frank, it does not seem completely correct.
> 
> > [0] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/pcie-mediatek.c#L1048
> 
> > Are we talking about an MMIO address that an endpoint driver uses
> > for readw() etc, and this code configures the hardware apertures
> > through the host bridge?  Seems like that would be related to the
> > "ranges" properties in DT.
> 
> >I guess so, but I do not have any documentation about pbus-csr
> >(adding Hui in the loop).
> 
> >As pointed out by Frank, do you agree to add these info in the dts?
> >Something like:
> 
> >pcie0: pcie@1fc00000 {
> >	....
> >	mediatek,pbus-csr = <&pbus_csr 0x0 0x20000000 0x4 0xfc000000>;
> >	....
> >};
> >
> >pcie1: pcie@1fc20000 {
> >	....
> >	mediatek,pbus-csr = <&pbus_csr 0x8 0x24000000 0xc 0xfc000000>;
> >	....
> >};
> 
> >@Hui: can you please provide a better explanation about pbus-csr usage?
>
> 	Pbus-csr (base and mask) is used to determine the address
> 	range can be access by PCIe bus.
> 
> 1FBE3400 PCIE0_MEM_BASE 32 PCIE0 base address
> 1FBE3404 PCIE0_MEM_MASK 32 PCIE0 base address mask
> 1FBE3408 PCIE1_MEM_BASE 32 PCIE1 base address
> 1FBE340C PCIE1_MEM_MASK 32 PCIE1 base address mask
> 1FBE3410 PCIE2_MEM_BASE 32 PCIE2 base address
> 1FBE3414 PCIE2_MEM_MASK 32 PCIE2 base address mask

"Can be accessed by PCIe bus" sounds like DMA.  Is that what you mean?

I doubt it, because if you have multiple host bridges, I assume they
would all be able to handle DMA to all of system memory.

It would make more sense if this is some sort of description of host
bridge apertures, e.g., something like this to allow CPU MMIO accesses
to reach the first 2GB of PCI memory space below any of the pcie0,
pcie1, pcie2 host bridges:

  pcie0 0000:00: root bus resource [mem 0x84000000000-0x8407fffffff] (bus address [0x00000000-0x7fffffff])
  pcie1 0001:00: root bus resource [mem 0x84100000000-0x8417fffffff] (bus address [0x00000000-0x7fffffff])
  pcie2 0002:00: root bus resource [mem 0x84200000000-0x8427fffffff] (bus address [0x00000000-0x7fffffff])

But I think this would be described via 'ranges' properties.  And I
think it would make sense if the driver had to learn this address map
from devicetree and program it into the hardware, so maybe that's
what Pbus-csr is for?  Total speculation on my part.

Bjorn


Return-Path: <linux-pci+bounces-22056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09AA403DA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320E94275B8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CFEC4;
	Sat, 22 Feb 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2fs5jSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC94C6C;
	Sat, 22 Feb 2025 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182857; cv=none; b=rQ/W6rQLxlezuBIZXdnjwpmGAW7w+CRpPSGGv6jwoZBryyvC7VS2CSR+9tOFLSwRep8rSdLOK7H1zEhrzSkIcWd19wttblwYrExEVUtsgLrisg2pAYjBRxe3gZdi5N+qcT+8/pE7fzssniop3G2BuhGYfeaMRsqo41O7MJnkI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182857; c=relaxed/simple;
	bh=AWj4ITZuRanuJ+M84ptjWCJk4l50otylm68xoUwxSgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j/LR+MGSu7rBCx+Yg0eEWXbYd3SFKgnyTTcXWI7G610YmaGiFdf2T2fpVbu7g2jzU0ZssktUF292JaanDvA/f0wfXb1UN3jkxCFWh54Q8tx63zYDBaAvCC0WhDJX+CqBCZkGuzG8ONIkrBCbPA3gexGXKvta6JX0cCjwtLoIwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2fs5jSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F75AC4CED6;
	Sat, 22 Feb 2025 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740182856;
	bh=AWj4ITZuRanuJ+M84ptjWCJk4l50otylm68xoUwxSgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b2fs5jSvzjiXNBjYZMclGhfJIA7V+BQx9LiQB8PGf5kbHASKga5yF4WsFKCbBpt8M
	 dlyRA7mDkiuF4ZGwRP1NbkGuVTYM6naci/SCiqugfhxKJCQd/i1q/9Q54QbdibkdEn
	 dqgVLT3UMG4L8e1ZFFpHsLeJTxwtDh5EG/V/HDaIerZBaD/TO8IgbleYjuvzxanGqg
	 bEF3zrzxSwhYJ5h4C3zHgzMaLR+TFo7KefxHmRbcAtDu0d63+HsfgqqUqNdgc3krqP
	 wD7/HM+Fwu46kKbLlhxGP9iQWdiDFxa3a65sdM/lSya7bwWZ/QicToi6rc91engsnS
	 LJ7R4Vr+nq9Iw==
Date: Fri, 21 Feb 2025 18:07:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>,
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
Message-ID: <20250222000735.GA373804@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7kJ3Ejd4Mi_Lj0b@lore-desk>

On Sat, Feb 22, 2025 at 12:18:52AM +0100, Lorenzo Bianconi wrote:
> [...]
> 
> > >
> > > 	Pbus-csr (base and mask) is used to determine the address
> > > 	range can be access by PCIe bus.
> > > 
> > > 1FBE3400 PCIE0_MEM_BASE 32 PCIE0 base address
> > > 1FBE3404 PCIE0_MEM_MASK 32 PCIE0 base address mask
> > > 1FBE3408 PCIE1_MEM_BASE 32 PCIE1 base address
> > > 1FBE340C PCIE1_MEM_MASK 32 PCIE1 base address mask
> > > 1FBE3410 PCIE2_MEM_BASE 32 PCIE2 base address
> > > 1FBE3414 PCIE2_MEM_MASK 32 PCIE2 base address mask
> > 
> > "Can be accessed by PCIe bus" sounds like DMA.  Is that what you mean?
> > 
> > I doubt it, because if you have multiple host bridges, I assume they
> > would all be able to handle DMA to all of system memory.
> > 
> > It would make more sense if this is some sort of description of host
> > bridge apertures, e.g., something like this to allow CPU MMIO accesses
> > to reach the first 2GB of PCI memory space below any of the pcie0,
> > pcie1, pcie2 host bridges:
> > 
> >   pcie0 0000:00: root bus resource [mem 0x84000000000-0x8407fffffff] (bus address [0x00000000-0x7fffffff])
> >   pcie1 0001:00: root bus resource [mem 0x84100000000-0x8417fffffff] (bus address [0x00000000-0x7fffffff])
> >   pcie2 0002:00: root bus resource [mem 0x84200000000-0x8427fffffff] (bus address [0x00000000-0x7fffffff])
> > 
> > But I think this would be described via 'ranges' properties.  And I
> > think it would make sense if the driver had to learn this address map
> > from devicetree and program it into the hardware, so maybe that's
> > what Pbus-csr is for?  Total speculation on my part.
> 
> I agree we should provide these info to the driver via the dts.
> 
> Do you agree to pass the register offsets, base address and base mask values
> in the 'mediatek,pbus-csr' phandle array? Something like:
> 
> pcie0: pcie@1fc00000 {
> 	...
> 	mediatek,pbus-csr = <&pbus_csr 0x0 0x20000000 0x4 0xfc000000>;
> 	...
> }
> 
> where:
> - reg offset for base address:	0x0
> - base address value:		0x20000000
> - reg offset for base mask:	0x4
> - base mask value:		0xfc000000
> 
> Or do you prefer to just pass register offsets in mediatek,pbus-csr phandle
> array and get base address values reading ranges property? Something like:
> 
> pcie0: pcie@1fc00000 {
> 	...
> 	ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
> 	...
> 	mediatek,pbus-csr = <&pbus_csr 0x0 0x4>;
> 	...
> }
> 
> Considering the latter, even if it is not a real problem for EN7581 since we
> have just a single range, what if we have multiple ranges?

I'm really hesitant about giving DT advice because I don't understand
it well, but I do think it's important to specify host bridge aperture
addresses in 'ranges' because there's lots of generic code that
expects them there.

If you have to program the aperture addresses into the hardware, those
register addresses should be described separately elsewhere.  I assume
the aperture size is configurable since you have to write a mask
value, so the driver would have to compute the mask value based on the
aperture size.

Bjorn


Return-Path: <linux-pci+bounces-21937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6DA3E8F2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472CA420760
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F21EE03D;
	Thu, 20 Feb 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTL3U9QP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B801D5160;
	Thu, 20 Feb 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095769; cv=none; b=YiHjHqe04HUEgt1s+BOBs3dmrJIG7qEC2h0kWxjtw3vmsdk4GrO8RPkudzjLN4X9KYtN1fPN09gQ3RhD/mILAsuSYNsKCZmItnKWBPlu8WYqJFaNllk1QUJf2CI1d9F6RkVltbQRpvgcM4lqIChzdlXA4bEEE+EXEQUQaluzeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095769; c=relaxed/simple;
	bh=Eb3PNHLV4cPI8K6SDzl4RrupJI0tXhzPnoREbPcni7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ho5bcpQXiUBehd0/xKcstwcD3RbdoE94jDpnemrGxFRdMRWqD3/Y+2fVSZPvPP9Zozf7mIkUfLomMQrPm3ortyJzfJvc92nk26XunXt+8WGfMNiO/JE+4QFKGrAoA7INb2kNMgCTnQeHy5ilCkFk3n20o0SBuC7Xjc4giTrHnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTL3U9QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83825C4CED1;
	Thu, 20 Feb 2025 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740095768;
	bh=Eb3PNHLV4cPI8K6SDzl4RrupJI0tXhzPnoREbPcni7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PTL3U9QPyEq8DsWrE9mRVirVrg4Xpdiov+zckJd5xANuCrKWRinEGmyP1j/e4m/5O
	 PVBH7axWpFFORCsaWCblKfI5cgAKguHNxxf00l3qzBYjRpYpTjI6gGQ+NrXcIzX3ZX
	 eGNbByszbdPASr4BwCG3lQbds5rfXGf50Sz/9T8Zc49A0Br56VxZmpRxiQYvXZkg9W
	 At/a8C9LxJ56/ITaANbMIo9T9TkJvVBd5PxSBIPJmjKK8kZDJP0Zs/Ld39DNPPWnGp
	 kVZWtAfRV9c5svu8wllde5ohk3JfFANi60LfPU3ssJXYsEUxCFW1MlxPQOrO8j8ri1
	 9ahbSnETYQjSg==
Date: Thu, 20 Feb 2025 17:56:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Message-ID: <20250220235607.GA320302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eIXsupArd8xH7_@lore-desk>

[+cc Frank, who asked the same question about DT]

On Thu, Feb 20, 2025 at 08:54:06PM +0100, Lorenzo Bianconi wrote:
> On Feb 20, Bjorn Helgaas wrote:
> > On Sun, Feb 02, 2025 at 08:34:24PM +0100, Lorenzo Bianconi wrote:
> > > Configure PBus base address and address mask to allow the hw
> > > to detect if a given address is on PCIE0, PCIE1 or PCIE2.

> > > +#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
> > > +#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
> > > +#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
> > > +	((_n) == 2 ? 0x28000000 :	\
> > > +	 (_n) == 1 ? 0x24000000 : 0x20000000)
> > 
> > Are these addresses something that should be expressed in devicetree?
> 
> Do you have any example/pointer for it?
> 
> > It seems unusual to encode addresses directly in a driver.
> 
> AFAIK they are fixed for EN7581 SoC.

So this is used to detect if a given address is on PCIE0, PCIE1 or
PCIE2.  What does that mean?  There are no other mentions of PCIE0 etc
in the driver, but maybe they match up to "pcie0/1/2" in
arch/arm64/boot/dts/mediatek/mt7988a.dtsi?

It looks like you use PCIE_EN7581_PBUS_ADDR(slot), where "slot" came
from of_get_pci_domain_nr(), which suggests that these might be three
separate Root Ports?

Are we talking about an MMIO address that an endpoint driver uses for
readw() etc, and this code configures the hardware apertures through
the host bridge?  Seems like that would be related to the "ranges"
properties in DT.

Bjorn


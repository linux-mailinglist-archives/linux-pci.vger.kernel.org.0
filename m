Return-Path: <linux-pci+bounces-37717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F222BC58CE
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51FB44E7EFE
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E02EC56F;
	Wed,  8 Oct 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mObSjcqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F5285CAB;
	Wed,  8 Oct 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936791; cv=none; b=bOwe8iZAR2+Q/RMjVxFwDVfen/qEO51O1W1SQbOYI9RQtuqAawTlzmJUFAfeZGCPX91ouTyvY0Ju8BinvlwXzukwxOSwc9SdbWbQ6qR3KJ1/ryPZ6JSuxteLtFEgQq9rq9WojytaQn93B95bNjbLcehCAfwSGIrTe5rgdn8jius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936791; c=relaxed/simple;
	bh=i6VA+Bi416CqAXTghlrmyfIEfb8t56u1qvkZfUMrvRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVAusZMPpUhFlirSepHqGPqBXp0ILTccj8Ex1clEnBZYXHrzdUvg8Vhg5UEwDHz+Y4aBBzmbM6uP1GYHK4S9Ql+WOI703xOUL/Gl5K0XOqeq8x4z6RVQ1OduBbefTRkG8AqZxKxemHYeyEYVggsPuMmi/oMAGJgxqiKgnBSa9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mObSjcqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0554C4CEE7;
	Wed,  8 Oct 2025 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759936791;
	bh=i6VA+Bi416CqAXTghlrmyfIEfb8t56u1qvkZfUMrvRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mObSjcqhJYFbTtmCVuFRAoF8fQ7OdIgKcq88IyyQJvq13OjBEotKM1kR3oL5+KKBG
	 IrrnPf1td6SNYIOADfyG3IUgBRVUT2GTNokG6EVdSzsm+kKK8UQG1wyfyxvjIxAT1m
	 WV0DCAr9HVd7HpflJSxgUfGIS2SrWl1WoSl1MUoVFECbpW5NybWzZqSaoOvp+hODta
	 mvHviiSyTBdRSprB429Mx0bAyaWPiWHCsP4r81B9SQprFRBKLYsLU0XcwB6TOzsCqP
	 1fo7/ozlSgouap+2+JqlgY24mUvJ43pnVPKttNqCWbBWQHzH8Sho5PraK+Xpjf7VRC
	 oe2T/w/v8x5QQ==
Date: Wed, 8 Oct 2025 08:19:48 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	NXP S32 Linux Team <s32@nxp.com>, bhelgaas@google.com, jingoohan1@gmail.com, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, krzk+dt@kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Ionut.Vicovan@nxp.com, Larisa Grigore <larisa.grigore@nxp.com>, 
	Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>, ciprianmarian.costea@nxp.com, 
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
 <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>

On Wed, Oct 08, 2025 at 10:35:34AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 8, 2025, at 10:26, Arnd Bergmann wrote:
> > On Wed, Oct 8, 2025, at 00:28, Manivannan Sadhasivam wrote:
> >> On Tue, Oct 07, 2025 at 05:41:55PM +0200, Lorenzo Pieralisi wrote:
> >>> On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:
> > On the other hand, what looks like a bug to me is that the CPU
> > physical address range for the PCI BAR space overlaps with the
> 
> s/CPU physical/PCI bus/
> 

Yes, it got me confused.

> > the physical addresses for RAM at 0x80000000 and on-chip devices
> > at 0x40000000. This probably works fine as long as the total
> > PCI memory space assignment stays below 0x40000000 but would
> > fail once addresses actually start clashing.
> 
> I got confused here myself, but what I should have said is that
> having the DMA address for the RAM overlap the BAR space
> as seen from PCI is problematic as the PCI host bridge
> cannot tell PCI P2P transfers from DMA to RAM, so one
> of them will be broken here.
> 

No. The IP just sets up the outbound mapping here for the entire 'ranges'. When
P2P happens, it will use the inbound mapping translation.

So your concern would be valid if the 'dma-ranges' (for which inbound
translation happens) overlapped with the RAM/MMIO range. But that is not the
case here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


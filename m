Return-Path: <linux-pci+bounces-37716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B5BC587E
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60701896B1D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361D2ECD39;
	Wed,  8 Oct 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL3mTpfb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724272ECD11;
	Wed,  8 Oct 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936485; cv=none; b=ntZbJuHkwUU2rv9hkXhqlcelgfN3woNglnSanE0/KFsWciTNbEc4n+6wyMe+3gUII5a7h1Ba/UKhUZsCMXwRRaBRk7e3bdz1fS3egEhauadl/fPMBFX1aCXTxyEZf0Izjh0G/soOoQxMKMhrWN78dlnGS82Kwk7bJ3r30HFwVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936485; c=relaxed/simple;
	bh=yaCpMcSVmb2a4GcP5V5TbIm8ZHHu7Fc/eP7NoitbYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDe7YAbVBI8jYQRTOhYq/jdY2z0oZGMQqBh6wSRMSIYWY1OP/iTpoXErnxx7v0OBh+7QBXgiKJIHsJ7RHfMSn6VrVBUxyf1ssTI4xgQtFlH6YwnjbdlBIBuRusBOejrXPKowNgnj6kZ9BMpBYojKLrr/a1PJ+bc9Fo00MKZO7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL3mTpfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E553C4CEE7;
	Wed,  8 Oct 2025 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759936484;
	bh=yaCpMcSVmb2a4GcP5V5TbIm8ZHHu7Fc/eP7NoitbYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NL3mTpfbDtaaxlmJsWQllNwCG97x/DX9MX5VPCC5yEH2q8/vYDjPNQ5dJ1JFdJfbz
	 bVjYLqmEMXre3/ASbmA5dCY89XOxT0Oo+iUY6t9RqX52IyAu86xwAm0SqfKZF6R59C
	 4FEmD2Rrgzz+ufDRWidG496D/W98/qtsWjZcCiu9wWiRszBKactZiVLwTJaTsdSTUn
	 mOg0ZM1m1xaWwaw214QA0SBHBK9c2JdKBgR1MlIMrhonOqSzr9dFwyOS5zjE5LKd2B
	 kp/l6kTdM9mlE0Tbpz3wUBT0jI/JkBRsAFVrnKpM5FWJN7yIbSnL+qAslLPpDLped9
	 KU/UyZugDK5QA==
Date: Wed, 8 Oct 2025 08:14:41 -0700
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
Message-ID: <zdqmmpawrntlbebmeb3ey3z3rpxzmlanqqqp4stmbrouwelbx7@s5qt5f53553x>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>

On Wed, Oct 08, 2025 at 10:26:35AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 8, 2025, at 00:28, Manivannan Sadhasivam wrote:
> > On Tue, Oct 07, 2025 at 05:41:55PM +0200, Lorenzo Pieralisi wrote:
> >> On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:
> >> 
> >> [...]
> >> 
> >> > > +                  /*
> >> > > +                   * non-prefetchable memory, with best case size and
> >> > > +                   * alignment
> >> > > +                   */
> >> > > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> >> > 
> >> > s/0x82000000/0x02000000
> >> > 
> >> > And the PCI address really starts from 0x00000000? I don't think so.
> >> 
> >> Isn't the DWC ATU programmed to make sure that the PCI memory window DT
> >> provides _is_ the PCI "bus" memory base address ?
> >> 
> >> It is a question, I don't know the DWC inner details fully.
> >> 
> >> I don't get what you mean by "I don't think so". Either the host controller
> >> AXI<->PCI translation is programmable, then the PCI base address is what
> >> we decide it is or it isn't.
> >> 
> >
> > As per the binding, I/O PCI address already starts from 0x0. How can you have
> > two OB mappings with same PCI address?
> 
> I/O space and memory space can use the same bus addresses,
> since they are disambiguated by the type in the actual PCIe
> transactions.
> 

The DWC IP does the address match translation for OB regions, so I mistakenly
assumed that the PCI addresses has to be unique. But it is the other way around,
the CPU addresses has to be unique. So as long as the CPU addresses doesn't
overlap, we are fine.

Sorry for the confusion.

> We usually assume that I/O space port numbers start at 0 (as done
> here), while PCI memory ranges are identity-mapped to the CPU
> physical address they are mapped at, but in this case the physical
> address window is outside of the low 4GB range, so an identity map
> at 0x58.0x00000000 woulds prevent the use of 32-bit BARs, and
> mapping something in the low bus address range is the only
> possibility.
> 

Agree.

> On the other hand, what looks like a bug to me is that the CPU
> physical address range for the PCI BAR space overlaps with the
> the physical addresses for RAM at 0x80000000 and on-chip devices
> at 0x40000000.

I don't understand the overlap issue here. The outbound address translation only
cares about the CPU address and as long as that doesn't overlap with MMIO/RAM,
we should be fine.

Am I missing something?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-40934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBEC4FE84
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0D33BA966
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4E2C11C4;
	Tue, 11 Nov 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNDC4Lju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9218A6B0;
	Tue, 11 Nov 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897418; cv=none; b=j9A5wlGk4CU3rLB9RaMVpuWoJZKE7PKewqaSNXDfuce9gV3Wi7iJDEgh9S2Loqyd0R8jLh91BcMwO2qiAD85m4S07jYCTo6NwbCnKhpRabbA/sUA8rZRnsF7Cf7ifB+DZrA/ngH/grxGr4coukfPgLqfbxUbnA3aAAueUv0X3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897418; c=relaxed/simple;
	bh=BrVMOaDVyCaFwuLU2xGlgXvKEaAdQBM2gDIRbwlpENA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dXi8K9Xa7yGDdvb//sPGG3XaZL6quYyw39H+z0ENnu6D10lDnbdoFRcQRCo/vno9fBl46Jq3aZUgylytVShwvc7MBH4N5pS4EE/xP/qDEmSkFnaaMkhRFBHhkyRI+yQ85o1wQ1NTlWR6FTMojaKPeRQ21zybcMCTiyQjlL9J2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNDC4Lju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91EDC4CEF7;
	Tue, 11 Nov 2025 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762897418;
	bh=BrVMOaDVyCaFwuLU2xGlgXvKEaAdQBM2gDIRbwlpENA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sNDC4Lju93urVAUKUTfmYYPoCAbyzJNyscqunfEGxAzUiWXuk69Oh3tCqcbEQtNog
	 EL5EUfHxyJci9q6GXQ6FMmVEFGC66wdo0o1bkvERo8OpIuB73pntJm5uW2NBS9+BRA
	 gz4JWOjBN297BL2+KPNS92L5qLDXbAMgCYFMwPmEMP5ftTYhL4yowjPmTLKyy4jo+/
	 jeBj+u/DMKvp+ovtBwOKlIqquhe9A2Gnogp25YSy9N8fnWPwv8zz0EIw0BA6W0xeCH
	 GYBYOxvLnLdMejVkEM3X2FlTkUUBx3wAXZaipvYqRkCcQ/S40YN4T0tIK2mXt9Y+yI
	 sDV6ifo1bVQuA==
Date: Tue, 11 Nov 2025 15:43:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <20251111214336.GA2190667@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRM1VOodnSpaob3P@ryzen>

On Tue, Nov 11, 2025 at 02:08:36PM +0100, Niklas Cassel wrote:
> On Tue, Oct 21, 2025 at 08:05:17AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, 17 Oct 2025 18:32:53 +0200, Niklas Cassel wrote:
> > > The L1 substates support requires additional steps to work, namely:
> > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > >  hardware, but software still needs to set the clkreq fields in the
> > >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > -Program the frequency of the aux clock into the
> > >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > >  is turned off and the aux_clk is used instead.)
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] PCI: dw-rockchip: Prevent advertising L1 Substates support
> >       commit: 40331c63e7901a2cc75ce6b5d24d50601efb833d
> 
> Last update in this thread was "Applied, thanks!"
>
> and the patch was applied to pci/controller/dw-rockchip
> 
> since then it seems to have been demoted to
> pci/controller/dw-rockchip-pend

That was Oct 20, and we had some conversation about a more generic
approach after that, so I moved it to dw-rockchip-pend while we worked
that out.

I fleshed it out the generic approach and will post it soon.


Return-Path: <linux-pci+bounces-41533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA63C6B9FF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1C0E52B7EC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87932777E4;
	Tue, 18 Nov 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkK4SMgq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206B26E710;
	Tue, 18 Nov 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497885; cv=none; b=GV7FLDBlParRjCVlL70ItEK/q5U36mPCL/FiUYNQDe4Nm8wVPbD61+CW6lfOwOjaPSxnaAaKeyjhquCKi/2ruxI8bgeaY1VV6Ujz0H/W9NgmAaYgnzkbmOGuzGGViXFkSMM4NEX7rKTtoU6SgrfZ3mlCmFGZhqNs0vP6C1g/NuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497885; c=relaxed/simple;
	bh=oqg+3OVFmaSRCjxZe5IOBVHsbxPuGIcActP9xjBwLek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E057SbKI6eMSC4hKnF0NIbzGCfk1iJapqR3ZlSMKvzrHzLqJ1+hhVIvqBC1W1rWW5qIWdY51wfcShjgfmAUhkb44wxSYz0ZVAmSS2D+Xsz3bxldhjJvcrya+kKphXLHQjUv2RTjEo7ogRRh3J3VAnb7FTGfsHgcywi/ooIZxFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkK4SMgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6310C116D0;
	Tue, 18 Nov 2025 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763497884;
	bh=oqg+3OVFmaSRCjxZe5IOBVHsbxPuGIcActP9xjBwLek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JkK4SMgqrUOQr1yngEw3ygkBt7hsjFO2BfPlB7viBXZFEu/z2r1YAME19zoF5U3FI
	 GtAk0VuOejJ+h09FjrXlv63p6udIMP8zR1Z7Eu2wpwxQ6wcKY4qd+JfPxOua73pDIU
	 WoXYcnZ5Qur2PlfRQQShINDpOds3gQIsCJxR/LGPBHbAdBU+InGR0lwCgPT8HmwYVC
	 KHrMJlZO1JvyKo9IyVXadOkLPcCrcVtSJ7fMLPW3jfbNKUa862NiHY5KGJd4QVWzcK
	 7sWGYt9EVN/VdeTiCcDR+nRX8gT2+BndVhYP8IpEsUY06cM3WFOepTBXjCEbXgfHqO
	 6BFXx/EywULbw==
Date: Tue, 18 Nov 2025 14:31:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/4] PCI: tegra194: Remove unnecessary L1SS disable code
Message-ID: <20251118203121.GA2590423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRzRsFKkVouJDRRs@ryzen>

On Tue, Nov 18, 2025 at 09:06:08PM +0100, Niklas Cassel wrote:
> On Tue, Nov 18, 2025 at 12:59:17PM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 12, 2025 at 09:29:20AM +0100, Niklas Cassel wrote:
> > > On Tue, Nov 11, 2025 at 04:16:09PM -0600, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > The DWC core clears the L1 Substates Supported bits unless the driver sets
> > > > the "dw_pcie.l1ss_support" flag.
> > > >
> > > > The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
> > > > has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
> > > > "dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
> > > > Substates Supported bits.
> > > >
> > > > The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
> > > > so remove it.
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > >
> > > Since init_host_aspm() is now the only place using struct tegra_pcie_dw
> > > struct member cfg_link_cap_l1sub, I think that you can remove this struct
> > > member, and instead make this a local variable in init_host_aspm().
> >
> > It looks like tegra_pcie_ep_irq_thread() also uses it, although I'm
> > dubious about that.
> >
> > It's odd that software would be responsible for sending LTR messages,
> > but I guess this only happens for tegra194_pcie_dw_ep_of_data, and
> > apparently it's fixed (".has_ltr_req_fix" for tegra234.
> >
> > And odd that we would read the capability register on every interrupt
> > even though this driver is the only thing that can change it, so we
> > should be able to cache the value in init_host_aspm().
> 
> Yes, sorry, my thinking was that this code in tegra_pcie_ep_irq_thread():
> 
> 	/* If EP doesn't advertise L1SS, just return */
> 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
> 	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
> 		return IRQ_HANDLED;
> 
> 
> after your patch can be replaced with:
> 
> 	/* If EP doesn't advertise L1SS, just return */
> 	if (!pci->l1ss_support)
> 		return IRQ_HANDLED;
> 
> 
> Since we already know that if !pci->l1ss_support,
> these bits will be cleared by DWC common code.
> 
> 
> So, after that, we could replace the struct tegra_pcie_dw
> struct member cfg_link_cap_l1sub with a local variable in
> init_host_aspm().

Oh, of course, thanks!


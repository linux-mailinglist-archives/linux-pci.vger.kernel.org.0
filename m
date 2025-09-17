Return-Path: <linux-pci+bounces-36382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCFB81F7A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44084A7FAA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2243081D6;
	Wed, 17 Sep 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHvd1OUm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A02868AF;
	Wed, 17 Sep 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144515; cv=none; b=Nx94wZoMgy/X6bM/LPB4V2XMHA+twFMZSO0FxflQsZbW1meFgS2JghvEhIWCCqntIAHg60IxacYg4Rz778ydU3nnp7W2Tkataj+VV8sgqtjFTeN2y348KGHLGMkjLpQt3qW2uQpnsNVihuSOVwKC4PmNtOpfYnnrsWLd5FItAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144515; c=relaxed/simple;
	bh=sXeuIQMjL3ij8K65U8iZCGwbM5nnx/S7lPAqmUslGis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jSLqxTO9PANgKqo4/cq+78UCvzjg6b/kchzGRYnjZYrvqTXTmBa1pBq9PoGaFMxCC4K05P9hbogEhmCm44RgRDuH2phBiEEz3U3gZtETPnlzYkRH4duYVqTVP2C9uY2xZ5MTc3bB4agpxxYkGaNFYDU52pISgt5C+pEh4KU9k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHvd1OUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92193C4CEE7;
	Wed, 17 Sep 2025 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758144514;
	bh=sXeuIQMjL3ij8K65U8iZCGwbM5nnx/S7lPAqmUslGis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bHvd1OUm79r3XEeX6f8axMNEa0NGPaqKHC9jl1m7C+c0nonFO2VZoF6uksqnhj59f
	 4fUfAP+VPXo+8qfg+E/5sszwLGo572XdGdc++XSGEkZi2/iceZkeBB7gVzuCKAgX8P
	 eeVrQjhLjrtUoMlHTmlEA8hoFRLL3jcvBYMw6FWP/+mHfgtn5q5R+ODbra9qR8z6Rr
	 5BtBboj5xHGS9PaZNd4gK8GT9nntFNsfr9ySCGXyAHYsWxmagjBTRylsJG3vmqdxC6
	 rdsHUjs0cQkCqlPepE7v2TZmrpvuFbRRg0QGPJlhUY+6x959gdEIyAQX5Ueh+gsRlM
	 sq0tsUpoiYN3A==
Date: Wed, 17 Sep 2025 16:28:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <20250917212833.GA1873293@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e236uncj7qradf34elkmd2c4wjogc6pfkobuu7muyoyb2hrrai@tta36jq5fzsr>

On Wed, Sep 17, 2025 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Sep 16, 2025 at 09:23:13AM GMT, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> > > On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > > > Describe the PCIe controller available on the S32G platforms.
> > 
> > > > > > +                  num-lanes = <2>;
> > > > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > > >
> > > > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > > > Please put them in a separate stanza.  See this for details and
> > > > > examples:
> > > > >
> > > > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > > >
> > > > Ok, I'm going to have a look
> > > 
> > > This driver relies on dw_pcie_host_init() to get common resources like
> > > num-lane which doesn't look at childs to get num-lane.
> > > 
> > > I have to keep num-lane in the pcie node. Having this in mind should I
> > > keep phys as well as they are both linked ?

> > Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?
> > 
> > dw_pcie_host_init() includes several things that assume a single Root
> > Port: num_lanes, of_pci_get_equalization_presets(),
> > dw_pcie_start_link() are all per-Root Port things.
> 
> Yeah, it is a gap right now. We only recently started moving the DWC
> platforms to per Root Port binding (like Qcom).

Do you need num-lanes in the devicetree?
dw_pcie_link_get_max_link_width() will read it from PCI_EXP_LNKCAP, so
if that works maybe you can omit it from the binding?

If you do need num-lanes in the binding, maybe you could make a Root
Port parser similar to mvebu_pcie_parse_port() or
qcom_pcie_parse_port() that would get num-lanes, the PHY, and
nxp,phy-mode from a Root Port node?

Then all this would be in one place, and if you set ->num_lanes there
it looks like the DWC core wouldn't do anything with it.


Return-Path: <linux-pci+bounces-41535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09529C6BAA2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A66703562E7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA33043C1;
	Tue, 18 Nov 2025 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBNTS4dF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB222B5AC;
	Tue, 18 Nov 2025 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498741; cv=none; b=R4YRTNfetROGzhyzqU3sh9HBJ94+Pw0sRIT9Hx5rwg8Aa37nRCWV8pcMizFSCQqyM2sEmasUsdt7/zkXIqe0yGCMaeozTiUQO0ThLMFuadTK36A5jNF3e/jsMPg3eUpwSuZqIWrx8IQX9sOTWVBXIkXBn7JFHw8w/yySq0Lga5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498741; c=relaxed/simple;
	bh=LrsefOmy8EGZJbBvhiH/EY4R37o/mLzhhIaUXiOgkgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti7SRY3GQKGZ6zI9sxF09esbK4KA3K2M40Sl/37AE8hBuWkoE1/BfJrkqhreJgSTIn2yGCcuOzBIw5jjQ2fQENAwJcB+h9xJy0vngJtSTXEg0GWwYFhZquOI84JPR3dXmB/vcM7Q8wCq/TKb1ZkB1JuMCw/u3PGAtJNjVpMsY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBNTS4dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F59C2BCB3;
	Tue, 18 Nov 2025 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763498741;
	bh=LrsefOmy8EGZJbBvhiH/EY4R37o/mLzhhIaUXiOgkgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBNTS4dFeqs1FxFndbuiQs+P0fZn5Hw4UTyl3rTK+ReloR30FDw/Xxk8gH4fQQpsF
	 GwZoCV9JcAUtQmYn170bze64xD2/1D8MUO1meUJ8qXd9NLZ77u+7dIMTcUFDE4SV+L
	 lRlB2nMpf+fyuXhnqkEys4h4pN/+b+Zv3zfG2fjxtVhI8l7OMzddngHZkyio7ZVa9L
	 NhFNrhYDRt7+lj0mhg/yarjQMG/1RM3w0lr15pXPSELHseWixdv4RsZDCEjJ1iF0Df
	 WIKGjP8UwpA+NT3MigFbYOnUA0ddqkKduzZA/AM79ITWi0prkGNCj/CUrWuvujYr5B
	 jGu5g4/hp5R1g==
Date: Tue, 18 Nov 2025 21:45:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
Message-ID: <aRza6quobL4obC58@ryzen>
References: <aRRDzKFVTFTIuvvh@ryzen>
 <20251118203638.GA2591575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118203638.GA2591575@bhelgaas>

On Tue, Nov 18, 2025 at 02:36:38PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 12, 2025 at 09:22:36AM +0100, Niklas Cassel wrote:
> > On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> > >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> > >  
> > > +	dw_pcie_config_l1ss(pci);
> > 
> > The name dw_pcie_config_l1ss() sounds like we are enabling l1ss.
> > 
> > I know naming is hard.
> > 
> > Perhaps dw_pcie_disable_unsupported_l1ss() ?
> > 
> > Or something similar.
> 
> "disable" sounds like something we do with a control register, and
> here we want to remove the advertised support from the capabilities
> register.
> 
> Maybe dw_pcie_hide_unsupported_l1ss()?

Sounds good to me :)


Kind regards,
Niklas


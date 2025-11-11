Return-Path: <linux-pci+bounces-40941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A1C50091
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 00:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272D51897CDA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E42E7167;
	Tue, 11 Nov 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIsHRwtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC72C21FC;
	Tue, 11 Nov 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762902433; cv=none; b=KEKmHoWHiwpii3PA0JMMEW+O3gubV9uZ+wlNZA593+U9ymZuKvQ61F5AJTvDGJxXG80foRgPyg3QFm/Nsgf940/Uh8Q5xGJN3SorhV9nty1Mt1bg37WiGvTLkDQ8TCfxJGlVcVVNWZVdq2//m+xmAv+4y7NLh22UTQt4pM3O0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762902433; c=relaxed/simple;
	bh=IWaM6CDGnSAC6qohFfgy7sPG58r65YBIiW+Qqnin45s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dJm0IhBLBeb4onOvTyLKbdrD5IejTjzlGHe8ZY+mz/QmiR64UWrqlro5TdDObIwUi6mV3p3PZUtuQF/K3OGMojBpGNtt2Av5Kqs2LygY3fukeNF+wZt8YYInpTaMPwut+AIugkv4PPaQRCkyWDg176kRl/X/gItEg4CaESMM8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIsHRwtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1DC4AF09;
	Tue, 11 Nov 2025 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762902431;
	bh=IWaM6CDGnSAC6qohFfgy7sPG58r65YBIiW+Qqnin45s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NIsHRwtM9RtVAveYD7hxhkQk2BIMsIkYUeUZPG2ttP4o2ZHS8gUyQ+ezYo/ROnHNL
	 ZGkfAiVYCouHoUZMCLyzLAPBVaU1V3tfo222E+IVfFEgIGTfqGu1kxwuniBfhj5fF2
	 T3bPCc7oF1rMZ4X3AqtNc0ahRt5X3OPEjEexkdaLc+BRGnE79Kmk2JQ74xaqJPX9ia
	 JWB3MLuNI635l+qnj9OXSZ8hFS9VdbUX0dLG1eYUVWHnVITxgYHka2GkmjGCTyE3WC
	 ebjeEIpdODruvkyUzuIMbDa11SMUpYR+Zjkr8XxquSvB4Tb7IXP8p9EioT2D0Kx4HJ
	 ZLwMVqRFWlBJw==
Date: Tue, 11 Nov 2025 17:07:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
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
Message-ID: <20251111230710.GA2210983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRO9J9ybdseyExYK@lizhi-Precision-Tower-5810>

On Tue, Nov 11, 2025 at 05:48:07PM -0500, Frank Li wrote:
> On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > L1 PM Substates require the CLKREF# signal and may also require
> > device-specific support.  If CLKREF# is not supported or driver support is
> > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > e.g.,
> >
> >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> >
> > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > enable L1.x via sysfs, users may trip over these errors even if L1
> > Substates haven't been enabled by firmware or the driver.
> >
> > To prevent such errors, disable advertising the L1 PM Substates unless the
> > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREF# is
> > present and any device-specific configuration has been done.
> >
> > Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> > "supports-clkreq' property) and qcom (for 2.7.0 controllers) so they can
> > continue to use L1 Substates.
> >
> > Based on Niklas's patch:
> > https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
> >  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
> >  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
> >  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
> >  6 files changed, 35 insertions(+)
> >
> ...
> >
> > +void dw_pcie_config_l1ss(struct dw_pcie *pci)
> > +{
> > +	u16 l1ss;
> > +	u32 l1ss_cap;
> > +
> > +	if (!pci->l1ss_support)
> 
> I think when l1ss_support true, need return.
> when l1ss_support false, need clean PCI_L1SS_CAP.
> 
> Do your logic reverise?

Yes!  Thank you, fixed locally.


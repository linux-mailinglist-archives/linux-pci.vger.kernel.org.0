Return-Path: <linux-pci+bounces-41987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1526C82867
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB7C14E2A13
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997732F6936;
	Mon, 24 Nov 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUnwH3pW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C602F6921;
	Mon, 24 Nov 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019349; cv=none; b=DtWSVJ5K64vt6IYVefo54qG3y8mlb+iVu0xVjtZmxp8NcZuOe/maQFxzIPLu7CWW8r7SvRKHUYDkrVdrXwSy9+cY0x6Embdrit0b8VGduXoXS7hQUFYhFy18u2/1sPf1z7NH4FjFXIboBKseSsajstxKf3RQVV84j7Uv1ZNQJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019349; c=relaxed/simple;
	bh=RgrwDiinUzSpRqOGQiyfN+hRdSZO/OtpULDIPl/RaxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JOFdNyWP09mbytPfYqG4Dl0acnH/pDkfUJ5FwDExswgzLk4rCWbvwNKIxZjggN251Au7YhlAK/A9iPI+ye4yuorvwtT+IHNm1Y9D2Y5uyWotWFjGPm8P8qUvnqXW/5pGtS8dx3KnMSyaQ3HtfYZ4gp8m9RAvi0HMvui9HHNq2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUnwH3pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB27C4CEFB;
	Mon, 24 Nov 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019349;
	bh=RgrwDiinUzSpRqOGQiyfN+hRdSZO/OtpULDIPl/RaxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qUnwH3pWJBpE5n0hprzgUyQmQnyYDnqdsNL/7ivetkau8W72rzPw6TL6kyAZV06Cx
	 EESXAQ4m3JglpM69+IQcbANa/HFyP8qH9IXLwafZrKq+OV8OsiNXw7UDN2s3xWfS86
	 iq3U1hEgP0NdFE3xGqp8dkXzBpw21zocJN6AvpzNM2DQC4J5F8Y0wv+ajYA8mS1YIM
	 NSphcDi7VxA//qJ0GbJa8B2of/bu+R600bs7kWLaj+FzTWGKztJcxFQqO5ST1vsMHv
	 IH56mX+FT9s3Pcesq9w7rJJUrVxwhFgELcKZui4Ji52NlX0oO74l74Nq+azyLy8Ntb
	 49DxDSoqMqi4A==
Date: Mon, 24 Nov 2025 15:22:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
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
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <20251124212227.GA2713330@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2lOZDBEdGVd9On@ryzen>

On Wed, Nov 19, 2025 at 12:08:41PM +0100, Niklas Cassel wrote:
> On Tue, Nov 18, 2025 at 05:34:18PM -0500, Frank Li wrote:
> > On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > L1 PM Substates require the CLKREQ# signal and may also require
> > > device-specific support.  If CLKREQ# is not supported or driver support is
> > > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > > e.g.,
> > >
> > >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > >
> > > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > > enable L1.x via sysfs, users may trip over these errors even if L1
> > > Substates haven't been enabled by firmware or the driver.
> > >
> > > To prevent such errors, disable advertising the L1 PM Substates unless the
> > > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> > > present and any device-specific configuration has been done.
> > >
> > > Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> > > "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
> > > and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
> > >
> > > Based on Niklas's patch:
> > > https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
> > >  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
> > >  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
> > >  6 files changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 7f2112c2fb21..ad6c0fd67a65 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > >  	if (ep->ops->init)
> > >  		ep->ops->init(ep);
> > >
> > > +	dw_pcie_hide_unsupported_l1ss(pci);
> > > +
> > 
> > And, I don't think EP need clean L1SS CAP flags. If EP don't support L1SS,
> > it should be force pull down #clkreq.
> 
> I think the problem is that we cannot force pull down CLKREQ# in a generic
> DWC function. That would have to be done in glue driver specific callbacks.
> 
> Bjorn, perhaps we should simply drop the dw_pcie_hide_unsupported_l1ss()
> call from dw_pcie_ep_init_registers(), and consider hiding L1ss for EPs to
> be out of scope for this series.
> 
> That way, we could still queue this series up for 6.19.
> 
> Thoughts from everyone?

Good idea, done locally, thanks!

Bjorn


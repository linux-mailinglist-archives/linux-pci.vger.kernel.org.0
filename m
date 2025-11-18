Return-Path: <linux-pci+bounces-41529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 964ECC6B854
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3620235401F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BB2DCBF8;
	Tue, 18 Nov 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUurIK0Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23827F00A;
	Tue, 18 Nov 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496380; cv=none; b=SrfBwta448TZz4Gom61jXusPrJh8GMpbtvEjQdViGSp5qFx873RJXuS+dSld5K/9HR/tgqdQ/RYT7stfy5WtWkw6xv2+fFCc5KRJRR2BbqbCW8n6UXKrLnZmEEakJ5Kuy1yj6u3K4eloIUlWK8Z8qTxEonHBbO1FtVL/ukyGAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496380; c=relaxed/simple;
	bh=OWueXLv1GkidpSobbWOxzP1bNyno7+0tNkEr7FL03sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP2q0qp+xCWD5v8TSiuqrvV3c3qNwSugynpZuleeiL94XDDvfLgFZQZTFkoZeer3UU3egAEjAN6QAJK16PVnhhGLVk8YXPg8nw+nktrvdlw0lUi4Ip+zjqMriTGS0MxnvHnNUHyuIqLsuK/DvzE1gmn/G4NUY4tDbANHmTtHe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUurIK0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF55DC4CEF5;
	Tue, 18 Nov 2025 20:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763496378;
	bh=OWueXLv1GkidpSobbWOxzP1bNyno7+0tNkEr7FL03sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUurIK0Z0sKXeHJdsUgGZ2LIf1F7YrKZt2nQRR4Isz709nmFMo/qoMDiEkAtB0a0q
	 qiccU3CYAvBKFHEkPzn4DND9yaXDM9f9Q3No5h2j1xvWeMjaE3cD7XKzlhTVNLIVF5
	 LsMX1t/AS2eJNIE704QaNBpZSI559hShgvQ/QPMUMqpCpsxEhDFqNT7XShwrd2NWrj
	 l8IDJLQhluW8axVX9tzEZ4A/bHphXCNCkjM2T5PLydmqgMVCGYs55/f/NhT9fC7rUk
	 Gn+NggMtGQLfqe24VnT0aic3x1CFUnLoIY6e97PtARFNVHdy+tVjrmBZkpGLAYtoiP
	 B0mkVjNKqwvCA==
Date: Tue, 18 Nov 2025 21:06:08 +0100
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
Subject: Re: [PATCH 2/4] PCI: tegra194: Remove unnecessary L1SS disable code
Message-ID: <aRzRsFKkVouJDRRs@ryzen>
References: <aRRFYEgBigYDlfQh@ryzen>
 <20251118185917.GA2583698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118185917.GA2583698@bhelgaas>

On Tue, Nov 18, 2025 at 12:59:17PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 12, 2025 at 09:29:20AM +0100, Niklas Cassel wrote:
> > On Tue, Nov 11, 2025 at 04:16:09PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > The DWC core clears the L1 Substates Supported bits unless the driver sets
> > > the "dw_pcie.l1ss_support" flag.
> > >
> > > The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
> > > has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
> > > "dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
> > > Substates Supported bits.
> > >
> > > The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
> > > so remove it.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> >
> > Since init_host_aspm() is now the only place using struct tegra_pcie_dw
> > struct member cfg_link_cap_l1sub, I think that you can remove this struct
> > member, and instead make this a local variable in init_host_aspm().
>
> It looks like tegra_pcie_ep_irq_thread() also uses it, although I'm
> dubious about that.
>
> It's odd that software would be responsible for sending LTR messages,
> but I guess this only happens for tegra194_pcie_dw_ep_of_data, and
> apparently it's fixed (".has_ltr_req_fix" for tegra234.
>
> And odd that we would read the capability register on every interrupt
> even though this driver is the only thing that can change it, so we
> should be able to cache the value in init_host_aspm().

Yes, sorry, my thinking was that this code in tegra_pcie_ep_irq_thread():

	/* If EP doesn't advertise L1SS, just return */
	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
		return IRQ_HANDLED;


after your patch can be replaced with:

	/* If EP doesn't advertise L1SS, just return */
	if (!pci->l1ss_support)
		return IRQ_HANDLED;


Since we already know that if !pci->l1ss_support,
these bits will be cleared by DWC common code.


So, after that, we could replace the struct tegra_pcie_dw
struct member cfg_link_cap_l1sub with a local variable in
init_host_aspm().


Kind regards,
Niklas


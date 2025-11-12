Return-Path: <linux-pci+bounces-40963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C67C511DC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E28C18972A8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391682EDD6F;
	Wed, 12 Nov 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6TTndyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05A279346;
	Wed, 12 Nov 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936170; cv=none; b=bj/ErPqDqbT55jG0r1ALHjatT/yxe4DQlDZZHaLWOZ+BzE2/lekSmrqDA42i4hDg1H7g4UhDNvyzZsc/IwqQjokFZb55h6eGijoarO0axfPAR+fBQ/rVCHPvwvKoeP9XU8XNCd0+RQNBaUpvG6xup7vasBZn3kH+s53Kt/ThhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936170; c=relaxed/simple;
	bh=P/0U373DGH20CkAHJePNGHyKPPEzprJMAMaujhEWE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YADtiZ+B69fcIY1A4i8dzQCWu+V8dCGey9Dl2+k5I9gBbvhjQeEZOIhXFmqBizAV4rvqoBl13D2w2EbJ/C2yPzyTGw4VV79cEv8udk/9ocP1D/GQK1tNU+ygeZRxGBnWXCbUXQCt0hQAlNIcs0F8ypS9t9tZEfoDfS88ivI7/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6TTndyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36568C4AF0F;
	Wed, 12 Nov 2025 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762936169;
	bh=P/0U373DGH20CkAHJePNGHyKPPEzprJMAMaujhEWE3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6TTndyT/9VXKdEYPZNdVHH1e9mSNLLOM0nt2QNNuy2DF1zpJ7VX1W+XA8x8VBpFw
	 0q6reZVdpYS5+XUTeIlSFeRx/5l+TKy5+5Rh3Jtxytgs3/FTaIUG4PY7L+PNR7D4PF
	 wXiTYDw8GjkAr6Eq8wyo5PlZ5FKT6nEP5lRpV8aqYzrH0DwRY/S2dqMJrFElqiVqMn
	 RIDq1wZTZe7QbeVDI+1y+p6nbUc9YUwzB9djea+Ku5JeccJn6zwmtExUdHKGhMMIZC
	 bN3Wj70GJa9eWKC0+3SeaJ3f5uIehr962xnTbck2guqY5qREURZ8Vegcrhv4M/VpBo
	 +fZ8lRpBqYwzw==
Date: Wed, 12 Nov 2025 09:29:20 +0100
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
Message-ID: <aRRFYEgBigYDlfQh@ryzen>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111221621.2208606-3-helgaas@kernel.org>

On Tue, Nov 11, 2025 at 04:16:09PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The DWC core clears the L1 Substates Supported bits unless the driver sets
> the "dw_pcie.l1ss_support" flag.
> 
> The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
> has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
> "dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
> Substates Supported bits.
> 
> The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
> so remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Since init_host_aspm() is now the only place using struct tegra_pcie_dw
struct member cfg_link_cap_l1sub, I think that you can remove this struct
member, and instead make this a local variable in init_host_aspm().

Other than that, looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


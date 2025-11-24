Return-Path: <linux-pci+bounces-41995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2401C82BDA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C0E4E0340
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8142522BA;
	Mon, 24 Nov 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4X4KN3E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAC23D7E3;
	Mon, 24 Nov 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024633; cv=none; b=Pxfor9azvakbYtvu0OTk+f6jqd7crQ2p2MPuuSF+ojIuGypEVbuGcj/EgGTLhZH9MulljN3+HhCL7u8Yj9yQ2nUVsmeAep+trFtZ8IW2aUKR+HuioXMT1DbIup9eVc7BO9gw+az3DEfFxg/z0RyC5sUrzOKdcWlV9ZgUxLWANk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024633; c=relaxed/simple;
	bh=L9vxregCDQ2mkA1oTO/p4wTdwRK2bHafb670knLdCeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Smol3pxyKzRBJfmAAyQBZOoxhaLSjbq0CirAyroNszy6STdi+3wgs/Q/LoPv+ZmYLd22UDPmQyTRObnFDlUH3fmgk5anGOR1KIlT6rgznqi7xIY4292sGuE/r/m6QUpb4+LFQ65oDQ/Zzs8EddgPurF+iLRanyrMh+EWz+ih32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4X4KN3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DCFC4CEF1;
	Mon, 24 Nov 2025 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024632;
	bh=L9vxregCDQ2mkA1oTO/p4wTdwRK2bHafb670knLdCeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c4X4KN3EdiwLBbtGn7PgXZnYSgyoNSzgxcz5NevhwkczGejGdZ0AFxz2+e9CVKVY/
	 xZ8nrqYXcK29Er0/xWvywyxNy1FktZ33X1PITEPOA0SDI8EDfwTveqPWkS3CUh4tBU
	 IuNU3Em4z6ZCaPeaaKU5ZLFVvG/S3rYij2zGTmiwxurIObDVX+2I73Zif5gakUuzdq
	 wCjDZ15m/X9SZYDeLfys5ZdcB0OwmRgxjICh1zIuEExKgCyP68Jnb1EX/O+zRj8CVE
	 UciEjUzm+bOsIxB/zSggy0Js1Opcw9zhZLYKQUv7zpq3EO2o21Z0ys+LSDv6xDMvyi
	 2O5HZfBiEnyYA==
Date: Mon, 24 Nov 2025 16:50:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH v2 0/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <20251124225030.GA2721839@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118214312.2598220-1-helgaas@kernel.org>

On Tue, Nov 18, 2025 at 03:42:14PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a follow-up to Niklas's patch at
> https://lore.kernel.org/r/20251017163252.598812-2-cassel@kernel.org.  That
> patch clears the L1 PM Substate Supported bits for the dw-rockchip driver,
> which doesn't yet do the device configuration to support the L1 Substates.
> 
> This series does the same thing, but in the DWC core so it applies to all
> DWC-based drivers.  Drivers that do support L1 Substates (currently
> tegra194 and qcom) indicate that by setting "dw_pcie.l1ss_support", and the
> DWC core will leave the L1 PM Substate Supported bits alone.
> 
> This also includes Shawn's patches to add the dw-rockchip support for L1
> Substates.
> 
> The problem this fixes is that users are currently able to enable L1
> Substates, e.g., by
> 
>   - building with with CONFIG_PCIEASPM_POWER_SUPERSAVE=y
>   - booting with "pcie_aspm.policy=powersupersave"
>   - echo powersupersave > /sys/module/pcie_aspm/parameters/policy
>   - echo 1 > /sys/bus/pci/devices/.../link/l1_1_aspm
> 
> but this breaks devices if the platform doesn't support CLKREQ# or lacks
> Root Port configuration.  This series avoids that problem by preventing the
> kernel from enabling L1.x in the first place.
> 
> 
> Bjorn Helgaas (2):
>   PCI: dwc: Advertise L1 PM Substates only if driver requests it
>   PCI: tegra194: Remove unnecessary L1SS disable code
> 
> Shawn Lin (2):
>   PCI: dw-rockchip: Configure L1SS support
>   arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1

I applied these (except for the arm64: dts: patch) to
pci/controller/dwc, planned for v6.19.  Same as posted here except I
dropped dw_pcie_hide_unsupported_l1ss() from
dw_pcie_ep_init_registers().

>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  7 ++-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 +
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 ++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 40 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  2 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 48 ++++---------------
>  8 files changed, 85 insertions(+), 42 deletions(-)
> 
> -- 
> 2.43.0
> 


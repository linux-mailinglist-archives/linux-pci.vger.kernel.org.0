Return-Path: <linux-pci+bounces-34063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB4B26BAD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845055E17BF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4823BD1B;
	Thu, 14 Aug 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hABxWo7/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8832142C;
	Thu, 14 Aug 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186625; cv=none; b=lY7uoC/MTJV5SKtYUqHZnIgjPcIIDnOpOf1hYh5rEI4Ud0ZMOMTxmaSlSlBfoyPMAMoEJt2MSD/guECcnQw919GZZd1QDiOArAFdQH9bwGwVYEpsm5XGNmh9iPnE/wG+YbO4LNYBPcEvjHUj9HUuH6G6on27X/yUfg5TJ+Hdzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186625; c=relaxed/simple;
	bh=o/MgtG1g9Rt5y/lAK6YBxZs06Pfqhy/MN+PlW0TT6zY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JBsse9H/YuUqXvzRgTiTaMIVU0qxMQg0P8/Jtt8FJ+peV0bDhY+mZAt93BoO18NiMIa1f+ibeUwiRdS+tuoNgEGZguj2ZZCR4pXER8CDQ+ttxAASfHXBAAgxWm1gssQRTJhEivWsWy1ChinOLZO7j8Q4am0vdkp+HPqSj3was8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hABxWo7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B0C4CEED;
	Thu, 14 Aug 2025 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186624;
	bh=o/MgtG1g9Rt5y/lAK6YBxZs06Pfqhy/MN+PlW0TT6zY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hABxWo7/m8RV9cAcTZtZaUIEUqgl9tHzY7MAGXzXDi1h0HabiSaR90DAXzp67TWmF
	 U3o8bL2bFI98VWHbFSMyxlAy5TQYdtR2G++O6l0KliRJs2EbeJld/7OKWkDfcUrOIl
	 0xfAtz3yLkvtpi30XW37DeWsUbSGKgPUVUF1P58XR0gVgs+MNLqpsZkmYgs1ejou9W
	 tY4ezf6uWOrDwNRmSPTAgviF31BJxxVYx8W6JUSiBTOxeiGycaYA1eFU5Svy0kBjRr
	 wz6cEmKiiWTFycFptGV5EwGACSMjHnViMm8H+4C69Ai0v2gBl7/LC2WW2nqaMiqePg
	 NuaZILW4rT3jg==
Date: Thu, 14 Aug 2025 10:50:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/13] PCI: Drop superfluous pci_epc_features
 initialization
Message-ID: <20250814155023.GA330705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>

On Thu, Aug 14, 2025 at 05:21:19PM +0200, Niklas Cassel wrote:
> Hello all,
> 
> struct pci_epc_features has static storage duration, so all struct members
> are zero initialized implicitly. Thus, remove explicit zero initialization
> of struct members.
> 
> Series is based on pci/next.
> 
> Feel free to squash to a single commit if that is preferable.
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (13):
>   PCI: cadence-ep: Drop superfluous pci_epc_features initialization
>   PCI: rcar-ep: Drop superfluous pci_epc_features initialization
>   PCI: rockchip-ep: Drop superfluous pci_epc_features initialization
>   PCI: dra7xx: Drop superfluous pci_epc_features initialization
>   PCI: imx6: Drop superfluous pci_epc_features initialization
>   PCI: keystone: Drop superfluous pci_epc_features initialization
>   PCI: artpec6: Drop superfluous pci_epc_features initialization
>   PCI: designware-plat: Drop superfluous pci_epc_features initialization
>   PCI: dw-rockchip: Drop superfluous pci_epc_features initialization
>   PCI: keembay: Drop superfluous pci_epc_features initialization
>   PCI: qcom-ep: Drop superfluous pci_epc_features initialization
>   PCI: rcar-gen4: Drop superfluous pci_epc_features initialization
>   PCI: tegra194: Drop superfluous pci_epc_features initialization
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  | 2 --
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 1 -
>  drivers/pci/controller/dwc/pci-imx6.c             | 4 ----
>  drivers/pci/controller/dwc/pci-keystone.c         | 1 -
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 2 --
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 2 --
>  drivers/pci/controller/dwc/pcie-keembay.c         | 1 -
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         | 1 -
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 --
>  drivers/pci/controller/dwc/pcie-tegra194.c        | 2 --
>  drivers/pci/controller/pcie-rcar-ep.c             | 2 --
>  drivers/pci/controller/pcie-rockchip-ep.c         | 1 -
>  13 files changed, 22 deletions(-)

Squashed into one, added "remove explicit zero initialization for
features that are *not* supported so we don't have to touch existing
drivers as new features are added" to commit log, and applied to
pci/endpoint for v6.18, thanks, Niklas!



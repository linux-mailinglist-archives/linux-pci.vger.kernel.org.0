Return-Path: <linux-pci+bounces-41548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7AEC6BE40
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3D1F92AFDB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168DE29B8E5;
	Tue, 18 Nov 2025 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf6l0GI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AC19D08F;
	Tue, 18 Nov 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505959; cv=none; b=TAZgQlaPhqCKWLAk0ruS/OL9Wulw+8q/2TXQLY07Tj9Bit8P0O9m1MZMO/+YbN856tn4wHD/2VqzEuqgQdq8E7wJ7cYas+2UO2BvMPQm1K5YglQLxrffGd7MJwbjEohllngkyu2PVamTTIdol98WsdQf4H9TsxR9czQg9HOHw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505959; c=relaxed/simple;
	bh=lPmYAC5UhGq5csm5w1kpo4lzZfCH3Y5ufvUShymSFxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpUP8semGqXL2iTmBq7PTFodwmXAotqhso3wBjJXDEHso/dtBkLP/0jYyYDrcy7Fdfw/vRX9HBgUC5tkXWFbZKiiiSIvE4MA2AuU/8UsHrL9ol2naSc4qmlj432MZdIHpOBEbSHr+eNjVLb9q/Ok01Wx7YlC6409cIJ/1HY0bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf6l0GI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE8C2BCB2;
	Tue, 18 Nov 2025 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763505958;
	bh=lPmYAC5UhGq5csm5w1kpo4lzZfCH3Y5ufvUShymSFxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gf6l0GI2o2/EgE75LRuMBYxnQT61mUg8fexr0O/NLCVyFl0crqJh8ZyF60v86MbBV
	 oRyn3uZVM0CBaL8BGFVh4+c74IYt02Yal5tJJ1D06rwYgtUqwst9j2z0COSsZ9jZk/
	 OpTjOdbthQxGucQOfJqVgQbQeHeep42OYY7t0jaoPOtJERc3uAkFuSdmmlSV8JS8Q6
	 dMIt2Gbe6UsjWWkJL1pHh2lO891xUxdcoqW0UwqOy44hvWKNawpVvKhm3LPOSF5qQc
	 xsUfvQfQMN0mYU+FoMwH86p+YunCirxNYJbXMSsAckDLL8HITuWUhl823GeesM2N+M
	 VQINgYUfjydsQ==
Date: Tue, 18 Nov 2025 23:45:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
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
Message-ID: <aRz3Gnw-0IRtUj9f@ryzen>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRzxNMJ+byxZiF3i@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRzxNMJ+byxZiF3i@lizhi-Precision-Tower-5810>

Hello Frank,

On Tue, Nov 18, 2025 at 05:20:36PM -0500, Frank Li wrote:
> >
> > +	dw_pcie_hide_unsupported_l1ss(pci);
> > +
> 
> Need call dw_pcie_dbi_ro_wr_en(pci) to access PCI_L1SS_CAP.

I disagree.

At least when checking two different versions of the databook
(one very old and one more recent), the register fields that we
are touching are all marked as:

Dbi: R/W (sticky)


There are some other register fields in PCI_L1SS_CAP, e.g.
NEXT_OFFSET, CAP_VERSION, and EXTENDED_CAP_ID that are marked as:

Dbi: if (DBI_RO_WR_EN == 1) then R/W(sticky) else R(sticky)
Note: This register field is sticky.


But since we are not touching any of those register fields,
the current code should be good as is.


Perhaps your version of the databook says differently than the
two versions I have, but considering that they seem to have
intentionally made these R/W without the need for DBI_RO_WR_EN,
I don't see a reason why they would want to change it even in
the absolute newest IP version.


Kind regards,
Niklas


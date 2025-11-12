Return-Path: <linux-pci+bounces-40962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72299C5115E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED9E034BD01
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233312DC796;
	Wed, 12 Nov 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kttxp00X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CD2D6E42;
	Wed, 12 Nov 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935766; cv=none; b=dHGUgKpTP/nBv6FI0FuBY9zI1pTJKWSIz5f5bh86u+/w/89juLaQW7sgpRuzAO1IgMxZClqrfIGSoXQA9SdtMkXwNyCJK5Cy6Pw6pU39ifKbHG5hlWK7ENSoCFLc8MIVBH6q2+PsKt7+699Q1p3KYoqMUOieoZDtQa+PtAQYkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935766; c=relaxed/simple;
	bh=WHWCVmYt6UtQ3D5Ri8XoM/WvWGHNmlnb2EcUM8qufBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L88nZgCR1r6uLXS3Ib42dSQmhzKJGpUgQdvop5ZD41WKuSZVtAAAqlEQwyG9SH/4Oahh8bD4wYWmWv0XO1jJsbLmcOCc6MMZ1wVHrPrAMJU38b4sK+OuKfk1dyEy7gLVHjMEf2HfewVyom9nOB5WriVnYy6lwSSwkPl2z/PlEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kttxp00X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A174BC4CEF8;
	Wed, 12 Nov 2025 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762935765;
	bh=WHWCVmYt6UtQ3D5Ri8XoM/WvWGHNmlnb2EcUM8qufBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kttxp00Xc7Q2NVR9zWtAQOW32+K5IUJtvvbjIacWFrREkJHKtXZvOqAE9Gua6PoGC
	 Z0PWHqSpMfxReJv7iL5UYQPsbL046fDjJOWbbV4bdQ4pdjMz2nIzAIHZhMw7bzayUP
	 y2Bv+7T/1TtBofUmqHq5O+CejsEDVgK3i6OQG2/ijVcXuHJBdoNk3MTvk2hn7OOdM5
	 4L32vutb2OpX5twJ0FaMH2B6Hocia+8TeMb5mZAZkTeNOGVOALNy25ugZsQxFkScZ+
	 F5ZGrNhFI8NY7qx2IFdGhctYLQpV0z7JBTaVUMm/cMNC1+rmxzdT6Bx+4s4v6urya+
	 S/b1vretnjh2g==
Date: Wed, 12 Nov 2025 09:22:36 +0100
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
Message-ID: <aRRDzKFVTFTIuvvh@ryzen>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111221621.2208606-2-helgaas@kernel.org>

On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>  
> +	dw_pcie_config_l1ss(pci);

The name dw_pcie_config_l1ss() sounds like we are enabling l1ss.

I know naming is hard.

Perhaps dw_pcie_disable_unsupported_l1ss() ?

Or something similar.


> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val &= ~REQ_NOT_ENTR_L1;
>  	writel(val, pcie->parf + PARF_PM_CTRL);
>  
> +	pci->l1ss_support = true;
> +
>  	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  	val |= EN;
>  	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);

While it seems like ops_2_7_0 is the only type that explicitly does a
register write to enable L1ss, other versions might have the register
as enabled by default, so it would be nice if Mani could confirm exactly
which versions that should set l1ss_support = true.


Kind regards,
Niklas


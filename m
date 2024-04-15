Return-Path: <linux-pci+bounces-6251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF088A5486
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295A81C21484
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8873199;
	Mon, 15 Apr 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8ux2kJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AB74E11;
	Mon, 15 Apr 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191701; cv=none; b=IgcwM0QZAnhu7RZztIcN68C3OQ7Sop3KPtltXZac7O6RDEPptnryUNxMfGGQIBT/fkoVpEl4xHiLpRhQ3I0PsP/4b4xWozO7bZ76j4k4GCXTcCXj78gclWHh7ADI1uQQmKqlZLUJKLPuiJuCe/Uvw58w1JJqS0OA93RPnmP4dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191701; c=relaxed/simple;
	bh=iY4lgc0Rhhg0QzocM/HxB+V+JgnIN6Pz/U6ay5f9MVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iKxPweiJQ8kakUSx/0SiSbZqBobPNu1fhIwXuQGnYq08ye8bFTMRhgwwWhGp18UllZqSap9GGKAJNW6yh5ABHAC4TZKYK+7i5TA2Kb84JVZl0bL1Q5YimBsMO6sGEMd1LEhl/FqwOWE3tGOioAIUYEIeQvw8C534YmTqUjfGXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8ux2kJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707A5C113CC;
	Mon, 15 Apr 2024 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191700;
	bh=iY4lgc0Rhhg0QzocM/HxB+V+JgnIN6Pz/U6ay5f9MVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h8ux2kJ9VPc31EUKRstPFxlBtLqgAikyAAiDVJYFMkbo8mtxrOyOOK3NcACc+y8Ud
	 iXpqVF0MEx6sJdy9lY0wvSVKeeW8uxfxRN67mmZIVLth3xLTpCnMe7hyPn5vAXAEap
	 YJVO2lf3xgNEtO0oSJyygdI7v9QUj7HOXxZHY9dCiUhkDO7nzPi891PYd/BxHxCsHv
	 UyVxwOClfOgHueSz5EuCeCSIoFui/BN6bMZkuezCEt2p/LTzprmU9aAAuHUtmtAdXW
	 zFxLHFLFtq8kkv6xT1YhX19MuFUhTUT9zOppzKw1mDSETuxGYDPKQceVsXviKNPbDv
	 gZmkSaNAV4YtQ==
Date: Mon, 15 Apr 2024 09:34:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v12 2/8] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <20240415143458.GA111010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415140015.GJ7537@thinkpad>

On Mon, Apr 15, 2024 at 07:30:15PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 12, 2024 at 02:58:36PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 27, 2024 at 02:43:31PM +0530, Manivannan Sadhasivam wrote:
> > > All of the APIs are missing the Kernel-doc comments. Hence, add them.
> > 
> > > + * dw_pcie_ep_reset_bar - Reset endpoint BAR
> > 
> > Apparently this resets @bar for every function of the device, so it's
> > not just a single BAR?
> 
> Right. It should've been 'Reset endpoint BARs'. And the API name is also
> misleading, but that is not the scope of this series.

Maybe just this for now:

s/Reset endpoint BAR/Reset @bar of every function/

> > > + * dw_pcie_ep_raise_intx_irq - Raise INTx IRQ to the host
> > > + * @ep: DWC EP device
> > > + * @func_no: Function number of the endpoint
> > > + *
> > > + * Return: 0 if success, errono otherwise.
> > 
> > s/errono/errno/ (another instance below)
> 
> ah, thanks for spotting. Since this series is already merged, I hope
> Krzysztof can ammend this.

Sounds good, thanks!

Bjorn


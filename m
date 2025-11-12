Return-Path: <linux-pci+bounces-41013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0EC53CA9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 18:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B818D344551
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94382346A0C;
	Wed, 12 Nov 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO6Mud0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE5272813;
	Wed, 12 Nov 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969893; cv=none; b=q2Ij10fwx59Fh9cb8WmMdOGVpPtCajhGwPaJURTO/u2IjQS3BLAJPYuDnloBTWkJ8k8FD5EfdUYpYASjSXjvsQS1SsQqz5VVl7+94WTVTf0Zf9akAYx0u/33AzUn5S7LFEg5TNazAaEfRKfUWUrOZQpL1YldNVYStokIaDACl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969893; c=relaxed/simple;
	bh=T7knzhZ/hAoWyK2lUxIZdB+Ka4TMwRh1ujkOMO4Lf04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsO2ogcwJdF2yGTKLlMdP9LyD8g+lRFZPBDTFvOhnH92dgAIc9/UejhCIkZZVkozmX3qX67R0GahrNvABcUNHSEouaet/PGgoUGGA8t3vI9d0LhZlPNaYvB4iRDzoWC2fo3tbcx19yt3cJk3YcI6RZUjI7ZeatbBnrB2YxN6jPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO6Mud0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D3DC4CEF8;
	Wed, 12 Nov 2025 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969893;
	bh=T7knzhZ/hAoWyK2lUxIZdB+Ka4TMwRh1ujkOMO4Lf04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rO6Mud0EMKXzwiNc2bQlzO+QiF4pc3XFFext9cJ/t5Wa69rSTMlzvwp4mvrpz5ern
	 1/w711HXbiu7bl1ydAB5DUdFcwgQ1lJWeN5IpVji2dEdgRtnIF2lrTd0he6MlSGbV+
	 Zu6LUatZFmxfv4DqArs0FAoWQnazXwpImSlLMqQBPAtLcvSFfO6Qh9Ae3bcMYyPItL
	 aHx51+xOY/Tg8XTyidCaat1h3AuReI9ji7hHyBaIaStsRhn2b+K5jgPh7En09xzheM
	 0NaPZ/ftBPYlEZu+UPAyMN6G+DftPSkldBOvdcp8DKUWQSRJl+tUyr3vPq+x1twkib
	 lhmGS0PYRvO5Q==
Date: Wed, 12 Nov 2025 23:21:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel@pengutronix.de, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
Message-ID: <22srj63j7fzmsebwxwjnnxnpmdn2iwxo36gkrl36gdm7ge2xif@dmrdbfgu3hn3>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-2-helgaas@kernel.org>
 <aRRDzKFVTFTIuvvh@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRRDzKFVTFTIuvvh@ryzen>

On Wed, Nov 12, 2025 at 09:22:36AM +0100, Niklas Cassel wrote:
> On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> >  
> > +	dw_pcie_config_l1ss(pci);
> 
> The name dw_pcie_config_l1ss() sounds like we are enabling l1ss.
> 
> I know naming is hard.
> 
> Perhaps dw_pcie_disable_unsupported_l1ss() ?
> 
> Or something similar.
> 
> 
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >  	val &= ~REQ_NOT_ENTR_L1;
> >  	writel(val, pcie->parf + PARF_PM_CTRL);
> >  
> > +	pci->l1ss_support = true;
> > +
> >  	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> >  	val |= EN;
> >  	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> 
> While it seems like ops_2_7_0 is the only type that explicitly does a
> register write to enable L1ss, other versions might have the register
> as enabled by default, so it would be nice if Mani could confirm exactly
> which versions that should set l1ss_support = true.
> 

Yes, on the rest of the platforms, this bit is supposed to be enabled by
default. AFAIK, all Qcom platforms should support L1SS, atleast the
non-IPQ/APQ ones.

We should set it for below cfgs:

cfg_fw_managed
cfg_sc8280xp
cfg_1_34_0
cfg_1_9_0
cfg_2_7_0

I excluded msm8996 due to one recent bug report.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


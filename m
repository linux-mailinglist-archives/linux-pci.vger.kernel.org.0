Return-Path: <linux-pci+bounces-41532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0570C6B9F6
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7F3C4F7017
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F53002A4;
	Tue, 18 Nov 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMrjatDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B82FBE0D;
	Tue, 18 Nov 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497333; cv=none; b=PU7MVTzxbhe7goc6hkDTMF0VIuxK0XAZ24W2dGnldVojMwVp8QVf+Eo+ehrpg5NUTzt9nNTsa4pxm3SnZsCNvFWihlrpUlnN/ACPUJDBdoJy+0Ir0J8iXKMxUbpCdEglz35U12fXMBf7Wdwy7W0vrn73OTWOqYWVA/73UiuAS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497333; c=relaxed/simple;
	bh=m/y5HsGDFoNmN0W5o2ZWtHNb/BQMArPMLKv4Hr2h3S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bgNDJNDkoEH5YtsRT4ubGiYqTQHv8BjSmd6QWoAVFCK5B6fnSkm2ybHzQq6z9BtgJgH/l8sFIuvGv4HRWfDwKFeFUVkjlAxW0gWxHFIiGtMeeDJ/EiSh5enjYLxTZjxoA+KtQp9Of0u57eGUMtWh1b9WbY/gMuv/aT46v5mzMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMrjatDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9819DC2BC86;
	Tue, 18 Nov 2025 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763497333;
	bh=m/y5HsGDFoNmN0W5o2ZWtHNb/BQMArPMLKv4Hr2h3S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CMrjatDwWqdM/v1dfj1rdQS5VbA8KTQeF2MCab2sKZ+pRRyFCtoXrwdXRWP/MXJWb
	 e2YL4Z9l8u4EMzOLcmz95mCYQJwYpOaExEL3/aF1iyxGNrbGwOdnq/v+TJ0wawd8Br
	 60iotRVM03mtDzt6h01lahKDWUrBddEOgZru4vSf6Zuc6o8glHkqkIWb2cRA8Q1qdA
	 WQtnOsFvOWYnZMMenGPUjUISmMbm4yMlBPp2M0frhiOpea+0EKQLY/5DnMxqPewZPp
	 6F4QjGFzap+UESXlGdEOIK1E69TzlX5xOcyFcsqbBwramyit9tpnxvgkZ9DJGJ/Umw
	 2vfGPd/xT6S/Q==
Date: Tue, 18 Nov 2025 14:22:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
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
Message-ID: <20251118202210.GA2586610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22srj63j7fzmsebwxwjnnxnpmdn2iwxo36gkrl36gdm7ge2xif@dmrdbfgu3hn3>

On Wed, Nov 12, 2025 at 11:21:07PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 12, 2025 at 09:22:36AM +0100, Niklas Cassel wrote:
> > On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> > >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> > >  
> > > +	dw_pcie_config_l1ss(pci);

> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > >  	val &= ~REQ_NOT_ENTR_L1;
> > >  	writel(val, pcie->parf + PARF_PM_CTRL);
> > >  
> > > +	pci->l1ss_support = true;
> > > +
> > >  	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > >  	val |= EN;
> > >  	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > 
> > While it seems like ops_2_7_0 is the only type that explicitly does a
> > register write to enable L1ss, other versions might have the register
> > as enabled by default, so it would be nice if Mani could confirm exactly
> > which versions that should set l1ss_support = true.
> > 
> 
> Yes, on the rest of the platforms, this bit is supposed to be enabled by
> default. AFAIK, all Qcom platforms should support L1SS, atleast the
> non-IPQ/APQ ones.
> 
> We should set it for below cfgs:
> 
> cfg_fw_managed
> cfg_sc8280xp
> cfg_1_34_0
> cfg_1_9_0
> cfg_2_7_0

Except for cfg_fw_managed, the above are all covered by
qcom_pcie_init_2_7_0(), either via ops_2_7_0, ops_1_9_0, or
ops_1_21_0.

cfg_fw_managed is harder because we don't use dw_pcie_host_init() or
dw_pcie_setup_rc().

We do allocate a struct dw_pcie (where l1ss_support is) in
qcom_pcie_ecam_host_init(), but only so we can call
dw_pcie_msi_host_init() and dw_pcie_msi_init().

Neither of those seems like a logical place to fiddle with L1SS
support.

Open to suggestions.

Bjorn


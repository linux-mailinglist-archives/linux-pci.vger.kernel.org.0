Return-Path: <linux-pci+bounces-9320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A239185C3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDF4B267DC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95318A932;
	Wed, 26 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvvJEJL1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA502B2DA;
	Wed, 26 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415634; cv=none; b=RL7Bzika7JZdXNBtsO7y/S2NfgLYIBLZMPZT9SB+YJ1pp77ivGEqpiUWnQvZbJHIWN6O65ThAuocpdb2ExlHnr1BWqK+kevJpop2pBs9pN7lDh9PmiIlYAyFtZkmPvXUA9h1R4cn957w5ZlDykT1L3BPKjj1nhEGA771fvzGiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415634; c=relaxed/simple;
	bh=JgOdhfKoNF4gZsjDSQJd3zN1wwMai50AgDm2boUHMwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vEbLtCeqmMJRu4/hvrkHtIj/BKEXpYJvqnYZuLe9lk1frE1qdLOBBBY7mENL0xEGwfuG/8iR64gOjGxaKiuHxb/TRsLviPpnVCiWwxSBnlk7HBkzlwU00u7SiXsXeg5x705dKO/a90A6niZUdvG8oEPAByfdUnu4efOrrwBi1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvvJEJL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302AFC116B1;
	Wed, 26 Jun 2024 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415634;
	bh=JgOdhfKoNF4gZsjDSQJd3zN1wwMai50AgDm2boUHMwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qvvJEJL1PQMATVQudld62ezk/sGU5VALsZQ88gMUJfXYwd78OJ1KSjcCXtUEb+4Ou
	 gUxtXGKUNqck1BU8kBQQjQegHi8oF00MTlLpH/wd6SXlgcWCiKJ/tY6tNB/6oW+FL4
	 5Ugi3/42ACTF7gJT/2EhxXqMBMONML9GsXtBv6MpRKEBjzixZgzW4h5bxUTVcswW/X
	 692fH9ZwsRfZ1MKnaxrPlWxJdHWUVf+qTXa0j2o0uP6N3Xob2iUykNJXm0lA8zd9ig
	 2ve/a9TAR+c7M2SQlo2ADfGPLbLU/H9BI82rUuvb9qw+Xb8m5gpUN+sCxXA2MupN0c
	 nfRNOBEcFrHoA==
Date: Wed, 26 Jun 2024 10:27:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH 5/7] PCI: brcmstb: add phy_controllable flag
Message-ID: <20240626152712.GA1467478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104544.14233-6-svarbanov@suse.de>

Match the capitalization of the subject line, s/add/Add/ as in
previous patch.

On Wed, Jun 26, 2024 at 01:45:42PM +0300, Stanimir Varbanov wrote:
> Not all PCIe can control the phy block, add a flag
> in config structure to take that fact into account.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4ca509502336..ff8e5e672ff0 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -224,6 +224,7 @@ enum pcie_type {
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
> +	bool phy_controllable;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -1301,11 +1302,17 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
>  
>  static inline int brcm_phy_start(struct brcm_pcie *pcie)
>  {
> +	if (!pcie->cfg->phy_controllable)
> +		return 0;
> +
>  	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
>  }
>  
>  static inline int brcm_phy_stop(struct brcm_pcie *pcie)
>  {
> +	if (!pcie->cfg->phy_controllable)
> +		return 0;
> +
>  	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
>  }
>  
> @@ -1498,6 +1505,7 @@ static const int pcie_offsets_bmips_7425[] = {
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.type		= GENERIC,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
> @@ -1505,6 +1513,7 @@ static const struct pcie_cfg_data generic_cfg = {
>  static const struct pcie_cfg_data bcm7425_cfg = {
>  	.offsets	= pcie_offsets_bmips_7425,
>  	.type		= BCM7425,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
> @@ -1512,6 +1521,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
>  static const struct pcie_cfg_data bcm7435_cfg = {
>  	.offsets	= pcie_offsets,
>  	.type		= BCM7435,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
> @@ -1519,6 +1529,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  static const struct pcie_cfg_data bcm4908_cfg = {
>  	.offsets	= pcie_offsets,
>  	.type		= BCM4908,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_4908,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
> @@ -1532,6 +1543,7 @@ static const int pcie_offset_bcm7278[] = {
>  static const struct pcie_cfg_data bcm7278_cfg = {
>  	.offsets	= pcie_offset_bcm7278,
>  	.type		= BCM7278,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  };
> @@ -1539,6 +1551,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
>  static const struct pcie_cfg_data bcm2711_cfg = {
>  	.offsets	= pcie_offsets,
>  	.type		= BCM2711,
> +	.phy_controllable = true,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  };
> -- 
> 2.43.0
> 


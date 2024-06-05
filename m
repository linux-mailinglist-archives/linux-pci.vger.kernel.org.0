Return-Path: <linux-pci+bounces-8347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBD8FD47B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8587B22EAB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BF194AF0;
	Wed,  5 Jun 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1Ov+Ecn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605913A86A;
	Wed,  5 Jun 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610240; cv=none; b=a3oXGP6P17ZLUW26LLCPrdilkBZb6G/USX5exBeBL9ms6PAt4mxT2dkWubvuaFYXaA0eL0hZ8pxqTunELnOqOfzbxCCIi7Gsd0SZQR2XzbiciB7Loj5vSx9LTDFeISjDkNB1lFEjpRuFU5jh6FbwvmxuI45PPFsRYcjhD06KBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610240; c=relaxed/simple;
	bh=l9ydBUNQUdSilVJMSLqSHbZR/daYiVRwI/DRlUqbFp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaFwKQa/3TW+ax/Fte8B3E2s2Rgp4GU8AhpvnQ2Yx1uRQDMgujbc1i+FOj/BYeR/jyxQf18XVCao+BN+w3TiayiivoEwhL3Ge1jTufI1vh29vmdIuse8Z5tY37aes3ax5iT6v9lbygqGFfHw+AIpiPyiplqUI0eWmL5K5cKMdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1Ov+Ecn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C4C2BD11;
	Wed,  5 Jun 2024 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610239;
	bh=l9ydBUNQUdSilVJMSLqSHbZR/daYiVRwI/DRlUqbFp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1Ov+EcnLmZiKnQl0kqPAWCsSSPvAC/CasiQvdUq8byYLhR+p0pXtL6qwOpHrI2ap
	 vPJrclOJH437tVsYfzFKYgVYHr6Ni6PkCIl3B3zHmjSYhcpqO5915qj37+QB9v2fMN
	 GNfX163xkJBn1X+E2vyQezZNE924RN/m9r03mBLq7dZDpC3246SNoheRH2EHaZTgLr
	 QkCSq6zKrCHeIzNtS2ygW+JX6yVS7NtW8S++/xvSbb0kOPWH02j1EgKrUnULa9IChL
	 8kbja6WMkMFGUOCJmBEaiHvcmXhOXO4O0nQQdJD8KAi9mogv43rYgXFHA01GT1Pykf
	 n/c1NXRpDXdUg==
Date: Wed, 5 Jun 2024 19:57:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 09/13] PCI: dw-rockchip: Refactor the driver to
 prepare for EP mode
Message-ID: <ZmCm-Lt3yZpE84EG@ryzen.lan>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-9-3dc00fe21a78@kernel.org>
 <20240605080640.GJ5085@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605080640.GJ5085@thinkpad>

On Wed, Jun 05, 2024 at 01:36:40PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 29, 2024 at 10:29:03AM +0200, Niklas Cassel wrote:
> > This refactors the driver to prepare for EP mode.
> > Add of-match data to the existing compatible, and explicitly define it as
> > DW_PCIE_RC_TYPE. This way, we will be able to add EP mode in a follow-up
> > commit in a much less intrusive way, which makes the follup-up commit much
> > easier to review.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Few nitpicks below. With those addressed,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > ---

(snip)

> > @@ -294,13 +292,35 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> >  	.start_link = rockchip_pcie_start_link,
> >  };
> >  
> > +static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
> > +{
> > +	struct dw_pcie_rp *pp;
> > +	u32 val;
> > +
> > +	/* LTSSM enable control mode */
> > +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> > +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> > +
> > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> > +				 PCIE_CLIENT_GENERAL_CONTROL);
> > +
> > +	pp = &rockchip->pci.pp;
> > +	pp->ops = &rockchip_pcie_host_ops;
> > +
> > +	return dw_pcie_host_init(pp);
> > +}
> > +
> >  static int rockchip_pcie_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct rockchip_pcie *rockchip;
> > -	struct dw_pcie_rp *pp;
> > +	const struct rockchip_pcie_of_data *data;
> >  	int ret;
> >  
> > +	data = of_device_get_match_data(dev);
> > +	if (!data)
> > +		return -EINVAL;
> 
> -ENODATA?

-EINVAL seems to be most common:
$ git grep -A 5 of_device_get_match_data drivers/pci/



Kind regards,
Niklas


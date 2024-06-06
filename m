Return-Path: <linux-pci+bounces-8380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591688FDEBA
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 08:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C601C244AD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C213A415;
	Thu,  6 Jun 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8OBtjMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EC13A3F3;
	Thu,  6 Jun 2024 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655255; cv=none; b=Zt1RyQnu+3jWKk5hCJ5GQvsyGBvoZyNmIHm5CtYlvXPY2rm63lr+cg/l7RoWO9IIl5qOlnvsJIqb1jNIhT8sBB4ln5Osrqg9Oh15o0rA1seWmk4GkUbhxQd2esrb/vtz9IJOwccOAUgCd+7+tGorG6Grf7DQMu8kgYmEV190uNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655255; c=relaxed/simple;
	bh=/keuf3dCVugAEdTMAjTPla8xo+au+QS7B3jnvFRay+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bako4M9mVTAiybkJ8DZNff5iJOLQyRFDWq16LhjyTBm15q2/i1yCH9YSGutl9d9PgV+/QgufU4nlIWs/Pgf/O9pXUakfb470D3R31fF1DOMlVSLhmDfh432hai+UlLyYND4lbmdO8Bh6zBI6ngfHhKVUPtZBg7SStyyOL24c8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8OBtjMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDB1C2BD10;
	Thu,  6 Jun 2024 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717655254;
	bh=/keuf3dCVugAEdTMAjTPla8xo+au+QS7B3jnvFRay+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8OBtjMZQ9zqWvnO92ecqm1YB3+k3fZnbc2UGOW3j2MonYFrXFMO72E1ksdpxVXqG
	 eI/zq5X4D+EvJU9/AOSG4hiqAKz5TMLf965wPG6sh1qstN1cY1ag3M98QjKfWebeCd
	 YfER2U+eKamuB6a+ZnlZ0U0mkgK9McKHZRh7iDm5+mOiPgx8EZRFrnXYaCfEAbrNQx
	 2q67Nql6oujxuRiCMBq04v0Z6bwqo5cjiGjsM10Ctl7WGUmA4reIiqfbGCt4zll6Ov
	 NCGkOVDSl0knhxIb6OETPPoRpGqWdxPcv6QzKE+qFm2H76n5xalChKl20LM28fWmZH
	 woNmAsitiX6eg==
Date: Thu, 6 Jun 2024 11:57:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
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
Message-ID: <20240606062718.GB4441@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-9-3dc00fe21a78@kernel.org>
 <20240605080640.GJ5085@thinkpad>
 <ZmCm-Lt3yZpE84EG@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmCm-Lt3yZpE84EG@ryzen.lan>

On Wed, Jun 05, 2024 at 07:57:12PM +0200, Niklas Cassel wrote:
> On Wed, Jun 05, 2024 at 01:36:40PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, May 29, 2024 at 10:29:03AM +0200, Niklas Cassel wrote:
> > > This refactors the driver to prepare for EP mode.
> > > Add of-match data to the existing compatible, and explicitly define it as
> > > DW_PCIE_RC_TYPE. This way, we will be able to add EP mode in a follow-up
> > > commit in a much less intrusive way, which makes the follup-up commit much
> > > easier to review.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > 
> > Few nitpicks below. With those addressed,
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > ---
> 
> (snip)
> 
> > > @@ -294,13 +292,35 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> > >  	.start_link = rockchip_pcie_start_link,
> > >  };
> > >  
> > > +static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
> > > +{
> > > +	struct dw_pcie_rp *pp;
> > > +	u32 val;
> > > +
> > > +	/* LTSSM enable control mode */
> > > +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> > > +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> > > +
> > > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> > > +				 PCIE_CLIENT_GENERAL_CONTROL);
> > > +
> > > +	pp = &rockchip->pci.pp;
> > > +	pp->ops = &rockchip_pcie_host_ops;
> > > +
> > > +	return dw_pcie_host_init(pp);
> > > +}
> > > +
> > >  static int rockchip_pcie_probe(struct platform_device *pdev)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > >  	struct rockchip_pcie *rockchip;
> > > -	struct dw_pcie_rp *pp;
> > > +	const struct rockchip_pcie_of_data *data;
> > >  	int ret;
> > >  
> > > +	data = of_device_get_match_data(dev);
> > > +	if (!data)
> > > +		return -EINVAL;
> > 
> > -ENODATA?
> 
> -EINVAL seems to be most common:
> $ git grep -A 5 of_device_get_match_data drivers/pci/
> 

Yeah, but we abused -EINVAL a lot ;) Nowadays, I prefer to use more apt error
codes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-12808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A152996CFA0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C1B1F24C45
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBF18BC2D;
	Thu,  5 Sep 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLAgHg4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE84400;
	Thu,  5 Sep 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518722; cv=none; b=GHHM7LMR6mm4VSoVMnI/WWCeFTXU6xxykgOrIsvE9HqTWbfNH/rJ06rhWbn0sVjutyEOkt7TgpnbYdW6JhG0+l1L7pmckgi4XElSN0pNl6+tSE0+COd26adGHDCUyEHGvnM44XxahQ6b5/qFw3/m5pMS8bi9Q4AooCN6NjpmsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518722; c=relaxed/simple;
	bh=pwkWnjC+Q1NqaXK6JlAyfabTkTo0JS4rxXogOThDdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnsuKXVpvjyKf7f2NtDKpTE6aIBdksCWFKtPC976S6z5TyHiDWagPzbs5unze0DN4IX6IXp04zVhz5oOec9jBObJI7FDuc42YPRUvuVK9MR0ZszpxoV9kBnJ83ZGoAV/v9W9zRezYQLu0AcCid44VuZ9rxOsAoVeQi0MUxl0a+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLAgHg4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B1EC4CEC4;
	Thu,  5 Sep 2024 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518721;
	bh=pwkWnjC+Q1NqaXK6JlAyfabTkTo0JS4rxXogOThDdac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLAgHg4raavHGx9ezW/P9yna3hyJgw6SY+qG+4eCnu+2qT3zUt0b0fPsaJX0WAkRr
	 b9cDKSCmOjvrTllVynwEXb3enBl+fSuzgT8hcBIruZ1ep0mGnWnVs4eifKMzJLsXgD
	 35jjwGbavg8yMkh4NuEm3LKrA4x/PiKW9Ths/TrPgN0knM+hXgOmtuzIsjGCLGx80j
	 z/MZF/3Spt7uR/u6V7jXGZQ69+qZxu9fqwCjKpnn8ybA6s1e5TAsV2Q3+PArjZM+Vb
	 AOHDiGufvBkKqM3fG7dHqhwMeJTdNSxlKnbaolpRKwMhvrtoM2mQb+ukgwSk+Zdewl
	 ds5+/dbcHItmw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sm6FO-000000001Hc-2EOT;
	Thu, 05 Sep 2024 08:45:38 +0200
Date: Thu, 5 Sep 2024 08:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 2/4] PCI: dwc: Always cache the maximum link speed
 value in dw_pcie::max_link_speed
Message-ID: <ZtlTkjIky3X2fBQc@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>
 <ZtgooHdex5gXh0tP@hovoldconsulting.com>
 <20240904154944.w4bujfmhy5uhzkld@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904154944.w4bujfmhy5uhzkld@thinkpad>

On Wed, Sep 04, 2024 at 09:19:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 04, 2024 at 11:30:08AM +0200, Johan Hovold wrote:
> > On Wed, Sep 04, 2024 at 12:41:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> > > +	/*
> > > +	 * Even if the platform doesn't want to limit the maximum link speed,
> > > +	 * just cache the hardware default value so that the vendor drivers can
> > > +	 * use it to do any link specific configuration.
> > > +	 */
> > > +	if (pci->max_link_speed < 0) {
> > 
> > This should be 
> > 
> > 	if (pci->max_link_speed < 1) {
> > 
> 
> Well I was trying to catch the error value here because if neither driver nor
> platform limits the max link speed, this would have -EINVAL (returned by
> of_pci_get_max_link_speed()).

Indeed, I thought I'd traced it do be zero here, but I must have made a
mistake. The old code did check for 0 before calling this function,
though (e.g. in case max_link_speed was never initialised as intended).

> But logically it makes sense to use 'pci->max_link_speed < 1' since anything
> below value 1 is an invalid value.
> 
> Will change it.

Sounds good.

> > > @@ -1058,8 +1069,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > >  {
> > >  	u32 val;
> > >  
> > > -	if (pci->max_link_speed > 0)
> > > -		dw_pcie_link_set_max_speed(pci, pci->max_link_speed);
> > > +	dw_pcie_link_set_max_speed(pci);

Johan


Return-Path: <linux-pci+bounces-9816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB8927ACF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090351F22321
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8A1B3720;
	Thu,  4 Jul 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uctUXtst"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E11B29CD;
	Thu,  4 Jul 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109064; cv=none; b=dtotdWw6xNKVeLbu9nkBsgl+d+Ed+1vwQeHAagnj/e11FE65YnwU6qlhWO9BGGh57KKu/4TV+ENUh768lDIG/SqPxv9e66cSOD/382TzdLqDlrU56elUvJWfSxf3PVKVoS21PCxC75KusaT0wmia6/RCBJfaLdayoKyefWf4LC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109064; c=relaxed/simple;
	bh=1+toRJY35/129MSR44qFWaryqVoiascuVBFB3NmaZ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvy2tcntNmsqvvyfx7GRr4698K+UJKCPlS582UAIpLc0LbyuwfhuvStqlafx/vfeO2vBDPvFSJpXbYjJKO0E8g7YPCjOsPQRamI2/vrn/+eLnpWPL2KDaxbDaOIOwKwvCJwFuYZm/Oj01MidtxcDaio519FI6guNC5V/3e7Swkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uctUXtst; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NUvYT0Apw8SqjInlbdvt2ov0pZsd3AGE3tETszdRDzg=; b=uctUXtstqOdYStp1RAdEevee8A
	og2m1rbeRGyNCyWKUOMtyM5AqIVxQFyxOPDwVFm9FnkbszNQ36vazTBa9yXYKCDMQBhsJURhhsCMA
	j1mTGX2YuuLQQvVFM9F5PJp4GaLgK5ASkZXssZl/rnBc5yDOus60fNPX7zh7xaHLB3Ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sPOvS-001pKc-Qp; Thu, 04 Jul 2024 18:03:14 +0200
Date: Thu, 4 Jul 2024 18:03:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, djakov@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jassisinghbrar@gmail.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	manivannan.sadhasivam@linaro.org, will@kernel.org, joro@8bytes.org,
	conor@kernel.org, tglx@linutronix.de, amitk@kernel.org,
	thara.gopinath@gmail.com, linus.walleij@linaro.org,
	wim@linux-watchdog.org, linux@roeck-us.net, rafael@kernel.org,
	viresh.kumar@linaro.org, vkoul@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	robimarko@gmail.com, bartosz.golaszewski@linaro.org,
	kishon@kernel.org, quic_wcheng@quicinc.com, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, agross@kernel.org,
	gregkh@linuxfoundation.org, quic_tdas@quicinc.com,
	robin.murphy@arm.com, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, quic_rjendra@quicinc.com,
	ulf.hansson@linaro.org, quic_sibis@quicinc.com,
	otto.pflueger@abscue.de, luca@z3ntu.xyz, neil.armstrong@linaro.org,
	abel.vesa@linaro.org, bhupesh.sharma@linaro.org,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
	joabreu@synopsys.com, netdev@vger.kernel.org, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@pengutronix.de, dmitry.baryshkov@linaro.org,
	quic_cang@quicinc.com, danila@jiaxyga.com,
	quic_nitirawa@quicinc.com, mantas@8devices.com, athierry@redhat.com,
	quic_kbajaj@quicinc.com, quic_bjorande@quicinc.com,
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com,
	quic_tsoni@quicinc.com, quic_rgottimu@quicinc.com,
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
	quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	kernel@quicinc.com
Subject: Re: [PATCH 29/47] dt-bindings: net: qcom,ethqos: add description for
 qcs9100
Message-ID: <add1bdda-2321-4c47-91ef-299f99385bc8@lunn.ch>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-30-quic_tengfan@quicinc.com>
 <u5ekupjqvgoehkl76pv7ljyqqzbnnyh6ci2dilfxfkcdvdy3dp@ehdujhkul7ow>
 <f4162b7f-d957-4dd6-90a0-f65c1cbc213a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4162b7f-d957-4dd6-90a0-f65c1cbc213a@quicinc.com>

On Thu, Jul 04, 2024 at 09:13:59AM +0800, Tengfei Fan wrote:
> 
> 
> On 7/3/2024 11:09 PM, Andrew Halaney wrote:
> > On Wed, Jul 03, 2024 at 10:58:32AM GMT, Tengfei Fan wrote:
> > > Add the compatible for the MAC controller on qcs9100 platforms. This MAC
> > > works with a single interrupt so add minItems to the interrupts property.
> > > The fourth clock's name is different here so change it. Enable relevant
> > > PHY properties. Add the relevant compatibles to the binding document for
> > > snps,dwmac as well.
> > 
> > This description doesn't match what was done in this patch, its what
> > Bart did when he made changes to add the sa8775 changes. Please consider
> > using a blurb indicating that this is the same SoC as sa8775p, just with
> > different firmware strategies or something along those lines?
> 
> I will update this commit message as you suggested.

Hi Andrew, Tengfei

Please trim emails when replying to just the needed context.

Thanks
	Andrew


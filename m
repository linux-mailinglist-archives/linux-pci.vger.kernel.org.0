Return-Path: <linux-pci+bounces-12809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D396CFC3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043971F236AB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680E192582;
	Thu,  5 Sep 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6FStA63"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA5191F6B;
	Thu,  5 Sep 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519018; cv=none; b=IIt3AgizOiVTre4APkPgdG8yfBjqA9ob5rJLnad/ZGzoAnM2PIc0jqBzLtd9h9sgE891Ej5d7u8jRamHuBxtW9f4f/kxBknGVptiP7VzT8PaLsyA5K3lm2ae0yM38kEwrFn/kUNXBQBHnyHPCiTyKNKp8j/paykfxnR/0L74h8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519018; c=relaxed/simple;
	bh=EGQxqnD+kJTdbSpDiqWezPqJO4plr2uZvSabvaxYSOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvR4HGZHYFkwswyDUi9kTLNuvsbmGtIKdvQwIItzWjTQt+l1isMGj+lZHx1xHc84yXQ3yTloYtr8mHs70KPH8M82LbwNRX8vIlPJkrizdZiUdkBJhenuey/CnRrF7N/HkD/Q6b64O03TIMljTCgMVCzqgcNSGvQJSECS6Y4psos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6FStA63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AEFC4CEC4;
	Thu,  5 Sep 2024 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725519017;
	bh=EGQxqnD+kJTdbSpDiqWezPqJO4plr2uZvSabvaxYSOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6FStA63hzOsr16OqGVMLzQIX3CqKwHZn87UzgA0l/RYmuNvEpHhxiqKpgFUe0ENW
	 d9JFokRO/q/UJpjckbVXfaEunkJuqL1G8wHwwXX5o7Yi5tsm6FlxPdLdLzRgFrzn3l
	 VtCGqy240WtYMHxbaaeU4jpGW88PJHFWUGVkLU6xehFdB7T66Drr+1ZVA8BTKVfRK2
	 F6s1VdEUtOOsHL4HfrC+BNsj76QBcx8uP7K2zXT7Bu7r2bNFgi+qSDy88VZez+bwf5
	 yjh7FySKpXZfngB8qWKH9hljPIkVigcd7AUvNb0TB0vIPYH1deXhbsJm3lrOoRups9
	 TlsDQIRHRrmqw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sm6KB-000000001Md-17n0;
	Thu, 05 Sep 2024 08:50:35 +0200
Date: Thu, 5 Sep 2024 08:50:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
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
	abel.vesa@linaro.org, johan+linaro@kernel.org
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <ZtlUu3uwl06E7LJF@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
 <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
 <20240904155233.zm3m6x3wvco35g6t@thinkpad>
 <941d1bfb-965e-43e4-9f34-edaf2de5d661@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941d1bfb-965e-43e4-9f34-edaf2de5d661@quicinc.com>

On Wed, Sep 04, 2024 at 01:46:09PM -0700, Shashank Babu Chinta Venkata wrote:
> On 9/4/24 08:52, Manivannan Sadhasivam wrote:
> > On Wed, Sep 04, 2024 at 11:39:09AM +0200, Johan Hovold wrote:
> >> On Wed, Sep 04, 2024 at 12:41:59PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> >>> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

> >>> +	/*
> >>> +	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> >>> +	 * settings at various data transmission rates through registers namely
> >>> +	 * GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF determines
> >>> +	 * data rate for which this equalization settings are applied.

> >>> +	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);
> >>
> >> How does 0x1 map to gen4/16 GT?

> GEN3_RELATED_OFF has been repurposed to use with multiple data rates.
> RATE_SHADOW_SEL_MASK on GEN3_RELATED_OFF value decides the data rate
> of shadow registers namely GEN3_EQ_* registers. Per documentation 0x0
> maps to 8 GT/s, 0x1 maps to 16 GT/s and 0x2 maps to 32 GT/s. 

Thanks for clarifying. Perhaps these should become defines eventually
(or the comment could be extended). There are a lot of "magic" constants
in here.

Johan


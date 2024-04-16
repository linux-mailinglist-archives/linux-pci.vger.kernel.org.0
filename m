Return-Path: <linux-pci+bounces-6312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD328A69EB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A6B20D8F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94232129A8D;
	Tue, 16 Apr 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2GhDjJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075B128361
	for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268172; cv=none; b=Bn5aAxpmz24xCpp0YahUgKhjFsdvdOsINJE+XWtBWwMpAwzIJcjx5J7/kyen3kKtqMwzlyIzri9n6Hy9aW7dHBbV1hc3n0eTGOCmM74pXQFxGFQ4znlzcancQiz/TmtWOsjzRoHBPN/VIW6gCFpmu85vTGBKzFpHCko1PlGXHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268172; c=relaxed/simple;
	bh=tqExM0tvwgYYvzfoeJzUHezqGwF85pfqg2BcHGHTOAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAbbjodceyBw/Fm2NxptPQpiphQlUJtjvmzCeF8gDYcnYFW0bXWtTMXgfwndhFmQbfzKCZzt1Fnd04o48/PgoWbckv8jG8OHBpyMN7437naVROVYZkfDs+vWCStW+VnZX2f3hC4OjUf6lMKTzvGQPY46cdptvpRqds6nv9WxGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2GhDjJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0410DC113CE;
	Tue, 16 Apr 2024 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713268172;
	bh=tqExM0tvwgYYvzfoeJzUHezqGwF85pfqg2BcHGHTOAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2GhDjJLW2WKUr/G74uTDMsCOlAFq0GOIyYwsDvCLJ45tDkSPjLE4pYjl8NPTVc0K
	 rMH05AdS1+1r2r0j0n7AerWzyotq6HJRQqCinxKQeIkEnZJkiTqjLJOEPDrXGIbxVH
	 ehuNKSjGJ7ndXpnTjrC83R59ahZbnO2EHyJ+dj3oUb3jAPNMIMWcL53f4lSOSH9AO0
	 +inXRo2ZXX5R8ouaA1/Ki/ZE8ObSjcnEzm725uN7eu3GxzH2wfPliyWa1o7X3buNuN
	 h3O67lF4nVpB8RM4D73X/jOjY1YPuTMC1GW5njV095NPChqxu1o/pgCA00pMX7AyTT
	 oh3pWpMVNwqZQ==
Date: Tue, 16 Apr 2024 13:49:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix GPIO initialization flag
Message-ID: <Zh5lx9r1H6MO3kEs@ryzen>
References: <20240327152531.814392-1-cassel@kernel.org>
 <20240416112807.GC2454@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416112807.GC2454@thinkpad>

On Tue, Apr 16, 2024 at 04:58:07PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 27, 2024 at 04:25:31PM +0100, Niklas Cassel wrote:
> > PERST is active low according to the PCIe specification.
> > 
> > However, the existing pcie-dw-rockchip.c driver does:
> > gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> > When asserting + deasserting PERST.
> > 
> > This is of course wrong, but because all the device trees for this
> > compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> > $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> > $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> > 
> > The actual toggling of PERST is correct.
> > (And we cannot change it anyway, since that would break device tree
> > compatibility.)
> > 
> > However, this driver does request the GPIO to be initialized as
> > GPIOD_OUT_HIGH, which does cause a silly sequence where PERST gets
> > toggled back and forth for no good reason.
> > 
> > Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> > (which for this driver means PERST asserted).
> > 
> > This will avoid an unnecessary signal change where PERST gets deasserted
> > (by devm_gpiod_get_optional()) and then gets asserted
> > (by rockchip_pcie_start_link()) just a few instructions later.
> > 
> > Before patch, debug prints on EP side, when booting RC:
> > [  845.606810] pci: PERST asserted by host!
> > [  852.483985] pci: PERST de-asserted by host!
> > [  852.503041] pci: PERST asserted by host!
> > [  852.610318] pci: PERST de-asserted by host!
> > 
> > After patch, debug prints on EP side, when booting RC:
> > [  125.107921] pci: PERST asserted by host!
> > [  132.111429] pci: PERST de-asserted by host!
> > 
> > Without this change, there is no guarantee that PERST will be asserted
> > while the core is performing a fundamental reset.

> There is no 'core' here, are you referring to the device?

If you at pcie-qcom.c, it does:
1) PERST# assert
2) core reset (using reset_control_assert() in ops->init())
3) PERST# deassert

So the EP is held in reset while the RC resets.

Right now, for dw-rockchip driver, there is no guarantee that
EP is held in reset when the core on RC side resets, which seems bad.


> 
> > (E.g. if the bootloader would leave PERST deasserted.)
> > 
> 
> I don't follow this last sentence. But even without that, the commit message
> itself is descriptive enough.

When I flash u-boot on my board, and boot using TFTP,
I can see that when u-boot jumps to Linux, PERST# is not asserted
and will not be asserted when PCIe RC driver loads.

So the scenario mentioned above can happen.

(If I don't boot using TFTP, PERST# is deasserted when PCIe RC driver loads.)

Anyway, I will remove or clarify this sentence.


> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> This is a legitimate bug fix. So you should add the fixes tag and CC stable to
> get it backported.

Ok, will do in V2.


> 
> But the patch itself looks fine to me.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you.


Kind regards,
Niklas


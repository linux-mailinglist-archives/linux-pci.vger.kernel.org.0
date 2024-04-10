Return-Path: <linux-pci+bounces-6084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A615F8A01BC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C79228470D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AA1836D8;
	Wed, 10 Apr 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq7zG0h5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D15AAD6;
	Wed, 10 Apr 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783407; cv=none; b=gAgOmrBUaMDifRh1wcZiA9f1ToqWr9kOIfxP/CC/aAsHbgMFvF23JFclFYle+wlG93nBcv3+bXWf+D2M02RJiAjFBzNdwoJbdmh8E1ZYcDKpG6RrKyFiR74jO6rJjN62KticPnMWZ8tMJSToWskt+0g7Ue6R4lg4ApPtGA7y/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783407; c=relaxed/simple;
	bh=epqxiRJJT06ouxXsQ6dNk3Sxe1Z+04pN0RBFaN6a68g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1vV/cKp86XsE+TJGaMGhCAhQEcaj59JFa4Xp33aNtWmwrT0D0zsvVuq9e/vU9ZKE0YutSYyoyCyf1E+uCY4kaMxM2CDVXZnfcxckqDtGgb1NJDPQx/7htFFX9l7UO8ynEQPxnHJxZgXcKOZzCtFxbhKjz/BQtICUcVY4YCTNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq7zG0h5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26899C433F1;
	Wed, 10 Apr 2024 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712783407;
	bh=epqxiRJJT06ouxXsQ6dNk3Sxe1Z+04pN0RBFaN6a68g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq7zG0h5SrekrSqAIw+NC6D2j3BaZVhgpOgUGupokoJKCz/HQPs1FjTM9YwwSddb5
	 3Lf/9jM6lYOXCaDYAEJKz6nOJaRNxrLdgjXk4KLULbnOkSbYPPAgmFjuc/+ubF3/Wt
	 2tkB62Sfl43fSMYh1TsFufYeJE8pF8RFLEfCInX/FkEzajdkwrXY/4ocd9fdIynrbk
	 ERYPKG7lYMb402h1QoFDUrswFeo3Z1NZ+1Vx4Nef3xRjot+Id3mXxPe/IS4xOwTQvg
	 typpy3hFMCPinD6ZUiNAkUkjkqyk6LRQhGLDHnoIEUoX0Hlql4VWpK6cDJz0FMfBeo
	 xkVxny7zNWdeQ==
Date: Wed, 10 Apr 2024 23:10:01 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Message-ID: <ZhcAKSJCQag6AX09@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
 <ZgvpnqdjQ39JMRiV@ryzen>
 <20240403133217.GK25309@thinkpad>
 <Zg22Dhi2c7U5oqoz@ryzen>
 <20240410105410.GC2903@thinkpad>
 <Zhanol2xi_E2Ypv3@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhanol2xi_E2Ypv3@ryzen>

On Wed, Apr 10, 2024 at 04:52:18PM +0200, Niklas Cassel wrote:
> On Wed, Apr 10, 2024 at 04:24:10PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Well, we could prevent the register access during PERST# assert time in the
> > endpoint, but my worry is that we will end up with 2 version of the cleanup
> > APIs. Lets take an example of dw_pcie_edma_remove() API which gets called
> > during deinit and it touches some eDMA registers.
> > 
> > So should we introduce another API which just clears the sw data structure and
> > not touching the registers? And this may be needed for other generic APIs as
> > well.
> 
> I agree that it will be hard to come up with an elegant solution to this
> problem.
> 
> These endpoint controllers that cannot do register accesses to their own
> controllers' DBI/register space without the RC providing a refclock are
> really becoming a pain... and the design and complexity of the PCI endpoint
> APIs is what suffers as a result.
> 
> PERST could be asserted at any time.
> So for your system to not crash/hang by accessing registers in the controller,
> an EPF driver must be designed with great care to never do any register access
> when it is not safe...
> 
> Perhaps the the EPF core should set the state (i.e. init_complete = false,
> even before calling the deinit callback in EPF driver, and perhaps even add
> safe-guards against init_complete in some APIs, so that e.g. a set_bar() call
> cannot trigger a crash because PERST# is asserted.. but even then, it could
> still be asserted in the middle of set_bar()'s execution.)
> 
> 
> Looking at the databook, it looks like core_clk is derived from pipe_clk
> output of the PHY. The PHY will either use external clock or internal clock.
> 
> 4.6.2 DBI Protocol Transactions
> it looks like core_clk must be active to read/write the DBI.
> 
> I really wish those controllers could e.g. change the clock temporarily
> using a mux, so that it could still perform DBI read/writes when there is
> not external refclk... Something like pm_sel_aux_clk selecting to use the
> aux clk instead of core_clk when in low power states.
> But I don't know the hardware well enough to know if that is possible for
> the DBI, so that might just be wishful thinking...


Looking at the rock5b SBC (rockchip rk3588), the PHY refclk can either
be taken from
-a PLL internally from the SoC.
or
-an external clock on the SBC.

There does not seem to be an option to get the refclk as an input from
the PCIe slot. (The refclk can only be output to the PCIe slot.)

So when running two rock5b SBC, you cannot use a common clock for the RC
and the EP side, you have to use a separate reference clock scheme,
either SRNS or SRIS.

Since I assume that you use two qcom platforms of the same model
(I remember that you wrote that you usually test with
qcom,sdx55-pcie-ep somewhere.)
Surely this board must be able to supply a reference clock?
(How else does it send this clock to the EP side?)

So... why can't you run in SRNS or SRIS mode, where the EP provides
it's own clock?


Kind regards,
Niklas


Return-Path: <linux-pci+bounces-7888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392198D150B
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6823F1C21F27
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC45745E1;
	Tue, 28 May 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxlBBuSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F774405;
	Tue, 28 May 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880326; cv=none; b=RVJYax3PNnOFOa45b9W0zalVi/K74DgWw6mbyzIwzWjXGSpJ7rp6s9z5T7aUfOt6SB9FeP1O9bBBlvgEV8AAiXNGIussLTrmtDCVbwXrzHUdHIf2JLDs+1uVKpcdWUmY8H8J3J6OXWRS5OGgS2VxHQ4+NwBIqvPywO9Qy65Vh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880326; c=relaxed/simple;
	bh=uPygDd1nw48qnwBlYqSuCwek4hR2YJO99HQXE1Joqb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvMIECC5xfGV2FR7P/grvxWy4ePiegN4xydpSiEUMJ+J+GJfzJeas6L06v1ywFv15fMKY7d6ZaK6nMzQWl1GjaTmLjcj/4iAdv4FfBKyYSwIVu6D4NjI4Xz0lgtTWgUoQ8kjqav/ieSpZKGTTNul+wsY4Y9cve2kFnlOtskUC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxlBBuSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07D1C32781;
	Tue, 28 May 2024 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716880325;
	bh=uPygDd1nw48qnwBlYqSuCwek4hR2YJO99HQXE1Joqb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxlBBuSWSpPbjEBARf5U2GZZdCeakTErnnH3AwNmxvC8NQSV49uQvBJ44f64w6ucz
	 MsQ5QwgCirCWTgB6UKoO+roGKzZ0aGWK4alVGwzxA4PwWFk2mQrd4NhAPa4MnTfbDM
	 rvr8gNw7W8S/hqtoBUKX2kGbSEYiUSkv8ylzMCSeTQNsZddgGv0vDnM7aHWY43SYNy
	 OHmnRt5EGs28D8/HRTr8puCkf6wB/vBN2Uf/W3yuE5ni/eWhBeHef+oFjJHmTOqIyG
	 oWjQoGh2/fLZkWgCjLdQHedhE7HSgT0s6vc2qRP0tnYwtrm71a2bI2U8RwLM+pN+8s
	 GbkgirE9EUP4w==
Date: Tue, 28 May 2024 09:11:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: tegra194: Add check for host and endpoint modes
Message-ID: <ZlWDv6k1AwUbAKmr@ryzen.lan>
References: <20240513154900.127612-1-manivannan.sadhasivam@linaro.org>
 <Zky0XkvmOoFCxnDx@x1-carbon.wireless.wdc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zky0XkvmOoFCxnDx@x1-carbon.wireless.wdc>

On Tue, May 21, 2024 at 04:49:02PM +0200, Niklas Cassel wrote:
> On Mon, May 13, 2024 at 05:49:00PM +0200, Manivannan Sadhasivam wrote:
> > Tegra194 driver supports both the host and endpoint mode, but there are no
> > checks to validate whether the corresponding mode is enabled in kernel
> > config or not. So if the driver tries to function without enabling the
> > required mode (CONFIG_PCIE_TEGRA194_HOST/CONFIG_PCIE_TEGRA194_EP), then it
> > will result in driver malfunction.
> > 
> > So let's add the checks in probe() before doing the mode specific config
> > and fail probe() if the corresponding mode is not enabled.
> > 
> > But this also requires adding one redundant check in
> > pex_ep_event_pex_rst_assert() for pci_epc_deinit_notify(). Because the
> > function is called outside of probe() and the compiler fails to spot the
> > dependency in probe() and still complains about the undefined reference to
> > pci_epc_deinit_notify().
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202405130815.BwBrIepL-lkp@intel.com
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index d2223821e122..e02a9bca70ef 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1715,7 +1715,16 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
> >  	if (ret)
> >  		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
> >  
> > -	pci_epc_deinit_notify(pcie->pci.ep.epc);
> > +	/*
> > +	 * We do not really need the below guard as the driver won't probe
> > +	 * successfully if it tries to probe in EP mode and
> > +	 * CONFIG_PCIE_TEGRA194_EP is not enabled. But since this function is
> > +	 * being called outside of probe(), compiler fails to spot the
> > +	 * dependency in probe() and hence this redundant check.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PCIE_TEGRA194_EP))
> > +		pci_epc_deinit_notify(pcie->pci.ep.epc);
> > +
> 
> This big comment is a bit ugly. It would be nice if it could be avoided.
> 
> (pci-epc.h does not provide any dummy implementations for any of the
> functions, so I suggest that we leave it like that.)
> 
> However, if we look at dw_pcie_ep_init_notify(), it is called from
> pex_ep_event_pex_rst_deassert(), and we do not get a build warning for that.
> 
> The reason is that dw_pcie_ep_init_notify() has a dummy implementation
> in pcie-designware.h.
> 
> May I suggest that we add a dw_pcie_ep_deinit_notify() wrapper around
> pci_epc_deinit_notify(), while also providing a dummy implementation
> in pcie-designware.h ?
> 
> That way, the code in pcie-tegra194.c (and pcie-qcom-ep.c) would be
> more symmetrical, calling dw_pcie_ep_init_notify() for init notification,
> and dw_pcie_ep_deinit_notify() for deinit notification.
> 
> (Instead of dw_pcie_ep_init_notify() + pci_epc_deinit_notify())

Ping.


The branch:
pci/endpoint

Which has commit:
commit f94f2844f28c968364af8543414fbea9c8b3005d
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Tue Apr 30 11:43:48 2024 +0530

    PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers

still fails to link using certain arm64-randconfigs.

See:
https://lore.kernel.org/linux-pci/202405270544.yKgcokbA-lkp@intel.com/T/#u

The patch in $subject was meant to fix that, but it hasn't been merged yet.

Considering that the pci/endpoint branch is currently broken, I think it
should be high priority to get a patch in to fix this.
(Otherwise the patches in pci/endpoint might get 'deferred' yet another
release cycle.)

Any thoughts on my review comments on this patch?


Kind regards,
Niklas


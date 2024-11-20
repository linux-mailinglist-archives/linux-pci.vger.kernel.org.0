Return-Path: <linux-pci+bounces-17127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1E9D43DE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 23:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BB91F22877
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D74154BE0;
	Wed, 20 Nov 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9DFv+Fa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC072F2A;
	Wed, 20 Nov 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141093; cv=none; b=eqNEatNLDo3YPwXJMiGqTnd6b5Nvikaf4l1DPHyTZ9C1NBFxkop2b3kTLhE+LfoiAVIfFArfLCi4l/rxg4C3QivZ0Ovdf6G31Z8JDZ/fq/Djg/9PX/te3NpinqpJCl+tsOVFTSxrtoS9nDkGGkTJLw+OAZVvMDJ4OzoCrU3svJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141093; c=relaxed/simple;
	bh=zNtJfwiVcVkYBUM9zLvpDyW7OUPFJRLMjLBG4HwmZT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fqUwCi3HJ46Jektv2WcYGunnYUUIciVnfYW4S9djPnQIKpd/SiGTtPsRZle6FMG0X2ZLnrkxHAEOBN477iE2x33pqEoEtePEASrEYghjYG+T70hPPhHHk8ODf27vd4fY+xRrKf10WF9sxDvsvXNfTmffFphT0LF5ue5D76HzVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9DFv+Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD2AC4CECD;
	Wed, 20 Nov 2024 22:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732141092;
	bh=zNtJfwiVcVkYBUM9zLvpDyW7OUPFJRLMjLBG4HwmZT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T9DFv+FaiKrMY+etPtl1qx/mzXnRufGOZZsTkuqtt8SgUclwT9043SxCVIHlBuQOt
	 +V539SB4BQGoCuNKuZdEtQeY+p48ZmrxfqbdFGi7DNp2ysuuIDmtUrwFPlfyZDRNRC
	 XbtXvVmrQINNvmy+LpNzafByDfNYeIYU8GY2i4RbmJvE+qsN5ii8Mn3DCxaEuEufQD
	 wgG+0F0h0BOQO//+HJ8eNkVKTUOQqcmfIutOcicbZNkFxcgvuGodz1zOloOmizVK1u
	 iad4b+XX4DGvtflRbJz/x9/istukut2EIGbm5N6otLKkda+VwWrc3VB/B6AKKD6sAi
	 egQkh808e4A2Q==
Date: Wed, 20 Nov 2024 16:18:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bartosz.golaszewski@linaro.org,
	Jonathan Currier <dullfire@yahoo.com>
Subject: Re: [PATCH] PCI/pwrctrl: Create device link only if both platform
 device and supplies are present
Message-ID: <20241120221810.GA2357837@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120062459.6371-1-manivannan.sadhasivam@linaro.org>

On Wed, Nov 20, 2024 at 11:54:59AM +0530, Manivannan Sadhasivam wrote:
> Checking only for platform device for the PCI devices and creating the
> devlink causes regression on SPARCv9 systems as they seem to have platform
> device populated elsewhere.
> 
> So add a check for supplies in DT to make sure that the devlink is only
> created for devices that require pwrctrl support.
> 
> Reported-by: Jonathan Currier <dullfire@yahoo.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219513
> Fixes: 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks, squashed into 03cfe0e05650 for v6.13:

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=cc70852b0962

> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 7a061cc860d5..e70f4c089cd4 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -394,7 +394,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 * PCI client drivers.
>  	 */
>  	pdev = of_find_device_by_node(dn);
> -	if (pdev) {
> +	if (pdev && of_pci_is_supply_present(dn)) {
>  		if (!device_link_add(&dev->dev, &pdev->dev,
>  				     DL_FLAG_AUTOREMOVE_CONSUMER))
>  			pci_err(dev, "failed to add device link between %s and %s\n",
> -- 
> 2.25.1
> 


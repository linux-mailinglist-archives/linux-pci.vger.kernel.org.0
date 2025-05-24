Return-Path: <linux-pci+bounces-28377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF54AC3164
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1DF189B6EB
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E51DE4E1;
	Sat, 24 May 2025 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuRE6cL7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE610FD;
	Sat, 24 May 2025 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748120066; cv=none; b=kvzukR3zb1YaVAKyz+72MKAzk3Nd/ORK84mUKiJF1nZ7HEmOZC5+nBbp3orST/tLFvU2QElIU4dkSQ4hrRQ10K4A6maUkyHZsWTmpDUcwO8KRrASYccyYLUAjMjMAWYp8O7u4jE4+u7cUWthJDJCrSJ9r8MsKNPrEvs/IEQW0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748120066; c=relaxed/simple;
	bh=vAMyCB5LtrJUl5vCLXNGrnc0C903N0xaljWpzC2GIG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isnSm8vB9Xv2EaQCffoarwKHUNKGB1hckr5izW31R9vqfzEyPBJ2nOPu75olzd9O3yhx28aUzyiL4J8UEZFj0AGJQzHqs2F8cX2FRzBQQQmEdIZM6XzQfzvlfU3SunNWCszn5Vt2nR0ndj3dg0Ojc4ed7hOBEQUZjsSo+aaRL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuRE6cL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32340C4CEE4;
	Sat, 24 May 2025 20:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748120066;
	bh=vAMyCB5LtrJUl5vCLXNGrnc0C903N0xaljWpzC2GIG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuRE6cL7cAJq9F1AqONN0LgF9ggsl3Qr9I2O2YSb2GBRXHmurT1rbr7artx7BdK+2
	 nrUCyp976U6c89LXxPTaw4icQ6+Se1ELBukHZgXjMIOHWRrgaQVue9nS1X90iZvegt
	 GmxteX/2AOty83QpLujVKuwLwW4/xS11SFfVJfnULD99tg9WoIX7Vw728ZDd7rLCJd
	 ua7AfW1AK+9sLSHIJ0tRLewm9gCbBTxTJwBeaAAy8yh8jY0AE7wFA1m7BMZM5BiH2o
	 xCUyIkM20K0hsshaJ4t0zGVB4ooeyLgxk5NJHJ7XHWQaZgFN3asTVSf+06aaERG223
	 tYaMGKCCgInFA==
Date: Sat, 24 May 2025 22:54:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, wilfred.mallawa@wdc.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Message-ID: <aDIx_TaNXv__uO14@ryzen>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>

On Sun, May 25, 2025 at 12:23:03AM +0530, Manivannan Sadhasivam wrote:
> host_bridge::reset_slot() is supposed to reset the PCI root port/slot. Once
> that happens, the config space content would be lost. This was reported by
> Niklas on the dw-rockchip based platform where the MPS setting of the root
> port was lost after the host_bridge::reset_slot() callback. Hence, save the
> config space before calling the host_bridge::reset_slot() callback and
> restore it afterwards.
> 
> While at it, make sure that the callback is only called for root ports by
> checking if the bridge is behind the root bus.
> 
> Fixes: d5c1e1c25b37 ("PCI/ERR: Add support for resetting the slots in a platform specific way")
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/aC9OrPAfpzB_A4K2@ryzen
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d396bbab4a8..6d6e9ce2bbcc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4985,10 +4985,19 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int ret;
>  
> -	if (host->reset_slot) {
> +	if (pci_is_root_bus(dev->bus) && host->reset_slot) {
> +		/*
> +		 * Save the config space of the root port before doing the
> +		 * reset, since the state could be lost. The device state
> +		 * should've been saved by the caller.
> +		 */
> +		pci_save_state(dev);
>  		ret = host->reset_slot(host, dev);
>  		if (ret)
>  			pci_err(dev, "failed to reset slot: %d\n", ret);
> +		else
> +			/* Now restore it on success */
> +			pci_restore_state(dev);
>  
>  		return;
>  	}
> -- 
> 2.43.0
> 

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


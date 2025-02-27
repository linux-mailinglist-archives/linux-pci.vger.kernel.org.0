Return-Path: <linux-pci+bounces-22597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E0A48B0E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AAC18889FB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6827290F;
	Thu, 27 Feb 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxZTLGnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FE27290B;
	Thu, 27 Feb 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693859; cv=none; b=HpjrQTsM6oDH3pZ8VTqa5BF/oHqWKbOXfFdSd8EQhIa4yMHIybdRRcIp8P/yKwdR1BqHXxCMm/4jSZKELsgP6XSNCgQ2kEH3MYDiuImEYzD9yUad5h7bc18f1NEVkK/fidJqc0xXi7Mpa06w7wjlnRsGOGxCqlWheYDhsPpaMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693859; c=relaxed/simple;
	bh=8OhUuNJoGvKBi/xXdJRzG3+310qxdtLu5DkmfSui/14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aNuLuZ7m0AD+OI6vuABUlYC6gkMEDvoLswiGbnw1odLfIpfaC+y4xsG2/CO4pR+XPykmmBj6wX5QqVzVNokgv3dT6PmK0RzOcUmzLpYNeU/HSTNGS4mhSSXqjeDAKAd8TIvVRIfoSwJ8j3yUCAvYUkVIuvbOAp+NHR/RRxbSqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxZTLGnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD15C4CEE7;
	Thu, 27 Feb 2025 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740693858;
	bh=8OhUuNJoGvKBi/xXdJRzG3+310qxdtLu5DkmfSui/14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fxZTLGnNlY+00IW2BFMKDuRednd+97WhfqcyApcmqe0DvNvAfk1Px72s3tOaVyul7
	 j29swFKRllBJhTpoJMf8smYzsLJvYVztY/7hfNs83DKdifJ5sfshCf9+2MfFBkmA8C
	 gw8kO65IInHWiXFY2o0LoeE//7eATetkqT/3s1mYrT2Zl57C0aBoFCaosAxGEvGpmf
	 Q0L5N2Tz8mWD/vW2s8OPNvYfSqoF+0Z1Zn9PAeZDEtE6JH3xXPA3T+atI8sKsgwL8M
	 2K7q6RbgYae0/KjHV1QyzHrr/2nn5H8S2TYlwn2BXHf90yEsAsJ1ckf5N7dTg23b9X
	 pkTTDClv2Rc3A==
Date: Thu, 27 Feb 2025 16:04:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com, yinghai@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI: fix reference leak in pci_alloc_child_bus()
Message-ID: <20250227220417.GA19880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202062357.872971-1-make24@iscas.ac.cn>

On Sun, Feb 02, 2025 at 02:23:57PM +0800, Ma Ke wrote:
> When device_register(&child->dev) failed, we should call put_device()
> to explicitly release child->dev.
> 
> As comment of device_register() says, 'NOTE: _Never_ directly free
> @dev after calling this function, even if it returned an error! Always
> use put_device() to give up the reference initialized in this function
> instead.'
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Applied with Ilpo's reviewed-by to pci/enumeration for v6.15, thanks!

> ---
> Changes in v3:
> - modified the description as suggestions.
> Changes in v2:
> - added the bug description about the comment of device_add();
> - fixed the patch as suggestions;
> - added Cc and Fixes table.
> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..51b78fcda4eb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  add_dev:
>  	pci_set_bus_msi_domain(child);
>  	ret = device_register(&child->dev);
> -	WARN_ON(ret < 0);
> +	if (WARN_ON(ret < 0)) {
> +		put_device(&child->dev);
> +		return NULL;
> +	}
>  
>  	pcibios_add_bus(child);
>  
> -- 
> 2.25.1
> 


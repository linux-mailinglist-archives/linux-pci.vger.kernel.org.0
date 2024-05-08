Return-Path: <linux-pci+bounces-7219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E488BF986
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279331F22E0C
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022F71B50;
	Wed,  8 May 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGWsAQLj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672571753;
	Wed,  8 May 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160457; cv=none; b=ZencQS0vmMxZ/HN0Wh5sbZ4Zpq3vMnQW97vvoQOQwkE7lhAeLxMb8NDTIrNGafezFCd7IAdepOiSfQNwwc8s0L7sX8dNFCP7Fj6fpsfMSQcliABgFf24Ov3Xw1ECrGz/+BylXDfYEVOY/QB7uOnyWzf+2F+1QKzRcsPRViYzCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160457; c=relaxed/simple;
	bh=pbTSEyt0Gb41E8A4klYfoIdoPzLnq/p8eOsp7yG/8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3UHmTtU5nV6fYJYOJVESpE0niVw88JYRY1BGJTD1Kf8GMM+980OpV9qGS86DSQSKZ+Lm5Ae25kUKRgCV2oQPa+nXUJkrRMqBZWSSdf6QE2rGJb4Ofa2bsChJ3Tl0VdobQ4oxFO5VBHug3c2aKvkYWJDEqpY/6p0kOl1M2Syhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGWsAQLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C3BC4AF66;
	Wed,  8 May 2024 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715160456;
	bh=pbTSEyt0Gb41E8A4klYfoIdoPzLnq/p8eOsp7yG/8Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGWsAQLjy7fFvXuUUkrtVTtFZVphACnI2lCg9l55lZDAce9lcZDWwhPgDtQhCQq8W
	 /MNI/DlL9roWV0kCOIgAT87ftll8IOKKF3I7dWk8P/39lBlqau/WkwhUBLU+DamIOY
	 +4M3ZBJ8Xp6yT6Y/URszZQvacs9TV3SiNn/62uuVK+vu6J7WJ0UHX0g/dasx6Etnu3
	 UiIxSZcA4p673qViz5mtqylCXFH0lXkIXiEjisVbY91oMt8KQ1aHkHdJijPWKrlmDk
	 E3Sjlgav9hYUxHoZY+svt2lB+LTxUZsshTMLeBwjb2wYlQvmTgcnqHoVZRB+HjSMkA
	 xa/eFo9Yb4AFA==
Date: Wed, 8 May 2024 11:27:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH V2] PCI: tegra194: Set EP alignment restriction for
 inbound ATU
Message-ID: <ZjtFg83RjyKQA82S@ryzen.lan>
References: <20240508092207.337063-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508092207.337063-1-jonathanh@nvidia.com>

On Wed, May 08, 2024 at 10:22:07AM +0100, Jon Hunter wrote:
> Tegra194 and Tegra234 PCIe EP controllers have 64K alignment
> restriction for the inbound ATU. Set the endpoint inbound ATU alignment to
> 64kB in the Tegra194 PCIe driver.
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V1: Updated commit message.
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 93f5433c5c55..4537313ef37a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2015,6 +2015,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  	.bar[BAR_4] = { .type = BAR_RESERVED, },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
> +	.align = SZ_64K,
>  };
>  
>  static const struct pci_epc_features*
> -- 
> 2.34.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>


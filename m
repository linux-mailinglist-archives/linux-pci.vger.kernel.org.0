Return-Path: <linux-pci+bounces-6191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102AA8A3524
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A39288B1B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCF14D29E;
	Fri, 12 Apr 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQjZA5q6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46D14C596
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944290; cv=none; b=esHQbtk9i1TGFGaVsdZ8RnBuopvDkO5+qPvwuj3zc3DNQGd96qIoZHynenGKhjBz2NcMqUmCEwkgrs472QPEpikreNRp2/UNggMLP16V2fx0GsSgXWAoCwRQhqjIZuqpcEMCWGLHBcx70L9dYjER+XntfRv1enTUg5bfZMTFD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944290; c=relaxed/simple;
	bh=B4SDpNiM6OJj6RA1ZnrFX2EgwahSw1RpMCPDTL5Nv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q+y2qhXa/LDqNy9V+xLEKDtpH3glPdi9lQ/FMpXzgOnh7RtUQtNlfP/g4JDVss6hLTZke34AULI/uRRHimYlHvcZGQw7xMGIWG2Qoa7Y1v6lmIRd2sHsAB7wpDDO1tNSkmzr3QPvdAY6cmZX4KFKIgMe6/REoFnacj9w0710Ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQjZA5q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59851C113CC;
	Fri, 12 Apr 2024 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712944289;
	bh=B4SDpNiM6OJj6RA1ZnrFX2EgwahSw1RpMCPDTL5Nv+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aQjZA5q6Qh0W9oWz3dVtullRDOpFKrgq9zOOq3Ta5ItJF0PLUQSZpC7H/6knlI8ol
	 DpD1Y2iho9K41AVL+wOkBBL7iLevPIoJy23roX4DC6P9hBItDUt4e4Qolx9p5zExDS
	 h1/v4KsIWPrBLlr/VK+9TlTqxbZS9NQaJRyTZwV+9zd+9sNVs+blFzmygs38cAfIyw
	 xktCioMFLFBMulyc5EwPPTetdX25Nc4IsOygdoGZUBx17JqOcDO9/JtAeNlQCKmGUZ
	 k5fVtGpCC9VK/eF76wkTuzuhsb6INbzAQP+S2s2cXn06EF05m7/r86VrzTl9TskV12
	 fzGtNmy+pIykw==
Date: Fri, 12 Apr 2024 12:51:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <20240412175127.GA8613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313105804.100168-9-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> is invalid if 64-bit flag is not set") it has been impossible to get the
> .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> requested to be configured as a 64-bit BAR.
> 
> It is however possible that an EPF driver configures a BAR as 64-bit,
> even if the requested size is < 4 GB.
> 
> Respect the requested BAR configuration, just like how it is already
> repected with regards to the prefetchable bit.

Does this (and the similar cadence patch) need a Fixes: tag for
f25b5fae29d4?

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index c9046e97a1d2..57472cf48997 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
>  	} else {
>  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> -		bool is_64bits = sz > SZ_2G;
> +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
>  
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;
> -- 
> 2.44.0
> 


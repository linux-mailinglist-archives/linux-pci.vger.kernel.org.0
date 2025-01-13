Return-Path: <linux-pci+bounces-19685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0CA0C15F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DE87A02B5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CC1C5D7E;
	Mon, 13 Jan 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBBjA9Yt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B11B21BC;
	Mon, 13 Jan 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796442; cv=none; b=MdyYTSxiBUubbsrBEPTMhHcQyogzo+dy507jp7jQlkE1CkVZWbyaV9hAPmJi29Ecqjrz9g26Jnk4oWfkt4cd5VerMTpiO0+axtSdeEa6oC77p5eX3okfNfnk+1kMEkeNTzqgJvt5kNewfmqJqGusStFdWmJ4eYdpfYK2zzBlKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796442; c=relaxed/simple;
	bh=CjvjHO6S+8TLxs+4MjSObjN8IEm72lKwk6gKdw1AnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MxL8hQ4FqCe4X9r4nc7vSm05ZTxfCKyB16Id5jiKjC3GFUWjjGBQz8Kng2vT2up3hCcgahxVo7xxORmhMyg6STl9UhFs1vAEvKZAAz8npwobIQGxoJcKk+Q7sPVUJkC4nyLkpkHNgXil1GknF9R1RkO7wj5AV/udkj97o+/ZLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBBjA9Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9317FC4CED6;
	Mon, 13 Jan 2025 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736796441;
	bh=CjvjHO6S+8TLxs+4MjSObjN8IEm72lKwk6gKdw1AnX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SBBjA9YtHpIZAElZpnXG7eyfeQ47XnV2mrw7Y/If8zZYzI8PeuENl94vB2jeUoJnY
	 CiIUpMTsmqzDqMGlRcbPenMZOXjlEwNutg5rBIpj9tRinHVXehfiNZIxjLero1PSAt
	 YVEXx3MYLSUJbNpj4tIzDymbUCfohNWie4Cugfj9NsNZd+Uv0uUbWcWmRrRZH2d8RS
	 J4+cMxU8CUP/HsaLwat+svRKSxflCFf6t39tCclPh0wZ8yRjxJrQo2su3DiQQr/80a
	 HkJ/u3IdJsSHFRtJlcbtIIlHibWB/ZMWEWJjO7j5XjQmrmQbuQ5fJxOvLxaCs+nHR+
	 HLTx8TXjhKJEQ==
Date: Mon, 13 Jan 2025 13:27:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <20250113192720.GA414640@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>

On Mon, Jan 13, 2025 at 11:59:34AM +0100, Niklas Cassel wrote:
> The Root Complex specific device tree binding for pcie-dw-rockchip has the
> 'sys' interrupt marked as required.
> 
> The driver requests the 'sys' IRQ unconditionally, and errors out if not
> provided.
> 
> Thus, we can unconditionally set use_linkup_irq before calling
> dw_pcie_host_init().
> 
> This will skip the wait for link up (since the bus will be enumerated once
> the link up IRQ is triggered), which reduces the bootup time.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thanks!  I was just reviewing the addition of your dll_link_up IRQ
handler, and was about to ask whether you wanted to set use_linkup_irq
to avoid the wait, but here's the patch already :)

I think I'll sort out the branches so the dll_link_up IRQ handler,
this patch, and the corresponding qcom change go on the same branch as
Krishna's patch to skip waiting if pp->use_linkup_irq.

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1170e1107508bd793b610949b0afe98516c177a4..62034affb95fbb965aad3cebc613a83e31c90aee 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
>  
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
> +	pp->use_linkup_irq = true;
>  
>  	return dw_pcie_host_init(pp);
>  }
> 
> ---
> base-commit: 2adda4102931b152f35d054055497631ed97fe73
> change-id: 20250113-rockchip-no-wait-403ffbc42313
> 
> Best regards,
> -- 
> Niklas Cassel <cassel@kernel.org>
> 


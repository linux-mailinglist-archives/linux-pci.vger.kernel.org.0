Return-Path: <linux-pci+bounces-6199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB58A37D4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 23:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3A31C20E61
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6E152160;
	Fri, 12 Apr 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9hLWH92"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A12D600
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957180; cv=none; b=bA35k0vg4QBmL+qyXvw7/JjadNNrTKKPbbzuXuH7shDxLoxwNdtWc0AS+mI7TEZwIz+ZnT1xKayNdonCEqcnkjfyFZk0dcALGvL3X/pZjelDaSvQBoRrN8hGac9fpJkmEJtFWCe6ww8WqeQYvjtVZ+lfkfkJoVPqK3t/VkOc/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957180; c=relaxed/simple;
	bh=6TxUy+yg2L9ECoMhj9r75VOWYOG0ZXDC5XiozrxgnMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AENnd/eI+2tq+rmiiwEJCHA+E/SiHNDQvXiRnROQTEADCtLg9DvRJagdpGdXhZ3dzHBNEht3XQP41TNXo/5t5JOLMGU5UAl2rXqykoppHAiRSgAsns6C32O3+/ZSuFYZwx9EiA8Yc/ZFY3W5VYCtPbkfQnSLVIFSiTEncK1Y+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9hLWH92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535DEC2BD10;
	Fri, 12 Apr 2024 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712957179;
	bh=6TxUy+yg2L9ECoMhj9r75VOWYOG0ZXDC5XiozrxgnMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E9hLWH926Sd6eTq/YruMgxgY6SgqRJK1OeCAP0V8Y2dYjbUju31DnLqpmwK3Te8qP
	 BvFpvgexdIvsz4QMf1d3KYxNMtafq0PYcN3AT2eyKFLvuOsSCANSL+lVnAc9NdGzVp
	 EvwGfZM7fIJt4SyHQMpGT1eZBKnB6GpXbpsMP6EctZZFO91DLs4fes1x8/HGI/oL1w
	 2zWQWcyzrn4/pN+hoRx/cV8B7xxiH5LtOAcfEu0aymBLKkQIoS51FuXK4dGXGEctJY
	 JkvCtuZUqtxxzvzPS+b/jLK7tf0a2C+Kw8aFksrGCj5NC6q/GXGv8wJ5JnntadsrIy
	 LoepQ2VBs59UA==
Date: Fri, 12 Apr 2024 16:26:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] PCI: rockchip-host: Fix
 rockchip_pcie_host_init_port() PERST# handling
Message-ID: <20240412212617.GA18670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412023721.1049303-2-dlemoal@kernel.org>

On Fri, Apr 12, 2024 at 11:37:20AM +0900, Damien Le Moal wrote:
> The PCIe specifications (PCI Express Electromechanical Specification rev
> 2.0, section 2.6.2) mandate that the PERST# signal must remain asserted

"PCIe CEM r5.1, sec 2.9.2"

> for at least 100 usec (Tperst-clk) after the PCIe reference clock
> becomes stable (if a reference clock is supplied), and for at least
> 100 msec after the power is stable (Tpvperl, defined by the macro
> PCIE_T_PVPERL_MS).
> 
> Modify rockchip_pcie_host_init_port() to satisfy these constraints by
> adding a sleep period before bringing back PESRT# signal to high using

s/PESRT#/PERST#/
s/bringing back PERST# to high/deasserting PERST#/

Whoever applies this can probably fix these up for you.

> the ep_gpio GPIO. Since Tperst-clk is the shorter wait time, add an
> msleep() call for the longer PCIE_T_PVPERL_MS milliseconds to handle
> both timing requirements.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 300b9dc85ecc..fc868251e570 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -322,6 +322,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	msleep(PCIE_T_PVPERL_MS);

Looks good, thanks!

>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
> -- 
> 2.44.0
> 


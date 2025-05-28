Return-Path: <linux-pci+bounces-28518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F159AC7426
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B935A1887754
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151821CC41;
	Wed, 28 May 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9b51zZJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43238634A
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472173; cv=none; b=QfA2bvuFobmt/wTZEf1WGQ8+4hpP/t9aO/nESjWySgUg9MFjIG0kJuA5JFs2aR31jDPb/2NjmGvCjqIg+sWYfUON7aK5oYepx+RSzMD4GYgboBOd1kR2IGkhIOaJ+VIO6qlhTWhSKtuDF6kkqRKoN8gACGPc1xcKjtfb+Akg3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472173; c=relaxed/simple;
	bh=BgtgZ94JV4lty9f7aKpjE/K76PxuE3tb9eltRydrPzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DramcL1A5QGBbAl30O9b5SRxd0OnYTmaCcDIucEEf1kPJm8X/LCuOyw/L03LZyvjiCxMqDWp5Y4xdpPN7S7HSW3QkBN9fIkuWgSwHsYIRrgsulcdLdtH19xWxJ+WJ4zfcMh70HQiXaa70kXCkBr0QanBzBBIqc4xAtVxni8FYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9b51zZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2025EC4CEE3;
	Wed, 28 May 2025 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748472173;
	bh=BgtgZ94JV4lty9f7aKpjE/K76PxuE3tb9eltRydrPzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F9b51zZJVSXTny6ilejAjYKo46E47eW7SnLAWMckqe5uEYoa2mF7gWDVsfBDqMcfh
	 5g2tP+c+9uNyElC+EKifehRog4JsBXOK0Tjv28wpC++aNp8ysTRfuNuXMbORUHy2dJ
	 4+P85wzqo4Sts4xHJxsmUGli/Pf+kHQzjT70XWVMp55RfKejRQFtbI/ZppJltUsE+r
	 QoKIozXi1dmYs9lW/gMjlnfj3wzWczOY4ub3VJFI2Rj5RN21okGs0gYbbSpZdgo/iW
	 6Trt+TYWzyteYUDuOTToFJOnv7n6Kl6QbjSYMapxn8CFBKuvfb9s8yzmdQBj5iBnoq
	 eTHGuRTL5hjDQ==
Date: Wed, 28 May 2025 17:42:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250528224251.GA58400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506073934.433176-7-cassel@kernel.org>

On Tue, May 06, 2025 at 09:39:36AM +0200, Niklas Cassel wrote:
> Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> and instead enumerate the bus when receiving a Link Up IRQ.
> 
> Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> SSD functional again.
> 
> It seems that we are enumerating the bus before the endpoint is ready.
> Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> threaded IRQ handler makes the SSD functional once again.

This sounds like a problem that could happen with any controller, not
just dw-rockchip?  Are we missing some required delay that should be
in generic code?  Or is this a PLEXTOR defect that everybody has to
pay the price for?

Delays like this are really hard to get rid of once we add them, so
I'm a little bit cautious.

> What appears to happen is that before ec9fd499b9c6, we called
> dw_pcie_wait_for_link(), and in the first iteration of the loop, the link
> will never be up (because the link was just started),
> dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS (90 ms),
> before trying again.
> 
> This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS)
> (100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
> bus would essentially be delayed by that time anyway (because of the sleep
> LINK_WAIT_SLEEP_MS (90 ms)).
> 
> While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERST,
> that would essentially bring back an unconditional delay during synchronous
> probe (the whole reason to use a Link Up IRQ was to avoid an unconditional
> delay during probe).
> 
> Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> IRQ handler. This way, we will not have an unconditional delay during boot
> for unpopulated PCIe slots.
> 
> Cc: Laszlo Fiat <laszlo.fiat@proton.me>
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3c6ab71c996e..6a7ec3545a7f 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -23,6 +23,7 @@
>  #include <linux/reset.h>
>  
>  #include "pcie-designware.h"
> +#include "../../pci.h"
>  
>  /*
>   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> @@ -458,6 +459,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>  		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +			msleep(PCIE_T_RRS_READY_MS);
>  			/* Rescan the bus to enumerate endpoint devices */
>  			pci_lock_rescan_remove();
>  			pci_rescan_bus(pp->bridge->bus);
> -- 
> 2.49.0
> 


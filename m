Return-Path: <linux-pci+bounces-7531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B788C6D70
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E591F213CE
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC115ADBE;
	Wed, 15 May 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/U46up4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07B3BBEA;
	Wed, 15 May 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806549; cv=none; b=JSAbrrI45Kl+AN+L5x6FuaQUamuDvLA2oGDbNhTkK7eIWIutkvgJk7Wm6HEVS3nN+7ox+lKPAosmYqKaDWeFuokvpcobfLpbygurRQWBmXMEQ/hXbVpkeDsiW3kqZaDwLz0Pu1oKSmiN3EvAv/J3n1mQjVrG6c3bM6orS9v4r/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806549; c=relaxed/simple;
	bh=AAeXwwHWMP0eHtZAb20qWMKLq5n94EYBqJos5Y7FBEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tno2Y4jqDCznrRJPnLcGvto5bsDUzxIYv/o5BFMY/VbXXQAhyy9znqUTxW9kWbAv9M9BZkI1KTfDpK9xmsChinn658ahm5o2doe7mR0bMF6N0GSBm6sjYnkWbwR/wdTk1Tm+bQoXXOKVrwS3qVSH3+yQhXhZrV/Zz/yUTXKtj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/U46up4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A379C116B1;
	Wed, 15 May 2024 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715806549;
	bh=AAeXwwHWMP0eHtZAb20qWMKLq5n94EYBqJos5Y7FBEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d/U46up4/1F7xAwdTRSJTYMeQ0ft+y0RZ8yEnDsVnOWx+XUXmNLq2ZaTcS0PwJi21
	 Is92bD6XPKbod2xd710vZHuXroJBdnqCE0oG33ui/DUsPLCbd4c4Cp9PWNZl/nUcrj
	 xm0WCopuH4JLUcRkkbgoymeB+Nh2zNH8zj0zXBRIyFtVutNG5YpWo/a4L+m1OHjdnp
	 0t7bGloxDN3jh2OUCoQOjD+rKKaVlksAjgQH2/psvco2L3HLNQSqgCS8Wq87rUXFyI
	 gN03XVNbAohU4I6fVzPVuWD1LJnR8QiZAITxgfqIXKJB1mPC6+y4j6dGIYyej7/+re
	 GSDrse3kZS56g==
Date: Wed, 15 May 2024 15:55:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
Message-ID: <20240515205547.GA2137633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403144508.489835-1-rick.wertenbroek@gmail.com>

On Wed, Apr 03, 2024 at 04:45:08PM +0200, Rick Wertenbroek wrote:
> Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
> Vendor ID are u16 variables and are written to a u32 register of the
> controller. The Subsystem Vendor ID was always 0 because the u16 value
> was masked incorrectly with GENMASK(31,16) resulting in all lower 16
> bits being set to 0 prior to the shift.
> 
> Remove both masks as they are unnecessary and set the register correctly
> i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
> Subsystem Vendor ID.
> 
> This is documented in the RK3399 TRM section 17.6.7.1.17
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Cc: stable@vger.kernel.org

Applied to pci/controller/rockchip by Krzysztof, but his outgoing mail
queue got stuck.  I added Damien's Reviewed-by.  Trying to squeeze
into v6.9.

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index c9046e97a1d2..37d4bcb8bd5b 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -98,10 +98,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
>  
>  	/* All functions share the same vendor ID with function 0 */
>  	if (fn == 0) {
> -		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
> -			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
> -
> -		rockchip_pcie_write(rockchip, vid_regs,
> +		rockchip_pcie_write(rockchip,
> +				    hdr->vendorid |
> +				    hdr->subsys_vendor_id << 16,
>  				    PCIE_CORE_CONFIG_VENDOR);
>  	}
>  
> -- 
> 2.25.1
> 


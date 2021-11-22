Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABDF458DF6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhKVMG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 07:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 07:06:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D0D601FC;
        Mon, 22 Nov 2021 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582630;
        bh=J6QSisCas28FyW2gcQwmaAfdUy4SQyLKy447BZL/E8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paPfM2lNpXFcVEQIf3a080U5w1vXtgrmKlFoq8eBW0zK275x7+OXiy2cxeNfcJvyd
         l+qEt+d1rtB6FkATCJ0s8XMY8vrlwyynLm9AqilVL+uBRuVpJ871EFNondEzCFcMCp
         X/Vn4TwyI6lQaEpIKcgINHKmRRuGtgrhOn7KGdL3dhXwwyUH1T9+n8fpTUkp0V18g5
         jExfcbDUn9tk7qt8OTciQJ3qL0ds21cqyNC+uyx2N4f4K2FrpRNl4Sw4nVp7ZwR7yI
         0JkIIhSCepCAnKgSbl35xUJ5XpNKuxDpFG8LZrLIw+fchnqDPJl6ECTH2bKOPh7Fld
         DI8DmP91Ck/XA==
Received: by pali.im (Postfix)
        id 12E6DA87; Mon, 22 Nov 2021 13:03:48 +0100 (CET)
Date:   Mon, 22 Nov 2021 13:03:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: apple: Follow the PCIe specifications when
 resetting the port
Message-ID: <20211122120347.6qyiycqqjkgqvtta@pali>
References: <20211122104156.518063-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122104156.518063-1-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 22 November 2021 10:41:56 Marc Zyngier wrote:
> While the Apple PCIe driver works correctly when directly booted
> from the firmware, it fails to initialise when the kernel is booted
> from a bootloader using PCIe such as u-boot.
> 
> That's beacuse we're missing a proper reset of the port (we only
> clear the reset, but never assert it).
> 
> The PCIe spec requirements are two-fold:
> 
> - #PERST must be asserted before setting up the clocks, and
>   stay asserted for at least 100us (Tperst-clk).
> 
> - Once #PERST is deasserted, the OS must wait for at least 100ms
>   "from the end of a Conventional Reset" before we can start talking
>   to the devices
> 
> Implementing this results in a booting system.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Pali Rohár <pali@kernel.org>

Looks good, but see comment below.

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/pci/controller/pcie-apple.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 1bf4d75b61be..957960a733c4 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  
>  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>  
> +	/* Engage #PERST before setting up the clock */
> +	gpiod_set_value(reset, 0);
> +
>  	ret = apple_pcie_setup_refclk(pcie, port);
>  	if (ret < 0)
>  		return ret;
>  
> +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
> +	usleep_range(100, 200);
> +
> +	/* Deassert #PERST */
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
>  	gpiod_set_value(reset, 1);

+ Luca

Just one comment. PERST# (PCIe Reset) is active-low signal. De-asserting
means to really set value to 1.

But there was a discussion that de-asserting should be done by call:
  gpiod_set_value(reset, 0);

https://lore.kernel.org/linux-pci/51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net/

Could we make this new pcie-apple.c driver to use gpiod_set_value(reset, 0)
for de-asserting, like in other drivers?

>  
> +	/* Wait for 100ms after #PERST deassertion (PCIe r2.0, 6.6.1) */
> +	msleep(100);
> +
>  	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
>  					 stat & PORT_STATUS_READY, 100, 250000);
>  	if (ret < 0) {
> -- 
> 2.30.2
> 

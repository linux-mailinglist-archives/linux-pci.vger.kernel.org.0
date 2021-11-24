Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7145BFBF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbhKXNBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 08:01:23 -0500
Received: from foss.arm.com ([217.140.110.172]:37156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346253AbhKXM7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 07:59:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075C71042;
        Wed, 24 Nov 2021 04:56:13 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58DFB3F73B;
        Wed, 24 Nov 2021 04:56:11 -0800 (PST)
Message-ID: <fa1d802c-43a0-cbec-c16b-c662e3fdf7fa@arm.com>
Date:   Wed, 24 Nov 2021 12:56:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/3] PCI: apple: Follow the PCIe specifications when
 resetting the port
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
References: <20211123180636.80558-1-maz@kernel.org>
 <20211123180636.80558-2-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211123180636.80558-2-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-23 18:06, Marc Zyngier wrote:
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
>    stay asserted for at least 100us (Tperst-clk).
> 
> - Once #PERST is deasserted, the OS must wait for at least 100ms
>    "from the end of a Conventional Reset" before we can start talking
>    to the devices
> 
> Implementing this results in a booting system.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Acked-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/controller/pcie-apple.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 1bf4d75b61be..957960a733c4 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>   
>   	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>   
> +	/* Engage #PERST before setting up the clock */
> +	gpiod_set_value(reset, 0);

FWIW, given that getting the GPIO with GPIOD_OUT_LOW should have had 
this effect in the first place, if this isn't a no-op at this point then 
it would hint at something being more significantly wrong down at the 
GPIO/pinctrl end :/

Once you fix the polarity in the later patch, though, adding the 
explicit reset assertion here does seem a far nicer option than fiddling 
the flags to preserve the implicit assertion earlier.

Cheers,
Robin.

> +
>   	ret = apple_pcie_setup_refclk(pcie, port);
>   	if (ret < 0)
>   		return ret;
>   
> +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
> +	usleep_range(100, 200);
> +
> +	/* Deassert #PERST */
>   	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
>   	gpiod_set_value(reset, 1);
>   
> +	/* Wait for 100ms after #PERST deassertion (PCIe r2.0, 6.6.1) */
> +	msleep(100);
> +
>   	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
>   					 stat & PORT_STATUS_READY, 100, 250000);
>   	if (ret < 0) {
> 

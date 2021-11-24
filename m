Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCFD45B756
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhKXJZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 04:25:39 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:39902 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232105AbhKXJZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 04:25:38 -0500
Received: from [79.2.93.196] (port=52040 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mpoU0-0008zx-5Q; Wed, 24 Nov 2021 10:22:28 +0100
Subject: Re: [PATCH v3 1/3] PCI: apple: Follow the PCIe specifications when
 resetting the port
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        kernel-team@android.com
References: <20211123180636.80558-1-maz@kernel.org>
 <20211123180636.80558-2-maz@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <60f24740-156e-f679-e77b-3c60ced5b41b@lucaceresoli.net>
Date:   Wed, 24 Nov 2021 10:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123180636.80558-2-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 23/11/21 19:06, Marc Zyngier wrote:
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
> Acked-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>>
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

"Assert" is the verb typically used instead of "Engage".

With this fixed, or even without as this is a pretty urgent fix:

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca

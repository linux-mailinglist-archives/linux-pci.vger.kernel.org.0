Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75445AE83
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 22:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhKWVjZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 23 Nov 2021 16:39:25 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:46141 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhKWVjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 16:39:25 -0500
Received: from [77.244.183.192] (port=64428 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mpdSX-0008mA-Vi; Tue, 23 Nov 2021 22:36:14 +0100
Subject: Re: [PATCH v3 3/3] PCI: apple: Fix #PERST polarity
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        kernel-team@android.com
References: <20211123180636.80558-1-maz@kernel.org>
 <20211123180636.80558-4-maz@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <453389da-b041-94b3-009e-6c6323134936@lucaceresoli.net>
Date:   Tue, 23 Nov 2021 22:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123180636.80558-4-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mark,

On 23/11/21 19:06, Marc Zyngier wrote:
> Now that #PERST is properly defined as active-low in the device tree,
> fix the driver to correctly drive the line indemendently of the
> implied polarity.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Suggested-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for quickly addressing this!

Do we need a transition path for backward compatibility with old DTs
already around? Something like this [0]. You said [1] the DT actually
used is not even the one in the kernel, thus how do we guarantee DT and
driver switch to the new polarity all at once?

[0] https://lkml.org/lkml/2021/6/24/1049
[1] https://lkml.org/lkml/2021/11/23/455

> ---
>  drivers/pci/controller/pcie-apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 957960a733c4..03bc56f39be5 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -540,7 +540,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>  
>  	/* Engage #PERST before setting up the clock */
>
> -	gpiod_set_value(reset, 0);
> +	gpiod_set_value(reset, 1);
>  
>  	ret = apple_pcie_setup_refclk(pcie, port);
>  	if (ret < 0)
> @@ -551,7 +551,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  
>  	/* Deassert #PERST */
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> -	gpiod_set_value(reset, 1);
> +	gpiod_set_value(reset, 0);

Minor note: if it were me I would coalesce patches 1 and 3 together,
otherwise we are insisting on a wrong implementation (patch 1) to later
fix it all (this patch).

-- 
Luca


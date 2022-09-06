Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39195AE0B3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiIFHOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiIFHOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 03:14:03 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF25EDD9;
        Tue,  6 Sep 2022 00:14:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 45FC2424EB;
        Tue,  6 Sep 2022 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1662448440; bh=0nUWl89mjqQ5K31+h2G4hNBO/2+SnGSjnZ+TdSHB9e8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZoXYswq0HIX0U7DUE3HhgoIat+FrZQJmJZN5Qkuv9B9QlHGflmeOrVJVtI2rh/Pug
         eB/LcOM6VlZeg89arq1wH9Jb3/7G7D3g7lPaM83BhcnSCeZKVrUHQkK0O2mWWi2NE4
         O6hwwHI4IkN3qlS9piY5O+JryIer8/GnZSzsFQdJxeC2zUZP3Mnvlks6wwTjkT40in
         bFABA/rPAF8Vmhuj2Q/jTtKvAlfcgzmEfbybd86A0bnAzt0r5qFiwRTOfoXwW43fPq
         hZKq6nU2NRsLcGChvypsO0P6PEkbaijBAbzVSf+3qs1SgLdgkLDb6SM7HhhpmbARiB
         9V7gRx8x5B+hA==
Message-ID: <bbae73e7-9c9b-d86d-c34d-018cb9ef4540@marcan.st>
Date:   Tue, 6 Sep 2022 16:13:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PCI: apple: do not leak reset GPIO on unbind/unload/error
Content-Language: es-ES
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YxatO5OaI2RpxQ2M@google.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <YxatO5OaI2RpxQ2M@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/09/2022 11.15, Dmitry Torokhov wrote:
> The driver allocates reset GPIO in apple_pcie_setup_port() but neither
> releases the resource, nor uses devm API to have it released
> automatically.
> 
> Let's fix this by switching to devm API. While at it let's use generic
> devm_fwnode_gpiod_get() instead of OF-specific gpiod_get_from_of_node()
> - this will allow us top stop exporting the latter down the road.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This patch has been pulled out of the series
> https://lore.kernel.org/all/20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com/
> with updated justification (leak fix vs pure API deprecation).
> 
>  drivers/pci/controller/pcie-apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index a2c3c207a04b..66f37e403a09 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	u32 stat, idx;
>  	int ret, i;
>  
> -	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
> -				       GPIOD_OUT_LOW, "PERST#");
> +	reset = devm_fwnode_gpiod_get(pcie->dev, of_fwnode_handle(np), "reset",
> +				      GPIOD_OUT_LOW, "PERST#");
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  

Reviewed-by: Hector Martin <marcan@marcan.st>

I actually caught this one a while back, just didn't get around to
submitting it yet since it's part of my WIP PCIe power management branch
(that I'm getting back to next week or so!) :)

https://github.com/AsahiLinux/linux/commit/04f5628fc73ea0369f66c83ba473cb6f8187d2b3

- Hector

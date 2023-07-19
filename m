Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDB758CAC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 06:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGSEhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 00:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGSEhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 00:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265D1B1;
        Tue, 18 Jul 2023 21:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2126C60FE2;
        Wed, 19 Jul 2023 04:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041E3C433C8;
        Wed, 19 Jul 2023 04:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689741433;
        bh=Kx5U5a1uOORtcZ6S84+5N/7Or28yVlj2BT3UaDH8ZbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=etb7PAn8fYWwon+0FhjWa+30egyQhjTszegVqrHP/0ONuc7pcK6zsD2ZSCXY+vBxM
         xHUD6cdhAIBL7AjHarpooFfAFKZW/cZN0McOiFKMS/g0Wtat9WZcD/i11P7MsPS0vX
         MQrYwozj7mJbAmmCcpko9Wbg1duDo8QLyD21c5M2+vGemPCsixkeSeH33JO9p9ofB7
         FZlOwjkHQWvu+mV6ZmHD7KrRnesv025zwqY2DGLTbaDvdk/EOby5NaHd+PTJ5mhXh6
         EiNRGu3s6gKOks7Q5MkCRgzBkx/qJB0NVqzzGEjpU91Zi9lKK2vZcCY7SY5CmLghcC
         SP72AdOoV0hfg==
Message-ID: <1c657304-7fb6-1f03-9fa6-7225fc14c28d@kernel.org>
Date:   Wed, 19 Jul 2023 14:37:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] m68k/pci: Drop useless pcibios_setup()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230718204229.493669-1-helgaas@kernel.org>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20230718204229.493669-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 19/7/23 06:42, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCI core supplies a weak pcibios_setup() implementation that is
> identical to the m68k implementation.  Remove the m68k version since it is
> unnecessary.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks. Seeing as this is related to the ColdFire parts I'll take this through
the m68knommu git tree. Applied to the for-next branch.

Regards
Greg


> ---
>   arch/m68k/kernel/pcibios.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index b0e110d3d2e6..9504eb19d73a 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -92,9 +92,3 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>   		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 32);
>   	}
>   }
> -
> -char *pcibios_setup(char *str)
> -{
> -	return str;
> -}
> -

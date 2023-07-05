Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3642A7482BB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGELKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGELKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 07:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F25F7;
        Wed,  5 Jul 2023 04:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 132B1614FC;
        Wed,  5 Jul 2023 11:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8015C433C7;
        Wed,  5 Jul 2023 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688555419;
        bh=g6CYKrOZqJsjFnhJULlPH2suTKtswHjrQA/J8KXwfjI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gnsh5uEDp+j6wgKmHlnUGthHWhIpFxCWue5UMLRRE6rqW5lpG8IqAwMwgg5Ag8Swt
         VhFQ0iu1+Ea0s9mV2Y/XIyKjKX8Lz0adurLF7sqHcXCwx/TmCySx+I3pHRlhH5SXZU
         ITvgyDh+jCsi6sFL69ZY8sJbvSAkUviTScxZpBB236VbkksgkIyiMplfowKLuDUOkp
         q9A03y4Fgjrm+zKdo4v0Nx4A9UcCwO/5MX9fXDV4zWphuT9+pOWVFGyw5i3rCuOPhf
         pjxlnjdirVRMG02c7Pm+b8kszY35tvCv5CY9oBAueoyboiNit+2zgiRYCVaANOagw6
         uQTBsv5AjnuGw==
Message-ID: <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org>
Date:   Wed, 5 Jul 2023 20:10:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of
 linux/pci-epc.h
To:     Alistair Francis <alistair@alistair23.me>,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, alistair23@gmail.com
References: <20230705104824.174396-1-alistair@alistair23.me>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230705104824.174396-1-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/5/23 19:48, Alistair Francis wrote:
> pci-epc.h doesn't define the members of the pci_epf_header struct, so
> trying to access them results in errors like this:
> 
>     error: invalid use of undefined type 'struct pci_epf_header'
>       167 |                 val = hdr->vendorid;
> 
> Instead let's include pci-epf.h which not only defines the
> pci_epf_header but also includes pci-epc.h.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

It is odd that the the build bot did not detect this...

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index f9682df1da61..5afc91d11eef 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -10,7 +10,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> -#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  

-- 
Damien Le Moal
Western Digital Research


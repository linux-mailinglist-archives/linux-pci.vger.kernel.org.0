Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2344E98C6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiC1N4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiC1N4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 09:56:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263D3ED34;
        Mon, 28 Mar 2022 06:54:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 856811F42AAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648475695;
        bh=93dA8FqYNp/Lt0Zjhk8lbR0S/JZ+vwD2obtfNGwvT9k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KQMS29eMxg8jrJxNMnr1l3jR2gpWeys+qwiBVvwG9sKokh3/MdoMaow+vqOBWlLNl
         B8gaYSG5RrP3uRI6NW/7fOSDseJNzgYymCvrythI8PxI6Sh91JEnzBOhWDLtzgSUZc
         9SJyLPFYulCwU+4cxVWr/j1zo+pWB61LilNV31K2ydtfj7rUZD/lc8mjWFYrbhDTl/
         rqWkXmci9gLpTG9e5ZcUUD4EI7jCMoz58/U1Moho+yuqdrecQDZSfeLrRI67cGW99c
         S2SawVjwMzea5rQeLqt8PQdO4jkfqy/zo3koFbfRyO9hDVbzTovLwfUEOMIYsSsF6Z
         EiDKJPsG0ibbA==
Message-ID: <a2421f17-fa0f-bc8c-f55d-9526ed844998@collabora.com>
Date:   Mon, 28 Mar 2022 15:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: mediatek: Update entries to distinguish MediaTek
 PCIe controller
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220326032708.3626-1-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220326032708.3626-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 26/03/22 04:27, Jianjun Wang ha scritto:
> Add model numbers in Kconfig and update driver name in
> pcie-mediatek-gen3.c to distinguish the MediaTek PCIe controllers.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   drivers/pci/controller/Kconfig              | 11 +++++++----
>   drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++------
>   2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 601f2531ee91..dd7a2caf8da9 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -237,8 +237,11 @@ config PCIE_MEDIATEK
>   	depends on OF
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	help
> -	  Say Y here if you want to enable PCIe controller support on
> -	  MediaTek SoCs.
> +	  Adds support for PCIe MAC controller for MediaTek SoCs.
> +
> +	  The following SoCs are supported for this PCIe controller:
> +	  MT2701 and MT7623 with no MSI supported.
> +	  MT2712, MT7622 and MT7629 support up to 32 MSI interrupt numbers.
>   
>   config PCIE_MEDIATEK_GEN3
>   	tristate "MediaTek Gen3 PCIe controller"
> @@ -250,8 +253,8 @@ config PCIE_MEDIATEK_GEN3
>   	  and support up to 256 MSI interrupt numbers for
>   	  multi-function devices.
>   
> -	  Say Y here if you want to enable Gen3 PCIe controller support on
> -	  MediaTek SoCs.
> +	  The following SoCs are supported for this PCIe controller:
> +	  MT8192 and MT8195.

I agree with the pcie-mediatek-gen3 naming change, it's good to differentiate,
but I don't think that updating the Kconfig description is a good idea.

Everyone can get the list of supported SoCs by reading the dt-bindings for these
drivers, so it's unnecessary to make a list of SoCs in Kconfig... this is also
to avoid updating these entries everytime support for a new chip is added to the
gen3 (or the other) driver.

If nobody opposes to my proposal - please drop that description change.

Regards,
Angelo

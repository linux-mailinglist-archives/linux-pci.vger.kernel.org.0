Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329476E556C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 01:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDQXvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 19:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQXvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 19:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27C272A;
        Mon, 17 Apr 2023 16:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 463CE6206E;
        Mon, 17 Apr 2023 23:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D67C433EF;
        Mon, 17 Apr 2023 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681775504;
        bh=DFQGJWdyBU1izSaYheQ9L9VdeF02eDdqUuoEMtq36cM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QatFTR85OhMc/JCVfgZaWt/qSvJU4UCQL0jSEL+JNYThCMNTza5rytAdJz8wW7skl
         SuB5zpmqrHXzApwx1Q6INcm4PN8Ul8zEsds1s5vw7kybSglExYBQi7WDT0bi2tX5Z9
         n6qnJMEDEOk6qEzN46YiAcTT8DTh0aJejXsC5xt+hDgv//oNwcE74oM1B8ybkbMYoh
         vTSmFC7uFT5qUlgAiGniJVdLI8ZqlVYfJB8PCwymn3P4DtlipcG4KUS89bPRBWnZhl
         SQ+1l0BNyZ1wZvRXyL0mkUrkHjt86MpiijuXMHi+xo+MO2IljgK25iUXL90lhQxq5R
         jTE3CKTzTp6AQ==
Message-ID: <cf47e154-1a48-58a9-b139-95b51b87d356@kernel.org>
Date:   Tue, 18 Apr 2023 08:51:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 11/11] PCI: rockchip: Set address alignment for
 endpoint mode
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Brian Norris <briannorris@chromium.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
 <20230417092631.347976-12-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230417092631.347976-12-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/17/23 18:26, Rick Wertenbroek wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> The address translation unit of the rockchip EP controller does not use
> the lower 8 bits of a PCIe-space address to map local memory. Thus we
> must set the align feature field to 256 to let the user know about this
> constraint.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

I think this one also needs the tag:

Fixes: cf590b078391 ("...")
Cc: stable@vger.kernel.org

And you forgot to add you Signed-off-by tag (when sending someones else patch,
you must add your own SoB tag after the author's tag).

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index edfced311a9f..0af0e965fb57 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -442,6 +442,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = false,
> +	.align = 256,
>  };
>  
>  static const struct pci_epc_features*


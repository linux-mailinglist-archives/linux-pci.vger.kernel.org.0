Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A9735156
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjFSKBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjFSKBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 06:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3611E7F
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 03:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C6F60B0D
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 10:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BDEC433C8;
        Mon, 19 Jun 2023 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687168834;
        bh=8qBw1ddxdTtUbmxqPlg0C8TcutXJwuzg5suaBWkJh0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCG3tktTJchd+tLELdtU/yIJLTUedhH6FrAiQfj6v9DL4n0i9RVQkBW4Z5p0tIpOY
         bflyIRF3ZWKJ0a8w3MXWy4GPjrRmGvDS5beYb3I1h6X17pTi77butNPEsSZi6QRtZm
         el2SiETQ2X4f+drRzgD5K8gpEGevmdfnrGDH8RmNH6bGjoIp/f0+jJ+opIxkmr7xX1
         PVL0+mY8FhZQ3xTeHF099t8hhZGIfFRDJr3eO/PHjcDVve3B/B7DnhrI/Sxrxeihlm
         iNlwdAC2jFi4Iz7NrG54Xm2k1XlCLne58tupakeYwzh8fnQOm3DbwGMC/qp2k1T/Ej
         PDQ2ytmW93ORw==
Date:   Mon, 19 Jun 2023 12:00:27 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 3/8] PCI: microchip: enable building this driver as a
 module
Message-ID: <ZJAnO3NefrPfU9i/@lpieralisi>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
 <20230614155556.4095526-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614155556.4095526-4-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nit: "Enable building driver as a module"

Capital "E" and removed "this" as that's obvious.

On Wed, Jun 14, 2023 at 04:55:51PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Enable building this driver as a module. The expected use case is the
> driver is built as a module, is installed when needed, and cannot be
> removed once installed.
> 
> The remove() callback is not implemented as removing a driver with
> INTx and MSI interrupt handling is inherently unsafe.

Other than Uwe's comment, that I will integrate, the sentence above
should be linked to the Link: below otherwise it is not easy to
parse - it requires some context.

I will do it.

Lorenzo

> 
> Link: https://lore.kernel.org/linux-pci/87y1wgbah8.wl-maz@kernel.org/
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/Kconfig               | 2 +-
>  drivers/pci/controller/pcie-microchip-host.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 8d49bad7f847..f4ad0e9cca45 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -217,7 +217,7 @@ config PCIE_MT7621
>  	  This selects a driver for the MediaTek MT7621 PCIe Controller.
>  
>  config PCIE_MICROCHIP_HOST
> -	bool "Microchip AXI PCIe controller"
> +	tristate "Microchip AXI PCIe controller"
>  	depends on PCI_MSI && OF
>  	select PCI_HOST_COMMON
>  	help
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 73046bad1521..5efd480e42fa 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -1141,5 +1141,6 @@ static struct platform_driver mc_pcie_driver = {
>  };
>  
>  builtin_platform_driver(mc_pcie_driver);
> +MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microchip PCIe host controller driver");
>  MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> -- 
> 2.25.1
> 

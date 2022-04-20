Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD2D508D84
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380691AbiDTQob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380697AbiDTQoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BCC45508
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 09:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12363619F3
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A3C385A1;
        Wed, 20 Apr 2022 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472902;
        bh=sgv77QEGBy7O6TUJeEfmecJX/ahrF4if5cSjkO7hPx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/Zf8CDdpa4FkcJs9P5wjO040T83uGXRKLf6Pm0uBRPq6a/difV4W/52dPGFCFiWJ
         43VbLYf5mzxbMklk8geIfQo6TRvnQTOQWq31TaxSus5A4x+bU9ISyXFqYvV69jRq6T
         sEKkBLQ8cb06SlyDOGISPEWKNrX8pnK5rVeyAfAgRszXu6SI3s1hmU0JncHBMbW8JW
         jCazbK57/sQhTcHX+fyKUleM0FWBuuZPgl1dc1v+BL5XhC/DdnkyS4K8dAzHnEOhMr
         L6gwoDGd+S72lwGtSE3zq/epq1EYnGND36KIdBZCDSeAf8xSaPu8JCBcQ/yaaCgNGH
         WTc+vKaiF5G8A==
Received: by pali.im (Postfix)
        id 44CDA395; Wed, 20 Apr 2022 18:41:39 +0200 (CEST)
Date:   Wed, 20 Apr 2022 18:41:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Conor.Dooley@microchip.com
Subject: Re: [PATCH] PCI: microchip: Allow driver to be built as a module
Message-ID: <20220420164139.k37fc3xixn4j7kug@pali>
References: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 20 April 2022 11:34:49 Uwe Kleine-König wrote:
> There are no known reasons to not use this driver as a module,

Hello! I think that there are reasons. pcie-microchip-host.c driver uses
builtin_platform_driver() and not module_platform_driver(); it does not
implement .remove driver callback and also has set suppress_bind_attrs
to true. I think that all these parts should be properly implemented
otherwise it does not have sane reasons to use driver as loadable and
unloadable module.

Btw, I implemented proper module support for pci-mvebu.c driver
recently, so you can take an inspiration. See:
https://lore.kernel.org/linux-pci/20211126144307.7568-1-pali@kernel.org/t/#u

> so allow to configure PCIE_MICROCHIP_HOST=m.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index b8d96d38064d..6eae2289410a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -301,7 +301,7 @@ config PCI_LOONGSON
>  	  Loongson systems.
>  
>  config PCIE_MICROCHIP_HOST
> -	bool "Microchip AXI PCIe host bridge support"
> +	tristate "Microchip AXI PCIe host bridge support"
>  	depends on PCI_MSI && OF
>  	select PCI_MSI_IRQ_DOMAIN
>  	select GENERIC_MSI_IRQ_DOMAIN
> 
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> prerequisite-patch-id: e8aad0ef8193038684bc2e10d387a7b74da1116a
> -- 
> 2.35.1
> 

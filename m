Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC24516E28
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiEBKew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384538AbiEBKen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 06:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9990B7F0;
        Mon,  2 May 2022 03:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5AB6123B;
        Mon,  2 May 2022 10:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E887C385A4;
        Mon,  2 May 2022 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651487473;
        bh=F47tb2LcIQl1JzmX/6+L6mZEb8vZi9kPtE/YAoCVFFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbZeh2W3aXkSAYwbcO1vfSGS9AalqPh0LtpikQHrl1l6XQJJMZpAFRtIgkuxVW2Fe
         ncn/24QnrG+TKvF+jpgTBnp4dqNqAmt2irGJpvxucnGXK3316JTsFEnQfdWOPJ4w+m
         Y5Xg2Tdgc2p56WW1yOx6+mmkLBcV++Fk5uNIwjgKrD0tUys8gyI+bbrnEW7PcIY+Ao
         pggFxy0cGNuKDukuJz93xigqnijwnu8EvFlWZzwpVZGcwKCYBS5sUa9nMamp6H5z0p
         Xy01cTMR2Klt/Rut43CblnibnjlKkjCZP6Njf7uG5NVF63Qno68PN8MbclRfvi9eWC
         6edOpUA8dU6PQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nlTKh-008OYC-DR; Mon, 02 May 2022 11:31:11 +0100
Date:   Mon, 02 May 2022 11:31:11 +0100
Message-ID: <87ee1ci5u8.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
In-Reply-To: <20220502093832.32778-4-marcan@marcan.st>
References: <20220502093832.32778-1-marcan@marcan.st>
        <20220502093832.32778-4-marcan@marcan.st>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: marcan@marcan.st, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com, bhelgaas@google.com, alyssa@rosenzweig.io, sven@svenpeter.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 02 May 2022 10:38:32 +0100,
Hector Martin <marcan@marcan.st> wrote:
> 
> WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
> Add support for this to the PCIe controller. This is modeled after how
> pcie-fu740 does it.

Please update the DT binding to reflect this as an optional property.

> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/pci/controller/pcie-apple.c | 35 ++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index e3aa2d461739..5b73c03ebe94 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -518,6 +518,16 @@ static int apple_pcie_probe_port(struct device_node *np)
>  	}
>  
>  	gpiod_put(gd);
> +
> +	gd = gpiod_get_from_of_node(np, "pwren-gpios", 0,
> +				    GPIOD_OUT_LOW, "PWREN");
> +	if (IS_ERR(gd)) {
> +		if (PTR_ERR(gd) != -ENOENT)
> +			return PTR_ERR(gd);
> +	} else {
> +		gpiod_put(gd);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -526,7 +536,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  {
>  	struct platform_device *platform = to_platform_device(pcie->dev);
>  	struct apple_pcie_port *port;
> -	struct gpio_desc *reset;
> +	struct gpio_desc *reset, *pwren = NULL;
>  	u32 stat, idx;
>  	int ret, i;
>  
> @@ -535,6 +545,15 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> +	pwren = devm_gpiod_get_from_of_node(pcie->dev, np, "pwren-gpios", 0,
> +					    GPIOD_OUT_LOW, "PWREN");
> +	if (IS_ERR(pwren)) {
> +		if (PTR_ERR(pwren) == -ENOENT)
> +			pwren = NULL;
> +		else
> +			return PTR_ERR(pwren);
> +	}
> +
>  	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
>  	if (!port)
>  		return -ENOMEM;
> @@ -557,12 +576,22 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	/* Assert PERST# before setting up the clock */
>  	gpiod_set_value_cansleep(reset, 1);
>  
> +	/* Power on the device if required */
> +	if (pwren)
> +		gpiod_set_value_cansleep(pwren, 1);

nit: AFAICT, the gpiod_* helpers already check for a NULL descriptor,
and silently return without an error.

> +
>  	ret = apple_pcie_setup_refclk(pcie, port);
>  	if (ret < 0)
>  		return ret;
>  
> -	/* The minimal Tperst-clk value is 100us (PCIe CEM r5.0, 2.9.2) */
> -	usleep_range(100, 200);
> +	/*
> +	 * The minimal Tperst-clk value is 100us (PCIe CEM r5.0, 2.9.2)
> +	 * If powering up, the minimal Tpvperl is 100ms
> +	 */
> +	if (pwren)
> +		msleep(100);
> +	else
> +		usleep_range(100, 200);
>  
>  	/* Deassert PERST# */
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);

With the documentation aspect addressed:

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
